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
    @config = YAML.load(File.read('lib/evernotable_config.yml'))
    @args = params
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
  
  def method_missing(method_name, *args)
  end
end