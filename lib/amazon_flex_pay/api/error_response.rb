module AmazonFlexPay::API #:nodoc:
  class ErrorResponse < AmazonFlexPay::Model #:nodoc:
    # Re-implements the XML parsing because ErrorResponse does not inherit from BaseResponse.
    def self.from_xml(xml)
      new(MultiXml.parse(xml)['Response'])
    end

    # Check response.error? to determine whether Amazon accepted the request.
    def error?
      true
    end

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
end
