require 'spec_helper'

describe Mailgunna::MailingList do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})		# used to get the default values

    @sample = {
      :email      => "test@sample.mailgunna.org",
      :list_email => "dev@samples.mailgunna.org",
      :name       => "test",
      :domain     => "sample.mailgunna.org"
    }
  end

  describe "list mailing lists" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:get, "#{@mailgunna.lists.send(:list_url)}", {}).and_return(sample_response)
    
      @mailgunna.lists.list
    end
  end

  describe "find list adress" do
    it "should make a GET request with correct params to find given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:get, "#{@mailgunna.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @mailgunna.lists.find(@sample[:list_email])
    end
  end

  describe "create list" do
    it "should make a POST request with correct params to add a given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:post, "#{@mailgunna.lists.send(:list_url)}", {:address => @sample[:list_email]})
      .and_return(sample_response)

      @mailgunna.lists.create(@sample[:list_email])
    end
  end

  describe "update list" do
    it "should make a PUT request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:put, "#{@mailgunna.lists.send(:list_url, @sample[:list_email])}", {:address => @sample[:email]})
      .and_return(sample_response)

      @mailgunna.lists.update(@sample[:list_email], @sample[:email])
    end
  end

  describe "delete list" do
    it "should make a DELETE request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:delete, "#{@mailgunna.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @mailgunna.lists.delete(@sample[:list_email])
    end
  end

end
