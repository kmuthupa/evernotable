require "evernotable"
require "evernotable/command"

class Evernotable::CLI

  def self.start(*args)
    command = args.shift.strip rescue "help"
    Evernotable::Command.load
    Evernotable::Command.run(command, args)
  end

end