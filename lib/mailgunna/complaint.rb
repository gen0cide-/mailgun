module Mailgunna

  # Complaints interface. Refer to http://documentation.mailgunna.net/api-complaints.html
  class Complaint
    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna, domain)
      @mailgunna = mailgunna
      @domain  = domain
    end
    
    # List all the users who have complained
    def list(options={})
      Mailgunna.submit(:get, complaint_url, options)["items"] || []
    end

    # Find a complaint by email
    def find(email)
      Mailgunna.submit :get, complaint_url(email)
    end

    # Add an email to the complaints list
    def add(email)
      Mailgunna.submit :post, complaint_url, {:address => email}
    end

    # Removes a complaint by email
    def destroy(email)
      Mailgunna.submit :delete, complaint_url(email)
    end

    private

    # Helper method to generate the proper url for Mailgunna complaints API calls
    def complaint_url(address=nil)
      "#{@mailgunna.base_url}/#{@domain}/complaints#{'/' + address if address}"
    end

  end
end