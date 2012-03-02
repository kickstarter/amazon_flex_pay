require File.dirname(__FILE__) + '/test_helper'

class AmazonFlexPayTest < AmazonFlexPay::Test
  include ResponseSamples

  ## Cancel

  should "construct a Cancel request" do
    AmazonFlexPay::API::Cancel.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.cancel('txid', {:description => 'test'})
    end
  end

  should "parse a Cancel response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::Cancel::Response.from_xml(cancel_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  ## CancelToken

  should "construct a CancelToken request" do
    AmazonFlexPay::API::CancelToken.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.cancel_token('token', {:reason_text => 'test'})
    end
  end

  should "parse a CancelToken response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::CancelToken::Response.from_xml(cancel_token_response)
    end
    assert response.request_id
  end

  ## GetAccountActivity

  should "construct a GetAccountActivity request" do
    AmazonFlexPay::API::GetAccountActivity.any_instance.expects(:submit)
    since = Time.now - 60*60*24 # 1.day
    to    = Time.now
    assert_nothing_raised do
      AmazonFlexPay.get_account_activity(since, to)
    end
  end

  should "parse a GetAccountActivity response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetAccountActivity::Response.from_xml(get_account_activity_response)
    end
    assert response.request_id
    assert_equal 5, response.transactions.count
  end

  ## GetAccountBalance

  should "construct a GetAccountBalance request" do
    AmazonFlexPay::API::GetAccountBalance.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_account_balance
    end
  end

  should "parse a GetAccountBalance response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetAccountBalance::Response.from_xml(get_account_balance_response)
    end
    assert response.request_id
    assert_equal '7.400000', response.account_balance.total_balance.value
  end

  ## GetRecipientVerificationStatus

  should "construct a GetRecipientVerificationStatus request" do
    AmazonFlexPay::API::GetRecipientVerificationStatus.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_recipient_verification_status('token')
    end
  end

  should "parse a GetRecipientVerificationStatus response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetRecipientVerificationStatus::Response.from_xml(get_recipient_verification_status_response)
    end
    assert response.request_id
    assert response.recipient_verification_status
  end

  ## GetTokenByCaller

  should "construct a GetTokenByCaller request by reference" do
    AmazonFlexPay::API::GetTokenByCaller.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_token_by_caller_reference('reference')
    end
  end

  should "construct a GetTokenByCaller request by token id" do
    AmazonFlexPay::API::GetTokenByCaller.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_token_by_id('token')
    end
  end

  should "parse a GetTokenByCaller response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTokenByCaller::Response.from_xml(get_token_by_caller_response)
    end
    assert response.request_id
    assert response.token.token_id
    assert response.token.token_status
  end
  
  ## GetTokenUsage
  
  should "construct a GetTokenUsage request" do
    AmazonFlexPay::API::GetTokenUsage.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_token_usage('token')
    end
  end

  should "parse a GetTokenUsage response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTokenUsage::Response.from_xml(get_token_usage_response)
    end
    assert 2, response.token_usage_limits.count
    assert_equal '10.000000', response.token_usage_limits.first.amount.value
    assert_equal '1', response.token_usage_limits.last.count
  end
  
  ## GetTokens

  should "construct a GetTokens request" do
    AmazonFlexPay::API::GetTokens.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_tokens
    end
  end

  should "parse a GetTokens response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTokens::Response.from_xml(get_tokens_response)
    end
    assert 1, response.tokens.count
  end

  ## GetTransaction

  should "construct a GetTransaction request" do
    AmazonFlexPay::API::GetTransaction.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_transaction('txid')
    end
  end

  should "parse a GetTransaction response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTransaction::Response.from_xml(get_transaction_response)
    end
    assert response.request_id
    assert response.transaction.caller_reference
    assert response.transaction.payment_method
  end

  should "delegate to transaction attributes" do
    response = AmazonFlexPay::API::GetTransaction::Response.from_xml(get_transaction_response)
    assert_equal response.caller_reference, response.transaction.caller_reference
    assert_equal response.date_completed, response.transaction.date_completed
  end

  ## GetTransactionStatus

  should "construct a GetTransactionStatus request" do
    AmazonFlexPay::API::GetTransactionStatus.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.get_transaction_status('txid')
    end
  end

  should "parse a GetTransactionStatus response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTransactionStatus::Response.from_xml(get_transaction_status_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert_equal 'Success', response.transaction_status
  end

  ## Pay

  should "construct a Pay request" do
    request = nil
    assert_nothing_raised do
      request = AmazonFlexPay::API::Pay.new(:transaction_amount => {:currency_code => 'USD', :value => '1.00'}, :caller_reference => 'myid')
    end
    assert_equal '1.00', request.transaction_amount.value
  end

  should "parse a Pay response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::Pay::Response.from_xml(reserve_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  ## Refund

  should "construct a Refund request" do
    request = nil
    assert_nothing_raised do
      request = AmazonFlexPay::API::Refund.new(:transaction_id => 'txid', :caller_reference => 'myid', :refund_amount => {:currency_code => 'USD', :value => '1.00'})
    end
    assert_equal '1.00', request.refund_amount.value
  end

  should "parse a Refund response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::Refund::Response.from_xml(refund_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  ## Reserve

  should "construct a Reserve request" do
    request = nil
    assert_nothing_raised do
      request = AmazonFlexPay::API::Reserve.new(:sender_token_id => 'token', :transaction_amount => {:currency_code => 'USD', :value => '1.00'}, :caller_reference => 'myid', :descriptor_policy => {:cs_owner => 'Caller', :soft_descriptor_type => 'Static'})
    end
    assert_equal 'Caller', request.descriptor_policy.cs_owner
    assert request.to_params['DescriptorPolicy'].has_key?('CSOwner') # funky casing
  end

  should "parse a Reserve response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::Reserve::Response.from_xml(reserve_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  ## Settle

  should "construct a Settle request" do
    request = nil
    assert_nothing_raised do
      request = AmazonFlexPay::API::Settle.new(:reserve_transaction_id => 'txid', :transaction_amount => {:currency_code => 'USD', :value => '3.14'})
    end
    assert_equal 'USD', request.transaction_amount.currency_code
    assert_equal '3.14', request.transaction_amount.value
  end

  should "parse a Settle response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::Settle::Response.from_xml(settle_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  ## VerifySignature

  should "construct a VerifySignature request" do
    AmazonFlexPay::API::VerifySignature.any_instance.expects(:submit)
    assert_nothing_raised do
      AmazonFlexPay.verify_signature('http://example.com/api', 'foo=bar')
    end
  end

  should "parse a VerifySignature response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::VerifySignature::Response.from_xml(verify_signature_response)
    end
    assert response.request_id
    assert response.verification_status
  end
end
