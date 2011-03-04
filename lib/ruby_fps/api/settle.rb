module RubyFPS::API
  class Settle < Base
    attribute :reserve_transaction_id
    attribute :transaction_amount, :type => :amount

    class Response < BaseResponse
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
