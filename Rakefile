#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rspec/core/rake_task'
load 'tasks/redis.rake'
require 'resque/tasks'

task default: :spec

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = %w(-fd -c)
end

Rake::TestTask.new do |test|
  test.libs << "test"
  test.test_files = FileList['test/**/*_test.rb']
end

task install: [ 'redis:install', 'dtach:install' ]
