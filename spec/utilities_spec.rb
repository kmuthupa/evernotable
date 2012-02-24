require 'evernotable/utilities'

describe Evernotable::Utilities do
  include Evernotable::Utilities
  it 'should test format message with bang' do
    format_with_bang('').should == ''
    format_with_bang('hello there').should == '! hello there'
    format_with_bang("hello there\nWhats up?").should == "! hello there\n ! Whats up?"
  end
  
  it 'should test display message' do
    STDOUT.should_receive(:puts).with("hello there")
    display('hello there', true)
    STDOUT.should_receive(:print).with("hello there")
    display('hello there', false)
  end
  
  it 'should test output with bang' do
    STDOUT.should_receive(:puts).with("! hello there is a problem")
    output_with_bang('hello there is a problem')
    STDOUT.should_receive(:print).with("! hello there")
    output_with_bang('hello there', false)
  end
  
  it 'should test error display' do
    STDERR.should_receive(:puts).with('')
    lambda {error(nil)}.should raise_error(SystemExit)
    STDERR.should_receive(:puts).with("! error thrown")
    lambda {error('error thrown')}.should raise_error(SystemExit)
  end
  
  it 'should wrap enml content around a string' do
    wrap_enml('test').should == "<?xml version='1.0' encoding='UTF-8'?><!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'><en-note>test</en-note>"
  end
  
end