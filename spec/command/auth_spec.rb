require 'spec_helper'
require 'evernotable/command/auth'

describe Evernotable::Command::Auth do
  it 'displays relevant information when help is invoked' do 
    auth_command = Evernotable::Command::Auth.new
    auth_command.should_not be_nil
    STDOUT.should_receive(:puts).exactly(3).times.with(any_args())
    lambda {auth_command.send(:help)}.should_not raise_error(Evernotable::Command::CommandFailed)
  end
end