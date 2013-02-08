require 'amazon_flex_pay/signature'
require 'amazon_flex_pay/api'
require 'amazon_flex_pay/pipelines'

module AmazonFlexPay
  class Client
    attr_reader :access_key
    attr_reader :secret_key
    attr_reader :mode

    include AmazonFlexPay::API
    include AmazonFlexPay::Pipelines

    # Initialize a Client for a set of credentials.
    # By default the client will run in sandbox mode.
    def initialize(access_key, secret_key, mode = :sandbox)
      raise ArgumentError "unknown mode #{mode}" unless ENDPOINTS[mode.to_sym]

      @access_key = access_key
      @secret_key = secret_key
      @mode = mode
    end

    def sign(endpoint, params)
      Signature.new(secret_key, endpoint, params).generate
    end
  end
end
