require 'spec_helper'

describe Mailgunna::Log do

  before :each do
    @mailgunna = Mailgunna({:api_key => "api-key"})   # used to get the default values

    @sample = {
      :email  => "test@sample.mailgunna.org",
      :name   => "test",
      :domain => "sample.mailgunna.org"
    }
  end

  describe "send email" do
    it "should make a POST request to send an email" do

      sample_response = "{\"items\": [{\"size_bytes\": 0,  \"mailbox\": \"postmaster@bsample.mailgunna.org\" }  ]}"
      Mailgunna.should_receive(:submit)
      .with(:get, "#{@mailgunna.lists.send(:list_url, @sample[:list_email])}")
      .and_return(sample_response)

      @mailgunna.lists.find(@sample[:list_email])

      sample_response = "{\"message\": \"Queued. Thank you.\",\"id\": \"<20111114174239.25659.5817@samples.mailgunna.org>\"}"
      parameters = {
        :to => "cooldev@your.mailgunna.domain",
        :subject => "missing tps reports",
        :text => "yeah, we're gonna need you to come in on friday...yeah.",
        :from => "lumberg.bill@initech.mailgunna.domain"
      }
      Mailgunna.should_receive(:submit)                            \
        .with(:post, @mailgunna.messages.messages_url, parameters) \
        .and_return(sample_response)

      @mailgunna.messages.send_email(parameters)
    end
  end

end