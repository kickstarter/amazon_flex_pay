module RubyFPS::API
  class GetRecipientVerificationStatus < Base
    attribute :recipient_token_id

    class Response < BaseResponse
      attribute :recipient_verification_status, :enumeration => :recipient_verification_status
    end
  end
end
