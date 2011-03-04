module RubyFPS::API
  class GetTokenByCaller < Base
    attributes :token_id
    attributes :caller_reference

    class Response < BaseResponse
      attr_reader :token
      def token=(val)
        @token = Token.new(val)
      end

      class Token < RubyFPS::Model
        attributes :token_id, :old_token_id, :token_type
        attributes :friendly_name, :token_status, :date_installed, :caller_reference, :payment_reason
      end
    end
  end
end
