require 'spec_helper'
require 'evernotable/command/auth'

describe Evernotable::Command::Auth do
  it 'displays relevant information when help is invoked' do 
    auth_command = Evernotable::Command::Auth.new
    auth_command.should_not be_nil
    STDOUT.should_receive(:puts).exactly(3).times.with(any_args())
    lambda {auth_command.send(:help)}.should_not raise_error(Evernotable::Command::CommandFailed)
  end
  
  describe '#login' do
    pending 'This is pending'
    # it 'should log the user in successfully using user input' do
    #       user_mock = mock("Evernotable::Client::User")
    #       Evernotable::Client::User.stub(:new).and_return(user_mock)
    #       user_mock.stub!(:read_from_file).and_return(nil)
    #       highline = mock("HighLine")
    #       HighLine.stub(:new).and_return(highline)
    #       highline.stub!(:ask).and_return('kswamin', 'karth1980') 
    #       user_mock.stub!(:authenticate).and_return(true)
    #       user_mock.stub!(:write_to_file).and_return(true)
    #       STDOUT.should_receive(:puts).exactly(1).times.with('You were successfully authenticated.')
    #       auth_command = Evernotable::Command::Auth.new
    #       lambda {auth_command.send(:login)}.should_not raise_error(Evernotable::Command::CommandFailed)
    #     end
    #     
    #     it 'should log the user in successfully using credentials file' do
    #       user_mock = mock("Evernotable::Client::User")
    #       Evernotable::Client::User.stub(:new).and_return(user_mock)
    #       user_mock.stub!(:read_from_file).and_return('kswamin/karth1980')
    #       user_mock.stub!(:authenticate).and_return(true)
    #       user_mock.stub!(:write_to_file).and_return(true)
    #       STDOUT.should_receive(:puts).exactly(1).times.with('You were successfully authenticated.')
    #       auth_command = Evernotable::Command::Auth.new
    #       lambda {auth_command.send(:login)}.should_not raise_error(Evernotable::Command::CommandFailed)
    #     end
    #     
    # it 'should fail authenticating the user' do
    #   user_mock = mock("Evernotable::Client::User")
    #   Evernotable::Client::User.stub(:new).and_return(user_mock)
    #   File.stub!(:exist?).and_return(true)
    #   File.stub!(:read).and_return('kswamin/wrongpass')
    #   user_mock.stub!(:authenticate).and_raise(Evernotable::Client::ClientException)
    #   auth_command = Evernotable::Command::Auth.new
    #   lambda {auth_command.send(:login)}.should raise_error(Evernotable::Command::CommandFailed)
    # end
  end
  
  describe '#logout' do
    it 'should log the user out successfully' do
      File.stub!(:exist?).and_return(true)
      File.stub!(:delete).and_return(true)
      STDOUT.should_receive(:puts).exactly(1).times.with('You were successfully logged out.')
      auth_command = Evernotable::Command::Auth.new
      lambda {auth_command.send(:logout)}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
    
    it 'should not log out if the user is not logged in already' do
      File.stub!(:exist?).and_return(false)
      STDOUT.should_receive(:puts).exactly(1).times.with(any_args())
      auth_command = Evernotable::Command::Auth.new
      lambda {auth_command.send(:logout)}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
  end
end