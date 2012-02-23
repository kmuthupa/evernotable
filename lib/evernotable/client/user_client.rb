require 'evernotable/client/base'

class Evernotable::Client::UserClient < Evernotable::Client::Base 
  def initialize(user, password)
    super
    @api_key = @config["api_credentials"]["consumer_key"]
    @api_secret = @config["api_credentials"]["consumer_secret"]
    @user = user
    @password = password
    api_url = @config["user_api"]["sandbox"] #TODO: variablize the api env
    self.instance = Evernote::UserStore.new(api_url, auth_params)
  end
  
  def authenticate
    wrap_method('attempt to authenticate the user', { 
      self.client_token = self.instance.authenticate.authenticationToken })
  end
  
  def refresh_authentication
    wrap_method('attempt to refresh auth token', { |client_token|
      self.instance.refreshAuthentication(client_token)})
  end

  def valid_version?
    wrap_method('attempt to check API version', {
      self.instance.version_valid? })
  end
  
  private
  
  def auth_params
    {:username => self.user, :password => self.password, :consumer_key => self.api_key, :consumer_secret => self.api_secret}
  end
end