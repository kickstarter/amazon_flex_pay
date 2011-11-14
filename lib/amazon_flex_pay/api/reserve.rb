module AmazonFlexPay::API #:nodoc:
  class Reserve < BaseRequest #:nodoc:
    attribute :caller_description
    attribute :caller_reference # required
    attribute :charge_fee_to, :enumeration => :charge_fee_to
    attribute :descriptor_policy, :type => :descriptor_policy
    attribute :marketplace_fixed_fee, :type => :amount
    attribute :marketplace_variable_fee
    attribute :recipient_token_id
    attribute :sender_description
    attribute :sender_token_id # required
    attribute :transaction_amount, :type => :amount # required
    attribute :transaction_timeout_in_mins

    class Response < BaseResponse #:nodoc:
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
