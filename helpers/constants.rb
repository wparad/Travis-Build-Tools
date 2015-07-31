require_relative '../lib/travis-build-tools/build'

PWD = File.expand_path(File.join(File.dirname(__FILE__), '..'))
PKG_DIR = File.join(PWD, 'pkg')
BIN = 'bin'
LIB = 'lib'
NAME = 'travis-build-tools'

BUILD_VERSION = TravisBuildTools::Build::VERSION.to_s
