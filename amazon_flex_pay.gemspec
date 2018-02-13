lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amazon_flex_pay/version'

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

  s.require_paths = ["lib"]

  s.add_dependency('rest-client', '~>1.8.0')
  s.add_dependency('multi_xml', '>= 0.5.2')
  s.add_dependency('activesupport', '>= 3.0.14')

  s.add_development_dependency('mocha')
  s.add_development_dependency("bundler", "~> 1.3")
  s.add_development_dependency("rake")
  s.add_development_dependency("rails", '3.2.22.5')
  s.add_development_dependency "shoulda"
  s.add_development_dependency "minitest"
end
