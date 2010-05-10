require 'rake'
require 'rake/clean'

require File.dirname(__FILE__) + "/lib/google_visualization.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "btucker-google_visualization"
    gem.version = Google::Visualization::VERSION
    gem.summary = "A Ruby interface to manipulate and populate data for Google Interactive Charts.  Differ's from original in that it uses the JSON gem to provide valid JSON."
    gem.email = "ben@btucker.net"
    gem.homepage = "http://github.com/btucker/google_visualization"
    gem.authors = ["Ben Tucker", "Miguel Fonseca"]
    gem.add_dependency 'json'
  end
  CLEAN.include("pkg")
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

Dir["tasks/*.rake"].each { |ext| load ext }

task :default => 'test:unit'
