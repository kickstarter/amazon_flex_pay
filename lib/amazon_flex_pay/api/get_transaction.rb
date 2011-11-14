module AmazonFlexPay::API #:nodoc:
  class GetTransaction < BaseRequest #:nodoc:
    attribute :transaction_id

    class Response < BaseResponse #:nodoc:
      attribute :transaction, :type => :transaction_detail
    end
  end
end
