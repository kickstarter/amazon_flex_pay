module AmazonFlexPay
  module Util
    # Flattens a possibly-nested hash into a query string for Amazon.
    # With Amazon, nested hashes are flattened with a period, as follows:
    #
    #   AmazonFlexPay::Util.query_string(:foo => {:hello => 'world'})
    #   => "foo.hello=world"
    #
    def query_string(params, prefix = nil) #:nodoc:
      prefix = "#{prefix}." if prefix
      params.keys.sort { |a, b| a.to_s <=> b.to_s }.collect do |key|
        case val = params[key]
          when Hash
          query_string(val, key)
          else
          "#{prefix}#{key}=#{escape val}"
        end
      end.join('&')
    end

    UNSAFE = /[^A-Za-z0-9_.~-]/ #:nodoc:
    # Amazon is very specific about which chars should be escaped, and which should not.
    def escape(value) #:nodoc:
      # note that URI.escape(' ') => '%20', and CGI.escape(' ') => '+'
      URI.escape(value.to_s, UNSAFE)
    end

    extend self
  end
end
