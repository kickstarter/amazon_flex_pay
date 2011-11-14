module AmazonFlexPay::API #:nodoc:
  class Refund < BaseRequest #:nodoc:
    attribute :caller_description
    attribute :caller_reference # required
    attribute :refund_amount, :type => :amount
    attribute :transaction_id # required
    attribute :marketplace_refund_policy, :enumeration => :marketplace_refund_policy

    class Response < BaseResponse #:nodoc:
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
