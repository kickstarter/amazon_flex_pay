require 'uri'
require 'base64'
require 'openssl'

module RubyFPS
  class SignedQuery < Hash
    SIGNATURE_VERSION = '2'

    def initialize(uri, secret_key, params = {})
      update(params)
      @uri = URI.parse(uri.to_s)
      @secret_key = secret_key
      sign
    end

    def to_s
      keys.sort { |a, b| a.to_s <=> b.to_s }.collect do |key|
        "#{key}=#{self.class.escape(fetch(key))}"
      end.join('&')
    end

    def sign
      store(:SignatureVersion, SIGNATURE_VERSION)
      store(:SignatureMethod, 'HmacSHA256')
      store(:Signature, signature)

      # for pipelines, we use different keys. sigh.
      #store(:signatureVersion, SIGNATURE_VERSION)
      #store(:signatureMethod, 'HmacSHA256')
      #store(:signature, signature)
    end

    def signature
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, @secret_key, signable_string)).strip
    end

    def signable_string
      [ 'GET',
        @uri.host,
        @uri.path,
        to_s
      ].join("\n")
    end

    class << self
      UNSAFE = /[^A-Za-z0-9_.~-]/
      # Amazon is very specific about what chars should be escaped, and which should not.
      def escape(value)
        # note that URI.escape(' ') => '%20', and CGI.escape(' ') => '+'
        URI.escape(value.to_s, UNSAFE)
      end
    end
  end
end
