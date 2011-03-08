module AmazonFlexPay::Pipelines #:nodoc:
  class EditToken < Base #:nodoc:
    attribute :token_id # required
    attribute :payment_method, :enumeration => :payment_method
  end
end
