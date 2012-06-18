module AmazonFlexPay::API
  class Error < StandardError
    attr_accessor :request, :request_id, :code, :message

    def initialize(code, message, request_id, request)
      @request_id, @request, @code, @message = request_id, request, code, message
    end

    def to_s
      message
    end
  end

  # generated from http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAPIReference/APIErrorCodesTable.html
  # as of: 2012-06-15
  %w(
    AccessFailure
    AccountClosed
    AccountLimitsExceeded
    AmountOutOfRange
    AuthFailure
    ConcurrentModification
    DuplicateRequest
    InactiveInstrument
    IncompatibleTokens
    InstrumentAccessDenied
    InstrumentExpired
    InsufficientBalance
    InternalError
    InvalidAccountState
    InvalidAccountState_Caller
    InvalidAccountState_Recipient
    InvalidAccountState_Sender
    InvalidCallerReference
    InvalidClientTokenId
    InvalidDateRange
    InvalidParams
    InvalidPaymentInstrument
    InvalidPaymentMethod
    InvalidRecipientForCCTransaction
    InvalidSenderRoleForAccountType
    InvalidTokenId
    InvalidTokenId_Recipient
    InvalidTokenId_Sender
    InvalidTokenType
    InvalidTransactionId
    InvalidTransactionState
    NotMarketplaceApp
    OriginalTransactionFailed
    OriginalTransactionIncomplete
    PaymentInstrumentNotCC
    PaymentMethodNotDefined
    PrepaidFundingLimitExceeded
    RefundAmountExceeded
    SameSenderAndRecipient
    SameTokenIdUsedMultipleTimes
    SenderNotOriginalRecipient
    SettleAmountGreaterThanDebt
    SettleAmountGreaterThanReserveAmount
    SignatureDoesNotMatch
    TokenAccessDenied
    TokenNotActive
    TokenNotActive_Recipient
    TokenNotActive_Sender
    TokenUsageError
    TransactionDenied
    TransactionFullyRefundedAlready
    TransactionTypeNotRefundable
    UnverifiedAccount_Recipient
    UnverifiedAccount_Sender
    UnverifiedBankAccount
    UnverifiedEmailAddress_Caller
    UnverifiedEmailAddress_Recipient
    UnverifiedEmailAddress_Sender
  ).each do |name|
    const_set(name, Class.new(Error))
  end

  # undocumented errors
  %w(
    InvalidSignature
  ).each do |name|
    const_set(name, Class.new(Error))
  end
end