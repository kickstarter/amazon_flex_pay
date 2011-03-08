module RubyFPS::API
  class GetTokenUsage < Base
    attribute :token_id

    class Response < BaseResponse
      attribute :token_usage_limits, :collection => :token_usage_limit
    end
  end
end
