require File.dirname(__FILE__) + '/test_helper'

class AmazonFlexPayTest < AmazonFlexPay::Test
  ## signing

  should "generate a valid v2 signature" do
    # NOTE: I'm not sure of a supplied signature example that I can copy, so
    # I set this one up by making sure signatures were being accepted by
    # Amazon and then generating and saving my own example. Kinda backwards
    # but good enough for regression testing.
    assert_equal "Ro7iH0M+1hIR/SXGvT1kmF6Tg5uUKRSUd1AWaJHOcpE=", AmazonFlexPay::Signature.new(AmazonFlexPay.secret_key, 'http://example.com/api', :hello => 'world').generate
  end

  ## query strings

  should "create a sorted query string" do
    assert_equal "a=1&b=2&c=3&d=4&e=5", AmazonFlexPay.query_string(:a => 1, :b => 2, :c => 3, :d => 4, :e => 5)
  end

  should "flatten nested hashes into a query string using periods" do
    assert_equal "a.a=1&a.b=2&b=3", AmazonFlexPay.query_string(:b => 3, :a => {:a => 1, :b => 2})
  end

  should "percent-encode spaces and other characters for a query string" do
    assert_equal 'a=hello%20world%21', AmazonFlexPay.query_string(:a => 'hello world!')
  end

  ## verifying a request

  should "verify a GET request" do
    request = stub(:get? => true, :protocol => 'http://', :host_with_port => 'example.com', :path => '/foo/bar', :query_string => 'a=1&b=2')
    AmazonFlexPay.expects(:verify_signature).with('http://example.com/foo/bar', 'a=1&b=2').returns(true)
    assert AmazonFlexPay.verify_request(request)
  end

  should "verify a POST request" do
    request = stub(:get? => false, :protocol => 'http://', :host_with_port => 'example.com', :path => '/foo/bar', :raw_post => 'a=1&b=2')
    AmazonFlexPay.expects(:verify_signature).with('http://example.com/foo/bar', 'a=1&b=2').returns(true)
    assert AmazonFlexPay.verify_request(request)
  end

  # api basics

  class TestRequest < AmazonFlexPay::API::BaseRequest
    attribute :foo
    attribute :amount, :type => :amount
    attribute :stuffs, :collection => :amount
    attribute :method, :enumeration => :payment_method

    class Response < AmazonFlexPay::API::BaseRequest::BaseResponse; end
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

  should "store the request in the response" do
    RestClient.expects(:get).returns(stub(:body => cancel_token_response, :code => 200))
    response = TestRequest.new(:foo => 'bar').submit
    assert_equal 'bar', response.request.foo
  end

  should "instrument successful responses" do
    events = []
    callback = proc{ |*args| events << ActiveSupport::Notifications::Event.new(*args) }

    ActiveSupport::Notifications.subscribed(callback, "amazon_flex_pay.api") do
      RestClient.expects(:get).returns(stub(:body => cancel_token_response, :code => 200))
      TestRequest.new(:foo => 'bar').submit
    end

    assert_equal 1, events.size
    assert_equal 'TestRequest', events.first.payload[:action]
    assert_equal 200, events.first.payload[:code]
    assert events.first.payload.has_key?(:request)
    assert events.first.payload.has_key?(:response)
    assert events.first.duration > 0.1, events.first.duration.to_s
  end

  should "catch and parse errors" do
    net_http_res = stub(:code => 400)
    http_response = RestClient::Response.create(error_response, net_http_res, nil)
    RestClient.expects(:get).raises(RestClient::BadRequest.new(http_response))

    error = nil
    begin
      TestRequest.new(:foo => 'bar').submit
    rescue AmazonFlexPay::API::InvalidParams => e
      error = e
    end
    assert error.request_id
    assert_equal 'InvalidParams', error.code
    assert error.message.match(/has to be a valid/)
  end

  should "instrument error responses" do
    events = []
    callback = proc{ |*args| events << ActiveSupport::Notifications::Event.new(*args) }

    ActiveSupport::Notifications.subscribed(callback, "amazon_flex_pay.api") do
      net_http_res = stub(:code => 400)
      http_response = RestClient::Response.create(error_response, net_http_res, nil)
      RestClient.expects(:get).raises(RestClient::BadRequest.new(http_response))

      TestRequest.new(:foo => 'bar').submit rescue AmazonFlexPay::API::Error
    end

    assert_equal 1, events.size
    assert_equal 'TestRequest', events.first.payload[:action]
    assert_equal 400, events.first.payload[:code]
    assert events.first.payload.has_key?(:request)
    assert events.first.payload.has_key?(:response)
    assert events.first.duration > 0.1, events.first.duration.to_s
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

  # pipeline basics

  class TestPipeline < AmazonFlexPay::Pipelines::Base
    attribute :foo
  end

  should "hash pipelines" do
    pipeline = TestPipeline.new(:foo => 'bar')
    hash = pipeline.to_hash('http://example.com/return')

    assert_equal 'TestPipeline', hash['pipelineName']
    assert_equal '2009-01-09', hash['version']
    assert_equal 'http://example.com/return', hash['returnURL']
  end

  should "parameterize signed pipelines" do
    Time.stubs(:now).returns(Time.parse('Jan 1 2011')) # so the signature remains constant

    pipeline = TestPipeline.new(:foo => 'bar')
    param = pipeline.to_param('http://example.com/return')

    {
      'foo' => 'bar',
      'callerKey' => 'foo',
      'signatureVersion' => 2,
      'signatureMethod' => 'HmacSHA256',
      'signature' => 'OuUJQqFBJhezmcWOAhDGcsD%2F6OXpOLVlcbF3XMIZO3U%3D'
    }.each do |key, value|
      assert param.match(/#{key}=#{value}/), "#{param} should contain #{key}=#{value}"
    end
  end
end
