require 'uri'
require 'base64'
require 'openssl'

require 'rubygems'
require 'rest_client'
require 'multi_xml'
require 'active_support' # camelcase, underscore
require 'active_support/inflector'
require 'active_support/notifications'

require_relative 'amazon_flex_pay/util'
require_relative 'amazon_flex_pay/signature'
require_relative 'amazon_flex_pay/model'
require_relative 'amazon_flex_pay/enumerations'
require_relative 'amazon_flex_pay/data_types'

require_relative 'amazon_flex_pay/api'
require_relative 'amazon_flex_pay/pipelines'

module AmazonFlexPay
  VERSION = '0.10.0'
  API_VERSION = '2011-09-20'
  PIPELINE_VERSION = '2009-01-09'

  ENDPOINTS = {
    :sandbox => {
      :api => 'https://fps.sandbox.amazonaws.com/',
      :cbui => 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
    }.freeze,
    :live => {
      :api => 'https://fps.amazonaws.com/',
      :cbui => 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    }.freeze
  }

  extend Util
  extend AmazonFlexPay::API
  extend AmazonFlexPay::Pipelines

  class << self
    attr_accessor :access_key
    attr_accessor :secret_key

    # The URL used for API calls.
    #
    # Defaults to the sandbox unless you set it explicitly or call <tt>go_live!</tt>.
    def api_endpoint
      @api_endpoint ||= ENDPOINTS[:sandbox][:api]
    end
    attr_writer :api_endpoint

    # The URL used for pipeline redirects.
    #
    # Defaults to the sandbox unless you set it explicitly or call <tt>go_live!</tt>.
    def pipeline_endpoint
      @pipeline_endpoint ||= ENDPOINTS[:sandbox][:cbui]
    end
    attr_writer :pipeline_endpoint

    # By default all API calls and pipeline redirects are in the Amazon Payments sandbox.
    #
    # Call <tt>AmazonFlexPay.go_live!</tt> to enable live transactions and real money in this environment.
    def go_live!
      self.api_endpoint = ENDPOINTS[:live][:api]
      self.pipeline_endpoint = ENDPOINTS[:live][:cbui]
    end

    def sign(endpoint, params)
      Signature.new(secret_key, endpoint, params).generate
    end

  end

end
