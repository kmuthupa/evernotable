require "evernotable/command"
require "evernotable/client/user"
require "evernotable/client/note"

class Evernotable::Command::Base
  
  include Evernotable::Utilities
  
  attr_reader :args
  
  def initialize(params=[])
    @args = params
  end
  
  def method_missing(method_name, *args)
  end
end