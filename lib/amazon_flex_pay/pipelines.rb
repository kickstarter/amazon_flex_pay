require_relative 'pipelines/base'
Dir[File.dirname(__FILE__) + '/pipelines/*'].each do |p| require_relative "pipelines/#{File.basename(p)}" end

module AmazonFlexPay
  module Pipelines
    # Creates a pipeline that may be used to change the payment method of a token.
    #
    # Note that this does not allow changing a token's limits or recipients or really anything but the method.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/EditTokenPipeline.html
    def edit_token_pipeline(caller_reference, return_url, options = {})
      cbui EditToken.new(options.merge(:caller_reference => caller_reference, :return_url => return_url))
    end

    # Creates a pipeline that will authorize you to send money _from_ the user multiple times.
    #
    # This is also necessary to create sender tokens that are valid for a long period of time, even if
    # you only plan to collect from the token once.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/MultiUsePipeline.html
    def multi_use_pipeline(caller_reference, return_url, options = {})
      cbui MultiUse.new(options.merge(:caller_reference => caller_reference, :return_url => return_url))
    end

    # Creates a pipeline that will authorize you to send money _to_ the user.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/CBUIapiMerchant.html
    def recipient_pipeline(caller_reference, return_url, options = {})
      cbui Recipient.new(options.merge(:caller_reference => caller_reference, :return_url => return_url))
    end

    # Creates a pipeline that will authorize you to send money _from_ the user one time.
    #
    # Note that if this payment fails, you must create another pipeline to get another token.
    #
    # See http://docs.amazonwebservices.com/AmazonFPS/2010-08-28/FPSBasicGuide/SingleUsePipeline.html
    def single_use_pipeline(caller_reference, return_url, options = {})
      cbui SingleUse.new(options.merge(:caller_reference => caller_reference, :return_url => return_url))
    end

    protected

    def cbui(pipeline)
      pipeline.to_url
    end
  end
end
