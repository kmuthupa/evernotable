# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "evernotable/version"

Gem::Specification.new do |s|
  s.name        = "evernotable"
  s.version     = Evernotable::VERSION
  s.authors     = ["Karthik Muthupalaniappan"]
  s.email       = ["karthik.m@imaginea.com"]
  s.homepage    = "http://intellisenze.wordpress.com"
  s.summary     = %q{A simple commandline task manager that uses Evernote note store}
  s.description = %q{A simple commandline task manager that uses Evernote note store. This automatically creates a new distinct Evernote notebook for persistance of these task notes.}

  s.rubyforge_project = "evernotable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "thrift"
  s.add_dependency "thrift_client"
  s.add_dependency "evernote"
  s.add_dependency "highline"
  s.add_dependency "encrypted_strings"
  s.add_development_dependency "rspec"
end
