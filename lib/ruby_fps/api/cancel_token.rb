module RubyFPS::API
  class CancelToken < Base
    attributes :token_id, :reason_text

    class Response < BaseResponse
    end
  end
end
