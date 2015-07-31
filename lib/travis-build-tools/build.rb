module TravisBuildTools
  module Build
    RELEASE_VERSION = case
      #Builds of pull requests
      when ['TRAVIS_PULL_REQUEST'] && !ENV['TRAVIS_PULL_REQUEST'].match(/false/i) then "0.#{ENV['TRAVIS_PULL_REQUEST']}"
      #Builds of branches that aren't master or release
      when !ENV['TRAVIS_BRANCH'] || !ENV['TRAVIS_BRANCH'].match(/^release[\/-]/i) then '0.0'
      #Builds of release branches (or locally or on server)
      else ENV['TRAVIS_BRANCH'].match(/^release[\/-](\d+\.\d+)$/i)[1]
    end
    now = Time.now.to_a
    VERSION = Gem::Version.new("#{RELEASE_VERSION}.#{ENV['TRAVIS_BUILD_NUMBER'] || '0'}")
    PULL_REQUEST = ENV['TRAVIS_PULL_REQUEST'].match(/false/i) ? nil : ENV['TRAVIS_PULL_REQUEST']
  end
end
