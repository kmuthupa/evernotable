require 'spec_helper'
require 'evernotable/command/task'

describe Evernotable::Command::Task do
  
  before(:all) do
    @task_command = Evernotable::Command::Task.new(['dude!'])
  end
  
  it 'displays relevant information when help is invoked' do 
    @task_command.should_not be_nil
    STDOUT.should_receive(:puts).exactly(5).times.with(any_args())
    lambda {@task_command.send(:help)}.should_not raise_error(Evernotable::Command::CommandFailed)
  end
  
  describe '#add note' do
    it 'should add note successfully' do
      mock_note_client = mock('Evernotable::Client::Note')
      mock_note_client.stub!(:add_note).and_return(true)
      @task_command.stub!(:note_client).and_return(mock_note_client)
      STDOUT.should_receive(:puts).exactly(1).times.with('Done.')
      lambda {@task_command.add}.should_not raise_error(Evernotable::Command::CommandFailed)
    end

    it 'should not add when nothing is supplied' do
      @task_command = Evernotable::Command::Task.new([])
      STDOUT.should_receive(:puts).exactly(1).times.with('Nothing to add!')
      lambda {@task_command.add}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
  end

  describe '#remove note' do
    it 'should remove note successfully' do
      mock_note_client = mock('Evernotable::Client::Note')
      mock_note_client.stub!(:remove_note).and_return(true)
      @task_command.stub!(:note_client).and_return(mock_note_client)
      STDOUT.should_receive(:puts).exactly(1).times.with('Done.')
      lambda {@task_command.remove}.should_not raise_error(Evernotable::Command::CommandFailed)
    end

    it 'should not remove when nothing is supplied' do
      @task_command = Evernotable::Command::Task.new([])
      STDOUT.should_receive(:puts).exactly(1).times.with('Nothing to remove!')
      lambda {@task_command.remove}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
  end
  
  describe '#list notes' do
    it 'should not list notes when there is nothing ' do
      mock_note_client = mock('Evernotable::Client::Note')
      mock_note_client.stub!(:list_notes).and_return([])
      @task_command.stub!(:note_client).and_return(mock_note_client)
      STDOUT.should_receive(:puts).exactly(1).times.with('No tasks!')
      lambda {@task_command.list}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
    
    it 'should list notes successfully' do
      mock_note_client = mock('Evernotable::Client::Note')
      mock_note_client.stub!(:list_notes).and_return([StubNote.new('note1'), StubNote.new('note2')])
      @task_command.stub!(:note_client).and_return(mock_note_client)
      STDOUT.should_receive(:puts).exactly(2).times.with(any_args())
      lambda {@task_command.list}.should_not raise_error(Evernotable::Command::CommandFailed)
    end
  end
end