require 'spec_helper'

describe Mailgunna::Base do

  it "should raise an error if the api_key has not been set" do
    expect do
      Mailgunna()
    end.to raise_error ArgumentError
  end

  it "can be called directly if the api_key has been set via Mailgunna.configure" do
    Mailgunna.config { |c| c.api_key = "some-junk-string" }
    expect do
      Mailgunna()
    end.not_to raise_error()
  end

  it "can be instanced with the api_key as a param" do
    expect do
      Mailgunna({:api_key => "some-junk-string"})
    end.not_to raise_error()
  end

  describe "Mailgunna.new" do
    it "Mailgunna() method should return a new Mailgunna object" do
      mailgunna = Mailgunna({:api_key => "some-junk-string"})
      mailgunna.should be_kind_of(Mailgunna::Base)
    end
  end

  describe "resources" do
    before :each do
      @mailgunna = Mailgunna({:api_key => "some-junk-string"})
    end

    it "Mailgunna#mailboxes should return an instance of Mailgunna::Mailbox" do
      @mailgunna.mailboxes.should be_kind_of(Mailgunna::Mailbox)
    end

    it "Mailgunna#routes should return an instance of Mailgunna::Route" do
      @mailgunna.routes.should be_kind_of(Mailgunna::Route)
    end
  end


  
  describe "internal helper methods" do
    before :each do
      @mailgunna = Mailgunna({:api_key => "some-junk-string"})
    end

    describe "Mailgunna#base_url" do
      it "should return https url if use_https is true" do
      @mailgunna.base_url.should == "https://api:#{Mailgunna.api_key}@#{Mailgunna.mailgunna_host}/#{Mailgunna.api_version}"
      end
    end

    describe "Mailgunna.submit" do
      it "should send method and arguments to RestClient" do
        RestClient.should_receive(:test_method)
          .with({:arg1=>"val1"},{})
          .and_return({})
        Mailgunna.submit :test_method, :arg1=>"val1"
      end
    end
    
  end

  describe "configuration" do
    describe "default settings" do
      it "api_version is v2" do
        Mailgunna.api_version.should eql 'v2'
      end
      it "should use https by default" do
        Mailgunna.protocol.should == "https"
      end
      it "mailgunna_host is 'api.mailgunna.net'" do
        Mailgunna.mailgunna_host.should eql 'api.mailgunna.net'
      end

      it "test_mode is false" do
        Mailgunna.test_mode.should eql false
      end

      it "domain is not set" do
        Mailgunna.domain.should be_nil
      end
    end

    describe "setting configurations" do
      before(:each) do
        Mailgunna.configure do |c|
          c.api_key = 'some-api-key'
          c.api_version = 'v2'
          c.protocol = 'https'
          c.mailgunna_host = 'api.mailgunna.net'
          c.test_mode = false
          c.domain = 'some-domain'
        end
      end

      it "allows me to set my API key easily" do
        Mailgunna.api_key.should eql 'some-api-key'
      end

      it "allows me to set the api_version attribute" do
        Mailgunna.api_version.should eql 'v2'
      end

      it "allows me to set the protocol attribute" do
        Mailgunna.protocol.should eql 'https'
      end
      
      it "allows me to set the mailgunna_host attribute" do
        Mailgunna.mailgunna_host.should eql 'api.mailgunna.net'
      end
      it "allows me to set the test_mode attribute" do
        Mailgunna.test_mode.should eql false
      end

      it "allows me to set my domain easily" do
        Mailgunna.domain.should eql 'some-domain'
      end
    end
  end
end
