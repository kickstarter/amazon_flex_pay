# Sample REST responses pulled from Amazon's Docs
module ResponseSamples

  def cancel_response
    <<-END
    <CancelResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <CancelResult>
        <TransactionId>14GKI1SKSR1V6DO1RCCB32RBR6KLODMGQUD</TransactionId>
        <TransactionStatus>Cancelled</TransactionStatus>
      </CancelResult>
      <ResponseMetadata>
        <RequestId>6fe4b755-a328-419d-8967-e1d3b43779fc:0</RequestId>
      </ResponseMetadata>
    </CancelResponse>
    END
  end

  def cancel_token_response
    <<-END
    <CancelTokenResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <ResponseMetadata>
        <RequestId>a10e0ad6-148f-4afe-8bcd-e80a2680793d:0</RequestId>
      </ResponseMetadata>
    </CancelTokenResponse>
    END
  end
  
  def error_response
    <<-END
    <?xml version="1.0"?>
    <Response>
      <Errors>
        <Error>
          <Code>InvalidParams</Code>
          <Message>transactionId has to be a valid transaction ID. Specified value: FAKE</Message>
        </Error>
      </Errors>
      <RequestID>50ca0b2f-9435-4852-a889-89d144c07ff6</RequestID>
    </Response>
    END
  end

  def get_recipient_verification_status_response
    <<-END
      <GetRecipientVerificationResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
        <GetRecipientVerificationResult>
          <RecipientVerificationStatus>
          	VerificationComplete
          </RecipientVerificationStatus>
        </GetRecipientVerificationResult>
        <ResponseMetadata>
          <RequestId>197e2085-1ed7-47a2-93d8-d76b452acc74:0</RequestId>
        </ResponseMetadata>
      </GetRecipientVerificationResponse>
    END
  end

  def get_token_by_caller_response
    <<-END
    <GetTokenByCallerResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetTokenByCallerResult>
        <Token>
          <TokenId>
            543IJMECGZZ3J4K1F7BJ3TMNXFBQU9VXNT7RRCTNAJDJ8X36L1ZRKSUUPPIBTTIK
          </TokenId>
          <FriendlyName>Friendly1339359778</FriendlyName>
          <TokenStatus>Active</TokenStatus>
          <DateInstalled>2009-10-07T04:29:05.054-07:00</DateInstalled>
          <CallerReference>callerReferenceSingleUse10</CallerReference>
          <TokenType>SingleUse</TokenType>
          <OldTokenId>
            543IJMECGZZ3J4K1F7BJ3TMNXFBQU9VXNT7RRCTNAJDJ8X36L1ZRKSUUPPIBTTIK
          </OldTokenId>
          <PaymentReason>PaymentReason</PaymentReason>
        </Token>
      </GetTokenByCallerResult>
      <ResponseMetadata>
        <RequestId>45b6c560-8aa9-463c-84be-80eeefb21034:0</RequestId>
      </ResponseMetadata>
    </GetTokenByCallerResponse>
    END
  end

  def get_transaction_response
    <<-END
    <GetTransactionResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetTransactionResult>
        <Transaction>
          <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
          <CallerReference>CallerReference02</CallerReference>
          <CallerDescription>MyWish</CallerDescription>
          <DateReceived>2009-10-05T22:50:08.010-07:00</DateReceived>
          <DateCompleted>2009-10-05T22:50:09.086-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>1.000000</Value>
          </TransactionAmount>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.100000</Value>
          </FPSFees>
          <FPSFeesPaidBy>Recipient</FPSFeesPaidBy>
          <SenderTokenId>
            553ILMLCG6Z8J431H7BX3UMN3FFQU8VSNTSRNCTAASDJNX66LNZLKSZU3PI7TXIH
          </SenderTokenId>
          <FPSOperation>Pay</FPSOperation>
          <PaymentMethod>CC</PaymentMethod>
          <TransactionStatus>Success</TransactionStatus>
          <StatusCode>Success</StatusCode>
          <StatusMessage>
            The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <SenderName>Test Business</SenderName>
          <SenderEmail>new_premium@amazon.com</SenderEmail>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <RecipientEmail>test-caller@amazon.com</RecipientEmail>
          <StatusHistory>
            <Date>2009-10-05T22:50:08.092-07:00</Date>
            <TransactionStatus>Pending</TransactionStatus>
            <StatusCode>PendingNetworkResponse</StatusCode>
          </StatusHistory>
          <StatusHistory>
            <Date>2009-10-05T22:50:09.086-07:00</Date>
            <TransactionStatus>Success</TransactionStatus>
            <StatusCode>Success</StatusCode>
          </StatusHistory>
        </Transaction>
      </GetTransactionResult>
      <ResponseMetadata>
        <RequestId>0702960e-8221-4e04-9413-ca7d010d3b06:0</RequestId>
      </ResponseMetadata>
    </GetTransactionResponse>
    END
  end

  def get_transaction_status_response
    <<-END
    <GetTransactionStatusResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetTransactionStatusResult>
        <TransactionId>14GKE3B85HCMF1BTSH5C4PD2IHZL95RJ2LM</TransactionId>
        <TransactionStatus>Success</TransactionStatus>
        <CallerReference>CallerReference07</CallerReference>
        <StatusCode>Success</StatusCode>
        <StatusMessage>
          The transaction was successful and the payment instrument was charged.
        </StatusMessage>
      </GetTransactionStatusResult>
      <ResponseMetadata>
        <RequestId>13279842-6f84-41ef-ae36-c1ededaf278d:0</RequestId>
      </ResponseMetadata>
    </GetTransactionStatusResponse>
    END
  end

  def pay_response
    <<-END
    <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
       <PayResult>
          <TransactionId>14GK6BGKA7U6OU6SUTNLBI5SBBV9PGDJ6UL</TransactionId>
          <TransactionStatus>Pending</TransactionStatus>
       </PayResult>
       <ResponseMetadata>
          <RequestId>c21e7735-9c08-4cd8-99bf-535a848c79b4:0</RequestId>
       </ResponseMetadata>
    </PayResponse>
    END
  end

  def refund_response
    <<-END
    <RefundResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <RefundResult>
        <TransactionId>14GK6F2QU755ODS27SGHEURLKPG72Z54KMF</TransactionId>
        <TransactionStatus>Pending</TransactionStatus>
      </RefundResult>
      <ResponseMetadata>
        <RequestId>1a146b9a-b37b-4f5f-bda6-012a5b9e45c3:0</RequestId>
      </ResponseMetadata>
    </RefundResponse>
    END
  end

  def reserve_response
    <<-END
    <ReserveResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <ReserveResult>
        <TransactionId>14GKD9GE66FAA63E6O6B2JDPZKN53LZ7F22</TransactionId>
        <TransactionStatus>Pending</TransactionStatus>
      </ReserveResult>
      <ResponseMetadata>
        <RequestId>d13273fc-fca8-4963-8fbc-66d03e66055f:0</RequestId>
      </ResponseMetadata>
    </ReserveResponse>
    END
  end

  def settle_response
    <<-END
    <SettleResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <SettleResult>
        <TransactionId>14GKD9GE66FAA63E6O6B2JDPZKN53LZ7F22</TransactionId>
        <TransactionStatus>Pending</TransactionStatus>
      </SettleResult>
      <ResponseMetadata>
        <RequestId>9ed2008b-b230-4ed0-9210-095f77fc2359:0</RequestId>
      </ResponseMetadata>
    </SettleResponse>
    END
  end

  def verify_signature_response
    <<-END
    <VerifySignatureResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <VerifySignatureResult>
        <VerificationStatus>Success</VerificationStatus>
      </VerifySignatureResult>
      <ResponseMetadata>
        <RequestId>197e2085-1ed7-47a2-93d8-d76b452acc74:0</RequestId>
      </ResponseMetadata>
    </VerifySignatureResponse>
    END
  end

end
