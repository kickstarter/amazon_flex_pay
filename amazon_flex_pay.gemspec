$LOAD_PATH << File.dirname(__FILE__) + '/lib'
require 'amazon_flex_pay'

Gem::Specification.new do |s|
  s.name = 'amazon_flex_pay'
  s.version = AmazonFlexPay::VERSION
  s.authors = ['Lance Ivy']
  s.email = 'lance@kickstarter.com'
  s.homepage = 'http://github.com/kickstarter/amazon_flex_pay'
  s.summary = 'API layer for Amazon FPS'
  s.description = 'A straight-forward REST API for Amazon\'s Flexible Payments Services.'

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.rdoc Rakefile)
  s.test_files = Dir.glob("test/**/*")

  s.add_dependency('rest-client', '~>1.6.1')
  s.add_dependency('multi_xml', '~>0.5.0')
  s.add_dependency('activesupport', '>= 3.0.14')

  s.add_development_dependency('mocha')
end
