require 'uri'
require 'base64'
require 'openssl'

require 'rubygems'
require 'rest_client'
require 'multi_xml'
require 'active_support/core_ext/string/inflections' # camelcase, underscore

require 'ruby_fps/signing'

require 'ruby_fps/model'

require 'ruby_fps/response'
require 'ruby_fps/error_response'
require 'ruby_fps/request'
require 'ruby_fps/api'

require 'ruby_fps/pipeline'
require 'ruby_fps/pipelines'

RestClient.log = 'stdout'

module RubyFPS
  API_VERSION = '2008-09-17'
  PIPELINE_VERSION = '2009-01-09'

  class << self
    attr_accessor :access_key
    attr_accessor :secret_key

    attr_writer :api_endpoint
    def api_endpoint
      @api_endpoint ||= 'https://fps.sandbox.amazonaws.com/'
    end

    attr_writer :pipeline_endpoint
    def pipeline_endpoint
      @pipeline_endpoint ||= 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
    end

    # RubyFPS defaults to the Amazon Payments sandbox.
    # Call RubyFPS.go_live! to enable live transactions and real money.
    def go_live!
      self.api_endpoint = 'https://fps.amazonaws.com/'
      self.pipeline_endpoint = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    end
  end

end

