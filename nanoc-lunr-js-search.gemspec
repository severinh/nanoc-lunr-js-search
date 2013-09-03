# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors = ["Severin Heiniger"]
  gem.email = ["severinheiniger@gmail.com"]
  gem.description = %q{JavaScript-based full-text search for nanoc-generated static websites}
  gem.summary = %q{This nanoc filter extracts the content of HTML files into a JSON file.
    Use the JavaScript library lunr.js to load this file and allow the visitor to search
    the complete nanoc-generated website without any server-side processing.}
  gem.homepage = "https://github.com/severinh/nanoc-lunr-js-search"

  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/§*`.split("\n")
  gem.name = "nanoc-lunr-js-search"
  gem.require_paths = ["lib"]
  gem.version = '0.1'

  gem.add_dependency 'nanoc', '>= 3.3.0'
  gem.add_dependency 'json'
  gem.add_dependency 'nokogiri'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'bluecloth'
end