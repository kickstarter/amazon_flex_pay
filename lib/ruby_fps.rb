require 'uri'
require 'base64'
require 'openssl'

require 'rubygems'
require 'rest_client'
require 'multi_xml'
require 'active_support/core_ext/string/inflections' # camelcase, underscore

require 'ruby_fps/signing'
require 'ruby_fps/model'
require 'ruby_fps/data_types'
require 'ruby_fps/enumerations'

require 'ruby_fps/api'
require 'ruby_fps/pipelines'

RestClient.log = 'stdout'

module RubyFPS
  VERSION = '1.0.pre'
  API_VERSION = '2010-08-28'
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
    # Call <tt>RubyFPS.go_live!</tt> to enable live transactions and real money in this environment.
    def go_live!
      self.api_endpoint = 'https://fps.amazonaws.com/'
      self.pipeline_endpoint = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    end
  end

end

