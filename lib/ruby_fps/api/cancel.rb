module RubyFPS::API
  class Cancel < Base
    attr_accessor :transaction_id, :description

    class Response < BaseResponse
      attr_accessor :transaction_id, :transaction_status
    end
  end
end
