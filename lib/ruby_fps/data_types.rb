# Complex Data Types pulled from the documentation
module RubyFPS::DataTypes
  class Amount < RubyFPS::Model
    attr_accessor :currency_code, :value

    def currency_code=(val)
      raise ArgumentError.new("#{val} is not an allowed option (#{RubyFPS::Enumerations::CurrencyCode.join(', ')})") unless RubyFPS::Enumerations::CurrencyCode.include?(val)
      @currency_code = val
    end
  end
end
