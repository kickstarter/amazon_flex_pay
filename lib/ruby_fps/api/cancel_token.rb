module RubyFPS::API
  class CancelToken < Base
    attribute :token_id
    attribute :reason_text

    class Response < BaseResponse
    end
  end
end
