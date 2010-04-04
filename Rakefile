require 'rake'
require 'rake/clean'

require File.dirname(__FILE__) + "/lib/google_visualization.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "google_visualization"
    gem.version = Google::Visualization::VERSION
    gem.summary = "A Ruby interface to manipulate and populate data for Google Interactive Charts"
    gem.email = "fmmfonseca@gmail.com"
    gem.homepage = "http://github.com/fmmfonseca/google_visualization"
    gem.authors = ["Miguel Fonseca"]
  end
  CLEAN.include("pkg")
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

Dir["tasks/*.rake"].each { |ext| load ext }

task :default => 'test:unit'
