# load the support libraries
require 'test/unit'
require 'rubygems'
require 'mocha'

# load the gem
root = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift root
require root + '/ruby_fps'

class RubyFPS::Test < Test::Unit::TestCase
  def default_test; end # quiet Test::Unit

  def self.should(name, &block) # very simple syntax
    define_method("test_should_#{name.gsub(/[ -]/, '_')}", &block)
  end
end

RubyFPS.access_key = 'foo'
RubyFPS.secret_key = 'bar'
