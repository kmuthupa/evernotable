require 'spec_helper'
require 'evernotable/client/base'

describe Evernotable::Client::Base do
  it 'should load the config from yml when initialized' do
    base_client = Evernotable::Client::Base.new
  end
end