module RubyFPS::Pipelines
  class Recipient < Base
    attribute :recipient_pays_fee # required
    attribute :payment_method, :enumeration => :payment_method
    attributes :max_fixed_fee, :max_variable_fee, :validity_expiry, :validity_start
  end
end
