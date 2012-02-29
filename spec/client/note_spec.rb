require 'spec_helper'
require 'evernotable/client/note'

describe Evernotable::Client::Note do

  before(:all) do
    @config = YAML.load(File.read('lib/evernote_config.yml'))
    @user_client = Evernotable::Client::User.new({:user => 'kswamin', :password => 'karth1980', :config => @config})
    @user_client.authenticate
    @note_client = Evernotable::Client::Note.new({:user_shard => @user_client.current_user.shardId, :client_token => @user_client.client_token, :config => @config})
    #@note_client.expunge_notebook #TODO: doesn't work for some weird reason, investigate
  end

  it 'should appropriately be initialized' do
    @note_client.should_not be_nil
    @note_client.config.should_not be_nil
    @note_client.notebook_guid.should be_nil
  end

  it 'should add a new notebook successfully' do
    lambda { @note_client.add_notebook }.should_not raise_error
    @note_client.notebook_guid.should_not be_nil
  end

  it 'should list notebooks successfully' do
    list = []
    lambda {list = @note_client.list_notebooks}.should_not raise_error
    list.size.should == 2
    list.collect {|n| n.name}.include?('evernotable').should be_true
  end

  it 'should check if the notebook exists?' do
    @note_client.notebook_exists?.should be_true
  end

  it 'should add a note successfully' do
    notes = nil
    lambda {notes = @note_client.list_notes}.should_not raise_error
    notes.size.should == 0
    lambda { @note_client.add_note('note 1') }.should_not raise_error
    lambda { @note_client.add_note('note 2') }.should_not raise_error
    lambda { @note_client.add_note('note 3') }.should_not raise_error
    lambda {notes = @note_client.list_notes}.should_not raise_error
    notes.size.should == 3
  end

  it 'should list notes successfully' do
    notes = nil
    lambda {notes = @note_client.list_notes}.should_not raise_error
    notes.size.should == 3
    notes.collect{|n| n.title}.should == ['note 1', 'note 2', 'note 3']
  end

  it 'should remove a note successfully' do
    note = nil
    lambda { note = @note_client.add_note('note 4') }.should_not raise_error
    count = @note_client.list_notes.size
    count.should == 4
    lambda { @note_client.remove_note(note.guid) }.should_not raise_error
    count = @note_client.list_notes.size
    count.should == 3
  end
  
end