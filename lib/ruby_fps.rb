require 'rubygems'
require 'rest_client'
require 'multi_xml'
require 'active_support/core_ext/string/inflections' # camelcase, underscore

require 'ruby_fps/signed_query'

RestClient.log = 'stdout'

module RubyFPS

  class << self
    ##
    # Base API stuff
    ##

    attr_accessor :access_key
    attr_accessor :secret_key
    attr_accessor :api_endpoint
    attr_accessor :pipeline_endpoint

    ##
    # API Methods
    ##

    def get_transaction_status(id)
      submit(:get_transaction_status, :transaction_id => id)
    end

    def get_token_by_caller_reference(ref)
      submit(:get_token_by_caller, :caller_reference => ref)
    end

    def get_token_by_id(id)
      submit(:get_token_by_caller, :token_id => id)
    end

    def get_recipient_verification_status(recipient_token_id)
      submit(:get_recipient_verification_status, :recipient_token_id => recipient_token_id)
    end

    protected

    def submit(action, args)
      const_get(action.to_s.camelcase).new(args).submit
    end
  end

  ##
  # Base Classes
  ##

  class Model
    def initialize(hash)
      assign(hash)
    end

    protected

    def assign(hash)
      hash.each do |k, v|
        send("#{k.to_s.underscore}=", v)
      end
    end
  end

  class Request < Model
    def self.requires(*fields)
      # TODO: save requiredness
    end

    def valid?
      # check required fields
      # check enumerated fields
      true
    end

    def submit
      if valid?
        params = self.to_hash.merge(
          'Action' => action,
          'AWSAccessKeyId' => RubyFPS.access_key,
          'Version' => '2008-09-17',
          'Timestamp' => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
        )

        query = RubyFPS::SignedQuery.new(
          RubyFPS.api_endpoint,
          RubyFPS.secret_key,
          params
        )

        begin
          response = RestClient.get(RubyFPS.api_endpoint + '?' + query.to_s)
          self.class::Response.new(MultiXml.parse(response.body)[action + 'Response'])
        rescue RestClient::BadRequest, RestClient::Unauthorized, RestClient::Forbidden => e
          RubyFPS::ErrorResponse.new(MultiXml.parse(e.response.body)['Response'])
        end
      else
        raise 'raise a better error here'
      end
    end

    protected

    def to_hash
      instance_variables.inject({}) do |hash, iname|
        name = iname[1..-1]
        hash.merge(name.camelcase => send(name))
      end
    end

    def action
      self.class.to_s.split('::').last
    end
  end

  class ErrorResponse < Model
    attr_accessor :request_id

    attr_reader :errors
    def errors=(val)
      @errors = [val['Error']].flatten.map{|e| Error.new(e)}
    end

    class Error < Model
      attr_accessor :code, :message
    end
  end

  class Response < Model
    attr_accessor :request_id

    def initialize(hash)
      assign(hash['ResponseMetadata'])
      assign(hash[hash.keys.find{|k| k.match /Result$/}])
    end
  end

  class Pipeline < Model
    def to_uri
      # crunch params, add endpoint, magic happens!
    end
  end

  ##
  # Concrete Classes
  ##

  class GetTransactionStatus < Request
    attr_accessor :transaction_id

    class Response < RubyFPS::Response
      attr_accessor :caller_reference, :status_code, :status_message, :transaction_id, :transaction_status
    end
  end

  class GetTokenByCaller < Request
    attr_accessor :token_id
    attr_accessor :caller_reference

    class Response < RubyFPS::Response
      attr_reader :token
      def token=(val)
        @token = Token.new(val)
      end

      class Token < RubyFPS::Model
        attr_accessor :token_id, :old_token_id, :token_type
        attr_accessor :friendly_name, :token_status, :date_installed, :caller_reference, :payment_reason
      end
    end
  end

  class GetRecipientVerificationStatus < Request
    attr_accessor :recipient_token_id

    class Response < RubyFPS::Response
      attr_accessor :recipient_verification_status
    end
  end
end

RubyFPS.api_endpoint = 'https://fps.sandbox.amazonaws.com/'
RubyFPS.pipeline_endpoint = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
