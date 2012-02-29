require "evernotable/command"
require "evernotable/client/user"
require "evernotable/client/note"
require 'evernotable/utilities'

class Evernotable::Command::Base
  
  include Evernotable::Utilities
  
  attr_reader :config
  attr_reader :args
  attr_reader :user_client
  attr_reader :note_client
  
  def initialize(params=[])
    @config = YAML.load(File.read('lib/evernote_config.yml'))
    @args = params
    @highline = HighLine.new
  end
  
  def method_missing(method_name, *args)
  end
end