module RubyFPS::API
  class VerifySignature < Base
    attributes :url_end_point, :http_parameters

    class Response < BaseResponse
      attributes :verification_status

      def verified?
        verification_status == 'Success'
      end
    end
  end
end
