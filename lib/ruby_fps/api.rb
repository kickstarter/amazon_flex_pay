# load all api classes
require 'ruby_fps/api/base'
Dir[File.dirname(__FILE__) + '/api/*'].each do |p| require "ruby_fps/api/#{File.basename(p)}" end

module RubyFPS
  class << self
    def cancel(transaction_id, options = {})
      submit(:cancel, options.merge(:transaction_id => transaction_id))
    end

    def cancel_token(token_id, options = {})
      submit(:cancel_token, options.merge(:token_id => token_id))
    end

    def get_account_activity(start_date, end_date, options = {})
      submit(:get_account_activity, options.merge(:start_date => start_date, :end_date => end_date))
    end

    def get_account_balance
      submit(:get_account_balance)
    end

    def get_recipient_verification_status(recipient_token_id)
      submit(:get_recipient_verification_status, :recipient_token_id => recipient_token_id)
    end

    def get_token_by_caller_reference(ref)
      submit(:get_token_by_caller, :caller_reference => ref)
    end

    def get_token_by_id(id)
      submit(:get_token_by_caller, :token_id => id)
    end

    def get_token_usage(id)
      submit(:get_token_usage, :token_id => id)
    end

    def get_tokens(options = {})
      submit(:get_tokens, options)
    end

    def get_transaction(id)
      submit(:get_transaction, :transaction_id => id)
    end

    def get_transaction_status(id)
      submit(:get_transaction_status, :transaction_id => id)
    end

    def pay(value, currency, sender_token_id, caller_reference, options = {})
      submit(:pay, options.merge(
        :transaction_amount => {:value => value, :currency_code => currency},
        :sender_token_id => sender_token_id,
        :caller_reference => caller_reference
      ))
    end

    def reserve(value, currency, sender_token_id, caller_reference, options = {})
      submit(:reserve, options.merge(
        :transaction_amount => {:value => value, :currency_code => currency},
        :sender_token_id => sender_token_id,
        :caller_reference => caller_reference
      ))
    end

    def refund(transaction_id, caller_reference, options = {})
      submit(:refund, options.merge(:transaction_id => transaction_id, :caller_reference => caller_reference))
    end

    def settle(transaction_id, options = {})
      submit(:settle, options.merge(:reserve_transaction_id => transaction_id))
    end

    # This is how you verify IPNs and pipeline responses.
    # Pass the entire request object.
    def verify_request(request)
      verify_signature(
        # url without query string
        request.protocol + request.host_with_port + request.path,
        # raw parameters
        request.get? ? request.query_string : request.raw_post
      )
    end

    def verify_signature(url, params)
      submit(:verify_signature, :url_end_point => url, :http_parameters => params)
    end

    protected

    def submit(action, *args)
      RubyFPS::API.const_get(action.to_s.camelcase).new(*args).submit
    end
  end
end
