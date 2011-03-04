module RubyFPS::Pipelines
  class SingleUse < Base
    attribute :recipient_token # required
    attribute :transaction_amount # required
    attribute :currency_code, :enumeration => :currency_code
    attribute :item_total
    attribute :shipping
    attribute :handling
    attribute :discount
    attribute :tax
    attribute :address_name
    attribute :address_line_1
    attribute :address_line_2
    attribute :city
    attribute :state
    attribute :zip
    attribute :phone_number
    attribute :collect_shipping_address
    attribute :gift_wrapping
    attribute :payment_method, :enumeration => :payment_method
    attribute :payment_reason
    attribute :reserve
  end
end
