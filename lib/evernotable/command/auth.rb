require "evernotable/command/base"

class Evernotable::Command::Auth < Evernotable::Command::Base
  
  def login
    user = [] << @highline.ask("Enter your Evernote username: ")
    user << @highline.ask("Enter your Evernote password: ") { |q| q.echo = "*" }
    authenticate_user(user)
    write_to_file credentials_file, user.join('/')
    display "You were successfully authenticated."
  end
  
  def logout
    if File.exist?(credentials_file)
      File.delete(credentials_file)
      display "You were successfully logged out."
    else
      output_with_bang "You are not logged in."
    end
  end
  
  def method_missing(method_name, *args)
    case method_name
    when :help then
      display '--------------------------------------------'
      display '# authenticate 
      evernotable auth login
      evernotable auth logout'
      display '--------------------------------------------'
    end
  end
  
end