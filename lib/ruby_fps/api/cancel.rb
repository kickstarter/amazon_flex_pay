module RubyFPS::API #:nodoc:
  class Cancel < Base #:nodoc:
    attribute :transaction_id
    attribute :description

    class Response < BaseResponse #:nodoc:
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
