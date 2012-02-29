require 'spec_helper'
require 'evernotable/command/base'

describe Evernotable::Command::Base do
  it 'should appropriately be initialized' do
    base_command = Evernotable::Command::Base.new(['remove', '2'])
    base_command.should_not be_nil
  end
  
  it 'should log the user in successfully using user input' do
    user_mock = mock("Evernotable::Client::User")
    Evernotable::Client::User.stub(:new).and_return(user_mock)
    user_mock.stub!(:authenticate).and_return(true)
    base_command = Evernotable::Command::Base.new
    lambda {base_command.authenticate_user(['kswamin', 'dumbass'])}.should_not raise_error(Evernotable::Command::CommandFailed)
  end

  it 'should fail authenticating the user' do
    user_mock = mock("Evernotable::Client::User")
    Evernotable::Client::User.stub(:new).and_return(user_mock)
    user_mock.stub!(:authenticate).and_raise(Evernotable::Client::ClientException)
    base_command = Evernotable::Command::Base.new
    lambda {base_command.authenticate_user(['kswamin', 'wrongpass'])}.should raise_error(Evernotable::Command::CommandFailed)
  end
  
  describe '#invoke client' do
    it 'should invoke the client method without exceptions' do
      base_command = Evernotable::Command::Base.new
      base_command.invoke_client do
        true
      end.should_not raise_error(Evernotable::Command::CommandFailed)
    end
    
    it 'should invoke the client method resulting in exception' do
      base_command = Evernotable::Command::Base.new
      lambda do
        base_command.invoke_client do
          raise Evernotable::Client::ClientException
        end
      end.should raise_error(Evernotable::Command::CommandFailed)
    end
  end
end