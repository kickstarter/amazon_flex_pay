module RubyFPS::Pipelines
  class EditToken < Base
    attr_accessor :token_id # required
    attr_accessor :payment_method # allowed payment types
  end
end
