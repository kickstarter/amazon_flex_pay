module RubyFPS
  class Request < Model
    def self.requires(*fields)
      # TODO: save requiredness
    end

    def valid?
      # check required fields
      # check enumerated fields
      true
    end

    def submit
      raise 'API request is invalid' unless valid?

      params = self.to_hash.merge(
        'Action' => action,
        'AWSAccessKeyId' => RubyFPS.access_key,
        'Version' => RubyFPS::API_VERSION,
        'Timestamp' => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
      )

      params['SignatureVersion'] = 2
      params['SignatureMethod'] = 'HmacSHA256'
      params['Signature'] = RubyFPS.signature(RubyFPS.api_endpoint, params)

      begin
        response = RestClient.get(RubyFPS.api_endpoint + '?' + RubyFPS.query_string(params))
        self.class::Response.new(MultiXml.parse(response.body)[action + 'Response'])
      rescue RestClient::BadRequest, RestClient::Unauthorized, RestClient::Forbidden => e
        RubyFPS::ErrorResponse.new(MultiXml.parse(e.response.body)['Response'])
      end
    end

    protected

    def to_hash
      instance_variables.inject({}) do |hash, iname|
        name = iname[1..-1]
        hash.merge(name.camelcase => send(name))
      end
    end

    def action
      self.class.to_s.split('::').last
    end
  end
end
