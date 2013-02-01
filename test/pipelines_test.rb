require File.dirname(__FILE__) + '/test_helper'

class AmazonFlexPayPipelinesTest < AmazonFlexPay::Test
  should "build a edit token pipeline" do
    hash = nil
    assert_nothing_raised do
      hash = AmazonFlexPay.edit_token_pipeline('pipe1', 'http://example.com/return',
        :token_id => 'token'
      ).to_hash
    end
    assert_equal 'pipe1', hash['callerReference']
  end

  should "build a multi use pipeline" do
    hash = nil
    assert_nothing_raised do
      hash = AmazonFlexPay.multi_use_pipeline('pipe2', 'http://example.com/return',
        :global_amount_limit => "50.00",
        :usage_limit_type1 => 'Count',
        :usage_limit_value1 => '2'
      ).to_hash
    end
    assert_equal 'pipe2', hash['callerReference']
    assert_equal '50.00', hash['globalAmountLimit']
    assert_equal 'Count', hash['usageLimitType1']
    assert_equal '2',     hash['usageLimitValue1']
  end

  should "build a recipient pipeline" do
    hash = nil
    assert_nothing_raised do
      hash = AmazonFlexPay::recipient_pipeline('pipe3', 'http://example.com/return',
        :recipient_pays_fee => true
      ).to_hash
    end
    assert_equal 'pipe3', hash['callerReference']
  end

  should "build a single use pipeline" do
    hash = nil
    assert_nothing_raised do
      hash = AmazonFlexPay.single_use_pipeline('pipe4', 'http://example.com/return',
        :recipient_token => 'token',
        :transaction_amount => '25.00',
        :disable_guest => true
      ).to_hash
    end
    assert_equal 'pipe4', hash['callerReference']
    assert_equal '25.00', hash['transactionAmount']
    assert_equal 'True', hash['disableGuest']
  end
end
