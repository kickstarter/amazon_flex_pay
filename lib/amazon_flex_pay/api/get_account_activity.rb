module AmazonFlexPay::API #:nodoc:
  class GetAccountActivity < BaseRequest #:nodoc:
    attribute :start_date # required
    attribute :end_date
    attribute :'FPSOperation', :enumeration => :fps_operation
    attribute :max_batch_size
    attribute :payment_method, :enumeration => :payment_method
    attribute :response_group
    attribute :role, :enumeration => :transactional_role
    attribute :sort_order_by_date, :enumeration => :sort_order_by_date
    attribute :status, :enumeration => :transaction_status

    class Response < BaseResponse #:nodoc:
      attribute :batch_size
      attribute :start_time_for_next_transaction
      attribute :transaction, :collection => :transaction

      alias_method :transactions, :transaction
    end
  end
end
