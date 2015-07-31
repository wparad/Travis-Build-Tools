# Travis-Build-Tools
Creates a Ruby Gem travis-build-tools.

### Usage
Version is created by joining the the number of the release branch number with the build number and then a zero.  `(release.number).(build number).0`.
  
    #!/usr/bin/ruby
    require 'travis-build-tools'
    VERSION = TravisBuildTools::Version #Returns Gem::Version
    puts VERSION
