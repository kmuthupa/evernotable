require 'spec_helper'
require 'evernotable/command/task'

describe Evernotable::Command::Task do
  it 'displays relevant information when help is invoked' do 
    task_command = Evernotable::Command::Task.new
    task_command.should_not be_nil
    STDOUT.should_receive(:puts).exactly(5).times.with(any_args())
    lambda {task_command.send(:help)}.should_not raise_error(Evernotable::Command::CommandFailed)
  end
end