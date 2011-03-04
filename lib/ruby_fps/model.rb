module RubyFPS
  class Model
    class << self
      def attributes(*attrs)
        attrs.each{|attr| attribute(attr)}
      end

      def attribute(attr, options = {})
        @attributes ||= []
        @attributes << attr.to_s
        attr_accessor attr

        if options[:enumeration]
          enumerated_attribute(attr, options[:enumeration])
        elsif options[:type]
          complex_attribute(attr, options[:type])
        end
      end

      def attribute_names
        @attributes || []
      end

      def enumerated_attribute(attr, source = nil)
        source ||= attr
        class_eval <<-END
          def #{attr}=(val)
            options = RubyFPS::Enumerations::#{source.to_s.camelcase}
            unless options.include?(val)
              raise ArgumentError.new("\#{val} is not an allowed option (\#{options.join(', ')})")
            end
            @#{attr} = val
          end
        END
      end

      def complex_attribute(attr, data_type = nil)
        data_type ||= attr
        class_eval <<-END
          def #{attr}=(hash)
            @#{attr} = RubyFPS::DataTypes::#{data_type.to_s.camelcase}.new(hash)
          end
        END
      end
    end

    def initialize(hash)
      assign(hash)
    end

    protected

    def to_hash
      self.class.attribute_names.inject({}) do |hash, name|
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

    def assign(hash)
      hash.each do |k, v|
        send("#{k.to_s.underscore}=", v)
      end
    end
  end
end
