module RubyFPS::API
  class GetTokenByCaller < Base
    attr_accessor :token_id
    attr_accessor :caller_reference

    class Response < BaseResponse
      attr_reader :token
      def token=(val)
        @token = Token.new(val)
      end

      class Token < RubyFPS::Model
        attr_accessor :token_id, :old_token_id, :token_type
        attr_accessor :friendly_name, :token_status, :date_installed, :caller_reference, :payment_reason
      end
    end
  end
end
