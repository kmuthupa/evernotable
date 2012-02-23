require 'evernotable/client/base'

class Evernotable::Client::NoteClient < Evernotable::Client::Base 
  def initialize
    super
    @api_url = @config["note_api"]["sandbox"] #TODO: variablize the api env
    @notebook_name = @config["notebook"]["name"]
    self.instance = Evernote::NoteStore.new(note_url)
  end
  
  def add_notebook
    wrap_method('attempt to create new notebook', { |client_token|
      @notebook_guid = self.instance.createNotebook(client_token, Evernote::EDAM::Type::Notebook.new({:name => @notebook_name}).guid}) 
  end

  def add_note(note_text)
    self.add_notebook unless notebook_exists?
    wrap_method('attempt to create a new note', { |client_token|
      self.instance.createNote(client_token, Evernote::EDAM::Type::Note.new({:title => note_text, :content => note_text, :notebookguid => @notebook_guid})})
  end

  def remove_note(note_guid)
    return unless notebook_exists?
    wrap_method('attempt to remove a note', { |client_token|
      self.instance.deleteNote(client_token, note_guid)
  end
  
  def list_notes
    return unless notebook_exists?
    wrap_method('attempt to list notes', { |client_token|
      @notebook_guid = self.instance.createNotebook(client_token, Evernote::EDAM::NoteStore::NoteFilter.new({:notebookguid => @notebook_guid})})
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
    "#{@api_url}/#{self.client_token)}"
  end
end