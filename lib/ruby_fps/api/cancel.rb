module RubyFPS::API
  class Cancel < Base
    attribute :transaction_id
    attribute :description

    class Response < BaseResponse
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
