require_relative '../test_helper'

class AmazonFlexPay::APITest < AmazonFlexPay::Test
  include ResponseSamples

  ## Cancel

  should "construct a Cancel request" do
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::Cancel
      assert_equal 'txid', request.transaction_id
      assert_equal 'test', request.description
    end
    AmazonFlexPay.cancel('txid', {:description => 'test'})
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::CancelToken
      assert_equal 'token', request.token_id
      assert_equal 'test', request.reason_text
    end
    AmazonFlexPay.cancel_token('token', {:reason_text => 'test'})
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
    since = Time.now - 60*60*24 # 1.day
    to    = Time.now
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetAccountActivity
      assert_equal since, request.start_date
      assert_equal to, request.end_date
    end
    AmazonFlexPay.get_account_activity(since, to)
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetAccountBalance
    end
    AmazonFlexPay.get_account_balance
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetRecipientVerificationStatus
      assert_equal 'token', request.recipient_token_id
    end
    AmazonFlexPay.get_recipient_verification_status('token')
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTokenByCaller
      assert_equal 'reference', request.caller_reference
    end
    AmazonFlexPay.get_token_by_caller_reference('reference')
  end

  should "construct a GetTokenByCaller request by token id" do
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTokenByCaller
      assert_equal 'token', request.token_id
    end
    AmazonFlexPay.get_token_by_id('token')
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTokenUsage
      assert_equal 'token', request.token_id
    end
    AmazonFlexPay.get_token_usage('token')
  end

  should "parse a GetTokenUsage response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTokenUsage::Response.from_xml(get_token_usage_response)
    end
    assert_equal 2, response.token_usage_limits.count
    assert_equal '10.000000', response.token_usage_limits.first.amount.value
    assert_equal '1', response.token_usage_limits.last.count
  end

  ## GetTokens

  should "construct a GetTokens request" do
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTokens
    end
    AmazonFlexPay.get_tokens
  end

  should "parse a GetTokens response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::GetTokens::Response.from_xml(get_tokens_response)
    end
    assert_equal 1, response.tokens.count
  end

  ## GetTransaction

  should "construct a GetTransaction request" do
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTransaction
      assert_equal 'txid', request.transaction_id
    end
    AmazonFlexPay.get_transaction('txid')
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::GetTransactionStatus
      assert_equal 'txid', request.transaction_id
    end
    AmazonFlexPay.get_transaction_status('txid')
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::Pay
      assert_equal '1.00', request.transaction_amount.value
      assert_equal 'USD', request.transaction_amount.currency_code
      assert_equal 'token', request.sender_token_id
      assert_equal 'myid', request.caller_reference
    end
    AmazonFlexPay.pay('1.00', 'USD', 'token', 'myid')
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::Refund
      assert_equal 'txid', request.transaction_id
      assert_equal 'myid', request.caller_reference
      assert_equal '1.00', request.refund_amount.value
    end
    AmazonFlexPay.refund('txid', 'myid', :refund_amount => {:currency_code => 'USD', :value => '1.00'})
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::Reserve
      assert_equal '1.00', request.transaction_amount.value
      assert_equal 'USD', request.transaction_amount.currency_code
      assert_equal 'token', request.sender_token_id
      assert_equal 'myid', request.caller_reference
      assert_equal 'Caller', request.descriptor_policy.cs_owner

      assert request.to_hash['DescriptorPolicy'].has_key?('CSOwner') # funky casing
    end
    AmazonFlexPay.reserve('1.00', 'USD', 'token', 'myid', :descriptor_policy => {:cs_owner => 'Caller', :soft_descriptor_type => 'Static'})
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::Settle
      assert_equal 'txid', request.reserve_transaction_id
      assert_equal 'USD', request.transaction_amount.currency_code
      assert_equal '3.14', request.transaction_amount.value
    end
    AmazonFlexPay.settle('txid', :transaction_amount => {:currency_code => 'USD', :value => '3.14'})
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
    AmazonFlexPay.expects(:submit).with do |request|
      assert request.is_a? AmazonFlexPay::API::VerifySignature
      assert_equal 'http://example.com/api', request.url_end_point
      assert_equal 'foo=bar', request.http_parameters
    end
    AmazonFlexPay.verify_signature('http://example.com/api', 'foo=bar')
  end

  should "parse a VerifySignature response" do
    response = nil
    assert_nothing_raised do
      response = AmazonFlexPay::API::VerifySignature::Response.from_xml(verify_signature_response)
    end
    assert response.request_id
    assert response.verification_status
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

  ## Submit

  class TestRequest < AmazonFlexPay::API::BaseRequest
    attribute :foo

    class Response < AmazonFlexPay::API::BaseRequest::BaseResponse; end
  end


  should "store the request in the response" do
    RestClient.expects(:get).returns(stub(:body => cancel_token_response, :code => 200))
    request = TestRequest.new(:foo => 'bar')
    response = AmazonFlexPay.send(:submit, request)
    assert_equal 'bar', response.request.foo
  end

  should "instrument successful responses" do
    events = []
    callback = proc{ |*args| events << ActiveSupport::Notifications::Event.new(*args) }

    ActiveSupport::Notifications.subscribed(callback, "amazon_flex_pay.api") do
      RestClient.expects(:get).returns(stub(:body => cancel_token_response, :code => 200))
      request = TestRequest.new(:foo => 'bar')
      AmazonFlexPay.send(:submit, request)
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
      request = TestRequest.new(:foo => 'bar')
      AmazonFlexPay.send(:submit, request)
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

      begin
        request = TestRequest.new(:foo => 'bar')
        AmazonFlexPay.send(:submit, request)
      rescue AmazonFlexPay::API::Error
      end
    end

    assert_equal 1, events.size
    assert_equal 'TestRequest', events.first.payload[:action]
    assert_equal 400, events.first.payload[:code]
    assert events.first.payload.has_key?(:request)
    assert events.first.payload.has_key?(:response)
    assert events.first.duration > 0.1, events.first.duration.to_s
  end

end
