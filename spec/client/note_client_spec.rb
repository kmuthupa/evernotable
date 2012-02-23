require 'spec_helper'
require 'evernotable/client/note_client'

describe Evernotable::Client::NoteClient do
  
  before(:all) do
    @user_client = Evernotable::Client::UserClient.new({:user => 'kswamin', :password => 'karth1980'})
    @user_client.authenticate
  end
  
  it 'should appropriately be initialized' do
    note_client = Evernotable::Client::NoteClient.new({:user_shard => @user_client.current_user.shardId})
    note_client.should_not be_nil
    note_client.config.should_not be_nil
  end
  
end