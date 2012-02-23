require 'evernotable/client/base'

class Evernotable::Client::UserClient < Evernotable::Client::Base 
  
  def initialize(params={})
    super
    api = @config["user_api"]["sandbox"] #TODO: variablize the api env
    @instance = Evernote::UserStore.new(api, {:username => params[:user], :password => params[:password], :consumer_key => @config["api_credentials"]["consumer_key"], :consumer_secret => @config["api_credentials"]["consumer_secret"]})
  end
  
  def authenticate
    self.wrap_method('attempt to authenticate the user') do
      auth_result = @instance.authenticate
      self.current_user = auth_result.user
      self.client_token = auth_result.authenticationToken
    end
  end
  
  def refresh_authentication
    self.wrap_method('attempt to refresh auth token') {|client_token| self.client_token = @instance.refreshAuthentication(client_token).authenticationToken}
  end

  def valid_version?
    self.wrap_method('attempt to check API version') { @instance.version_valid? }
  end
  
end