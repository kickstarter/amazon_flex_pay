module RubyFPS::API
  class CancelToken < Base
    attr_accessor :token_id, :reason_text

    class Response < BaseResponse
    end
  end
end
