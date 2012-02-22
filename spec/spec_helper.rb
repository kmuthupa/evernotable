$stdin = File.new("/dev/null")

require "rubygems"
require "bundler/setup"
require "evernotable/cli"
require "rspec"


def execute(command_line)
end

def output
  $command_output.gsub(/\n$/, '')
end

def run(command_line)
  capture_stdout do
    begin
      Evernotable::CLI.start(*command_line.split(" "))
    rescue SystemExit
    end
  end
end

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

def fail_command(message)
  raise_error(Evernotable::Command::CommandFailed, message)
end

require "display_matcher"

RSpec.configure do |config|
  config.color_enabled = true
  config.include DisplayMatcher
  config.order = 'rand'
end