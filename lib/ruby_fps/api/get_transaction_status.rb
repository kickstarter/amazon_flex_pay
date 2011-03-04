module RubyFPS::API
  class GetTransactionStatus < Base
    attributes :transaction_id

    class Response < BaseResponse
      attributes :caller_reference, :status_code, :status_message, :transaction_id, :transaction_status
    end
  end
end
