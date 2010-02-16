$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'google_visualization'

# Load all rakefile extensions
Dir["tasks/*.rake"].each { |ext| load ext }

# Set default task
task :default => ["test:unit"]