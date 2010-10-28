module RubyFPS::API
  class GetTransactionStatus < Base
    attr_accessor :transaction_id

    class Response < BaseResponse
      attr_accessor :caller_reference, :status_code, :status_message, :transaction_id, :transaction_status
    end
  end
end
