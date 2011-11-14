module AmazonFlexPay::API #:nodoc:
  class GetTokens < BaseRequest #:nodoc:
    attribute :caller_reference
    attribute :token_status
    attribute :token_type

    class Response < BaseResponse #:nodoc:
      attribute :token, :collection => :token

      alias_method :tokens, :token
    end
  end
end
