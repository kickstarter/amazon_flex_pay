module AmazonFlexPay::API #:nodoc:
  class GetAccountBalance < BaseRequest #:nodoc:

    class Response < BaseResponse #:nodoc:
      attribute :account_balance, :type => :account_balance
    end
  end
end
