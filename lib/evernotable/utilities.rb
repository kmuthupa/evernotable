module Evernotable
  module Utilities
    def error(msg)
      STDERR.puts(format_with_bang(msg))
      exit 1
    end

    def format_with_bang(message)
      return '' if message.to_s.strip == ""
      " !    " + message.split("\n").join("\n !    ")
    end

    def output_with_bang(message="", new_line=true)
      return if message.to_s.strip == ""
      display(format_with_bang(message), new_line)
    end

    def display(msg="", new_line=true)
      if new_line
        puts(msg)
      else
        print(msg)
        STDOUT.flush
      end
    end
  end
end