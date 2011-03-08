module RubyFPS::API
  class GetAccountBalance < Base

    class Response < BaseResponse
      attribute :account_balance, :type => :account_balance
    end
  end
end
