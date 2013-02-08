require_relative '../../test_helper'

class AmazonFlexPay::Pipelines::BaseTest < AmazonFlexPay::Test

  class TestPipeline < AmazonFlexPay::Pipelines::Base
    attribute :foo
  end

  should "hash pipelines" do
    pipeline = TestPipeline.new(:foo => 'bar', :return_url => 'http://example.com/return')
    hash = pipeline.to_hash

    assert_equal 'TestPipeline', hash['pipelineName']
    assert_equal '2009-01-09', hash['version']
    assert_equal 'http://example.com/return', hash['returnURL']
  end

  should "parameterize signed pipelines" do
    Time.stubs(:now).returns(Time.parse('Jan 1 2011')) # so the signature remains constant

    pipeline = TestPipeline.new(:foo => 'bar', :return_url => 'http://example.com/return')
    param = pipeline.to_param

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
