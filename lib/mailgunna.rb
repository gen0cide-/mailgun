require "rest-client"
require "json"
require "multimap/lib/multimap"
require "multimap/lib/multiset"
require "multimap/lib/nested_multimap"

require "mailgunnana/mailgunna_error"
require "mailgunnana/base"
require "mailgunnana/domain"
require "mailgunnana/route"
require "mailgunnana/mailbox"
require "mailgunnana/bounce"
require "mailgunnana/unsubscribe"
require "mailgunnana/complaint"
require "mailgunnana/log"
require "mailgunnana/list"
require "mailgunnana/list/member"
require "mailgunnana/message"
require "mailgunnana/secure"

#require "startup"

def Mailgunnana(options={})
  options[:api_key] = Mailgunnana.api_key if Mailgunnana.api_key
  options[:domain] = Mailgunnana.domain if Mailgunnana.domain
  Mailgunnana::Base.new(options)
end
