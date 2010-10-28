module RubyFPS
  # Base model for pipelines.
  # Note that pipelines use camelcase(:lower) for all parameters, where API requests use full camelcase.
  class Pipeline < Model
    attr_accessor :caller_reference # required
    attr_accessor :cobranding_style, :cobranding_url, :website_description

    def url(return_url)
      params = self.to_hash.merge(
        'pipelineName' => pipeline_name,
        'callerKey' => RubyFPS.access_key,
        'version' => RubyFPS::PIPELINE_VERSION,
        'returnURL' => return_url
      )

      params['signatureVersion'] = 2
      params['signatureMethod'] = 'HmacSHA256'
      params['signature'] = RubyFPS.signature(RubyFPS.pipeline_endpoint, params)

      RubyFPS.pipeline_endpoint + '?' + RubyFPS.query_string(params)
    end

    protected

    def to_hash
      instance_variables.inject({}) do |hash, iname|
        name = iname[1..-1]
        hash.merge(name.camelcase(:lower) => send(name))
      end
    end

    def pipeline_name
      self.class.to_s.split('::').last
    end
  end
end
