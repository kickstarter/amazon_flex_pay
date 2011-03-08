module AmazonFlexPay::API #:nodoc:
  class GetTransaction < Base #:nodoc:
    attribute :transaction_id

    class Response < BaseResponse #:nodoc:
      attribute :transaction, :type => :transaction_detail
    end
  end
end
