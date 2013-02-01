module AmazonFlexPay::Pipelines #:nodoc:
  class Base < AmazonFlexPay::Model
    attribute :caller_reference # required
    attribute :cobranding_style
    attribute :cobranding_url
    attribute :website_description

    # Returns a full redirectable URL for this pipeline.
    def to_url(return_url)
      AmazonFlexPay.pipeline_endpoint + '?' + self.to_param(return_url)
    end

    # Converts the Pipeline object into parameters and signs them.
    def to_param(return_url)
      params = to_hash(return_url).merge(
        'callerKey' => AmazonFlexPay.access_key,
        'signatureVersion' => 2,
        'signatureMethod' => 'HmacSHA256'
      )
      params['signature'] = AmazonFlexPay.sign(AmazonFlexPay.pipeline_endpoint, params)
      AmazonFlexPay::Util.query_string(params)
    end

    def to_hash(return_url)
      super().merge(
        'pipelineName' => pipeline_name,
        'version' => AmazonFlexPay::PIPELINE_VERSION,
        'returnURL' => return_url
      )
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
