#!/usr/bin/ruby -e
require 'bundler/setup'
require 'fileutils'
require 'rake'
require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'tmpdir'
require_relative 'helpers/constants'
require_relative 'lib/travis-build-tools/builder'

#Environment variables: http://docs.travis-ci.com/user/environment-variables/

#### TASKS ####
  RSpec::Core::RakeTask.new(:spec)

  task :clean => [:clobber_package]

  task :default => [:spec, :publish_git_tag]

  task :after_build => [:display_repository]

task :publish_git_tag do
  builder = TravisBuildTools::Builder.new(ENV['GIT_TAG_PUSHER'])
  tag_name = BUILD_VERSION
  builder.publish_git_tag(tag_name)
end

task :display_repository do
  puts Dir.glob(File.join(PWD, '**', '*'), File::FNM_DOTMATCH).select{|f| !f.match(/\/(\.git|vendor|bundle)\//)}
end
task :set_owner do
  system("gem owner travis-build-tools -a wparad@gmail.com")
end
