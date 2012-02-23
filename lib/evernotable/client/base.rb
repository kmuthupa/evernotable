require 'evernote'
require 'evernotable/client'
require 'yaml'

class Evernotable::Client::Base 
  attr_reader :config
  attr_reader :current_user
  attr_reader :client_token
  
  def initialize(params={})
    @config = YAML.load(File.read('lib/evernote_config.yml'))
    @current_user = params[:current_user] || nil
    @client_token = params[:client_token] || nil
  end
  
  def wrap_enml(note_content)
    "<?xml version='1.0' encoding='UTF-8'?>
    <!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'>
    <en-note>
       #{note_content}
    </en-note>"
  end
  
  protected 
  
  def wrap_method(message, &block)
    yield @client_token
  rescue Exception => ex
    raise Evernotable::Client::ClientException, "#{message}: #{ex.message}"
  end
  
  attr_writer :current_user
  attr_writer :client_token
end




