module RubyFPS
  class ErrorResponse < Model
    attr_accessor :request_id

    attr_reader :errors
    def errors=(val)
      @errors = [val['Error']].flatten.map{|e| Error.new(e)}
    end

    class Error < Model
      attr_accessor :code, :message
    end
  end
end
