module AmazonFlexPay::API #:nodoc:
  class GetTransaction < BaseRequest #:nodoc:
    attribute :transaction_id

    class Response < BaseResponse #:nodoc:
      attribute :transaction, :type => :transaction_detail

      def method_missing(attr)
        if transaction.respond_to? attr
          transaction.send attr
        else
          super
        end
      end
    end
  end
end
