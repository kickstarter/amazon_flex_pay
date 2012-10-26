require 'uri'
require 'base64'
require 'openssl'

require 'rubygems'
require 'rest_client'
require 'multi_xml'
require 'active_support' # camelcase, underscore
require 'active_support/inflector'
require 'active_support/notifications'

require 'amazon_flex_pay/version'

require 'amazon_flex_pay/signing'
require 'amazon_flex_pay/model'
require 'amazon_flex_pay/enumerations'
require 'amazon_flex_pay/data_types'

require 'amazon_flex_pay/api'
require 'amazon_flex_pay/pipelines'

module AmazonFlexPay
  VERSION = '0.9.13'
  API_VERSION = '2011-09-20'
  PIPELINE_VERSION = '2009-01-09'

  class << self
    attr_accessor :access_key
    attr_accessor :secret_key

    # The URL used for API calls.
    #
    # Defaults to the sandbox unless you set it explicitly or call <tt>go_live!</tt>.
    def api_endpoint
      @api_endpoint ||= 'https://fps.sandbox.amazonaws.com/'
    end
    attr_writer :api_endpoint

    # The URL used for pipeline redirects.
    #
    # Defaults to the sandbox unless you set it explicitly or call <tt>go_live!</tt>.
    def pipeline_endpoint
      @pipeline_endpoint ||= 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
    end
    attr_writer :pipeline_endpoint

    # By default all API calls and pipeline redirects are in the Amazon Payments sandbox.
    #
    # Call <tt>AmazonFlexPay.go_live!</tt> to enable live transactions and real money in this environment.
    def go_live!
      self.api_endpoint = 'https://fps.amazonaws.com/'
      self.pipeline_endpoint = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    end
  end

end
