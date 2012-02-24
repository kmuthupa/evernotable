require 'evernotable/utilities'

module Evernotable
  module Command

    class CommandFailed  < RuntimeError
    end
    
    extend Evernotable::Utilities

    def self.load
      Dir[File.join(File.dirname(__FILE__), "command", "*.rb")].each do |file|
        require file
      end
      @@commands = {'auth' => '', 'task' => ''}
    end
    
    def self.parse(cmd)
       @@commands[cmd] 
    end

    def self.prepare_run(cmd, args=[])
      command = parse(cmd)

      unless command
        output_with_bang("*#{cmd}* is not a valid evernotable command.")
        output_with_bang("Use *evernotable help* for additional information.")
        exit(1)
      end

      @current_command = cmd
      @current_args = args

      [ command[:klass].new(args.dup, opts.dup), command[:method] ]
    end

    def self.run(cmd, arguments=[])
      object, method = prepare_run(cmd, arguments.dup)
      object.send(method)
    rescue CommandFailed => ex
      error ex.message
    rescue Interrupt => e
      error "\n[canceled]"
    end

  end
end