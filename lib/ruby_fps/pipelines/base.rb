module RubyFPS::Pipelines #:nodoc:
  class Base < RubyFPS::Model
    attribute :caller_reference # required
    attribute :cobranding_style
    attribute :cobranding_url
    attribute :website_description

    # Returns a full redirectable URL for this pipeline.
    def url(return_url)
      RubyFPS.pipeline_endpoint + '?' + RubyFPS.query_string(to_params(return_url))
    end

    # Converts the Pipeline object into parameters and signs them.
    def to_params(return_url)
      params = self.to_hash.merge(
        'pipelineName' => pipeline_name,
        'callerKey' => RubyFPS.access_key,
        'version' => RubyFPS::PIPELINE_VERSION,
        'returnURL' => return_url
      )

      params['signatureVersion'] = 2
      params['signatureMethod'] = 'HmacSHA256'
      params['signature'] = RubyFPS.signature(RubyFPS.pipeline_endpoint, params)

      params
    end

    protected

    # For pipelines, parameter keys are camelCase instead of CamelCase.
    def format_key(key)
      key.camelcase(:lower)
    end

    def pipeline_name #:nodoc:
      self.class.to_s.split('::').last
    end
  end
end
