require File.dirname(__FILE__) + '/test_helper'

class RubyFPSTest < RubyFPS::Test
  ## signing

  should "generate a valid v2 signature" do
    # NOTE: I'm not sure of a supplied signature example that I can copy, so
    # I set this one up by making sure signatures were being accepted by
    # Amazon and then generating and saving my own example. Kinda backwards
    # but good enough for regression testing.
    assert_equal "Ro7iH0M+1hIR/SXGvT1kmF6Tg5uUKRSUd1AWaJHOcpE=", RubyFPS.signature('http://example.com/api', {:hello => 'world'})
  end

  ## query strings

  should "create a sorted query string" do
    assert_equal "a=1&b=2&c=3&d=4&e=5", RubyFPS.query_string(:a => 1, :b => 2, :c => 3, :d => 4, :e => 5)
  end

  should "flatten nested hashes into a query string using periods" do
    assert_equal "a.a=1&a.b=2&b=3", RubyFPS.query_string(:b => 3, :a => {:a => 1, :b => 2})
  end

  should "percent-encode spaces and other characters for a query string" do
    assert_equal 'a=hello%20world%21', RubyFPS.query_string(:a => 'hello world!')
  end

  ## verifying a request

  should "verify a GET request" do
    request = stub(:get? => true, :protocol => 'http://', :host_with_port => 'example.com', :path => '/foo/bar', :query_string => 'a=1&b=2')
    RubyFPS.expects(:verify_signature).with('http://example.com/foo/bar', 'a=1&b=2').returns(true)
    assert RubyFPS.verify_request(request)
  end

  should "verify a POST request" do
    request = stub(:get? => false, :protocol => 'http://', :host_with_port => 'example.com', :path => '/foo/bar', :raw_post => 'a=1&b=2')
    RubyFPS.expects(:verify_signature).with('http://example.com/foo/bar', 'a=1&b=2').returns(true)
    assert RubyFPS.verify_request(request)
  end

  # api basics

  class TestRequest < RubyFPS::API::Base
    attribute :foo
    attribute :amount, :type => :amount

    class Response; end
  end

  should "add necessary fields and sign api requests" do
    Time.stubs(:now).returns(Time.parse('Jan 1 2011')) # so the signature remains constant

    request = TestRequest.new(:foo => 'bar', :amount => {:value => '3.14', :currency_code => 'USD'})
    params = request.to_params

    # simple attributes
    assert_equal 'bar', params['Foo']

    # complex attributes
    assert_equal '3.14', params['Amount']['Value']
    assert_equal 'USD', params['Amount']['CurrencyCode']

    # standard additions
    assert_equal 'foo', params['AWSAccessKeyId']
    assert_equal 'TestRequest', params['Action']
    assert_equal '2008-09-17', params['Version']

    # the signature is backwards-calculated for regression testing
    assert_equal '7nugNc5UdqKn7cgsaH2Di1w9Mx0AouaJiTi8bsN7wWc=', params['Signature']
    assert_equal 'HmacSHA256',                                   params['SignatureMethod']
    assert_equal 2,                                              params['SignatureVersion']
  end

  should "not allow unknown values for enumerated attributes" do
    assert_raises ArgumentError do TestRequest.new(:amount => {:currency_code => 'UNKOWN'}) end
  end

  # pipeline basics

  class TestPipeline < RubyFPS::Pipelines::Base
    attribute :foo
  end

  should "add necessary fields and sign pipeline urls" do
    Time.stubs(:now).returns(Time.parse('Jan 1 2011')) # so the signature remains constant

    pipeline = TestPipeline.new(:foo => 'bar')
    params = pipeline.to_params('http://example.com/return')

    assert_equal 'TestPipeline', params['pipelineName']
    assert_equal 'foo', params['callerKey']
    assert_equal '2009-01-09', params['version']
    assert_equal 'http://example.com/return', params['returnURL']

    assert_equal 2,                                              params['signatureVersion']
    assert_equal 'HmacSHA256',                                   params['signatureMethod']
    assert_equal 'OuUJQqFBJhezmcWOAhDGcsD/6OXpOLVlcbF3XMIZO3U=', params['signature']
  end
end
