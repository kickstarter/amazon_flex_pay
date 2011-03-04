module RubyFPS::API
  class Cancel < Base
    attributes :transaction_id, :description

    class Response < BaseResponse
      attributes :transaction_id, :transaction_status
    end
  end
end
