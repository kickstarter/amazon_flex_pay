require_relative '../test_helper'

class AmazonFlexPay::SignatureTest < AmazonFlexPay::Test
  should "generate a valid v2 signature" do
    # NOTE: I'm not sure of a supplied signature example that I can copy, so
    # I set this one up by making sure signatures were being accepted by
    # Amazon and then generating and saving my own example. Kinda backwards
    # but good enough for regression testing.
    assert_equal "Ro7iH0M+1hIR/SXGvT1kmF6Tg5uUKRSUd1AWaJHOcpE=", AmazonFlexPay::Signature.new('bar', 'http://example.com/api', :hello => 'world').generate
  end
end
