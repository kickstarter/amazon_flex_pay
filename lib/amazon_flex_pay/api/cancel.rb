module AmazonFlexPay::API #:nodoc:
  class Cancel < BaseRequest #:nodoc:
    attribute :transaction_id
    attribute :description

    class Response < BaseResponse #:nodoc:
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
