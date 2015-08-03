# Travis-Build-Tools
Creates a Ruby Gem travis-build-tools.

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
      service_user = ENV['GIT_TAG_PUSHER'] #GitHub Deploy key that has access to the repository
      git_repository = %x[git config --get remote.origin.url].split('://')[1]
      builder = TravisBuildTools::Builder.new(service_user, git_repository)
      tag_name = BUILD_VERSION
      builder.publish_git_tag(tag_name)
    end

Automatic downstream branch merging

    task :merge_downstream do
      service_user = ENV['GIT_TAG_PUSHER'] #GitHub Deploy key that has access to the repository
      git_repository = %x[git config --get remote.origin.url].split('://')[1]
      builder = TravisBuildTools::Builder.new(service_user, git_repository)

      downstream_branch_merge_order = ['release\/.*', 'master']
      builder.merge_downstream(downstream_branch_merge_order)
    end  
