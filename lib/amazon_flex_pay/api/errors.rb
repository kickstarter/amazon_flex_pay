module AmazonFlexPay::API
  class Error < StandardError
    attr_accessor :request, :request_id, :code, :message

    def initialize(code, message, request_id, request)
      @request_id, @request, @code, @message = request_id, request, code, message
    end
  end

  # generated from http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAPIReference/APIErrorCodesTable.html
  # 2010-08-28
  %w(
    AccessFailure
    AccountClosed
    AccountLimitsExceeded
    AmountOutOfRange
    ConcurrentModification
    DuplicateRequest
    InactiveInstrument
    InsufficientBalance
    InternalError
    InvalidAccountState
    InvalidAccountState_Caller
    InvalidAccountState_Recipient
    InvalidAccountState_Sender
    InvalidParams
    InvalidSenderRoleForAccountType
    InvalidTokenId
    InvalidTokenId_Recipient
    InvalidTokenId_Sender
    InvalidTokenType
    InvalidTransactionId
    InvalidTransactionState
    OriginalTransactionFailed
    RefundAmountExceeded
    SenderNotOriginalRecipient
    SettleAmountGreaterThanDebt
    SettleAmountGreaterThanReserveAmount
    TokenAccessDenied
    TokenNotActive
    TokenNotActive_Recipient
    TokenNotActive_Sender
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
end