module Mailgunna
  class Unsubscribe
    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna, domain)
      @mailgunna = mailgunna
      @domain  = domain
    end
    
    # List all unsubscribes for the domain
    def list(options={})
      Mailgunna.submit(:get, unsubscribe_url, options)["items"]
    end

    def find(email)
      Mailgunna.submit :get, unsubscribe_url(email)
    end

    def add(email, tag='*')
      Mailgunna.submit :post, unsubscribe_url, {:address => email, :tag => tag}
    end

    def remove(email)
      Mailgunna.submit :delete, unsubscribe_url(email)
    end
    
    private

    # Helper method to generate the proper url for Mailgunna unsubscribe API calls
    def unsubscribe_url(address=nil)
      "#{@mailgunna.base_url}/#{@domain}/unsubscribes#{'/' + address if address}"
    end
    
  end
end