module Mailgunna

  # Interface to manage domains
  class Domain

    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna)
      @mailgunna = mailgunna
    end
    
    # List all domains on the account
    def list(options={})
      Mailgunna.submit(:get, domain_url, options)["items"] || []
    end

    # Find domain by name
    def find(domain)
      Mailgunna.submit :get, domain_url(domain)
    end

    # Add domain to account
    def create(domain, opts = {})
      opts = {name: domain}.merge(opts)
      Mailgunna.submit :post, domain_url, opts
    end

    # Remves a domain from account
    def delete(domain)
      Mailgunna.submit :delete, domain_url(domain)
    end

    private

    # Helper method to generate the proper url for Mailgunna domain API calls
    def domain_url(domain = nil)
      "#{@mailgunna.base_url}/domains#{'/' + domain if domain}"
    end
    
  end
end