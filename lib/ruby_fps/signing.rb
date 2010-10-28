module RubyFPS
  class << self
    def signature(endpoint, params)
      uri = URI.parse(endpoint)

      signable_string = [
        'GET',
        uri.host,
        uri.path,
        query_string(params)
      ].join("\n")

      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, RubyFPS.secret_key, signable_string)).strip
    end

    def query_string(params)
      params.keys.sort { |a, b| a.to_s <=> b.to_s }.collect do |key|
        "#{key}=#{escape(params[key])}"
      end.join('&')
    end

    UNSAFE = /[^A-Za-z0-9_.~-]/
    # Amazon is very specific about which chars should be escaped, and which should not.
    def escape(value)
      # note that URI.escape(' ') => '%20', and CGI.escape(' ') => '+'
      URI.escape(value.to_s, UNSAFE)
    end
  end
end
