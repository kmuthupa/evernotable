require 'spec_helper'
require 'evernotable/client/user'

describe Evernotable::Client::User do
  
  before(:all) do
    @config = YAML.load(File.read('lib/evernotable_config.yml'))
  end
  
  it 'should appropriately be initialized' do
    user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'dumbass', :config => @config})
    user_client.should_not be_nil
    user_client.config.should_not be_nil
  end
  
  describe '#authenticate' do
    it 'should authenticate the user successfully' do
      user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'dumbass', :config => @config})
      user_client.should_not be_nil
      user_client.authenticate
      user_client.current_user.should_not be_nil
      user_client.client_token.should_not be_nil
    end 
    it 'should not authenticate the user successfully' do
      user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'thewrongpassword', :config => @config})
      user_client.should_not be_nil
      lambda { user_client.authenticate }.should raise_error(Evernotable::Client::ClientException)
      user_client.current_user.should be_nil
      user_client.client_token.should be_nil
    end
  end
  
  describe '#refresh authentication' do
    before(:all) do
      @user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'dumbass', :config => @config})
      @user_client.authenticate
    end
    it 'should refresh the authentication for the user successfully' do
      prev_token = @user_client.client_token
      @user_client.refresh_authentication
      @user_client.client_token.should_not be_nil
      new_token = @user_client.client_token
      prev_token.should_not == new_token
    end
  end
  
  describe '#check valid version' do
    before(:all) do
      @user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'dumbass', :config => @config})
    end
    it 'should check if the version is valid' do
      @user_client.valid_version?.should be_true
    end
  end
  
end