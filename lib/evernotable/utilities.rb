module Evernotable
  module Utilities
    
    def format_with_bang(message)
      return '' if message.to_s.strip == ""
      "! " + message.split("\n").join("\n ! ")
    end

    def output_with_bang(message="", new_line=true)
      return if message.to_s.strip == ""
      display(format_with_bang(message), new_line)
    end

    def display(msg="", new_line=true)
      if new_line
        STDOUT.puts(msg)
      else
        STDOUT.print(msg)
        STDOUT.flush
      end
    end
    
    def error(msg)
      STDERR.puts(format_with_bang(msg))
    end
    
    def wrap_enml(content)
      "<?xml version='1.0' encoding='UTF-8'?><!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'><en-note>#{content}</en-note>"
    end
    
  end
end