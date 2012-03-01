require "evernotable/command/base"

class Evernotable::Command::Task < Evernotable::Command::Base
  
  def add
    invoke_client do
      unless @args.empty?
        note_client.add_note(@args.first)
        display 'Done.'
      else
        display 'Nothing to add!'
      end
    end
  end

  def list
    invoke_client do
      notes = note_client.list_notes
      notes.collect{|n| n.title}.each_with_index{|n, i| display "#{i+1}. #{n}"}
    end
  end

  def remove
    invoke_client do
      unless @args.empty?
        note_client.remove_note(@args.first)
        display 'Done.' 
      else
        display 'Nothing to remove!'
      end
    end
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