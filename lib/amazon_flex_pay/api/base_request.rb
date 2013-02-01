module AmazonFlexPay::API #:nodoc:
  class BaseRequest < AmazonFlexPay::Model
    # This compiles an API request object into a URL, sends it to Amazon, and processes
    # the response.
    def submit
      url = self.to_url
      ActiveSupport::Notifications.instrument("amazon_flex_pay.api", :action => action_name, :request => url) do |payload|
        begin
          http = RestClient.get(url)

          payload[:response] = http.body
          payload[:code] = http.code

          response = self.class::Response.from_xml(http.body)
          response.request = self
          response

        rescue RestClient::BadRequest, RestClient::Unauthorized, RestClient::Forbidden => e
          payload[:response] = e.http_body
          payload[:code] = e.http_code

          er = ErrorResponse.from_xml(e.response.body)
          klass = AmazonFlexPay::API.const_get(er.errors.first.code)
          raise klass.new(er.errors.first.code, er.errors.first.message, er.request_id, self)
        end
      end
    end

    def to_url
      AmazonFlexPay.api_endpoint + '?' + self.to_param
    end

    def to_param
      params = to_hash.merge(
        'AWSAccessKeyId' => AmazonFlexPay.access_key,
        'Timestamp' => format_value(Time.now),
        'SignatureVersion' => 2,
        'SignatureMethod' => 'HmacSHA256'
      )
      params['Signature'] = AmazonFlexPay.sign(AmazonFlexPay.api_endpoint, params)
      AmazonFlexPay::Util.query_string(params)
    end

    # Converts the API request object into parameters and signs them.
    def to_hash
      super.merge(
        'Action' => action_name,
        'Version' => AmazonFlexPay::API_VERSION
      )
    end

    class BaseResponse < AmazonFlexPay::Model
      attribute :request
      attribute :request_id

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

    class ErrorResponse < AmazonFlexPay::Model
      attribute :request_id

      def self.from_xml(xml)
        new(MultiXml.parse(xml)['Response'])
      end

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
