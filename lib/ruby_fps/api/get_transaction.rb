module RubyFPS::API
  class GetTransaction < Base
    attribute :transaction_id

    class Response < BaseResponse
      attribute :transaction, :type => :transaction_detail
    end
  end
end
