module RubyFPS
  class << self
    def get_transaction_status(id)
      submit(:get_transaction_status, :transaction_id => id)
    end

    def get_token_by_caller_reference(ref)
      submit(:get_token_by_caller, :caller_reference => ref)
    end

    def get_token_by_id(id)
      submit(:get_token_by_caller, :token_id => id)
    end

    def get_recipient_verification_status(recipient_token_id)
      submit(:get_recipient_verification_status, :recipient_token_id => recipient_token_id)
    end

    protected

    def submit(action, args)
      const_get(action.to_s.camelcase).new(args).submit
    end
  end

  class GetTransactionStatus < Request
    attr_accessor :transaction_id

    class Response < RubyFPS::Response
      attr_accessor :caller_reference, :status_code, :status_message, :transaction_id, :transaction_status
    end
  end

  class GetTokenByCaller < Request
    attr_accessor :token_id
    attr_accessor :caller_reference

    class Response < RubyFPS::Response
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

  class GetRecipientVerificationStatus < Request
    attr_accessor :recipient_token_id

    class Response < RubyFPS::Response
      attr_accessor :recipient_verification_status
    end
  end
end
