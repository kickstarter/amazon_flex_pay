# Enumerated sets pulled from documentation, with some obvious corrections.
#
# See http://docs.amazonwebservices.com/AmazonFPS/latest/FPSAdvancedGuide/EnumeratedDataTypes.html
module AmazonFlexPay::Enumerations
  AmountType = %w(Exact Maximum Minimum) # undocumented
  ChargeFeeTo = %w(Caller Recipient)
  CsOwner = %w(Caller Recipient) # undocumented
  CurrencyCode = %w(USD)
  FpsOperation = %w(Pay Refund Settle SettleDebt WriteOffDebt FundPrepaid Reserve)
  InstrumentId = %w(InstrumentId) # whaaaaaaat? should go in DataTypes probably, but it actually seems like a simple field.
  InstrumentStatus = %w(Active All Cancelled)
  MarketplaceRefundPolicy = %w(MarketplaceTxnOnly MasterAndMarketplaceTxn MasterTxnOnly) # moved from DataTypes
  PaymentMethod = %w(ABT ACH CC Debt Prepaid)
  RecipientVerificationStatus = %w(PendingUserAction PendingReview Closed Active) # moved from DataTypes
  RelationType = %w(MarketplaceFee Parent Refund RefundReversal Reserve Settle)
  SoftDescriptorType = %w(Static Dynamic) # undocumented
  SortOrderByDate = %w(Ascending Descending)
  TokenStatus = %w(Active Inactive)
  TokenType = %w(MultiUse Recurring SingleUse Unrestricted)
  TransactionalRole = %w(Caller Recipient Sender)
  TransactionStatus = %w(Cancelled Failure Pending Reserved Success)
  UsageLimitType = %w(Amount Count) # undocumented
end
