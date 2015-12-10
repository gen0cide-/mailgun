require 'spec_helper'

describe Mailgunna::Log do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})		# used to get the default values

    @sample = {
      :email  => "test@sample.mailgunna.org",
      :name   => "test",
      :domain => "sample.mailgunna.org"
    }
  end

  describe "list log" do
    it "should make a GET request with the right params" do
      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      log_url = @mailgunna.log(@sample[:domain]).send(:log_url)
      Mailgunna.should_receive(:submit).
        with(:get, log_url, {}).
        and_return(sample_response)

      @mailgunna.log(@sample[:domain]).list
    end
  end

end