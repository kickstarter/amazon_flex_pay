module AmazonFlexPay::API #:nodoc:
  class CancelToken < BaseRequest #:nodoc:
    attribute :token_id
    attribute :reason_text

    class Response < BaseResponse #:nodoc:
    end
  end
end
