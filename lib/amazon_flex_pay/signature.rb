module AmazonFlexPay
  # Generates a signature for the given URL and parameters.
  class Signature
    def initialize(secret_key, endpoint, params)
      @secret_key, @endpoint, @params = secret_key, endpoint, params
    end

    def generate
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @secret_key, signable)).strip
    end

    private

    def signable
      uri = URI.parse(@endpoint)
      [
        'GET',
        uri.host,
        uri.path,
        AmazonFlexPay::Util.query_string(@params)
      ].join("\n")
    end
  end
end
