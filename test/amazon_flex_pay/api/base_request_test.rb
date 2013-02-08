require_relative '../../test_helper'

class AmazonFlexPay::API::BaseRequestTest < AmazonFlexPay::Test

  class TestRequest < AmazonFlexPay::API::BaseRequest
    attribute :foo
    attribute :amount, :type => :amount
    attribute :stuffs, :collection => :amount
    attribute :method, :enumeration => :payment_method
  end

  should "respond with data structures even when models are empty" do
    tr = TestRequest.new
    assert tr.stuffs.is_a?(Array)
    assert tr.amount.respond_to?(:value)
    assert !tr.to_hash.has_key?('Stuffs')
    assert !tr.to_hash.has_key?('Amount')
  end

  should "hash api requests" do
    request = TestRequest.new(:foo => 'bar', :amount => {:value => '3.14', :currency_code => 'USD'})
    hash = request.to_hash

    # simple attributes
    assert_equal 'bar', hash['Foo']

    # complex attributes
    assert_equal '3.14', hash['Amount']['Value']
    assert_equal 'USD', hash['Amount']['CurrencyCode']

    # standard additions
    assert_equal 'TestRequest', hash['Action']
    assert_equal '2011-09-20', hash['Version']
  end

  should "parameterize api requests" do
    Time.stubs(:now).returns(Time.parse('Jan 1 2011')) # so the signature remains constant

    request = TestRequest.new(:foo => 'bar', :amount => {:value => '3.14', :currency_code => 'USD'})
    param = request.to_param

    {
      'Foo' => 'bar',
      'AWSAccessKeyId' => 'foo',
      'SignatureVersion' => 2,
      'SignatureMethod' => 'HmacSHA256',
      'Signature' => 'WVrkmK7qt%2FT%2BgtHWcdzqtkLRH8c06l%2FmPv3ZfxyvNyg%3D'
    }.each do |key, value|
      assert param.match(/#{key}=#{value}/), "#{param} should contain #{key}=#{value}"
    end
  end

  should "not allow unknown values for enumerated attributes" do
    assert_raises ArgumentError do TestRequest.new(:method => 'UNKOWN') end
  end

  should "allow value sets for enumerated attributes" do
    assert_nothing_raised do
      TestRequest.new(:method => ['CC', 'ACH'])
    end
  end

  should "convert value sets into comma-separated lists" do
    assert_equal 'a,b', TestRequest.new(:foo => ['a', 'b']).to_hash['Foo']
  end

end
