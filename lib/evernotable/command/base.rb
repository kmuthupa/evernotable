require "evernotable/command"
require "evernotable/client/user_client"
require "evernotable/client/note_client"

class Evernotable::Command::Base
  
  attr_reader :args
  
  def initialize(params=[])
    @args = params
  end
  
end