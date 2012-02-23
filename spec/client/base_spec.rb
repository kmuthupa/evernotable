require 'spec_helper'
require 'evernotable/client/base'

describe Evernotable::Client::Base do
  it 'should load the config from yml when initialized' do
    base_client = Evernotable::Client::Base.new
    base_client.should_not be_nil
    base_client.current_user.should be_nil
    base_client.config.should_not be_nil
    base_client.config["api_credentials"]["consumer_key"].should == 'kswamin'
    base_client.config["api_credentials"]["consumer_secret"].should == 'dbd87f40e8507b16'
  end
end