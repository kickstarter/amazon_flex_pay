module RubyFPS::API
  class Settle < Base
    attr_accessor :reserve_transaction_id, :transaction_amount
    complex :transaction_amount, :amount

    class Response < BaseResponse
      attr_accessor :transaction_id, :transaction_status
    end
  end
end
