module RubyFPS::API
  class GetTransactionStatus < Base
    attribute :transaction_id

    class Response < BaseResponse
      attribute :caller_reference
      attribute :status_code
      attribute :status_message
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
