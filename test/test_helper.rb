# load the support libraries
require 'test/unit'
require 'rubygems'
gem 'rails', '3.2.5'
require 'mocha'

# load the gem
root = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift root
require root + '/amazon_flex_pay'

require 'response_samples'

class AmazonFlexPay::Test < Test::Unit::TestCase
  def default_test; end # quiet Test::Unit

  def self.should(name, &block) # very simple syntax
    define_method("test_should_#{name.gsub(/[ -]/, '_')}", &block)
  end
end

AmazonFlexPay.access_key = 'foo'
AmazonFlexPay.secret_key = 'bar'
