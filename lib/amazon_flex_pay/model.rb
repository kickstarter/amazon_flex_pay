module AmazonFlexPay
  
  class Model
    class << self
      # Creates an attribute by defining reader and writer methods. These attributes will
      # also be returned by AmazonFlexPay::Model#to_hash for processing into query strings, etc.
      #
      # A few different attribute types are supported.
      #
      # === Enumerated Attributes
      # If Amazon only supports certain values, this will enforce a whitelist. Name one of
      # the existing enumerations from AmazonFlexPay::Enumerations like this:
      #
      #   attribute :status, :enumeration => :token_status
      #
      # === Complex Attributes
      # When the attribute itself has attributes, name one of the existing complex data types
      # from AmazonFlexPay::DataTypes like this:
      #
      #   attribute :final_amount, :type => :amount
      #
      # === Arrays of Complex Attributes
      # When Amazon's XML returns (or has the potential to return) multiples of a complex data
      # type, declare it like this:
      #
      #   attribute :transaction, :collection => :transaction_detail
      #
      # And then for convenience and readability, alias a plural method:
      #
      #   alias_method :transactions, :transaction
      def attribute(attr, options = {})
        attribute_names << attr.to_s.camelcase
        name = attr.to_s.underscore

        # writer
        if options[:enumeration]
          enumerated_attribute(name, options[:enumeration])
        elsif options[:type]
          complex_attribute(name, options[:type])
        elsif options[:collection]
          collection_attribute(name, options[:collection])
        else
          attr_accessor name
        end
      end

      # The names of all of the attributes of this model, in CamelCase.
      def attribute_names
        @attributes ||= (self == Model) ? [] : superclass.attribute_names.dup
      end

      def enumerated_attribute(attr, source = nil) #:nodoc:
        source ||= attr
        class_eval <<-END
          def #{attr}
            @#{attr}
          end

          def #{attr}=(val)
            options = AmazonFlexPay::Enumerations::#{source.to_s.camelcase}
            unless [val].flatten.all?{ |v| options.include?(v) }
              raise ArgumentError.new("\#{val} is not an allowed option (\#{options.join(', ')})")
            end
            @#{attr} = val
          end
        END
      end

      def complex_attribute(attr, data_type = nil) #:nodoc:
        data_type ||= attr
        class_eval <<-END
          def #{attr}
            @#{attr} ||= AmazonFlexPay::DataTypes::#{data_type.to_s.camelcase}.new
          end

          def #{attr}=(hash)
            @#{attr} = AmazonFlexPay::DataTypes::#{data_type.to_s.camelcase}.new(hash)
          end
        END
      end

      def collection_attribute(attr, data_type = nil) #:nodoc:
        class_eval <<-END
          def #{attr}
            @#{attr} ||= []
          end

          def #{attr}=(array)
            @#{attr} = [array].flatten.map{|hash| AmazonFlexPay::DataTypes::#{data_type.to_s.camelcase}.new(hash)}
          end
        END
      end
    end

    def initialize(hash = {}) #:nodoc:
      assign(hash)
    end

    # Formats all attributes into a hash of parameters.
    def to_hash
      self.class.attribute_names.inject({}) do |hash, name|
        val = format_value(send(name.underscore))
        val.empty? ? hash : hash.merge(format_key(name) => val)
      end
    end

    protected

    # By default all parameter keys are CamelCase.
    def format_key(key)
      key.camelcase
    end

    # Formats times and booleans as Amazon desires them.
    def format_value(val)
      case val
        when AmazonFlexPay::Model
        val.to_hash

        when Time
        val.utc.strftime('%Y-%m-%dT%H:%M:%SZ')

        when TrueClass, FalseClass
        val.to_s.capitalize

        when Array
        val.join(',')

        else
        val.to_s
      end
    end

    # Allows easy initialization for a model by assigning attributes from a hash.
    def assign(hash)
      hash.each do |k, v|
        send("#{k.to_s.underscore}=", v.respond_to?(:strip) ? v.strip : v)
      end
    end
  end
end
