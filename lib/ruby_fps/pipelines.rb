module RubyFPS
  class Recipient < Pipeline
    attr_accessor :recipient_pays_fee, # required
                  :max_fixed_fee, :max_variable_fee, :payment_method, :validity_expiry, :validity_start
  end

  class SingleUse < Pipeline
    attr_accessor :recipient_token, :transaction_amount, # required
                  :currency_code, :item_total, :shipping, :handling, :discount, :tax,
                  :address_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number,
                  :collect_shipping_address, :gift_wrapping,
                  :payment_method, :payment_reason, :reserve
  end

  class MultiUse < Pipeline
    attr_accessor :global_amount_limit, # required
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
