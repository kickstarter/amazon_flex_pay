module RubyFPS
  class Model
    def initialize(hash)
      assign(hash)
    end

    protected

    def assign(hash)
      hash.each do |k, v|
        send("#{k.to_s.underscore}=", v)
      end
    end
  end
end
