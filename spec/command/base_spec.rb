require 'spec_helper'
require 'evernotable/command/base'

describe Evernotable::Command::Base do
  it 'should appropriately be initialized' do
    base_command = Evernotable::Command::Base.new(['remove', '2'])
    base_command.should_not be_nil
    base_command.args.should_not be_nil
    base_command.args.should =~ ['remove', '2']
  end
end