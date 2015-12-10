module Mailgunna
  class Mailbox

    # Used internally, called from Mailgunna::Base
    def initialize(mailgunna, domain)
      @mailgunna = mailgunna
      @domain  = domain
    end
    
    # List all mailboxes for a given domain
    # * domain the domain for which all mailboxes will listed
    def list(options={})
      Mailgunna.submit(:get, mailbox_url, options)["items"]
    end
    

    # Creates a mailbox on the Mailgunna server with the given password
    def create(mailbox_name, password)
      address = "#{mailbox_name}@#{@domain}"
      Mailgunna.submit(
        :post,
        mailbox_url,
        {
          :mailbox => address,
          :password => password
        }
      )
    end


    # Sets the password for a mailbox
    def update_password(mailbox_name, password)
      Mailgunna.submit :put, mailbox_url(mailbox_name), :password => password
    end


    # Destroys the mailbox
    def destroy(mailbox_name)
      Mailgunna.submit :delete, mailbox_url(mailbox_name)
    end


    private

    # Helper method to generate the proper url for Mailgunna mailbox API calls
    def mailbox_url(mailbox_name=nil)
      "#{@mailgunna.base_url}/#{@domain}/mailboxes#{'/' + mailbox_name if mailbox_name}"
    end

  end
end
