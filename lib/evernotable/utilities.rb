require 'encrypted_strings'

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
      exit(1)
    end
    
    def wrap_enml(content)
      "<?xml version='1.0' encoding='UTF-8'?><!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'><en-note>#{content}</en-note>"
    end
    
    def write_to_file(file, content)
      File.open(file, 'w') {|f| f.write(content.encrypt(:symmetric, :password => encrypt_key))}
    end
    
    def read_from_file(file)
      File.exist?(file) ? File.read(file).decrypt(:symmetric, :password => encrypt_key) : '' 
    end
    
    def encrypt_key
      config = YAML.load(File.read('lib/evernotable_config.yml'))
      return config["encryption"]["key"]
    end
    
  end
end