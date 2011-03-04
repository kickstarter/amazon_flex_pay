module RubyFPS::Pipelines
  class EditToken < Base
    attribute :token_id # required
    attribute :payment_method, :enumeration => :payment_method
  end
end
