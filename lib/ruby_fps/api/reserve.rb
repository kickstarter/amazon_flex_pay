module RubyFPS::API
  class Reserve < Base
    attribute :caller_description
    attribute :caller_reference # required
    attribute :descriptor_policy, :type => :descriptor_policy
    attribute :sender_description
    attribute :sender_token_id # required
    attribute :transaction_amount, :type => :amount # required
    attribute :transaction_timeout_in_mins

    class Response < BaseResponse
      attribute :transaction_id
      attribute :transaction_status, :enumeration => :transaction_status
    end
  end
end
