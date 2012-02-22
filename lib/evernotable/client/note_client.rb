require 'evernotable/client/base'

class Evernotable::Client::NoteClient < Evernotable::Client::Base
  def initialize
    super
    @api_url = @config["note_api"]["sandbox"]
    @notebook_name = @config["notebook"]["name"]
    self.instance = Evernote::NoteStore.new(note_url)
  end
  
  def add_notebook
    return if self.notebook_exists?
    wrap_method('attempt to create new notebook', { |client_token|
      @notebook_guid = self.instance.createNotebook(client_token, Evernote::EDAM::Type::Notebook.new({:name => @notebook_name}).guid}) 
  end

  def add_note(note)
    if notebook_exists?
      wrap_method('attempt to create a new note', { |client_token|
        self.instance.createNote(client_token, Evernote::EDAM::Type::Note.new({:title => note, :content => note, :notebookguid => @notebook_guid})})
    end
  end

  def remove_note
    
  end
  
  def list_notes
    if notebook_exists?
      wrap_method('attempt to list notes', { |client_token|
        @notebook_guid = self.instance.createNotebook(client_token, Evernote::EDAM::NoteStore::NoteFilter.new({:notebookguid => @notebook_guid})})
    end
  end
  
  def list_notebooks
    wrap_method('attempt to list notebooks', { |client_token|
      self.instance.listNotebooks(client_token)
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
  
  private
  
  def note_url
    "#{@api_url}/#{self.try(:client_token)}"
  end
end