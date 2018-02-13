# load the support libraries
require 'rubygems'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'mocha/setup'
require 'shoulda'

# load the gem
require_relative '../lib/amazon_flex_pay'

require_relative 'response_samples'

class AmazonFlexPay::Test < Minitest::Test
  def assert_nothing_raised(*)
    yield
  end
end

AmazonFlexPay.access_key = 'foo'
AmazonFlexPay.secret_key = 'bar'
