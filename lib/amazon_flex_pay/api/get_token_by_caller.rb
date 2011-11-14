module AmazonFlexPay::API #:nodoc:
  class GetTokenByCaller < BaseRequest #:nodoc:
    attribute :token_id
    attribute :caller_reference

    class Response < BaseResponse #:nodoc:
      attribute :token, :type => :token
    end
  end
end
