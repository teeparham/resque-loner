#
# Setup
#

$LOAD_PATH.unshift 'lib'

require "rubygems"
require "bundler"
Bundler.setup

require 'rspec/core/rake_task'

load 'tasks/redis.rake'
require 'rake/testtask'

require 'resque/tasks'

require 'bundler/gem_tasks'

#
# Tests
#

task :default => :spec

desc "Run specs for resque-loner"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = %w(-fd -c)
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList['test/**/*_test.rb']
end

#
# Install
#

task :install => [ 'redis:install', 'dtach:install' ]


#
# Documentation
#

begin
  require 'sdoc_helpers'
rescue LoadError
end

