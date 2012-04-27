# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "Datag/version"

Gem::Specification.new do |s|
  s.name        = "Datag"
  s.version     = Datag::VERSION
  s.authors     = ["da99"]
  s.email       = ["i-hate-spam-45671204@mailinator.com"]
  s.homepage    = "https://github.com/da99/Datag"
  s.summary     = %q{ Print out previous/next git tags. }
  s.description = %q{
    Print out your previous/next git tags: Datag.next, Datag.previous.
  }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bacon'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'Bacon_Colored'
  s.add_development_dependency 'pry'
  
  # Specify any dependencies here; for example:
  s.add_runtime_dependency 'Exit_0'
  s.add_runtime_dependency 'Split_Lines'
  s.add_runtime_dependency 'trollop'
end
