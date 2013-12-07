# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'resque-loner/version'

Gem::Specification.new do |s|
  s.name        = 'resque-loner'
  s.version     = Resque::Plugins::Loner::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jannis Hermanns', 'Tee Parham']
  s.email       = ['jannis@moviepilot.com', 'tee@neighborland.com']
  s.homepage    = 'http://github.com/teeparham/resque-loner'
  s.summary     = 'Adds unique jobs to resque (fork)'

  s.add_dependency 'resque', '~> 1.25'
  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'rack-test', '~> 0.6'
  s.add_development_dependency 'rspec', '~> 2.5'
  s.add_development_dependency 'mock_redis', '~> 0.2'
  
  s.required_ruby_version = '>= 2.0.0'  

  s.executables   = []
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.description = <<desc
Makes sure that for special jobs, there can be only one job with the same workload in one queue.

Example:
    class CacheSweeper 

       include Resque::Plugins::UniqueJob

       @queue = :cache_sweeps

       def self.perform(article_id)
         # Cache Me If You Can...
       end
    end
desc
end
