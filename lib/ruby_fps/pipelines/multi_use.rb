module RubyFPS::Pipelines
  class MultiUse < Base
    attributes :global_amount_limit, # required
                  :amount_type, :transaction_amount,
                  :currency_code, :payment_method, :payment_reason,
                  :is_recipient_cobranding, :recipient_token_list,
                  :usage_limit_type_1, :usage_limit_period_1, :usage_limit_value_1,
                  :usage_limit_type_2, :usage_limit_period_2, :usage_limit_value_2,
                  :validity_expiry, :validity_start,
                  :collect_shipping_address,
                  :address_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number
  end
end
