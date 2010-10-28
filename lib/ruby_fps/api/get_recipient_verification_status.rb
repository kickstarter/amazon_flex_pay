module RubyFPS::API
  class GetRecipientVerificationStatus < Base
    attr_accessor :recipient_token_id

    class Response < BaseResponse
      attr_accessor :recipient_verification_status
    end
  end
end
