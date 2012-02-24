require 'evernotable/client/base'
require 'evernotable/utilities'

class Evernotable::Client::NoteClient < Evernotable::Client::Base 
  include Evernotable::Utilities
  attr_reader :notebook_guid
  
  def initialize(params={})
    super(params)
    @api = @config["note_api"]["sandbox"] #TODO: variablize the api env
    @notebook_name = @config["notebook"]["name"]
    @notebook_guid = nil
    @instance = Evernote::NoteStore.new("#{@api}#{params[:user_shard]}")
  end
  
  def add_notebook
    wrap_method('attempt to create new notebook') do |client_token| 
      @notebook_guid = @instance.createNotebook(client_token, Evernote::EDAM::Type::Notebook.new({:name => @notebook_name})).guid 
    end
  end

  def add_note(note_text)
    self.add_notebook unless notebook_exists?
    wrap_method('attempt to create a new note') do |client_token| 
      @instance.createNote(client_token, Evernote::EDAM::Type::Note.new({:title => note_text, :content => wrap_enml(note_text), :notebookGuid => @notebook_guid}))
    end
  end

  def remove_note(note_guid)
    return unless notebook_exists?
    wrap_method('attempt to remove a note') { |client_token| @instance.deleteNote(client_token, note_guid) }
  end
  
  def list_notes
    return unless notebook_exists?
    wrap_method('attempt to list notes') do |client_token| 
      @instance.findNotes(client_token, Evernote::EDAM::NoteStore::NoteFilter.new({:notebookGuid => @notebookGuid}), 0, 100).notes 
    end
  end
  
  def list_notebooks
    wrap_method('attempt to list notebooks') { |client_token| @instance.listNotebooks(client_token) }
  end
  
  def expunge_notebook
    return unless notebook_exists?
    wrap_method('attempt to expunge the evernotable notebook') do |client_token| 
      @instance.expungeNotebook(client_token, @notebook_guid) 
    end
  end
  
  def expunge_trashed_notes
    wrap_method('attempt to expunge all trashed notes') do |client_token| 
      @instance.expungeInactiveNotes(client_token) 
    end
  end
  
  def notebook_exists?
    notebooks = list_notebooks
    notebooks.each do |notebook|
      if notebook.name == 'evernotable'
        @notebook_guid = notebook.guid
        return true
      end
    end
    return false
  end
  
end