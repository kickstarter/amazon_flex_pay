# Complex Data Types pulled from the documentation
module RubyFPS::DataTypes
  class Amount < RubyFPS::Model
    attr_accessor :currency_code, :value
    enumerated :currency_code
  end
end
