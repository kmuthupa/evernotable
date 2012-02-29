require "evernotable/command"
require "evernotable/client/user"
require "evernotable/client/note"
require 'evernotable/utilities'

class Evernotable::Command::Base
  
  include Evernotable::Utilities
  
  def initialize(params=[])
    @config = YAML.load(File.read('lib/evernotable_config.yml'))
    @args = params.map {|p| p.strip}
    @highline = HighLine.new
  end
  
  def authenticate_user(user=[])
    user = read_from_file(credentials_file).split('/') if user.empty?
    @user_client = Evernotable::Client::User.new({:user => user.first, :password => user.last, :config => @config})
    begin
      @user_client.authenticate
    rescue Evernotable::Client::ClientException => ex
      raise Evernotable::Command::CommandFailed, "Invalid Evernote credentials."
    end
  end
  
  def note_client
    authenticate_user
    Evernotable::Client::Note.new({:user_shard => @user_client.current_user.shardId, :client_token => @user_client.client_token, :config => @config})
  end
  
  def invoke_client
    begin
      yield
    rescue Evernotable::Client::ClientException => ex
      raise Evernotable::Command::CommandFailed, "Oops! That didn't work."
    end
  end
  
  def method_missing(method_name, *args)
  end
  
  protected
  
  def credentials_file
    @config["credentials_file"]["path"]
  end
end