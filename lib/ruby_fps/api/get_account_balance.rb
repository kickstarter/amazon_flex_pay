module RubyFPS::API #:nodoc:
  class GetAccountBalance < Base #:nodoc:

    class Response < BaseResponse #:nodoc:
      attribute :account_balance, :type => :account_balance
    end
  end
end
