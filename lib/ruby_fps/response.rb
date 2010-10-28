module RubyFPS
  class Response < Model
    attr_accessor :request_id

    def initialize(hash)
      assign(hash['ResponseMetadata'])
      assign(hash[hash.keys.find{|k| k.match /Result$/}])
    end
  end
end
