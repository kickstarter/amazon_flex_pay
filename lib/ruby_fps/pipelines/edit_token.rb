module RubyFPS::Pipelines
  class EditToken < Base
    attributes :token_id # required
    attributes :payment_method # allowed payment types
  end
end
