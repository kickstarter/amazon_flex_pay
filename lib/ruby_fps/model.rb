module RubyFPS
  class Model
    def initialize(hash)
      assign(hash)
    end

    protected

    def to_hash
      attribute_names.inject({}) do |hash, name|
        val = send(name)
        hash.merge(format_key(name) => val.is_a?(RubyFPS::Model) ? val.to_hash : format_value(send(name)))
      end
    end

    def format_key(key)
      key.camelcase
    end

    def format_value(val)
      case val
        when Time
        val.utc.strftime('%Y-%m-%dT%H:%M:%SZ')

        when TrueClass, FalseClass
        val.to_s.capitalize

        else
        val.to_s
      end
    end

    def attribute_names
      (instance_variables - ['@mocha']).map{|iname| iname[1..-1]}
    end

    def assign(hash)
      hash.each do |k, v|
        send("#{k.to_s.underscore}=", v)
      end
    end
  end
end
