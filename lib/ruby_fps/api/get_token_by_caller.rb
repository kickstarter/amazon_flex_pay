module RubyFPS::API
  class GetTokenByCaller < Base
    attribute :token_id
    attribute :caller_reference

    class Response < BaseResponse
      attribute :token, :type => :token
    end
  end
end
