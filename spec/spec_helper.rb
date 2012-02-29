$stdin = File.new("/dev/null")

require "rubygems"
require "bundler/setup"
require "rspec"
require 'highline'
require "display_matcher"

def fail_command(message)
  raise_error(Evernotable::Command::CommandFailed, message)
end

RSpec.configure do |config|
  config.color_enabled = true
  config.include DisplayMatcher
end