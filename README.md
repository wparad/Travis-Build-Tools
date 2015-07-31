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
