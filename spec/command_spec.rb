require 'spec_helper'
require 'evernotable/command'

describe Evernotable::Command do
  before(:all) do
    Evernotable::Command.load
  end

  it 'should raise command failed error' do
    begin
      raise Evernotable::Command::CommandFailed, 'testing commandfailed'
    rescue Evernotable::Command::CommandFailed => ex
      ex.message.should == 'testing commandfailed'
      ex.is_a?(Evernotable::Command::CommandFailed).should be_true
    end
  end

  it 'should load all the commands successfully' do
    Evernotable::Command::Base.should_not be_nil
    Evernotable::Command::Auth.should_not be_nil
    Evernotable::Command::Task.should_not be_nil
  end

  it 'should build the list of commands available' do
    Evernotable::Command.commands.should =~ ['auth', 'base', 'task', 'help']
  end

  it 'should test valid' do
    Evernotable::Command.valid?('auth').should be_true
    Evernotable::Command.valid?('task').should be_true
    Evernotable::Command.valid?('wrong-one').should be_false
  end

  describe '#run' do
    it 'should display errors and exit on invalid command' do
      STDOUT.should_receive(:puts).with("! *uncommand* is not a valid evernotable command.")
      STDOUT.should_receive(:puts).with("! Use *evernotable help* for additional information.")
      lambda { Evernotable::Command.run('uncommand') }.should raise_error(SystemExit)
    end
    it 'should display error and exit on blank command' do
      STDOUT.should_receive(:puts).with("! Use *evernotable help* for additional information.")
      lambda { Evernotable::Command.run('') }.should raise_error(SystemExit)
    end
    it 'should display error and exit on nil command' do
      STDOUT.should_receive(:puts).with("! Use *evernotable help* for additional information.")
      lambda { Evernotable::Command.run(nil) }.should raise_error(SystemExit)
    end
    it 'should instantiate the right command and invoke the appropriate method on it' do
      auth_mock = mock("Evernotable::Command::Auth")
      task_mock = mock("Evernotable::Command::Task")
      help_mock = mock("Evernotable::Command::Help")
      Evernotable::Command::Auth.stub(:new).and_return(auth_mock)
      Evernotable::Command::Task.stub(:new).and_return(task_mock)
      Evernotable::Command::Help.stub(:new).and_return(help_mock)
      auth_mock.should_receive(:login).with(no_args())
      auth_mock.should_receive(:logout).with(no_args())
      lambda { Evernotable::Command.run('auth', ['login']) }.should_not raise_error(SystemExit)
      lambda { Evernotable::Command.run('auth', ['logout']) }.should_not raise_error(SystemExit)
      task_mock.should_receive(:add)
      task_mock.should_receive(:remove)
      task_mock.should_receive(:help)
      help_mock.should_receive(:help)
      lambda { Evernotable::Command.run('task', ['add', 'do this right away!']) }.should_not raise_error(SystemExit)
      lambda { Evernotable::Command.run('task', ['remove', '3']) }.should_not raise_error(SystemExit)
      lambda { Evernotable::Command.run('task') }.should_not raise_error(SystemExit)
      lambda { Evernotable::Command.run('help') }.should_not raise_error(SystemExit)
    end
  end
end