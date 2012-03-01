require 'spec_helper'
require 'evernotable/client/base'

describe Evernotable::Client::Base do
  before(:all) do
    @config = YAML.load(File.read('lib/evernotable_config.yml'))
  end
  
  it 'should appropriately be initialized' do
    base_client = Evernotable::Client::Base.new({:config => @config})
    base_client.should_not be_nil
    base_client.current_user.should be_nil
    base_client.client_token.should be_nil
  end
end