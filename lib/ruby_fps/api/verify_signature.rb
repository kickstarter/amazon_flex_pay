module RubyFPS::API
  class VerifySignature < Base
    attr_accessor :url_end_point, :http_parameters

    class Response < BaseResponse
      attr_accessor :verification_status

      def verified?
        verification_status == 'Success'
      end
    end
  end
end
