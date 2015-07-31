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
  
  desc "Install new version of #{NAME}"
  task :redeploy => [:repackage, :deploy]

  task :default => [:spec, :publish_git_tag]

  task :repackage => [:spec]
#### TASKS ####

Gem::PackageTask.new(Gem::Specification.load(Dir['*.gemspec'].first)) do |pkg|
  #pkg.need_zip = true
  #pkg.need_tar = true
end

publish_git_tag :publish_git_tag do |t, args|
  t.git_repository = %x[git config --get remote.origin.url].split('://')[1]
  t.tag_name = BUILD_VERSION
  t.service_user = ENV['GIT_TAG_PUSHER']
end

task :uninstall do
  Bundler.with_clean_env do
    puts %x[gem uninstall -x travis-build-tools -a]
  end
end

task :deploy do
  Bundler.with_clean_env do
    #Create local gem repository for testing
    Dir.chdir(PKG_DIR) do
      FileUtils.rm_rf('gems')
      gem = Dir["*.gem"].first
      FileUtils.mkdir_p('gems')
      FileUtils.cp(gem, 'gems')
      %x[gem generate_index]
    end
    puts %x[gem install pkg/*.gem --no-ri --no-rdoc -u -N]
  end
end
