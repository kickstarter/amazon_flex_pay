require File.dirname(__FILE__) + '/test_helper'

class AmazonFlexPayPipelinesTest < AmazonFlexPay::Test
  should "build a edit token pipeline" do
    params = nil
    assert_nothing_raised do
      params = AmazonFlexPay.edit_token_pipeline('pipe1', :token_id => 'token').to_params('http://example.com/return')
    end
  end

  should "build a multi use pipeline" do
    params = nil
    assert_nothing_raised do
      params = AmazonFlexPay.multi_use_pipeline('pipe2',
        :global_amount_limit => "50.00",
        :usage_limit_type1 => 'Count',
        :usage_limit_value1 => '2'
      ).to_params('http://example.com/return')
    end
    assert_equal '50.00', params['globalAmountLimit']
    assert_equal 'Count', params['usageLimitType1']
    assert_equal '2',     params['usageLimitValue1']
  end

  should "build a recipient pipeline" do
    params = nil
    assert_nothing_raised do
      params = AmazonFlexPay::recipient_pipeline('pipe3', :recipient_pays_fee => true).to_params('http://example.com/return')
    end
  end

  should "build a single use pipeline" do
    params = nil
    assert_nothing_raised do
      params = AmazonFlexPay.single_use_pipeline('pipe4',
        :recipient_token => 'token',
        :transaction_amount => '25.00'
      ).to_params('http://example.com/return')
    end
    assert_equal '25.00', params['transactionAmount']
  end
end
