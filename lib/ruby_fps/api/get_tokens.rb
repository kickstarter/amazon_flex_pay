module RubyFPS::API
  class GetTokens < Base
    attribute :caller_reference
    attribute :token_status
    attribute :token_type

    class Response < BaseResponse
      attribute :token, :collection => :token

      alias_method :tokens, :token
    end
  end
end
