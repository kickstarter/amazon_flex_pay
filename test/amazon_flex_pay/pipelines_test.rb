require_relative '../test_helper'

class AmazonFlexPay::PipelinesTest < AmazonFlexPay::Test
  should "build a edit token pipeline" do
    AmazonFlexPay.expects(:cbui).with do |pipeline|
      assert pipeline.is_a? AmazonFlexPay::Pipelines::EditToken
      assert_equal 'pipe1', pipeline.caller_reference
      assert_equal 'token', pipeline.token_id
    end
    AmazonFlexPay.edit_token_pipeline('pipe1', 'http://example.com/return',
      :token_id => 'token'
    )
  end

  should "build a multi use pipeline" do
    AmazonFlexPay.expects(:cbui).with do |pipeline|
      assert pipeline.is_a? AmazonFlexPay::Pipelines::MultiUse
      assert_equal 'pipe2', pipeline.caller_reference
      assert_equal '50.00', pipeline.global_amount_limit
      assert_equal 'Count', pipeline.usage_limit_type1
      assert_equal '2',     pipeline.usage_limit_value1
    end
    AmazonFlexPay.multi_use_pipeline('pipe2', 'http://example.com/return',
      :global_amount_limit => "50.00",
      :usage_limit_type1 => 'Count',
      :usage_limit_value1 => '2'
    )
  end

  should "build a recipient pipeline" do
    AmazonFlexPay.expects(:cbui).with do |pipeline|
      assert pipeline.is_a? AmazonFlexPay::Pipelines::Recipient
      assert_equal 'pipe3', pipeline.caller_reference
      assert_equal true,    pipeline.recipient_pays_fee
    end
    AmazonFlexPay::recipient_pipeline('pipe3', 'http://example.com/return',
      :recipient_pays_fee => true
    )
  end

  should "build a single use pipeline" do
    AmazonFlexPay.expects(:cbui).with do |pipeline|
      assert pipeline.is_a? AmazonFlexPay::Pipelines::SingleUse
      assert_equal 'pipe4', pipeline.caller_reference
      assert_equal 'token', pipeline.recipient_token
      assert_equal '25.00', pipeline.transaction_amount
      assert_equal true,  pipeline.disable_guest
    end
    AmazonFlexPay.single_use_pipeline('pipe4', 'http://example.com/return',
      :recipient_token => 'token',
      :transaction_amount => '25.00',
      :disable_guest => true
    )
  end
end
