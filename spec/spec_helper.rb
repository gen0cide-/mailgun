$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'simplecov'
SimpleCov.start

require "rspec"
require "mailgunna"

RSpec.configure do |config|
end
