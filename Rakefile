require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "simple-private-messages"
    gem.summary = "Simple private messages plugin for Rails 3"
    gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
    gem.email = "ferdinand.niedermann@gmail.com"
    gem.authors = ["Jon Gilbraith","Ferdinand Niedermann"]
    # other fields that would normally go in your gemspec
    # like authors, email and has_rdoc can also be included here
  end
rescue
  puts "Jeweler or one of its dependencies is not installed."
end


desc 'Default: run unit tests.'
task :default => :test

desc 'Test the simple_private_messages plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the simple_private_messages plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SimplePrivateMessages'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
