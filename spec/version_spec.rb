require "spec_helper"
require "evernotable/version"

describe Evernotable do
  it 'returns the correct version of the gem' do
    Evernotable::VERSION.should == '1.0.1'
  end
end