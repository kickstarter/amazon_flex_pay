module AmazonFlexPay::API #:nodoc:
  class Base < AmazonFlexPay::Model
    # This compiles an API request object into a URL, sends it to Amazon, and processes
    # the response.
    def submit
      response = begin
        url = AmazonFlexPay.api_endpoint + '?' + AmazonFlexPay.query_string(self.to_params)
        response = RestClient.get(url)
        self.class::Response.from_xml(response.body)
      rescue RestClient::BadRequest, RestClient::Unauthorized, RestClient::Forbidden => e
        AmazonFlexPay::API::ErrorResponse.from_xml(e.response.body)
      end
      response.request = self
      response
    end

    # Check response.error? to determine whether it's an ErrorResponse or not.
    def error?
      false
    end

    # Converts the API request object into parameters and signs them.
    def to_params
      params = self.to_hash.merge(
        'Action' => action_name,
        'AWSAccessKeyId' => AmazonFlexPay.access_key,
        'Version' => AmazonFlexPay::API_VERSION,
        'Timestamp' => format_value(Time.now)
      )

      params['SignatureVersion'] = 2
      params['SignatureMethod'] = 'HmacSHA256'
      params['Signature'] = AmazonFlexPay.signature(AmazonFlexPay.api_endpoint, params)

      params
    end

    class BaseResponse < AmazonFlexPay::Model
      attribute :request
      attribute :request_id

      # Parses Amazon's XML response to REST requests and instantiates the response.
      def self.from_xml(xml)
        hash = MultiXml.parse(xml)
        response_key = hash.keys.find{|k| k.match(/Response$/)}
        new(hash[response_key])
      end

      def initialize(hash) #:nodoc:
        assign(hash['ResponseMetadata'])
        result_key = hash.keys.find{|k| k.match(/Result$/)}
        assign(hash[result_key]) if hash[result_key] # not all APIs have a result object
      end
    end

    protected

    def action_name #:nodoc:
      self.class.to_s.split('::').last
    end
  end
end
