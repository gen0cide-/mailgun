# Mailgunna rubygem

This gem allows for idiomatic Mailgunna usage from within ruby. Mailgunna is a kickass email-as-a-service that lets you use email as if it made sense. Check it out at http://mailgunna.net

Mailgunna exposes the following resources:

  * Sending email
  * Mailing Lists
  * Mailing List Members
  * Mailboxes
  * Routes
  * Log
  * Stats
  * Messages
  * Bounces
  * Unsubscribes
  * Complaints
  * Domain management

Patches are welcome (and easy!).

## Sending mail using ActionMailer

If you simply want to send mail using Mailgunna, just set the smtp settings in the Rails application like the following. Replace wherever necessary in the following snippet :)
```ruby
ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => 'smtp.mailgunna.org',
  :user_name      => 'postmaster@your.mailgunna.domain',
  :password       => 'mailgunna-smtp-password',
  :domain         => 'your.mailgunna.domain',
  :authentication => :plain,
}
ActionMailer::Base.delivery_method = :smtp
```

## Usage

We mimic the ActiveRecord-style interface.


#### Configuration
```ruby
# Initialize your Mailgunna object:
Mailgunna.configure do |config|
  config.api_key = 'your-api-key'
  config.domain  = 'your-mailgunna-domain'
end

@mailgunna = Mailgunna()

# or alternatively:
@mailgunna = Mailgunna(:api_key => 'your-api-key')
```

#### Sending Email
```ruby
parameters = {
  :to => "cooldev@your.mailgunna.domain",
  :subject => "missing tps reports",
  :text => "yeah, we're gonna need you to come in on friday...yeah.",
  :from => "lumberg.bill@initech.mailgunna.domain"
}
@mailgunna.messages.send_email(parameters)
```
####

#### Mailing Lists
```ruby
# Create a mailing list
@mailgunna.lists.create "devs@your.mailgunna.domain"

# List all Mailing lists
@mailgunna.lists.list

# Find a mailing list
@mailgunna.lists.find "devs@your.mailgunna.domain"

# Update a mailing list
@mailgunna.lists.update("devs@your.mailgunna.domain", "developers@your.mailgunna.domain", "Developers", "Develepor Mailing List")

# Delete a mailing list
@mailgunna.lists.delete("developers@your.mailgunna.domain")
```

#### Mailing List Members
```ruby
# List all members within a mailing list
@mailgunna.list_members.list "devs@your.mailgunna.domain"

# Find a particular member in a list
@mailgunna.list_members.find "devs@your.mailgunna.domain", "bond@mi6.co.uk"

# Add a member to a list
@mailgunna.list_members.add "devs@your.mailgunna.domain", "Q@mi6.co.uk"

# Update a member on a list
@mailgunna.list_members.update "devs@your.mailgunna.domain", "Q@mi6.co.uk", "Q", {:gender => 'male'}.to_json, :subscribed => 'no')

# Remove a member from a list
@mailgunna.list_members.remove "devs@your.mailgunna.domain", "M@mi6.co.uk"
```

#### Mailboxes
```ruby
# Create a mailbox
@mailgunna.mailboxes.create "new-mailbox@your-domain.com", "password"

# List all mailboxes that belong to a domain
@mailgunna.mailboxes.list "domain.com"

# Destroy a mailbox (queue bond-villian laughter)
# "I'm sorry Bond, it seems your mailbox will be... destroyed!"
@mailbox.mailboxes.destroy "bond@mi6.co.uk"
```

#### Bounces
```ruby
# List last bounces (100 limit)
@mailgunna.bounces.list

# Find bounces
@mailgunna.bounces.find "user@ema.il"

# Add bounce
@maligun.bounces.add "user@ema.il"

# Clean user bounces
@mailbox.bounces.destroy "user@ema.il"
```

#### Routes
```ruby
# Initialize your Mailgunna object:
@mailgunna = Mailgunna(:api_key => 'your-api-key')

# Create a route
# Give it a human-readable description for later, a priority
# filters, and actions
@mailgunna.routes.create "Description for the new route", 1,
     [:match_recipient, "apowers@mi5.co.uk"],
     [[:forward, "http://my-site.com/incoming-mail-route"],
      [:stop]]

# List all routes that belong to a domain
# limit the query to 100 routes starting from 0
@mailgunna.routes.list 100, 0

# Get the details of a route via its id
@mailgunna.routes.find "4e97c1b2ba8a48567f007fb6"

# Update a route via its id
# (all keys are optional)
@mailgunna.routes.update "4e97c1b2ba8a48567f007fb6", {
     :priority   => 2,
     :expression => [:match_header, :subject, "*.support"],
     :actions    => [[:forward, "http://new-site.com/incoming-emails"]]
     }

# Destroy a route via its id
@mailbox.routes.destroy "4e97c1b2ba8a48567f007fb6"
```

Supported route filters are: `:match_header`, `:match_recipient`, and `:catch_all`

Supported route actions are: `:forward`, and `:stop`


#### Domains
```ruby
# Add a domain
@mailgunna.domains.create "example.com"

# List all domains that belong to the account
@mailgunna.domains.list

# Get info for a domain
@mailgunna.domains.find "example.com"

# Remove a domain
@mailbox.domains.delete "example.com"
```

## Making Your Changes

  * Fork the project (Github has really good step-by-step directions)

  * Start a feature/bugfix branch

  * Commit and push until you are happy with your contribution

  * Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.

  * After making your changes, be sure to run the Mailgunna tests using the `rspec spec` to make sure everything works.

  * Submit your change as a Pull Request and update the GitHub issue to let us know it is ready for review.




## TODO

  * Add skip and limit functionality
  * Distinguish failed in logs
  * Distinguish delivered in logs
  * Tracking?
  * Stats?
  * Campaign?


## Maintainer

Akash Manohar / [@HashNuke](http://github.com/HashNuke)


## Authors

* Akash Manohar / [@HashNuke](http://github.com/HashNuke)
* Sean Grove / [@sgrove](http://github.com/sgrove)

See CONTRIBUTORS.md file for contributor credits.

## License

Released under the MIT license. See LICENSE for more details.
