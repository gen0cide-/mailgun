module Mailgunna
	class Log
    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna, domain)
      @mailgunna = mailgunna
      @domain = domain
    end
    
    # List all logs for a given domain
    # * domain the domain for which all complaints will listed
    def list(options={})
      Mailgunna.submit(:get, log_url, options)
    end
    
    private

    # Helper method to generate the proper url for Mailgunna complaints API calls
    def log_url
      "#{@mailgunna.base_url}/#{@domain}/log"
    end
   
	end
end