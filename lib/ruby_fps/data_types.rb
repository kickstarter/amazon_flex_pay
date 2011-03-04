# Complex Data Types pulled from the documentation
module RubyFPS::DataTypes
  class Amount < RubyFPS::Model
    attribute :currency_code, :enumeration => :currency_code
    attribute :value
  end
end
