module AmazonFlexPay
  class << self
    # Returns a signature for the given URL and parameters.
    def signature(endpoint, params)
      uri = URI.parse(endpoint)

      signable_string = [
        'GET',
        uri.host,
        uri.path,
        query_string(params)
      ].join("\n")

      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, AmazonFlexPay.secret_key, signable_string)).strip
    end
  end
end
