# Complex Data Types pulled from the documentation, with some obvious corrections.
#
# See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/ComplexDataTypes.html
module AmazonFlexPay::DataTypes
  # moved from Enumerations
  class AccountBalance < AmazonFlexPay::Model #:nodoc:
    attribute :available_balances, :type => :available_balances
    attribute :pending_in_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
    attribute :total_balance, :type => :amount
  end

  class Amount < AmazonFlexPay::Model #:nodoc:
    attribute :currency_code, :enumeration => :currency_code
    attribute :value
  end

  class AvailableBalances < AmazonFlexPay::Model #:nodoc:
    attribute :disburse_balance, :type => :amount
    attribute :refund_balance, :type => :amount
  end

  class DebtBalance < AmazonFlexPay::Model #:nodoc:
    attribute :available_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
  end

  class DescriptorPolicy < AmazonFlexPay::Model #:nodoc:
    attribute :'CSOwner', :enumeration => :cs_owner
    attribute :soft_descriptor_type, :enumeration => :soft_descriptor_type
  end

  class OutstandingDebtBalance < AmazonFlexPay::Model #:nodoc:
    attribute :outstanding_balance, :type => :amount
    attribute :pending_out_balance, :type => :amount
  end

  class OutstandingPrepaidLiability < AmazonFlexPay::Model #:nodoc:
    attribute :outstanding_balance, :type => :amount
    attribute :pending_in_balance, :type => :amount
  end

  class PrepaidBalance < AmazonFlexPay::Model #:nodoc:
    attribute :available_balance, :type => :amount
    attribute :pending_in_balance, :type => :amount
  end

  class RelatedTransaction < AmazonFlexPay::Model #:nodoc:
    attribute :relation_type, :enumeration => :relation_type
    attribute :transaction_id

    AmazonFlexPay::Enumerations::RelationType.each do |relation|
      class_eval <<-END
        def #{relation.underscore}?
          relation_type == '#{relation}'
        end
      END
    end

    def full
      AmazonFlexPay::API::GetTransaction.new(:transaction_id => transaction_id).submit
    end
  end

  class StatusHistory < AmazonFlexPay::Model #:nodoc:
    attribute :amount, :type => :amount
    attribute :date
    attribute :status_code
    attribute :transaction_status, :enumeration => :transaction_status
  end

  class Token < AmazonFlexPay::Model #:nodoc:
    attribute :caller_reference
    attribute :date_installed
    attribute :friendly_name
    attribute :old_token_id
    attribute :payment_reason
    attribute :token_id
    attribute :token_status, :enumeration => :token_status
    attribute :token_type, :enumeration => :token_type
  end

  class TokenUsageLimit < AmazonFlexPay::Model #:nodoc:
    attribute :amount, :type => :amount
    attribute :last_reset_amount, :type => :amount
    attribute :count
    attribute :last_reset_count
    attribute :last_reset_timestamp
  end

  class Transaction < AmazonFlexPay::Model #:nodoc:
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

  class TransactionDetail < AmazonFlexPay::Model #:nodoc:
    attribute :caller_name
    attribute :caller_description
    attribute :caller_reference
    attribute :credit_instrument_id
    attribute :date_received
    attribute :date_completed
    attribute :'FPSFees', :type => :amount
    attribute :'FPSFeesPaidBy', :enumeration => :transactional_role
    attribute :'FPSOperation', :enumeration => :fps_operation
    attribute :marketplace_fees, :type => :amount
    attribute :payment_method, :enumeration => :payment_method
    attribute :prepaid_instrument_id
    attribute :recipient_email
    attribute :recipient_name
    attribute :recipient_token_id
    attribute :related_transaction, :collection => :related_transaction
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

    alias_method :related_transactions, :related_transaction
  end

  class TransactionPart < AmazonFlexPay::Model #:nodoc:
    attribute :description
    attribute :fees_paid, :type => :amount
    attribute :instrument_id
    attribute :name
    attribute :reference
    attribute :role, :enumeration => :transactional_role
  end
end
