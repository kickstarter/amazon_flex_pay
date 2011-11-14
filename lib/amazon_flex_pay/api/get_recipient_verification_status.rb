module AmazonFlexPay::API #:nodoc:
  class GetRecipientVerificationStatus < BaseRequest #:nodoc:
    attribute :recipient_token_id

    class Response < BaseResponse #:nodoc:
      attribute :recipient_verification_status, :enumeration => :recipient_verification_status
    end
  end
end
