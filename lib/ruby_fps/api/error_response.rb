module RubyFPS::API
  class ErrorResponse < RubyFPS::Model
    def self.from_xml(xml)
      new(MultiXml.parse(xml)['Response'])
    end

    attributes :request_id

    attr_reader :errors
    def errors=(val)
      @errors = [val['Error']].flatten.map{|e| Error.new(e)}
    end

    class Error < RubyFPS::Model
      attributes :code, :message
    end
  end
end
