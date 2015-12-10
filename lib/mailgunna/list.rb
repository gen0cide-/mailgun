module Mailgunna

  # Mailing List functionality
  # Refer http://documentation.mailgunna.net/api-mailinglists.html for optional parameters

  class MailingList
    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna)
      @mailgunna = mailgunna
    end

    # List all mailing lists
    def list(options={})
      response = Mailgunna.submit(:get, list_url, options)["items"] || []
    end

    # List a single mailing list by a given address
    def find(address)
      Mailgunna.submit :get, list_url(address)
    end

    # Create a mailing list with a given address
    def create(address, options={})
    	params = {:address => address}
      Mailgunna.submit :post, list_url, params.merge(options)
    end

    # Update a mailing list with a given address
    # with an optional new address, name or description
    def update(address, new_address, options={})
      params = {:address => new_address}
      Mailgunna.submit :put, list_url(address), params.merge(options)
    end		

    # Deletes a mailing list with a given address
    def delete(address)
    	Mailgunna.submit :delete, list_url(address)
    end


    private

    # Helper method to generate the proper url for Mailgunna mailbox API calls
    def list_url(address=nil)
      "#{@mailgunna.base_url}/lists#{'/' + address if address}"
    end
    
  end
end