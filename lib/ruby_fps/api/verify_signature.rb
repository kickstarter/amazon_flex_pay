module RubyFPS::API
  class VerifySignature < Base
    attribute :url_end_point
    attribute :http_parameters

    class Response < BaseResponse
      attribute :verification_status

      def verified?
        verification_status == 'Success'
      end
    end
  end
end
