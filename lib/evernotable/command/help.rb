require "evernotable/command/base"

class Evernotable::Command::Help < Evernotable::Command::Base
  
  def method_missing(method_name, *args)
    case method_name
    when :help then
      display('Evernotable is a simple commandline task/todo manager that uses Evernote note store')
      display 'This automatically creates a new distinct Evernote notebook for persistance of tasks. 
      Users can add new tasks, list them and remove existing tasks after authenticating using their Evernote credentials.'
      display '# authenticate 
      evernotable auth login
      evernotable auth logout'
      display '# add a new task
      evernotable task add shave my beard!'
      display '# list all existing tasks
      evernotable task list'
      display '# remove an existing task
      evernotable task remove #2 => removes task listed #2'
    end
  end
  
end