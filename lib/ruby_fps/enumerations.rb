# pulled from documentation, with some obvious corrections
module RubyFPS::Enumerations
  AmountType = %w(Exact Maximum Minimum) # undocumented
  ChargeFeeTo = %w(Caller Recipient)
  CSOwner = %w(Caller Recipient) # undocumented
  CurrencyCode = %w(USD)
  FPSOperation = %w(Pay Refund Settle SettleDebt WriteOffDebt FundPrepaid Reserve)
  InstrumentId = %w(InstrumentId) # whaaaaaaat? should go in DataTypes probably, but it actually seems like a simple field.
  InstrumentStatus = %w(Active All Cancelled)
  MarketplaceRefundPolicy = %w(MarketplaceTxnOnly MasterAndMarketplaceTxn MasterTxnOnly) # moved from DataTypes
  PaymentMethod = %w(ABT ACH CC Debt Prepaid)
  RecipientVerificationStatus = %w(VerificationComplete VerificationPending VerificationCompleteNoLimits) # moved from DataTypes
  RelationType = %w(MarketplaceFee Parent Refund RefundReversal Reserve Settle)
  SoftDescriptorType = %w(Static Dynamic) # undocumented
  SortOrderByDate = %w(Ascending Descending)
  TokenStatus = %w(Active Inactive)
  TokenType = %w(MultiUse Recurring SingleUse Unrestricted)
  TransactionalRole = %w(Caller Recipient Sender)
  TransactionStatus = %w(Cancelled Failure Pending Reserved Success)
  UsageLimitType = %w(Amount Count) # undocumented
end
