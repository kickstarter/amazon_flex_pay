require 'ruby_fps/api/base'
require 'ruby_fps/api/error_response'

require 'ruby_fps/api/get_recipient_verification_status'
require 'ruby_fps/api/get_token_by_caller'
require 'ruby_fps/api/get_transaction_status'

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
      RubyFPS::API.const_get(action.to_s.camelcase).new(args).submit
    end
  end
end
