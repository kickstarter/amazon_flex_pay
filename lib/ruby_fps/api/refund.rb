module RubyFPS::API
  class Refund < Base
    attribute :caller_description
    attribute :caller_reference # required
    attribute :refund_amount, :type => :amount
    attribute :transaction_id # required

    class Response < BaseResponse
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
