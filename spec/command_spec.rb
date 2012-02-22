require 'spec_helper'
require 'evernotable/command'

describe Evernotable::Command do
  it 'should raise command failed error' do
    begin
      raise Evernotable::Command::CommandFailed, 'testing commandfailed'
    rescue Evernotable::Command::CommandFailed => ex
      ex.message.should == 'testing commandfailed'
      ex.is_a?(Evernotable::Command::CommandFailed).should be_true
    end
  end
  
  it 'should load all the commands successfully' do
    Evernotable::Command.load
    Evernotable::Command::Base.should_not be_nil
    Evernotable::Command::Auth.should_not be_nil
    Evernotable::Command::Task.should_not be_nil
  end
end