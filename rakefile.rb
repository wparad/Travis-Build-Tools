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
require_relative 'lib/travis-build-tools/dsl'

include TravisBuildTools::DSL

#Environment variables: http://docs.travis-ci.com/user/environment-variables/

#### TASKS ####
  RSpec::Core::RakeTask.new(:spec)

  task :clean => [:clobber_package]

  task :default => [:spec, :publish_git_tag]

publish_git_tag :publish_git_tag do |t, args|
  t.git_repository = %x[git config --get remote.origin.url].split('://')[1]
  t.tag_name = BUILD_VERSION
  t.service_user = ENV['GIT_TAG_PUSHER']
end

task :set_owner do
  system("gem owner travis-build-tools -a wparad@gmail.com")
end
