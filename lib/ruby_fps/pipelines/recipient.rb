module RubyFPS::Pipelines
  class Recipient < Base
    attribute :recipient_pays_fee # required
    attribute :payment_method, :enumeration => :payment_method
    attribute :max_fixed_fee
    attribute :max_variable_fee
    attribute :validity_expiry
    attribute :validity_start
  end
end
