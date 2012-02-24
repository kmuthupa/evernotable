require 'spec_helper'
require 'evernotable/command'

describe Evernotable::Command do
  before(:all) do
    Evernotable::Command.load
  end
  
  it 'should raise command failed error' do
    begin
      raise Evernotable::Command::CommandFailed, 'testing commandfailed'
    rescue Evernotable::Command::CommandFailed => ex
      ex.message.should == 'testing commandfailed'
      ex.is_a?(Evernotable::Command::CommandFailed).should be_true
    end
  end
  
  it 'should load all the commands successfully' do
    Evernotable::Command::Base.should_not be_nil
    Evernotable::Command::Auth.should_not be_nil
    Evernotable::Command::Task.should_not be_nil
  end
  
  it 'should build the list of commands available' do
    Evernotable::Command.commands.should =~ ['auth', 'base', 'task', 'help']
  end
  
  it 'should test valid' do
    Evernotable::Command.valid?('auth').should be_true
    Evernotable::Command.valid?('task').should be_true
    Evernotable::Command.valid?('wrong-one').should be_false
  end
  
  describe '#run' do
    it 'should display errors and exit on invalid command' do
      STDOUT.should_receive(:puts).with("! *uncommand* is not a valid evernotable command.")
      STDOUT.should_receive(:puts).with("! Use *evernotable help* for additional information.")
      lambda { Evernotable::Command.run('uncommand') }.should raise_error(SystemExit)
    end
  end
end