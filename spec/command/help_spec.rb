require 'spec_helper'
require 'evernotable/command/help'

describe Evernotable::Command::Help do
  it 'displays useful information when help is invoked' do 
    help_command = Evernotable::Command::Help.new
    help_command.should_not be_nil
    STDOUT.should_receive(:puts).with(/Evernotable is a simple commandline/)
    STDOUT.should_receive(:puts).with(/This automatically creates/)
    lambda {help_command.send(:help)}.should_not raise_error(Evernotable::Command::CommandFailed)
  end
end