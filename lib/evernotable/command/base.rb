require "evernotable/command"
require "evernotable/client/user_client"
require "evernotable/client/note_client"

class Evernotable::Command::Base
  
  include Evernotable::Utilities
  
  attr_reader :args
  
  def initialize(params=[])
    @args = params
  end
  
  def method_missing(method_name, *args)
  end
end