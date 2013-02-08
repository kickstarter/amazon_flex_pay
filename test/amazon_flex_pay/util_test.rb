require_relative '../test_helper'

class AmazonFlexPay::UtilTest < AmazonFlexPay::Test
  should "create a sorted query string" do
    assert_equal "a=1&b=2&c=3&d=4&e=5", AmazonFlexPay.query_string(:a => 1, :b => 2, :c => 3, :d => 4, :e => 5)
  end

  should "flatten nested hashes into a query string using periods" do
    assert_equal "a.a=1&a.b=2&b=3", AmazonFlexPay.query_string(:b => 3, :a => {:a => 1, :b => 2})
  end

  should "percent-encode spaces and other characters for a query string" do
    assert_equal 'a=hello%20world%21', AmazonFlexPay.query_string(:a => 'hello world!')
  end
end
