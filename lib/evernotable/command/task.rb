require "evernotable/command/base"

class Evernotable::Command::Task < Evernotable::Command::Base
  
  def add
    
  end
  
  def list
    
  end
  
  def remove

  end

  def method_missing(method_name, *args)
    case method_name
    when :help then 

    end
  end
end