require "rest-client"
require "json"
require "multimap/lib/multimap"
require "multimap/lib/multiset"
require "multimap/lib/nested_multimap"

require "mailgunna/mailgunna_error"
require "mailgunna/base"
require "mailgunna/domain"
require "mailgunna/route"
require "mailgunna/mailbox"
require "mailgunna/bounce"
require "mailgunna/unsubscribe"
require "mailgunna/complaint"
require "mailgunna/log"
require "mailgunna/list"
require "mailgunna/list/member"
require "mailgunna/message"
require "mailgunna/secure"

#require "startup"

def Mailgunna(options={})
  options[:api_key] = Mailgunna.api_key if Mailgunna.api_key
  options[:domain] = Mailgunna.domain if Mailgunna.domain
  Mailgunna::Base.new(options)
end
