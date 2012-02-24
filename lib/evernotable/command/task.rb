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
      display '--------------------------------------------'
      display '# add a new task
      evernotable task add shave my beard!'
      display '# list all existing tasks
      evernotable task list'
      display '# remove an existing task
      evernotable task remove #2 => removes task listed #2'
      display '--------------------------------------------'
    end
  end
end