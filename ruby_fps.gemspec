$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'ruby_fps'

Gem::Specification.new do |s|
  s.name = 'ruby_fps'
  s.version = RubyFPS::VERSION
  s.authors = ['Lance Ivy']
  s.email = 'lance@kickstarter.com'
  s.homepage = 'http://github.com/kickstarter/ruby_fps'
  s.summary = 'API layer for Amazon FPS'
  s.description = 'A straight-forward REST API for Amazon\'s Flexible Payments Services.'

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.rdoc)
  s.test_files = Dir.glob("test/**/*")

  s.add_dependency('rest-client', '~>1.6.1')
  s.add_dependency('multi_xml', '~>0.2.0')
  s.add_dependency('active_support', '~>2.3.11')

  s.add_development_dependency('mocha')
end
