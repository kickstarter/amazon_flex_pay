module RubyFPS::API
  class GetRecipientVerificationStatus < Base
    attributes :recipient_token_id

    class Response < BaseResponse
      attributes :recipient_verification_status
    end
  end
end
