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

  def get_account_activity_response
    <<-END
    <GetAccountActivityResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetAccountActivityResult>
        <BatchSize>5</BatchSize>
        <Transaction>
          <TransactionId>14GN2BUHUAV4KG5S8USHN79PQH1NGN5ADK4</TransactionId>
          <CallerTransactionDate>
            2009-10-07T01:37:54.765-07:00
          </CallerTransactionDate>
          <DateReceived>2009-10-07T01:38:11.262-07:00</DateReceived>
          <DateCompleted>2009-10-07T01:38:12.857-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>1.000000</Value>
          </TransactionAmount>
          <FPSOperation>FundPrepaid</FPSOperation>
          <TransactionStatus>Success</TransactionStatus>
          <StatusMessage>
            The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <StatusCode>Success</StatusCode>
          <TransactionPart>
            <Role>Recipient</Role>
            <Name>Test Business</Name>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.100000</Value>
            </FeesPaid>
          </TransactionPart>
          <TransactionPart>
            <Role>Caller</Role>
            <Name>Test Business</Name>
            <Reference>CallerReference10</Reference>
            <Description>MyWish</Description>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <PaymentMethod>CC</PaymentMethod>
          <SenderName>Test Business</SenderName>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.100000</Value>
          </FPSFees>
          <Balance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>7.400000</Value>
          </Balance>
          <SenderTokenId>
     563INMLCG3ZJJ4L1I7BB31MN2FBQUCVXNTDRTCT5A2DJDXG6LNZ7KSNUJPI7TVIF
          </SenderTokenId>
        </Transaction>
        <Transaction>
          <TransactionId>14GN1O5992IEOB3ELM1SCUFTSOQ3C6S7NR2</TransactionId>
          <CallerTransactionDate>2009-10-07T01:27:21.469-07:00</CallerTransactionDate>
          <DateReceived>2009-10-07T01:27:22.793-07:00</DateReceived>
          <DateCompleted>2009-10-07T01:27:23.335-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>4.000000</Value>
          </TransactionAmount>
          <FPSOperation>Pay</FPSOperation>
          <TransactionStatus>Success</TransactionStatus>
          <StatusMessage>
          The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <StatusCode>Success</StatusCode>
          <TransactionPart>
            <Role>Recipient</Role>
            <Name>Test Business</Name>
            <Reference>Prepaid Digital Download - 1254904041469</Reference>
            <Description>Prepaid Digital Download</Description>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <TransactionPart>
            <Role>Caller</Role>
            <Name>Test Business</Name>
            <Reference>Prepaid Digital Download - 1254904034205</Reference>
            <Description>
              Prepaid Digital Download - payment for mp3 from digital.
            </Description>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <PaymentMethod>Prepaid</PaymentMethod>
          <SenderName>Test Business</SenderName>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0</Value>
          </FPSFees>
          <Balance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>6.500000</Value>
          </Balance>
          <SenderTokenId>
            513I1MGCG6ZZJ49157BZ3EMNJFAQU6V9NTSRUCTEANDJ3X46LGZNKSJUVPIXTPID
          </SenderTokenId>
          <RecipientTokenId>
            D639FT4TMP4QK9UBH6PAK2WAXGHDZSBUX3UJSGVX3LEFVGU7XDQXMENL4OGVZEGB
          </RecipientTokenId>
        </Transaction>
        <Transaction>
          <TransactionId>14GN1NHHN489BFGH6D8BMGT8NLSR2DJ4PNK</TransactionId>
          <CallerTransactionDate>
            2009-10-07T01:26:58.190-07:00
          </CallerTransactionDate>
          <DateReceived>2009-10-07T01:27:02.583-07:00</DateReceived>
          <DateCompleted>2009-10-07T01:27:04.435-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>5.000000</Value>
          </TransactionAmount>
          <FPSOperation>FundPrepaid</FPSOperation>
          <TransactionStatus>Success</TransactionStatus>
          <StatusMessage>
            The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <StatusCode>Success</StatusCode>
          <TransactionPart>
            <Role>Caller</Role>
            <Name>Test Business</Name>
            <Reference>Prepaid Digital Download - 1254903995419</Reference>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <TransactionPart>
            <Role>Recipient</Role>
            <Name>Test Business</Name>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.300000</Value>
            </FeesPaid>
          </TransactionPart>
          <PaymentMethod>CC</PaymentMethod>
          <SenderName>Test Business</SenderName>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.300000</Value>
          </FPSFees>
          <Balance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>6.500000</Value>
          </Balance>
          <SenderTokenId>
            513ISM2CGDZPJ4S1D7BH3HMNIFCQUAVNNTQRXCTHAUDJLXV6LMZLKSTUKPITTXIV
          </SenderTokenId>
        </Transaction>
        <Transaction>
          <TransactionId>14GMNT2PDVUJA18L44TO4DIFJEJRF9LTV2T</TransactionId>
          <CallerTransactionDate>
            2009-10-06T22:35:02.031-07:00
          </CallerTransactionDate>
          <DateReceived>2009-10-06T22:35:18.317-07:00</DateReceived>
          <DateCompleted>2009-10-06T22:35:19.332-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>1.000000</Value>
          </TransactionAmount>
          <FPSOperation>Refund</FPSOperation>
          <TransactionStatus>Success</TransactionStatus>
          <StatusMessage>
            The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <StatusCode>Success</StatusCode>
          <TransactionPart>
            <Role>Caller</Role>
            <Name>Test Business</Name>
            <Reference>CallerReference09</Reference>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <TransactionPart>
            <Role>Sender</Role>
            <Name>Test Business</Name>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>-0.100000</Value>
            </FeesPaid>
          </TransactionPart>
          <PaymentMethod>CC</PaymentMethod>
          <SenderName>Test Business</SenderName>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>-0.100000</Value>
          </FPSFees>
          <Balance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>1.800000</Value>
          </Balance>
        </Transaction>
        <Transaction>
          <TransactionId>14GMNRDSJ6TJTNDUTOUA917PIFJDSGNB2JP</TransactionId>
          <CallerTransactionDate>
            2009-10-06T22:34:24.053-07:00
          </CallerTransactionDate>
          <DateReceived>2009-10-06T22:34:24.147-07:00</DateReceived>
          <DateCompleted>2009-10-06T22:34:25.223-07:00</DateCompleted>
          <TransactionAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>1.000000</Value>
          </TransactionAmount>
          <FPSOperation>Pay</FPSOperation>
          <TransactionStatus>Success</TransactionStatus>
          <StatusMessage>
            The transaction was successful and the payment instrument was charged.
          </StatusMessage>
          <StatusCode>Success</StatusCode>
          <TransactionPart>
            <Role>Recipient</Role>
            <Name>Test Business</Name>
            <Description>SubscriptionTesting</Description>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.100000</Value>
            </FeesPaid>
          </TransactionPart>
          <TransactionPart>
            <Role>Caller</Role>
            <Name>Test Business</Name>
            <Reference>63314e32-d6b0-4abd-a0ab-7b89717ba5cb</Reference>
            <FeesPaid>
              <CurrencyCode>USD</CurrencyCode>
              <Value>0.000000</Value>
            </FeesPaid>
          </TransactionPart>
          <PaymentMethod>CC</PaymentMethod>
          <SenderName>Test Business</SenderName>
          <CallerName>Test Business</CallerName>
          <RecipientName>Test Business</RecipientName>
          <FPSFees>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.100000</Value>
          </FPSFees>
          <Balance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>2.700000</Value>
          </Balance>
          <SenderTokenId>
            533I1M9CGUZ9J4M197BM3LMNKFVQUFVFNT5RRCT2ACDJBXV6LRZ6KSRUSPI6T3I3
          </SenderTokenId>
          <RecipientTokenId>
            D139MTVTMK4CK9QB26PKKLWA1GHDZGBGX3SJLGVU37EFUGJ7XVQIMETLSOGAZJGV
          </RecipientTokenId>
        </Transaction>
      </GetAccountActivityResult>
      <ResponseMetadata>
        <RequestId>87e1570a-ef8c-4846-8265-74d07a6a83fb:0</RequestId>
      </ResponseMetadata>
    </GetAccountActivityResponse>
    END
  end

  def get_account_balance_response
    <<-END
    <GetAccountBalanceResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetAccountBalanceResult>
        <AccountBalance>
          <TotalBalance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>7.400000</Value>
          </TotalBalance>
          <PendingInBalance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.000000</Value>
          </PendingInBalance>
          <PendingOutBalance>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.000000</Value>
          </PendingOutBalance>
          <AvailableBalances>
            <DisburseBalance>
              <CurrencyCode>USD</CurrencyCode>
              <Value>7.400000</Value>
            </DisburseBalance>
            <RefundBalance>
              <CurrencyCode>USD</CurrencyCode>
              <Value>7.400000</Value>
            </RefundBalance>
          </AvailableBalances>
        </AccountBalance>
      </GetAccountBalanceResult>
      <ResponseMetadata>
        <RequestId>7b74a504-7517-4d81-8312-1427570d028c:0</RequestId>
      </ResponseMetadata>
    </GetAccountBalanceResponse>
    END
  end

  def get_recipient_verification_status_response
    <<-END
      <GetRecipientVerificationResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
        <GetRecipientVerificationResult>
          <RecipientVerificationStatus>
            PendingUserAction
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

  def get_token_usage_response
    <<-END
    <GetTokenUsageResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetTokenUsageResult>
        <TokenUsageLimits>
          <Amount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>10.000000</Value>
          </Amount>
          <LastResetAmount>
            <CurrencyCode>USD</CurrencyCode>
            <Value>0.000000</Value>
          </LastResetAmount>
          <LastResetTimestamp>
            2008-01-01T02:00:00.000-08:00
          </LastResetTimestamp>
        </TokenUsageLimits>
        <TokenUsageLimits>
          <Count>1</Count>
          <LastResetCount>0</LastResetCount>
          <LastResetTimestamp>
            2008-01-01T02:00:00.000-08:00
          </LastResetTimestamp>
        </TokenUsageLimits>
      </GetTokenUsageResult>
      <ResponseMetadata>
        <RequestId>9faeed71-9362-4eb8-9431-b99e92b441ee:0</RequestId>
      </ResponseMetadata>
    </GetTokenUsageResponse>
    END
  end

  def get_tokens_response
    <<-END
    <GetTokensResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
      <GetTokensResult>
        <Token>
          <TokenId>
          D439DTSTMP4FK9NBL6PEKZWAPGRDZ2BDX3MJNGVX37EF3GA7XRQHMEELQOGFZ9GK
          </TokenId>
          <TokenStatus>Active</TokenStatus>
          <DateInstalled>2009-10-07T04:37:57.375-07:00</DateInstalled>
          <CallerReference>CallerReference12</CallerReference>
          <TokenType>SingleUse</TokenType>
          <OldTokenId>
            D439DTSTMP4FK9NBL6PEKZWAPGRDZ2BDX3MJNGVX37EF3GA7XRQHMEELQOGFZ9GK
          </OldTokenId>
        </Token>
      </GetTokensResult>
      <ResponseMetadata>
        <RequestId>c9db3c80-ff03-4a32-b6b6-ee071cd118c8:0</RequestId>
      </ResponseMetadata>
    </GetTokensResponse>
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
