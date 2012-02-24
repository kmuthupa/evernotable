$stdin = File.new("/dev/null")

require "rubygems"
require "bundler/setup"
require "rspec"

def fail_command(message)
  raise_error(Evernotable::Command::CommandFailed, message)
end

require "display_matcher"

RSpec.configure do |config|
  config.color_enabled = true
  config.include DisplayMatcher
end