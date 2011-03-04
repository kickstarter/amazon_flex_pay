module RubyFPS
  class Model
    def initialize(hash)
      assign(hash)
    end

    protected

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
