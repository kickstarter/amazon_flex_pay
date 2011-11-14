module AmazonFlexPay::API #:nodoc:
  class VerifySignature < BaseRequest #:nodoc:
    attribute :url_end_point
    attribute :http_parameters

    class Response < BaseResponse #:nodoc:
      attribute :verification_status

      def verified?
        verification_status == 'Success'
      end
    end
  end
end
