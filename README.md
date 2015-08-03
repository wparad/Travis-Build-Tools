# Travis Build Tools
A Ruby Gem to manage common Travis-CI build elemets.

[![Gem Version](https://badge.fury.io/rb/travis-build-tools.svg)](http://badge.fury.io/rb/travis-build-tools)

[![Build Status](https://travis-ci.org/wparad/Travis-Build-Tools.svg?branch=master)](https://travis-ci.org/wparad/Travis-Build-Tools)

### Usage
Version is created by joining the the number of the release branch number with the build number and then a zero.  `(release.number).(build number).0`.
  
    #!/usr/bin/ruby
    require 'travis-build-tools'
    VERSION = TravisBuildTools::Version #Returns Gem::Version
    puts VERSION

Generate Github Tags

    task :publish_git_tag do
      service_user = ENV['GIT_USER'] #GitHub repo access key
      builder = TravisBuildTools::Builder.new(service_user)
      tag_name = BUILD_VERSION
      builder.publish_git_tag(tag_name)
    end

Automatic downstream branch merging

    task :merge_downstream do
      service_user = ENV['GIT_USER'] #GitHub repo access key
      builder = TravisBuildTools::Builder.new(service_usery)

      branch_name_matcher = 'release/'
      master_branch_name = 'master'
      builder.merge_downstream(branch_name_matcher, master_branch_name)
    end  
