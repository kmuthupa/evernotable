require 'evernotable/utilities'

module Evernotable
  module Command
    
    extend Evernotable::Utilities
    
    class CommandFailed  < RuntimeError
    end

    def self.load
      @@commands = []
      Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
        require file
        @@commands << File.basename(file, '.*') 
      end
    end
    
    def self.commands
      @@commands ||= []
    end
    
    def self.valid?(cmd)
       @@commands.include?(cmd)
    end

    def self.run(cmd, arguments=[])
      if cmd.nil? || cmd.empty? 
        output_with_bang("Use *evernotable help* for additional information.")
        exit(1)
      end
      unless valid?(cmd)
        output_with_bang("*#{cmd}* is not a valid evernotable command.")
        output_with_bang("Use *evernotable help* for additional information.")
        exit(1)
      else
        #instantiate command and invoke method on it
        method = arguments.shift || :help
        obj = eval("Evernotable::Command::#{cmd.capitalize}").new(arguments)
        obj.send(method)
      end
    rescue CommandFailed => ex
      error "#{ex.message}"
    rescue Interrupt => e
      error "\n[command canceled]"
    end

  end
end