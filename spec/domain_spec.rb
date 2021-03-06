require 'spec_helper'

describe Mailgunna::Domain do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})   # used to get the default values

    @sample = {
      :email  => "test@sample.mailgunna.org",
      :name   => "test",
      :domain => "sample.mailgunna.org"
    }
  end

  describe "list domains" do
    it "should make a GET request with the right params" do

      sample_response = "{\"total_count\": 1, \"items\": [{\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@sample.mailgunna.org\", \"name\": \"sample.mailgunna.org\", \"smtp_password\": \"67bw67bz7w\" }]}"
      domains_url = @mailgunna.domains.send(:domain_url)

      Mailgunna.should_receive(:submit).
        with(:get, domains_url, {}).
        and_return(sample_response)
    
      @mailgunna.domains.list
    end
  end

  describe "find domains" do
    it "should make a GET request with correct params to find given domain" do
      sample_response = "{\"domain\": {\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@bample.mailgunna.org\", \"name\": \"sample.mailgunna.org\", \"smtp_password\": \"67bw67bz7w\" }, \"receiving_dns_records\": [], \"sending_dns_records\": []}"
      domains_url = @mailgunna.domains.send(:domain_url, @sample[:domain])

      Mailgunna.should_receive(:submit).
        with(:get, domains_url).
        and_return(sample_response)

      @mailgunna.domains.find(@sample[:domain])
    end
  end

  describe "add domains" do
    it "should make a POST request with correct params to add a domain" do
      sample_response = "{\"domain\": {\"created_at\": \"Tue, 12 Feb 2013 20:13:49 GMT\", \"smtp_login\": \"postmaster@sample.mailgunna.org\",\"name\": \"sample.mailgunna.org\",\"smtp_password\": \"67bw67bz7w\"}, \"message\": \"Domain has been created\"}"
      domains_url = @mailgunna.domains.send(:domain_url)

      Mailgunna.should_receive(:submit).
        with(:post, domains_url, {:name => @sample[:domain]} ).
        and_return(sample_response)

      @mailgunna.domains.create(@sample[:domain])
    end
  end

  describe "delete domain" do
    it "should make a DELETE request with correct params" do
      sample_response = "{\"message\": \"Domain has been deleted\"}"
      domains_url = @mailgunna.domains.send(:domain_url, @sample[:domain])

      Mailgunna.should_receive(:submit).
        with(:delete, domains_url).
        and_return(sample_response)

      @mailgunna.domains.delete(@sample[:domain])
    end
  end

end
