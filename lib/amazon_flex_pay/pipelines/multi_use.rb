module AmazonFlexPay::Pipelines #:nodoc:
  class MultiUse < Base #:nodoc:
    attribute :global_amount_limit # required
    attribute :amount_type, :enumeration => :amount_type
    attribute :transaction_amount
    attribute :currency_code, :enumeration => :currency_code
    attribute :payment_method, :enumeration => :payment_method
    attribute :payment_reason
    attribute :is_recipient_cobranding
    attribute :recipient_token_list
    attribute :usage_limit_type1, :enumeration => :usage_limit_type
    attribute :usage_limit_period1
    attribute :usage_limit_value1
    attribute :usage_limit_type2, :enumeration => :usage_limit_type
    attribute :usage_limit_period2
    attribute :usage_limit_value2
    attribute :validity_expiry
    attribute :validity_start
    attribute :collect_shipping_address
    attribute :address_name
    attribute :address_line1
    attribute :address_line2
    attribute :city
    attribute :state
    attribute :zip
    attribute :phone_number
    attribute :disable_guest
  end
end
