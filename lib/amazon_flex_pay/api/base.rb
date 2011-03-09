module AmazonFlexPay::API #:nodoc:
  class Base < AmazonFlexPay::Model
    # This compiles an API request object into a URL, sends it to Amazon, and processes
    # the response.
    def submit
      url = AmazonFlexPay.api_endpoint + '?' + AmazonFlexPay.query_string(self.to_params)
      response = begin
        self.class::Response.from_xml(RestClient.get(url).body)
      rescue RestClient::BadRequest, RestClient::Unauthorized, RestClient::Forbidden => e
        ErrorResponse.from_xml(e.response.body)
      end
      response.request = self
      response
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

      # Check response.error? to determine whether it's an ErrorResponse or not.
      def error?
        false
      end

      # Parses Amazon's XML response to REST requests and instantiates the response.
      def self.from_xml(xml)
        response = MultiXml.parse(xml)

        response_key = response.keys.find{|k| k.match(/Response$/)}
        hash = response[response_key]['ResponseMetadata']

        result_key = response[response_key].keys.find{|k| k.match(/Result$/)}
        hash.merge!(response[response_key][result_key]) if response[response_key][result_key] # not all APIs have a result object

        new(hash)
      end
    end

    class ErrorResponse < AmazonFlexPay::Model #:nodoc:
      # Re-implements the XML parsing because ErrorResponse does not inherit from BaseResponse.
      def self.from_xml(xml)
        new(MultiXml.parse(xml)['Response'])
      end

      # Check response.error? to determine whether Amazon accepted the request.
      def error?
        true
      end

      attribute :request
      attribute :request_id

      attr_reader :errors
      def errors=(val)
        @errors = [val['Error']].flatten.map{|e| Error.new(e)}
      end

      class Error < AmazonFlexPay::Model #:nodoc:
        attribute :code
        attribute :message
      end
    end

    protected

    def action_name #:nodoc:
      self.class.to_s.split('::').last
    end
  end
end
