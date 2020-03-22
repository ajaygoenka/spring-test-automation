@loansopploans
Feature:Justice League: Integration Tests for Personal Loans Opploans Lender - LC033

  @lc033happyflow
  Scenario: Verify status code, Success status and loan attributes for post lock offers for LC033
    Given save the value of int_opploans_julia_sv as userName
    #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders call to retrieve pre-qualified lender codes from globalconfig dynamo table
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value                                                                             |
      | result     | ["lc039","lc014","lc024","lc023","lc022","lc033","lc032","lc020","lc008","lc029"] |
      | result     | contain-lc033                                                                     |
   # POST ssn call to validate last 4 digit of ssn given by the user before post lock offers (required for UI lock offers only)
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/ssn endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/last4ssn.json replacing values:
      | lastFourOfSsn | 3377 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
   # Update user's Loan Profile with loan funnel information
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 3000         |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Loan Profile and to verify the values passed in previous call is saved in loan profile table
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value        |
      | firstName             | notnull      |
      | lastName              | notnull      |
      | yob                   | notnull      |
      | address1              | notnull      |
      | city                  | notnull      |
      | state                 | notnull      |
      | zip                   | notnull      |
      | email                 | notnull      |
      | phone                 | notnull      |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 3000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and loan attribute values of post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC033-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc033.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc033.status                  | SUCCESS                     |
      | results.lc033.lenderTransactionId     | session_lenderTransactionId |
      | results.lc033.loans[0].lenderCode     | lc033                       |
      | results.lc033.loans[0].index          | 1                           |
      | results.lc033.loans[0].amount         | notnull                     |
      | results.lc033.loans[0].interestRate   | notnull                     |
      | results.lc033.loans[0].term           | notnull                     |
      | results.lc033.loans[0].monthlyPayment | notnull                     |
      | results.lc033.loans[0].apr            | notnull                     |
      | results.lc033.loans[0].originationFee | notnull                     |
      | results.lc033.loans[0].offerUrl       | notnull                     |
      | results.lc033.loans[0].expirationDt   | notnull                     |
    # Get Call to retrieve post api offers of all lenders along with customer loan profile from loan profile and lock offers tables and validate the values retrieved
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | 36                          |
      | loanAmount                          | 3000                        |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc033.status                  | SUCCESS                     |
      | loans.lc033.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc033.loans[0].lenderCode     | lc033                       |
      | loans.lc033.loans[0].index          | 1                           |
      | loans.lc033.loans[0].amount         | notnull                     |
      | loans.lc033.loans[0].interestRate   | notnull                     |
      | loans.lc033.loans[0].monthlyPayment | notnull                     |
      | loans.lc033.loans[0].term           | notnull                     |
      | loans.lc033.loans[0].apr            | notnull                     |
      | loans.lc033.loans[0].offerUrl       | notnull                     |
      | loans.lc033.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc033                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | 1                           |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | lc033                       |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
     # | xRefId                   | notnull                     |
      #| xRefType                 | notnull                     |
    #And I want to delete the entry from LoanOffers Table for session_lenderTransactionId

