 require 'spec_helper'

describe Mailgunna::MailingList::Member do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})		# used to get the default values

    @sample = {
      :email      => "test@sample.mailgunna.org",
      :list_email => "test_list@sample.mailgunna.org",
      :name       => "test",
      :domain     => "sample.mailgunna.org"
    }
  end

  describe "list members" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      mailing_list_members_url = @mailgunna.list_members(@sample[:list_email]).send(:list_member_url)

      Mailgunna.should_receive(:submit).
        with(:get, mailing_list_members_url, {}).
        and_return(sample_response)
    
      @mailgunna.list_members(@sample[:list_email]).list
    end
  end

  describe "find member in list" do
    it "should make a GET request with correct params to find given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      mailing_list_members_url = @mailgunna.list_members(@sample[:list_email]).send(:list_member_url, @sample[:email])
      
      Mailgunna.should_receive(:submit).
        with(:get, mailing_list_members_url).
        and_return(sample_response)

      @mailgunna.list_members(@sample[:list_email]).find(@sample[:email])
    end
  end

  describe "add member to list" do
    it "should make a POST request with correct params to add a given email address" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      mailing_list_members_url = @mailgunna.list_members(@sample[:list_email]).send(:list_member_url)

      Mailgunna.should_receive(:submit).
        with(:post, mailing_list_members_url, {
          :address => @sample[:email]
        }).
        and_return(sample_response)

      @mailgunna.list_members(@sample[:list_email]).add(@sample[:email])
    end
  end

  describe "update member in list" do
    it "should make a PUT request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit).
        with(:put, "#{@mailgunna.list_members(@sample[:list_email]).send(:list_member_url, @sample[:email])}", {
          :address => @sample[:email]
        }).
        and_return(sample_response)

      @mailgunna.list_members(@sample[:list_email]).update(@sample[:email])
    end
  end

  describe "delete member from list" do
    it "should make a DELETE request with correct params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      mailing_list_members_url = @mailgunna.list_members(@sample[:list_email]).send(:list_member_url, @sample[:email])
      Mailgunna.should_receive(:submit).
        with(:delete, mailing_list_members_url).
        and_return(sample_response)

      @mailgunna.list_members(@sample[:list_email]).remove(@sample[:email])
    end
  end

end
