require 'spec_helper'
require 'evernotable/client/base'

describe Evernotable::Client::Base do
  it 'should appropriately be initialized' do
    base_client = Evernotable::Client::Base.new
    base_client.should_not be_nil
    base_client.current_user.should be_nil
    base_client.config.should_not be_nil
    base_client.config["api_credentials"]["consumer_key"].should == 'kswamin'
    base_client.config["api_credentials"]["consumer_secret"].should == 'dbd87f40e8507b16'
  end
  
  it 'should wrap enml content around a string' do
    base_client = Evernotable::Client::Base.new
    base_client.wrap_enml('test').should == "<?xml version='1.0' encoding='UTF-8'?>
    <!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'>
    <en-note>
       test
    </en-note>"
  end
end