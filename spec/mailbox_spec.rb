require 'spec_helper'

describe Mailgunna::Mailbox do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})		# used to get the default values

    @sample = {
      :email  => "test@sample.mailgunna.org",
      :mailbox_name => "test",
      :domain => "sample.mailgunna.org"
    }
  end

  describe "list mailboxes" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      mailboxes_url = @mailgunna.mailboxes(@sample[:domain]).send(:mailbox_url)

      Mailgunna.should_receive(:submit).
        with(:get,mailboxes_url, {}).
        and_return(sample_response)

      @mailgunna.mailboxes(@sample[:domain]).list
    end
  end

  describe "create mailbox" do
    it "should make a POST request with the right params"	do
      mailboxes_url = @mailgunna.mailboxes(@sample[:domain]).send(:mailbox_url)
      Mailgunna.should_receive(:submit)
        .with(:post, mailboxes_url,
          :mailbox  => @sample[:email],
          :password => @sample[:password])
        .and_return({})

      @mailgunna.mailboxes(@sample[:domain]).create(@sample[:mailbox_name], @sample[:password])
    end
  end

  describe "update mailbox" do
    it "should make a PUT request with the right params" do
      mailboxes_url = @mailgunna.mailboxes(@sample[:domain]).send(:mailbox_url, @sample[:mailbox_name])
      Mailgunna.should_receive(:submit)
        .with(:put, mailboxes_url, :password => @sample[:password])
        .and_return({})

      @mailgunna.mailboxes(@sample[:domain]).
        update_password(@sample[:mailbox_name], @sample[:password])
    end
  end

  describe "destroy mailbox" do
    it "should make a DELETE request with the right params" do
      mailboxes_url = @mailgunna.mailboxes(@sample[:domain]).send(:mailbox_url, @sample[:name])
      Mailgunna.should_receive(:submit)
        .with(:delete, mailboxes_url)
        .and_return({})

      @mailgunna.mailboxes(@sample[:domain]).destroy(@sample[:name])
    end
  end
end
