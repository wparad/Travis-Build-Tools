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

#Environment variables: http://docs.travis-ci.com/user/environment-variables/

#### TASKS ####
  RSpec::Core::RakeTask.new(:spec)

  task :clean => [:clobber_package]
  
  desc "Install new version of #{NAME}"
  task :redeploy => [:repackage, :deploy]

  task :default => [:repackage, :create_git_tag]

  task :repackage => [:spec]
#### TASKS ####

Gem::PackageTask.new(Gem::Specification.load(Dir['*.gemspec'].first)) do |pkg|
  #pkg.need_zip = true
  #pkg.need_tar = true
end

task :create_git_tag do
  if ENV['TRAVIS']
    raise 'Environment variable GIT_TAG_PUSHER mist be set.' if !ENV['GIT_TAG_PUSHER']

    #Setup up deploy
    puts %x[git config --global user.email "builds@travis-ci.com"]
    puts %x[git config --global user.name "Travis CI"]
    tag = TravisBuildTools::Build::VERSION.to_s
    puts %x[git tag #{tag} -a -m "Generated tag from TravisCI for build #{ENV['TRAVIS_BUILD_NUMBER']}"]
    puts "Pushing Git tag #{tag}."
    
    git_repository = %x[git config --get remote.origin.url].split('://')[1]
    %x[git push --quiet https://#{ENV['GIT_TAG_PUSHER']}@#{git_repository} #{tag} > /dev/null 2>&1]
  end
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
