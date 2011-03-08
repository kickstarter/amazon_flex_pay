# Complex Data Types pulled from the documentation
module RubyFPS::DataTypes
  class AccountBalance < RubyFPS::Model # moved from Enumerations
    attribute :available_balances, :type => :available_balances
    attribute :pending_in_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
    attribute :total_balance, :type => :amount
  end

  class Amount < RubyFPS::Model
    attribute :currency_code, :enumeration => :currency_code
    attribute :value
  end

  class AvailableBalances < RubyFPS::Model
    attribute :disburse_balance, :type => :amount
    attribute :refund_balance, :type => :amount
  end

  class DebtBalance < RubyFPS::Model
    attribute :available_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
  end

  class DescriptorPolicy < RubyFPS::Model
    attribute :'CSOwner', :enumeration => :cs_owner
    attribute :soft_descriptor_type, :enumeration => :soft_descriptor_type
  end

  class OutstandingDebtBalance < RubyFPS::Model
    attribute :outstanding_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
  end

  class OutstandingPrepaidLiability < RubyFPS::Model
    attribute :outstanding_balance, :type => :amount
    attribute :pending_in_balance, :type => :amount
  end

  class PrepaidBalance < RubyFPS::Model
    attribute :available_balance, :type => :amount
    attribute :pending_in_balance, :type => :amount
  end

  class RelatedTransaction < RubyFPS::Model
    attribute :relation_type, :enumeration => :relation_type
    attribute :transaction_id
  end

  class StatusHistory < RubyFPS::Model
    attribute :amount, :type => :amount
    attribute :date
    attribute :status_code
    attribute :transaction_status, :enumeration => :transaction_status
  end

  class Token < RubyFPS::Model
    attribute :caller_reference
    attribute :date_installed
    attribute :friendly_name
    attribute :old_token_id
    attribute :payment_reason
    attribute :token_id
    attribute :token_status, :enumeration => :token_status
    attribute :token_type, :enumeration => :token_type
  end

  class TokenUsageLimit < RubyFPS::Model
    attribute :amount, :type => :amount
    attribute :last_reset_amount, :type => :amount
    attribute :count
    attribute :last_reset_count
    attribute :last_reset_timestamp
  end

  class Transaction < RubyFPS::Model
    attribute :balance, :type => :amount
    attribute :caller_name
    attribute :caller_transaction_date
    attribute :date_completed
    attribute :date_received
    attribute :'FPSFees', :type => :amount
    attribute :'FPSOperation', :enumeration => :fps_operation
    attribute :original_transaction_id
    attribute :payment_method, :enumeration => :payment_method
    attribute :recipient_name
    attribute :recipient_token_id
    attribute :sender_name
    attribute :sender_token_id
    attribute :status_code
    attribute :status_message
    attribute :transaction_amount, :type => :amount
    attribute :transaction_id
    attribute :transaction_part, :collection => :transaction_part
    attribute :transaction_status, :enumeration => :transaction_status
  end

  class TransactionDetail < RubyFPS::Model
    attribute :caller_name
    attribute :caller_description
    attribute :caller_reference
    attribute :credit_instrument_id
    attribute :date_received
    attribute :date_completed
    attribute :'FPSFees', :type => :amount
    attribute :'FPSFeesPaidBy', :enumeration => :transactional_role
    attribute :'FPSOperation', :enumeration => :fps_operation
    attribute :market_place_fees, :type => :amount
    attribute :payment_method, :enumeration => :payment_method
    attribute :prepaid_instrument_id
    attribute :recipient_email
    attribute :recipient_name
    attribute :recipient_token_id
    attribute :related_transaction, :type => :related_transaction
    attribute :sender_description
    attribute :sender_email
    attribute :sender_name
    attribute :sender_token_id
    attribute :status_code
    attribute :status_history, :collection => :status_history
    attribute :status_message
    attribute :transaction_amount, :type => :amount
    attribute :transaction_id
    attribute :transaction_status, :enumeration => :transaction_status
  end

  class TransactionPart < RubyFPS::Model
    attribute :description
    attribute :fees_paid, :type => :amount
    attribute :instrument_id
    attribute :name
    attribute :reference
    attribute :role, :enumeration => :transactional_role
  end
end
