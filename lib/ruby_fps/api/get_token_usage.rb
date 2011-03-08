module RubyFPS::API #:nodoc:
  class GetTokenUsage < Base #:nodoc:
    attribute :token_id

    class Response < BaseResponse #:nodoc:
      attribute :token_usage_limits, :collection => :token_usage_limit
    end
  end
end
