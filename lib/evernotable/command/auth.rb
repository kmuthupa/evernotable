require "evernotable/command/base"

class Evernotable::Command::Auth < Evernotable::Command::Base
  
  def login
    
  end
  
  def logout
    
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