require 'evernote'
require 'evernotable/client'
require 'yaml'

class Evernotable::Client::Base 
  attr_reader :current_user
  attr_reader :client_token
  
  def initialize(params={})
    @config = params[:config] || nil
    @env = params[:env]
    @current_user = params[:current_user] || nil
    @client_token = params[:client_token] || nil
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




