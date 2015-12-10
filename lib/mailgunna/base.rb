module Mailgunna
  class Base
    # Options taken from
    # http://documentation.mailgunna.net/quickstart.html#authentication
    # * Mailgunna host - location of mailgunna api servers
    # * Procotol - http or https [default to https]
    # * API key and version
    # * Test mode - if enabled, doesn't actually send emails (see http://documentation.mailgunna.net/user_manual.html#sending-in-test-mode)
    # * Domain - domain to use
    def initialize(options)
      Mailgunna.mailgunna_host  = options.fetch(:mailgunna_host)    {"api.mailgun.net"}
      Mailgunna.protocol        = options.fetch(:protocol)        { "https"  }
      Mailgunna.api_version     = options.fetch(:api_version)     { "v3"  }
      Mailgunna.test_mode       = options.fetch(:test_mode)       { false }
      Mailgunna.api_key         = options.fetch(:api_key)         { raise ArgumentError.new(":api_key is a required argument to initialize Mailgunna") if Mailgunna.api_key.nil?}
      Mailgunna.domain          = options.fetch(:domain)          { nil }
    end

    # Returns the base url used in all Mailgunna API calls
    def base_url
      "#{Mailgunna.protocol}://api:#{Mailgunna.api_key}@#{Mailgunna.mailgunna_host}/#{Mailgunna.api_version}"
    end

    # Returns an instance of Mailgunna::Mailbox configured for the current API user
    def mailboxes(domain = Mailgunna.domain)
      Mailgunna::Mailbox.new(self, domain)
    end

    def messages(domain = Mailgunna.domain)
      @messages ||= Mailgunna::Message.new(self, domain)
    end

    def routes
      @routes ||= Mailgunna::Route.new(self)
    end

    def bounces(domain = Mailgunna.domain)
      Mailgunna::Bounce.new(self, domain)
    end

    def domains
      Mailgunna::Domain.new(self)
    end

    def unsubscribes(domain = Mailgunna.domain)
      Mailgunna::Unsubscribe.new(self, domain)
    end

    def complaints(domain = Mailgunna.domain)
      Mailgunna::Complaint.new(self, domain)
    end

    def log(domain=Mailgunna.domain)
      Mailgunna::Log.new(self, domain)
    end

    def lists
      @lists ||= Mailgunna::MailingList.new(self)
    end

    def list_members(address)
      Mailgunna::MailingList::Member.new(self, address)
    end

    def secure
      Mailgunna::Secure.new(self)
    end
  end


  # Submits the API call to the Mailgunna server
  def self.submit(method, url, parameters={})
    begin
      parameters = {:params => parameters} if method == :get
      return JSON.parse(RestClient.send(method, url, parameters))
    rescue => e
      begin
        error_code = e.http_code
        error_message = JSON(e.http_body)["message"]
        error = Mailgunna::Error.new(
          :code => error_code || nil,
          :message => error_message || nil
        )
        if error.handle.kind_of? Mailgunna::ErrorBase
          raise error
        else
          return error.handle
        end
      rescue
        raise e
      end
    end
  end

  #
  # @TODO Create root module to give this a better home
  #
  class << self
    attr_accessor :api_key,
                  :api_version,
                  :protocol,
                  :mailgunna_host,
                  :test_mode,
                  :domain

    def configure
      yield self
      true
    end
    alias :config :configure
  end
end
