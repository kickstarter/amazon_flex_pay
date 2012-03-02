require File.dirname(__FILE__) + '/test_helper'

class AmazonFlexPayTest < AmazonFlexPay::Test
  include AmazonFlexPay::DataTypes
  include ResponseSamples

  should "alias TransactionDetail#related_transaction" do
    detail = TransactionDetail.new(:related_transaction => [{:relation_type => 'Refund', :transaction_id => 'abc123'}])
    assert detail.respond_to?(:related_transactions)
    assert_equal detail.related_transactions, detail.related_transaction
  end
end