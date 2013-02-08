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

require_relative 'amazon_flex_pay/client'

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
end
