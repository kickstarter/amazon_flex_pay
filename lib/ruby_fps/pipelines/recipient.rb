module RubyFPS::Pipelines
  class Recipient < Base
    attributes :recipient_pays_fee, # required
                  :max_fixed_fee, :max_variable_fee, :payment_method, :validity_expiry, :validity_start
  end
end
