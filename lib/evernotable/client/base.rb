require 'evernote'
require 'yaml'

class Evernotable::Client::Base 
  class ClientException < RuntimeError
  end
  
  def initialize
    @config = YAML.load(File.read('lib/evernote_config.yml'))
  end
  
  protected 
  
  def wrap_method(message, &block)
    yield self.client_token
  rescue 
    raise ClientException, message
  end

  attr_reader :config, 
  attr_writer :instance
  attr_accessor :client_token
end