# load all api classes
require 'amazon_flex_pay/api/base_request'
Dir[File.dirname(__FILE__) + '/api/*'].each do |p| require "amazon_flex_pay/api/#{File.basename(p)}" end

module AmazonFlexPay
  class << self
    # Cancels a transaction.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/Cancel.html
    def cancel(transaction_id, options = {})
      API::Cancel.new(options.merge(:transaction_id => transaction_id)).submit
    end

    # Cancels a token.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/CancelToken.html
    def cancel_token(token_id, options = {})
      API::CancelToken.new(options.merge(:token_id => token_id)).submit
    end

    # Searches through transactions on your account. Helpful if you want to compare vs your own records,
    # or print an admin report.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetAccountActivity.html
    def get_account_activity(start_date, end_date, options = {})
      API::GetAccountActivity.new(options.merge(:start_date => start_date, :end_date => end_date)).submit
    end

    # Gets your Amazon Payments account balance.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetAccountBalance.html
    def get_account_balance
      API::GetAccountBalance.new.submit
    end

    # Returns the status of a recipient's Amazon account. This is a high-level status indicating whether
    # the recipient can receive up to $10k per month (VerificationComplete) or has no receiving limitations
    # at all (VerificationCompleteNoLimits).
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/GetRecipientVerificationStatus.html
    def get_recipient_verification_status(recipient_token_id)
      API::GetRecipientVerificationStatus.new(:recipient_token_id => recipient_token_id).submit
    end

    # Returns information about a token's state from a caller reference.
    #
    # This is the closest thing that Amazon's API has to getting the status of a pipeline. Provide the caller
    # reference for your pipeline (you are saving caller references, right?), and if this returns a token you
    # can assume the pipeline finished successfully.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/GetTokensByCaller.html
    def get_token_by_caller_reference(ref)
      API::GetTokenByCaller.new(:caller_reference => ref).submit
    end

    # Returns information about a token's state from a token id.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/GetTokensByCaller.html
    def get_token_by_id(id)
      API::GetTokenByCaller.new(:token_id => id).submit
    end

    # Returns information about how much of the token has been used, and what remains.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetTokenUsage.html
    def get_token_usage(id)
      API::GetTokenUsage.new(:token_id => id).submit
    end

    # Returns all of your tokens. Note that when you send someone through a recipient pipeline, that registers
    # a recipient token on _their_ account, not yours. And when you send someone through a single use pipeline,
    # that registers a sender token on _their_account, not yours.
    #
    # So basically this will only return recipient tokens where _you_ are the recipient, or sender tokens where
    # _you_ are the sender.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetTokens.html
    def get_tokens(options = {})
      API::GetTokens.new(options).submit
    end

    # Returns all of Amazon's details about a transaction, such as its status and when it began and finished
    # processing.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetTransaction.html
    def get_transaction(id)
      API::GetTransaction.new(:transaction_id => id).submit
    end

    # Returns the current status of the transaction. Note that this information is also available from
    # <tt>get_transaction</tt>.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAccountManagementGuide/GetTransactionStatus.html
    def get_transaction_status(id)
      API::GetTransactionStatus.new(:transaction_id => id).submit
    end

    # Begins a Pay request for a sender token. If you are not also the recipient (this is a three-party marketplace
    # transaction) then you must also specify the recipient token.
    #
    # Sign up for Instant Payment Notifications to be told when this has finished.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/Pay.html
    def pay(value, currency, sender_token_id, caller_reference, options = {})
      API::Pay.new(options.merge(
        :transaction_amount => {:value => value, :currency_code => currency},
        :sender_token_id => sender_token_id,
        :caller_reference => caller_reference
      )).submit
    end

    # Begins a Reserve request for the sender token. Very similar to <tt>pay</tt>.
    #
    # Sign up for Instant Payment Notifications to be told when this has finished.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/Reserve.html
    def reserve(value, currency, sender_token_id, caller_reference, options = {})
      API::Reserve.new(options.merge(
        :transaction_amount => {:value => value, :currency_code => currency},
        :sender_token_id => sender_token_id,
        :caller_reference => caller_reference
      )).submit
    end

    # Refunds a transaction. By default it will refund the entire transaction, but you can
    # provide an amount for partial refunds.
    #
    # Sign up for Instant Payment Notifications to be told when this has finished.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/Refund.html
    def refund(transaction_id, caller_reference, options = {})
      API::Refund.new(options.merge(:transaction_id => transaction_id, :caller_reference => caller_reference)).submit
    end

    # If you have a Reserve transaction, use this to Settle (capture) it.
    #
    # Sign up for Instant Payment Notifications to be told when this has finished.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/Settle.html
    def settle(transaction_id, options = {})
      API::Settle.new(options.merge(:reserve_transaction_id => transaction_id)).submit
    end

    # This is how you verify IPNs and pipeline responses.
    # Pass the entire request object.
    def verify_request(request)
      verify_signature(
        # url without query string
        request.protocol + request.host_with_port + request.path,
        # raw parameters
        request.get? ? request.query_string : request.raw_post
      )
    end

    # Verifies the signature embedded in the params string for the given url.
    #
    # Please use <tt>verify_request</tt> instead to make sure the URL and params remain properly formatted.
    def verify_signature(url, params)
      API::VerifySignature.new(:url_end_point => url, :http_parameters => params).submit
    end
  end
end
