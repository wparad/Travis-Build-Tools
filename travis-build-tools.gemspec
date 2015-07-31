$LOAD_PATH << '.'
require 'helpers/constants'

#EXECUTABLE_NAME = 'travis-build-tools'

Gem::Specification.new() do |s|
  s.name = NAME
  s.version = BUILD_VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Warren Parad']
  s.license = 'BSD-3-Clause'
  s.email = ["wparad@gmail.com"]
  s.homepage = 'https://github.com/wparad/Travis-Build-Tools'
  s.summary = 'A lightweight build and deployment tool wrapper'
  s.description = "#{NAME} allows you to easily create ruby-build packages using Travis CI."
  s.files = Dir.glob("{#{BIN},#{LIB}}/{**}/{*}", File::FNM_DOTMATCH).select{|f| !(File.basename(f)).match(/^\.+$/)}
  #s.executables = [EXECUTABLE_NAME]
  #s.requirements << 'none'
  s.require_paths = ['lib']
  s.add_runtime_dependency('bundler', '~> 1.10')
  s.add_runtime_dependency('rest-client', '~>1.8')
  s.add_runtime_dependency('rubyzip', '~> 1.1')
end
