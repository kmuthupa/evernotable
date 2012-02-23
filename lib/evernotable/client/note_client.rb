require 'evernotable/client/base'

class Evernotable::Client::NoteClient < Evernotable::Client::Base 
  
  def initialize(params={})
    super
    @api = @config["note_api"]["sandbox"] #TODO: variablize the api env
    @notebook_name = @config["notebook"]["name"]
    @instance = Evernote::NoteStore.new("#{@api}/#{params[:user_shard]}")
  end
  
  def add_notebook
    wrap_method('attempt to create new notebook') do |client_token| 
      @notebook_guid = @instance.createNotebook(client_token, Evernote::EDAM::Type::Notebook.new({:name => @notebook_name})).guid 
    end
  end

  def add_note(note_text)
    self.add_notebook unless notebook_exists?
    wrap_method('attempt to create a new note') do |client_token| 
      @instance.createNote(client_token, Evernote::EDAM::Type::Note.new({:title => note_text, :content => note_text, :notebookguid => @notebook_guid}))
    end
  end

  def remove_note(note_guid)
    return unless notebook_exists?
    wrap_method('attempt to remove a note') { |client_token| @instance.deleteNote(client_token, note_guid) }
  end
  
  def list_notes
    return unless notebook_exists?
    wrap_method('attempt to list notes') do |client_token| 
      @notebook_guid = @instance.createNotebook(client_token, Evernote::EDAM::NoteStore::NoteFilter.new({:notebookguid => @notebook_guid})) 
    end
  end
  
  def list_notebooks
    wrap_method('attempt to list notebooks') { |client_token| @instance.listNotebooks(client_token) }
  end
  
  def notebook_exists?
    notebooks = list_notebooks
    notebooks.each do |notebook|
      if notebook.name.equal?('evernotable')
        @notebook_guid = notebook.guid
        true
      end
    end
    false
  end
  
end