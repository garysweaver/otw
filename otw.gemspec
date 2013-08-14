# -*- encoding: utf-8 -*-  
$:.push File.expand_path("../lib", __FILE__)  
require "otw/version" 

Gem::Specification.new do |s|
  s.name        = 'otw'
  s.version     = Otw::VERSION
  s.authors     = ['Gary S. Weaver']
  s.email       = ['garysweaver@gmail.com']
  s.homepage    = 'https://github.com/garysweaver/otw'
  s.summary     = "Adds current_controller on ActiveRecord model instance so request, etc. can be used in model/model callbacks."
  s.description = "Provides `current_controller` in each model instance in a way that intends to be safe for concurrent access. Throws separation of concerns \"out the window\" for specific cases where it is needed."
  s.required_rubygems_version = ">= 1.3.6"
  s.files = Dir['lib/**/*'] + ['Rakefile', 'README.md']
  s.license = 'MIT'
  s.add_dependency 'activesupport', '>= 3.0.0'
  s.add_runtime_dependency 'activerecord', '>= 3.0.0'  
  s.add_runtime_dependency "actionpack", ">= 3.0.0"
  s.add_development_dependency "rails", ">= 3.0.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rake"
  #s.add_development_dependency "rspec"
  #s.add_development_dependency "rspec-rails"
end
