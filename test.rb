#!/usr/bin/ruby

require_relative 'lib/travis-build-tools'

ENV['TRAVIS'] = 'true'
ENV['TRAVIS_BRANCH'] = 'release/1.0'
ENV['TRAVIS_PULL_REQUEST'] = 'false'
TravisBuildTools::Builder.new('user').merge_downstream('release/', 'master')
