require 'ruby_fps/api/base'
require 'ruby_fps/api/error_response'

require 'ruby_fps/api/get_recipient_verification_status'
require 'ruby_fps/api/get_token_by_caller'
require 'ruby_fps/api/get_transaction_status'
require 'ruby_fps/api/verify_signature'

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

    # This is how you verify IPNs and pipeline responses.
    # Returns true if the url and params have been signed by Amazon, false otherwise.
    #
    # +url+ is the full request path up to the query string, as from request.url in the controller
    # +params+ is the full params hash from the controller
    def verify_signature(url, params)
      submit(:verify_signature, :url_end_point => url, :http_parameters => RubyFPS.query_string(params))
    end
    
    def cancel(transaction_id, options = {})
      submit(:cancel, options.merge(:transaction_id => transaction_id))
    end
    
    def cancel_token(token_id, options = {})
      submit(:cancel_token, options.merge(:token_id => token_id))
    end
    
    def settle(transaction_id, options = {})
      submit(:settle, options.merge(:reserve_transaction_id => transaction_id))
    end

    protected

    def submit(action, args)
      RubyFPS::API.const_get(action.to_s.camelcase).new(args).submit
    end
  end
end
