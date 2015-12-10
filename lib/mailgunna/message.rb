module Mailgunna
  class Message
    def initialize(mailgunna, domain)
      @mailgunna = mailgunna
      @domain  = domain
    end

    # send email
    def send_email(parameters={})
      # options:
      # :from, :to, :cc, :bcc, :subject, :text, :html
      # :with_attachment
      # :with_attachments
      # :at for delayed delivery time option
      # :in_test_mode BOOL. override the @use_test_mode setting
      # :tags to add tags to the email
      # :track BOOL
      Mailgunna.submit(:post, messages_url, parameters)
    end

    #private

    # Helper method to generate the proper url for Mailgunna message API calls
    def messages_url
      "#{@mailgunna.base_url}/#{@domain}/messages"
    end
  end
end
