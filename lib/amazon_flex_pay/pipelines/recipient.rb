module AmazonFlexPay::Pipelines #:nodoc:
  class Recipient < Base #:nodoc:
    attribute :recipient_pays_fee # required
    attribute :payment_method, :enumeration => :payment_method
    attribute :max_fixed_fee
    attribute :max_variable_fee
    attribute :validity_expiry
    attribute :validity_start
  end
end
