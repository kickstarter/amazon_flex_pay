module RubyFPS::API
  class Settle < Base
    attr_accessor :reserve_transaction_id, :transaction_amount

    def transaction_amount=(hash)
      @transaction_amount = RubyFPS::DataTypes::Amount.new(hash)
    end

    class Response < BaseResponse
      attr_accessor :transaction_id, :transaction_status
    end
  end
end
