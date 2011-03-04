require File.dirname(__FILE__) + '/test_helper'

class RubyFPSTest < RubyFPS::Test
  include ResponseSamples

  should "construct a Cancel request" do
    RubyFPS::API::Cancel.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.cancel('txid', {:description => 'test'})
    end
  end

  should "parse a Cancel response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::Cancel::Response.from_xml(cancel_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  should "construct a CancelToken request" do
    RubyFPS::API::CancelToken.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.cancel_token('token', {:reason_text => 'test'})
    end
  end

  should "parse a CancelToken response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::CancelToken::Response.from_xml(cancel_token_response)
    end
    assert response.request_id
  end

  should "parse error responses" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::ErrorResponse.from_xml(error_response)
    end
    assert response.request_id
    assert_equal 1, response.errors.count
    assert response.errors.first.code
    assert response.errors.first.message
  end

  should "construct a GetRecipientVerificationStatus request" do
    RubyFPS::API::GetRecipientVerificationStatus.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.get_recipient_verification_status('token')
    end
  end

  should "parse a GetRecipientVerificationStatus response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::GetRecipientVerificationStatus::Response.from_xml(get_recipient_verification_status_response)
    end
    assert response.request_id
    assert response.recipient_verification_status
  end

  should "construct a GetTokenByCaller request by reference" do
    RubyFPS::API::GetTokenByCaller.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.get_token_by_caller_reference('reference')
    end
  end

  should "construct a GetTokenByCaller request by token id" do
    RubyFPS::API::GetTokenByCaller.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.get_token_by_id('token')
    end
  end

  should "parse a GetTokenByCaller response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::GetTokenByCaller::Response.from_xml(get_token_by_caller_response)
    end
    assert response.request_id
    assert response.token.token_id
    assert response.token.token_status
  end

  should "construct a GetTransactionStatus request" do
    RubyFPS::API::GetTransactionStatus.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.get_transaction_status('txid')
    end
  end

  should "parse a GetTransactionStatus response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::GetTransactionStatus::Response.from_xml(get_transaction_status_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert_equal 'Success', response.transaction_status
  end

  should "construct a Settle request" do
    RubyFPS::API::Settle.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.settle('txid', {:transaction_amount => '3.14'})
    end
  end

  should "parse a Settle response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::Settle::Response.from_xml(settle_response)
    end
    assert response.request_id
    assert response.transaction_id
    assert response.transaction_status
  end

  should "construct a VerifySignature request" do
    RubyFPS::API::VerifySignature.any_instance.expects(:submit)
    assert_nothing_raised do
      RubyFPS.verify_signature('http://example.com/api', 'foo=bar')
    end
  end

  should "parse a VerifySignature response" do
    response = nil
    assert_nothing_raised do
      response = RubyFPS::API::VerifySignature::Response.from_xml(verify_signature_response)
    end
    assert response.request_id
    assert response.verification_status
  end
end
