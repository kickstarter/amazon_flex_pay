module RubyFPS::API
  class Settle < Base
    attribute :reserve_transaction_id
    attribute :transaction_amount, :type => :amount

    class Response < BaseResponse
      attributes :transaction_id, :transaction_status
    end
  end
end
