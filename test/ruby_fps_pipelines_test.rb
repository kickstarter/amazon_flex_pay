require File.dirname(__FILE__) + '/test_helper'

class RubyFPSPipelinesTest < RubyFPS::Test
  should "build a edit token pipeline" do
    url = nil
    assert_nothing_raised do
      url = RubyFPS::Pipelines::EditToken.new(:token_id => 'token').url('http://example.com/return')
    end
  end

  should "build a multi use pipeline" do
    url = nil
    assert_nothing_raised do
      url = RubyFPS::Pipelines::MultiUse.new(:global_amount_limit => "25.00").url('http://example.com/return')
    end
  end

  should "build a recipient pipeline" do
    url = nil
    assert_nothing_raised do
      url = RubyFPS::Pipelines::Recipient.new(:recipient_pays_fee => true).url('http://example.com/return')
    end
  end

  should "build a single use pipeline" do
    url = nil
    assert_nothing_raised do
      url = RubyFPS::Pipelines::SingleUse.new(:recipient_token => 'token', :transaction_amount => '25.00').url('http://example.com/return')
    end
  end
end
