module RubyFPS::Pipelines
  class SingleUse < Base
    attr_accessor :recipient_token, :transaction_amount, # required
                  :currency_code, :item_total, :shipping, :handling, :discount, :tax,
                  :address_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number,
                  :collect_shipping_address, :gift_wrapping,
                  :payment_method, :payment_reason, :reserve
  end
end
