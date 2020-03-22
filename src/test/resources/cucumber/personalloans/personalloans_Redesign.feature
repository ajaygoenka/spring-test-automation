@api @loansalllenders
Feature:Justice League: Integration Tests for Personal Loans Redesign

  @happyflowopploanslender
  Scenario: Verify response attributes and response code for one lender lc033
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666401535     |
      | firstName | JAMES         |
      | lastName  | MILLER        |
      | dob       | 1980-02-26    |
      | street    | 119 DAVIES ST |
      | city      | NEW CAMBRIA   |
      | state     | MO            |
      | zip       | 63558         |
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders call to retrieve pre-qualified lender codes from globalconfig dynamo table
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value                                                                                     |
      | result     | ["lc039","lc014","lc036","lc024","lc023","lc022","lc033","lc032","lc020","lc008","lc029"] |
      | result     | contain-lc033                                                                             |
   # POST ssn call to validate last 4 digit of ssn given by the user before post lock offers (required for UI lock offers only)
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/ssn endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/last4ssn.json replacing values:
      | lastFourOfSsn | 1535 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
     # Get Call to retrieve Customer Loan Profile with customer profile service info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value   |
      | firstName  | notnull |
      | lastName   | notnull |
      | yob        | notnull |
      | address1   | notnull |
      | city       | notnull |
      | state      | notnull |
      | zip        | notnull |
      | email      | notnull |
      | phone      | notnull |
    # Prequal call to retrieve matched offers, daas transaction id and  base vendor offer request id
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute vendorOfferTransactionId as daasTxId
    And I save the value of attribute baseRequestId as baseReqId
    And make sure following attributes exist within response data with correct values
      | Attributes               | Value   |
      | vendorOfferTransactionId | notnull |
      | baseRequestId            | notnull |
      | prequal                  | true    |
    # Prequal Internal call to retrieve eligible lender list, prequal attributes and restricted state details
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/filteredpersonalloans endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/json   |
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/custid.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | eligibleLenderSet     | notnull            |
      | restrictedLoanState   | false              |
      | restrictedCreditState | false              |
      | minPLMatTerm          | notnull            |
      | minPLMatPay           | notnull            |
      | age                   | notnull            |
      | militaryIndicator     | notnull            |
      | consumerStatus        | notnull            |
      | loginStatus           | notnull            |
      | transactionId         | notnull            |
      | vendorOfferRequestId  | session_baseReqId  |
      | customerState         | notnull            |
      | REH5020               | notnull            |
    # Prequal Internal call to retrieve min and max amount, term for lender
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/personalloans/{customerId} endpoint
    And I add the following headers to the request
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/minmaxlender.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value              |
      | customerId        | session_customerId |
      | daasTransactionId | session_daasTxId   |
      | lenderId          | notnull            |
      | maxTerm           | notnull            |
      | minAmount         | notnull            |
      | maxAmount         | notnull            |
      | revolvingDebt     | notnull            |
     # Get Call to retrieve lender list for Eligible, Ineligible and Decline Status
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes             | Value             |
      | lenders[0].status      | notnull           |
      | lenders[1].status      | notnull           |
      | lenders[2].status      | notnull           |
      | lenders[3].status      | notnull           |
      | lenders[4].status      | notnull           |
      | lenders[5].status      | notnull           |
      | lenders[6].status      | notnull           |
      | lenders[7].status      | notnull           |
      | lenders[8].status      | notnull           |
      | lenders[9].status      | notnull           |
      | lenders[10].status     | notnull           |
      | lenders[0].lenderCode  | lc039             |
      | lenders[1].lenderCode  | lc014             |
      | lenders[2].lenderCode  | lc036             |
      | lenders[3].lenderCode  | lc024             |
      | lenders[4].lenderCode  | lc023             |
      | lenders[5].lenderCode  | lc022             |
      | lenders[6].lenderCode  | lc033             |
      | lenders[7].lenderCode  | lc032             |
      | lenders[8].lenderCode  | lc020             |
      | lenders[9].lenderCode  | lc008             |
      | lenders[10].lenderCode | lc029             |
      | inRestrictedState      | false             |
      | vendorOfferRequestId   | session_baseReqId |
    # Update user's Loan Profile with loan funnel information
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 10000        |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values in CustomerLoanProfile Table
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | address1              | notnull            |
      | annualIncome          | notnull            |
      | city                  | notnull            |
      | annualIncome          | notnull            |
      | dob                   | notnull            |
      | email                 | notnull            |
      | employmentStatus      | notnull            |
      | firstName             | notnull            |
      | homeOwner             | notnull            |
      | lastName              | notnull            |
      | loanAmount            | notnull            |
      | loanPurpose           | notnull            |
      | loanTerm              | notnull            |
      | monthlyHousingPayment | notnull            |
      | phone                 | notnull            |
      | ssn                   | notnull            |
      | state                 | notnull            |
      | zip                   | notnull            |
   # Retrieve Customer Loan Profile to verify the values passed in previous call is saved along with other customer profile info
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
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and loan attribute values of post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders              | LC033--                        |
      | vendorOfferRequestId | pl-redesign-scenario-happyflow |
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
      | results.lc033.loans[0].totalCost      | notnull                     |
      | results.lc033.loans[0].monthlyPayment | notnull                     |
      | results.lc033.loans[0].apr            | notnull                     |
      | results.lc033.loans[0].originationFee | notnull                     |
      | results.lc033.loans[0].offerUrl       | notnull                     |
      | results.lc033.loans[0].expirationDt   | notnull                     |
    # Get Call to retrieve customer loan profile from loanprofile and locked offers from loanoffers table
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | firstName                           | notnull                     |
      | lastName                            | notnull                     |
      | yob                                 | notnull                     |
      | address1                            | notnull                     |
      | city                                | notnull                     |
      | state                               | notnull                     |
      | zip                                 | notnull                     |
      | email                               | notnull                     |
      | phone                               | notnull                     |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | 36                          |
      | loanAmount                          | 10000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc033.status                  | SUCCESS                     |
      | loans.lc033.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc033.vendorOfferRequestId    | notnull                     |
      | loans.lc033.loans[0].lenderCode     | lc033                       |
      | loans.lc033.loans[0].index          | 1                           |
      | loans.lc033.loans[0].amount         | notnull                     |
      | loans.lc033.loans[0].interestRate   | notnull                     |
      | loans.lc033.loans[0].monthlyPayment | notnull                     |
      | loans.lc033.loans[0].term           | notnull                     |
      | loans.lc033.loans[0].apr            | notnull                     |
      | loans.lc033.loans[0].offerUrl       | notnull                     |
      | loans.lc033.loans[0].originationFee | notnull                     |
      | loans.lc033.loans[0].lenderOfferId  | notnull                     |
      | loans.lc033.loans[0].expirationDt   | notnull                     |
      | loans.lc033.loans[0].totalCost      | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                          |
      | lenderTransactionId      | session_lenderTransactionId    |
      | daasTransactionId        | session_daasTxId               |
      | ttl                      | notnull                        |
      | status                   | SUCCESS                        |
      | lenderCode               | lc033                          |
      | expirationDt             | notnull                        |
      | customerId               | session_customerId             |
      | offers[0].amount         | notnull                        |
      | offers[0].apr            | notnull                        |
      | offers[0].expirationDt   | notnull                        |
      | offers[0].index          | 1                              |
      | offers[0].interestRate   | notnull                        |
      | offers[0].lenderCode     | lc033                          |
      | offers[0].lenderOfferId  | notnull                        |
      | offers[0].monthlyPayment | notnull                        |
      | offers[0].offerUrl       | notnull                        |
      | offers[0].originationFee | notnull                        |
      | offers[0].term           | notnull                        |
      | offers[0].totalCost      | notnull                        |
      | transactionId            | notnull                        |
      | xRefId                   | pl-redesign-scenario-happyflow |
      | xRefType                 | DaaS                           |
    # Call to boe to rank the loan offers received from lenders
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                                               | Value                          |
      | firstName                                                | notnull                        |
      | lastName                                                 | notnull                        |
      | yob                                                      | notnull                        |
      | address1                                                 | notnull                        |
      | city                                                     | notnull                        |
      | state                                                    | notnull                        |
      | zip                                                      | notnull                        |
      | email                                                    | notnull                        |
      | phone                                                    | notnull                        |
      | loanPurpose                                              | CC_REFINANCE                   |
      | loanTerm                                                 | 36                             |
      | loanAmount                                               | 10000                          |
      | employmentStatus                                         | EMPLOYED                       |
      | annualIncome                                             | 99000                          |
      | homeOwner                                                | true                           |
      | monthlyHousingPayment                                    | 4000                           |
      | plFlag                                                   | notnull                        |
      | offers[0].lenderCode                                     | lc033                          |
      | offers[0].rank                                           | notnull                        |
      | offers[0].index                                          | notnull                        |
      | offers[0].amount                                         | notnull                        |
      | offers[0].interestRate                                   | notnull                        |
      | offers[0].term                                           | notnull                        |
      | offers[0].monthlyPayment                                 | notnull                        |
      | offers[0].apr                                            | notnull                        |
      | offers[0].originationFee                                 | notnull                        |
      | offers[0].lenderOfferId                                  | notnull                        |
      | offers[0].totalCost                                      | notnull                        |
      | offers[0].vendorOfferRequestId                           | pl-redesign-scenario-happyflow |
      | offers[0].lenderTransactionId                            | session_lenderTransactionId    |
      | offers[0].offerUrl                                       | notnull                        |
      | offers[0].expirationDt                                   | notnull                        |
      | offers[0].displayFlag                                    | notnull                        |
      | offers[0].offerAttributes.is_active                      | notnull                        |
      | offers[0].offerAttributes.vendor_name                    | notnull                        |
      | offers[0].offerAttributes.offer_name                     | notnull                        |
      | offers[0].offerAttributes.offer_engine_offer_id          | notnull                        |
      | offers[0].offerAttributes.vendor_offer_link              | notnull                        |
      | offers[0].offerAttributes.vendor_offer_links.default     | notnull                        |
      | offers[0].offerAttributes.offer_class                    | notnull                        |
      | offers[0].offerAttributes.offer_type                     | pd                             |
      | offers[0].offerAttributes.revision_id                    | notnull                        |
      | offers[0].offerAttributes.offer_engine_name              | personal_lender                |
      | offers[0].offerAttributes.image_paths.untitled_1         | notnull                        |
      | offers[0].offerAttributes.attributes.Loan                | notnull                        |
      | offers[0].offerAttributes.values.Display                 | notnull                        |
      | offers[0].offerAttributes.values.Loan.ReferenceOfferCode | notnull                        |

  @loanamountoutsideminandmaxrange
  Scenario Outline: Verify response attributes and response code when loan amount passed out of min and max range for each lender lc024, lc014
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666401535     |
      | firstName | JAMES         |
      | lastName  | MILLER        |
      | dob       | 1980-02-26    |
      | street    | 119 DAVIES ST |
      | city      | NEW CAMBRIA   |
      | state     | MO            |
      | zip       | 63558         |
    And I create a new secure token with existing Customer ID and member scope
     # Get Call to retrieve Customer Loan Profile with customer profile info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value   |
      | firstName  | notnull |
      | lastName   | notnull |
      | yob        | notnull |
      | address1   | notnull |
      | city       | notnull |
      | state      | notnull |
      | zip        | notnull |
      | email      | notnull |
      | phone      | notnull |
    # Prequal call to retrieve matched offers, daas transaction id and  base vendor offer request id
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute vendorOfferTransactionId as daasTxId
    And I save the value of attribute baseRequestId as baseReqId
    And make sure following attributes exist within response data with correct values
      | Attributes               | Value   |
      | vendorOfferTransactionId | notnull |
      | baseRequestId            | notnull |
      | prequal                  | true    |
    # Prequal Internal call to retrieve eligible lender list, prequal attributes and restricted state details
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/filteredpersonalloans endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/json   |
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/custid.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | eligibleLenderSet     | notnull            |
      | restrictedLoanState   | false              |
      | restrictedCreditState | false              |
      | minPLMatTerm          | notnull            |
      | minPLMatPay           | notnull            |
      | age                   | notnull            |
      | militaryIndicator     | notnull            |
      | consumerStatus        | notnull            |
      | loginStatus           | notnull            |
      | transactionId         | notnull            |
      | vendorOfferRequestId  | session_baseReqId  |
      | customerState         | notnull            |
      | REH5020               | notnull            |
    # Prequal Internal call to retrieve min and max amount, term for lender
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/personalloans/{customerId} endpoint
    And I add the following headers to the request
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/minmaxlender.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value              |
      | customerId        | session_customerId |
      | daasTransactionId | session_daasTxId   |
      | lenderId          | notnull            |
      | maxTerm           | notnull            |
      | minAmount         | notnull            |
      | maxAmount         | notnull            |
      | revolvingDebt     | notnull            |
     # Get Call to retrieve lender list for Eligible, Ineligible and Decline Status
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes             | Value             |
      | lenders[0].status      | notnull           |
      | lenders[1].status      | notnull           |
      | lenders[2].status      | notnull           |
      | lenders[3].status      | notnull           |
      | lenders[4].status      | notnull           |
      | lenders[5].status      | notnull           |
      | lenders[6].status      | notnull           |
      | lenders[7].status      | notnull           |
      | lenders[8].status      | notnull           |
      | lenders[9].status      | notnull           |
      | lenders[10].status     | notnull           |
      | lenders[0].lenderCode  | lc039             |
      | lenders[1].lenderCode  | lc014             |
      | lenders[2].lenderCode  | lc036             |
      | lenders[3].lenderCode  | lc024             |
      | lenders[4].lenderCode  | lc023             |
      | lenders[5].lenderCode  | lc022             |
      | lenders[6].lenderCode  | lc033             |
      | lenders[7].lenderCode  | lc032             |
      | lenders[8].lenderCode  | lc020             |
      | lenders[9].lenderCode  | lc008             |
      | lenders[10].lenderCode | lc029             |
      | inRestrictedState      | false             |
      | vendorOfferRequestId   | session_baseReqId |
    # Update user's Loan Profile with different loan amount passed in
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000         |
      | loanAmount            | <loan_amount> |
      | loanTerm              | 36            |
      | loanPurpose           | CC_REFINANCE  |
      | employmentStatus      | EMPLOYED      |
      | homeOwner             | true          |
      | monthlyHousingPayment | 4000          |
      | profileChanged        | false         |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values in CustomerLoanProfile Table
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | address1              | notnull            |
      | annualIncome          | notnull            |
      | city                  | notnull            |
      | annualIncome          | notnull            |
      | dob                   | notnull            |
      | email                 | notnull            |
      | employmentStatus      | notnull            |
      | firstName             | notnull            |
      | homeOwner             | notnull            |
      | lastName              | notnull            |
      | loanAmount            | <loan_amount>      |
      | loanPurpose           | notnull            |
      | loanTerm              | notnull            |
      | monthlyHousingPayment | notnull            |
      | phone                 | notnull            |
      | ssn                   | notnull            |
      | state                 | notnull            |
      | zip                   | notnull            |
   # Retrieve Customer Loan Profile to verify the values passed in previous call is saved along with other customer profile info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value         |
      | firstName             | notnull       |
      | lastName              | notnull       |
      | yob                   | notnull       |
      | address1              | notnull       |
      | city                  | notnull       |
      | state                 | notnull       |
      | zip                   | notnull       |
      | email                 | notnull       |
      | phone                 | notnull       |
      | loanPurpose           | CC_REFINANCE  |
      | loanTerm              | 36            |
      | loanAmount            | <loan_amount> |
      | employmentStatus      | EMPLOYED      |
      | annualIncome          | 99000         |
      | homeOwner             | true          |
      | monthlyHousingPayment | 4000          |
    # Verify response status code and loan attribute values of post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders              | <lenders>--                         |
      | vendorOfferRequestId | pl-redesign-scenario-diffloanamount |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.<lenders>.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                                | Value                       |
      | results.<lenders>.status                  | SUCCESS                     |
      | results.<lenders>.lenderTransactionId     | session_lenderTransactionId |
      | results.<lenders>.loans[0].lenderCode     | <lenders>                   |
      | results.<lenders>.loans[0].index          | 1                           |
      | results.<lenders>.loans[0].amount         | notnull                     |
      | results.<lenders>.loans[0].interestRate   | notnull                     |
      | results.<lenders>.loans[0].term           | notnull                     |
      | results.<lenders>.loans[0].totalCost      | notnull                     |
      | results.<lenders>.loans[0].monthlyPayment | notnull                     |
      | results.<lenders>.loans[0].apr            | notnull                     |
      | results.<lenders>.loans[0].originationFee | notnull                     |
      | results.<lenders>.loans[0].offerUrl       | notnull                     |
      | results.<lenders>.loans[0].expirationDt   | notnull                     |
    # Get Call to retrieve customer loan profile from loanprofile and locked offers from loanoffers table
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                              | Value                       |
      | firstName                               | notnull                     |
      | lastName                                | notnull                     |
      | yob                                     | notnull                     |
      | address1                                | notnull                     |
      | city                                    | notnull                     |
      | state                                   | notnull                     |
      | zip                                     | notnull                     |
      | email                                   | notnull                     |
      | phone                                   | notnull                     |
      | loanPurpose                             | CC_REFINANCE                |
      | loanTerm                                | 36                          |
      | loanAmount                              | <loan_amount>               |
      | employmentStatus                        | EMPLOYED                    |
      | annualIncome                            | 99000                       |
      | homeOwner                               | true                        |
      | monthlyHousingPayment                   | 4000                        |
      | loans.<lenders>.status                  | SUCCESS                     |
      | loans.<lenders>.lenderTransactionId     | session_lenderTransactionId |
      | loans.<lenders>.vendorOfferRequestId    | notnull                     |
      | loans.<lenders>.loans[0].lenderCode     | <lenders>                   |
      | loans.<lenders>.loans[0].index          | 1                           |
      | loans.<lenders>.loans[0].amount         | notnull                     |
      | loans.<lenders>.loans[0].interestRate   | notnull                     |
      | loans.<lenders>.loans[0].monthlyPayment | notnull                     |
      | loans.<lenders>.loans[0].term           | notnull                     |
      | loans.<lenders>.loans[0].apr            | notnull                     |
      | loans.<lenders>.loans[0].offerUrl       | notnull                     |
      | loans.<lenders>.loans[0].originationFee | notnull                     |
      | loans.<lenders>.loans[0].lenderOfferId  | notnull                     |
      | loans.<lenders>.loans[0].expirationDt   | notnull                     |
      | loans.<lenders>.loans[0].totalCost      | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                               |
      | lenderTransactionId      | session_lenderTransactionId         |
      | daasTransactionId        | session_daasTxId                    |
      | ttl                      | notnull                             |
      | status                   | SUCCESS                             |
      | lenderCode               | <lenders>                           |
      | expirationDt             | notnull                             |
      | customerId               | session_customerId                  |
      | offers[0].amount         | notnull                             |
      | offers[0].apr            | notnull                             |
      | offers[0].expirationDt   | notnull                             |
      | offers[0].index          | 1                                   |
      | offers[0].interestRate   | notnull                             |
      | offers[0].lenderCode     | <lenders>                           |
      | offers[0].lenderOfferId  | notnull                             |
      | offers[0].monthlyPayment | notnull                             |
      | offers[0].offerUrl       | notnull                             |
      | offers[0].originationFee | notnull                             |
      | offers[0].term           | notnull                             |
      | offers[0].totalCost      | notnull                             |
      | transactionId            | notnull                             |
      | xRefId                   | pl-redesign-scenario-diffloanamount |
      | xRefType                 | DaaS                                |
    # Call to boe to rank the loan offers received from lenders
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                                               | Value                               |
      | firstName                                                | notnull                             |
      | lastName                                                 | notnull                             |
      | yob                                                      | notnull                             |
      | address1                                                 | notnull                             |
      | city                                                     | notnull                             |
      | state                                                    | notnull                             |
      | zip                                                      | notnull                             |
      | email                                                    | notnull                             |
      | phone                                                    | notnull                             |
      | loanPurpose                                              | CC_REFINANCE                        |
      | loanTerm                                                 | 36                                  |
      | loanAmount                                               | <loan_amount>                       |
      | employmentStatus                                         | EMPLOYED                            |
      | annualIncome                                             | 99000                               |
      | homeOwner                                                | true                                |
      | monthlyHousingPayment                                    | 4000                                |
      | plFlag                                                   | notnull                             |
      | offers[0].lenderCode                                     | notnull                             |
      | offers[0].rank                                           | notnull                             |
      | offers[0].index                                          | notnull                             |
      | offers[0].amount                                         | notnull                             |
      | offers[0].interestRate                                   | notnull                             |
      | offers[0].term                                           | notnull                             |
      | offers[0].monthlyPayment                                 | notnull                             |
      | offers[0].apr                                            | notnull                             |
      | offers[0].originationFee                                 | notnull                             |
      | offers[0].lenderOfferId                                  | notnull                             |
      | offers[0].totalCost                                      | notnull                             |
      | offers[0].vendorOfferRequestId                           | pl-redesign-scenario-diffloanamount |
      | offers[0].lenderTransactionId                            | notnull                             |
      | offers[0].offerUrl                                       | notnull                             |
      | offers[0].expirationDt                                   | notnull                             |
      | offers[0].displayFlag                                    | notnull                             |
      | offers[0].offerAttributes.is_active                      | notnull                             |
      | offers[0].offerAttributes.vendor_name                    | notnull                             |
      | offers[0].offerAttributes.offer_name                     | notnull                             |
      | offers[0].offerAttributes.offer_engine_offer_id          | notnull                             |
      | offers[0].offerAttributes.vendor_offer_link              | notnull                             |
      | offers[0].offerAttributes.vendor_offer_links.default     | notnull                             |
      | offers[0].offerAttributes.offer_class                    | notnull                             |
      | offers[0].offerAttributes.offer_type                     | pd                                  |
      | offers[0].offerAttributes.revision_id                    | notnull                             |
      | offers[0].offerAttributes.offer_engine_name              | personal_lender                     |
      | offers[0].offerAttributes.image_paths.untitled_1         | notnull                             |
      | offers[0].offerAttributes.attributes.Loan                | notnull                             |
      | offers[0].offerAttributes.values.Display                 | notnull                             |
      | offers[0].offerAttributes.values.Loan.ReferenceOfferCode | notnull                             |
    Examples:
      | loan_amount | lenders |
      | 500         | lc014   |
    #  | 90000       | lc014 |
    #  | 500         | lc024 |
    #  | 90000       | lc024   |

  @annualincome<minrange
  Scenario Outline: Verify response attributes and response code when annual income less than lender range passed in request payload
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666401535     |
      | firstName | JAMES         |
      | lastName  | MILLER        |
      | dob       | 1980-02-26    |
      | street    | 119 DAVIES ST |
      | city      | NEW CAMBRIA   |
      | state     | MO            |
      | zip       | 63558         |
    And I create a new secure token with existing Customer ID and member scope
     # Get Call to retrieve Customer Loan Profile with customer profile info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value   |
      | firstName  | notnull |
      | lastName   | notnull |
      | yob        | notnull |
      | address1   | notnull |
      | city       | notnull |
      | state      | notnull |
      | zip        | notnull |
      | email      | notnull |
      | phone      | notnull |
     # Get Call to retrieve lender list for Eligible, Ineligible and Decline Status
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes             | Value   |
      | lenders[0].status      | notnull |
      | lenders[1].status      | notnull |
      | lenders[2].status      | notnull |
      | lenders[3].status      | notnull |
      | lenders[4].status      | notnull |
      | lenders[5].status      | notnull |
      | lenders[6].status      | notnull |
      | lenders[7].status      | notnull |
      | lenders[8].status      | notnull |
      | lenders[9].status      | notnull |
      | lenders[10].status     | notnull |
      | lenders[0].lenderCode  | lc039   |
      | lenders[1].lenderCode  | lc014   |
      | lenders[2].lenderCode  | lc036   |
      | lenders[3].lenderCode  | lc024   |
      | lenders[4].lenderCode  | lc023   |
      | lenders[5].lenderCode  | lc022   |
      | lenders[6].lenderCode  | lc033   |
      | lenders[7].lenderCode  | lc032   |
      | lenders[8].lenderCode  | lc020   |
      | lenders[9].lenderCode  | lc008   |
      | lenders[10].lenderCode | lc029   |
      | inRestrictedState      | false   |
      | vendorOfferRequestId   | notnull |
    # Update user's Loan Profile with different loan amount passed in
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | <annual_income> |
      | loanAmount            | 10000           |
      | loanTerm              | 36              |
      | loanPurpose           | CC_REFINANCE    |
      | employmentStatus      | EMPLOYED        |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
      | profileChanged        | false           |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values in CustomerLoanProfile Table
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | address1              | notnull            |
      | annualIncome          | notnull            |
      | city                  | notnull            |
      | annualIncome          | notnull            |
      | dob                   | notnull            |
      | email                 | notnull            |
      | employmentStatus      | notnull            |
      | firstName             | notnull            |
      | homeOwner             | notnull            |
      | lastName              | notnull            |
      | loanAmount            | 10000              |
      | loanPurpose           | notnull            |
      | loanTerm              | notnull            |
      | monthlyHousingPayment | notnull            |
      | phone                 | notnull            |
      | ssn                   | notnull            |
      | state                 | notnull            |
      | zip                   | notnull            |
   # Retrieve Customer Loan Profile to verify the values passed in previous call is saved along with other customer profile info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value           |
      | firstName             | notnull         |
      | lastName              | notnull         |
      | yob                   | notnull         |
      | address1              | notnull         |
      | city                  | notnull         |
      | state                 | notnull         |
      | zip                   | notnull         |
      | email                 | notnull         |
      | phone                 | notnull         |
      | loanPurpose           | CC_REFINANCE    |
      | loanTerm              | 36              |
      | loanAmount            | notnull         |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
    # Verify response status code and loan attribute values of post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders              | <lenders>--                       |
      | vendorOfferRequestId | pl-redesign-scenario-minannualinc |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.<lenders>.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.<lenders>.status              | ERROR                       |
      | results.<lenders>.lenderTransactionId | session_lenderTransactionId |
    # Get Call to retrieve customer loan profile from loanprofile and locked offers from loanoffers table
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value           |
      | firstName             | notnull         |
      | lastName              | notnull         |
      | yob                   | notnull         |
      | address1              | notnull         |
      | city                  | notnull         |
      | state                 | notnull         |
      | zip                   | notnull         |
      | email                 | notnull         |
      | phone                 | notnull         |
      | loanPurpose           | CC_REFINANCE    |
      | loanTerm              | 36              |
      | loanAmount            | notnull         |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
    Examples:
      | annual_income | lenders |
      | 15000         | lc014   |
      | 15000         | lc008   |
      | 15000         | lc033   |
      | 1             | lc020   |
      | 5000          | lc029   |
      | 5000          | lc022   |
      | 5000          | lc023   |
      | 5000          | lc039   |
      | 0             | lc024   |

  @happyflowalllender @ignore

  Scenario: Verify response attributes and response code for all integrated lenders
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666401535     |
      | firstName | JAMES         |
      | lastName  | MILLER        |
      | dob       | 1980-02-26    |
      | street    | 119 DAVIES ST |
      | city      | NEW CAMBRIA   |
      | state     | MO            |
      | zip       | 63558         |
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders call to retrieve pre-qualified lender codes from globalconfig dynamo table
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value                                                                                     |
      | result     | ["lc039","lc014","lc036","lc024","lc023","lc022","lc033","lc032","lc020","lc008","lc029"] |
      | result     | contain-lc033                                                                             |
   # POST ssn call to validate last 4 digit of ssn given by the user before post lock offers (required for UI lock offers only)
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/ssn endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/last4ssn.json replacing values:
      | lastFourOfSsn | 1535 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
     # Get Call to retrieve Customer Loan Profile with customer profile service info
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value   |
      | firstName  | notnull |
      | lastName   | notnull |
      | yob        | notnull |
      | address1   | notnull |
      | city       | notnull |
      | state      | notnull |
      | zip        | notnull |
      | email      | notnull |
      | phone      | notnull |
    # Prequal call to retrieve matched offers, daas transaction id and  base vendor offer request id
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute vendorOfferTransactionId as daasTxId
    And I save the value of attribute baseRequestId as baseReqId
    And make sure following attributes exist within response data with correct values
      | Attributes               | Value   |
      | vendorOfferTransactionId | notnull |
      | baseRequestId            | notnull |
      | prequal                  | true    |
    # Prequal Internal call to retrieve eligible lender list, prequal attributes and restricted state details
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/filteredpersonalloans endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/json   |
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/custid.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | eligibleLenderSet     | notnull            |
      | restrictedLoanState   | false              |
      | restrictedCreditState | false              |
      | minPLMatTerm          | notnull            |
      | minPLMatPay           | notnull            |
      | age                   | notnull            |
      | militaryIndicator     | notnull            |
      | consumerStatus        | notnull            |
      | loginStatus           | notnull            |
      | transactionId         | notnull            |
      | vendorOfferRequestId  | session_baseReqId  |
      | customerState         | notnull            |
      | REH5020               | notnull            |
    # Prequal Internal call to retrieve min and max amount, term for lender
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/personalloans/{customerId} endpoint
    And I add the following headers to the request
      | x-customerId | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/personalloans/minmaxlender.json replacing values:
      | customerId | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value              |
      | customerId        | session_customerId |
      | daasTransactionId | session_daasTxId   |
      | lenderId          | notnull            |
      | maxTerm           | notnull            |
      | minAmount         | notnull            |
      | maxAmount         | notnull            |
      | revolvingDebt     | notnull            |
     # Get Call to retrieve lender list for Eligible, Ineligible and Decline Status
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes             | Value             |
      | lenders[0].status      | notnull           |
      | lenders[1].status      | notnull           |
      | lenders[2].status      | notnull           |
      | lenders[3].status      | notnull           |
      | lenders[4].status      | notnull           |
      | lenders[5].status      | notnull           |
      | lenders[6].status      | notnull           |
      | lenders[7].status      | notnull           |
      | lenders[8].status      | notnull           |
      | lenders[9].status      | notnull           |
      | lenders[10].status     | notnull           |
      | lenders[0].lenderCode  | lc039             |
      | lenders[1].lenderCode  | lc014             |
      | lenders[2].lenderCode  | lc036             |
      | lenders[3].lenderCode  | lc024             |
      | lenders[4].lenderCode  | lc023             |
      | lenders[5].lenderCode  | lc022             |
      | lenders[6].lenderCode  | lc033             |
      | lenders[7].lenderCode  | lc032             |
      | lenders[8].lenderCode  | lc020             |
      | lenders[9].lenderCode  | lc008             |
      | lenders[10].lenderCode | lc029             |
      | inRestrictedState      | false             |
      | vendorOfferRequestId   | session_baseReqId |
    # Update user's Loan Profile with loan funnel information
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 10000        |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values in CustomerLoanProfile Table
      | Attributes            | Value              |
      | customerId            | session_customerId |
      | address1              | notnull            |
      | annualIncome          | notnull            |
      | city                  | notnull            |
      | annualIncome          | notnull            |
      | dob                   | notnull            |
      | email                 | notnull            |
      | employmentStatus      | notnull            |
      | firstName             | notnull            |
      | homeOwner             | notnull            |
      | lastName              | notnull            |
      | loanAmount            | notnull            |
      | loanPurpose           | notnull            |
      | loanTerm              | notnull            |
      | monthlyHousingPayment | notnull            |
      | phone                 | notnull            |
      | ssn                   | notnull            |
      | state                 | notnull            |
      | zip                   | notnull            |
   # Retrieve Customer Loan Profile to verify the values passed in previous call is saved along with other customer profile info
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
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and loan attribute values of post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders              | lc039--lc014--lc036--lc024--lc023--lc022--lc033--lc032--lc020--lc029 |
      | vendorOfferRequestId | pl-redesign-scenario-happyflowalllenders                             |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc039.lenderTransactionId as lc039lenderTransactionId
    And I save the value of attribute results.lc014.lenderTransactionId as lc014lenderTransactionId
    And I save the value of attribute results.lc024.lenderTransactionId as lc024lenderTransactionId
    And I save the value of attribute results.lc023.lenderTransactionId as lc023lenderTransactionId
    And I save the value of attribute results.lc033.lenderTransactionId as lc033lenderTransactionId
    And I save the value of attribute results.lc022.lenderTransactionId as lc022lenderTransactionId
    And I save the value of attribute results.lc032.lenderTransactionId as lc032lenderTransactionId
    And I save the value of attribute results.lc020.lenderTransactionId as lc020lenderTransactionId
   # And I save the value of attribute results.lc008.lenderTransactionId as lc008lenderTransactionId
    And I save the value of attribute results.lc029.lenderTransactionId as lc029lenderTransactionId
    And I save the value of attribute results.lc036.lenderTransactionId as lc036lenderTransactionId
   # And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                            |
      | results.lc033.status                  | SUCCESS                          |
      | results.lc033.lenderTransactionId     | session_lc033lenderTransactionId |
      | results.lc033.loans[0].lenderCode     | lc033                            |
      | results.lc033.loans[0].index          | 1                                |
      | results.lc033.loans[0].amount         | notnull                          |
      | results.lc033.loans[0].interestRate   | notnull                          |
      | results.lc033.loans[0].term           | notnull                          |
      | results.lc033.loans[0].totalCost      | notnull                          |
      | results.lc033.loans[0].monthlyPayment | notnull                          |
      | results.lc033.loans[0].apr            | notnull                          |
      | results.lc033.loans[0].originationFee | notnull                          |
      | results.lc033.loans[0].offerUrl       | notnull                          |
      | results.lc033.loans[0].expirationDt   | notnull                          |
      | results.lc033.loans[0].lenderOfferId  | notnull                          |
      | results.lc039.status                  | SUCCESS                          |
      | results.lc039.lenderTransactionId     | session_lc039lenderTransactionId |
      | results.lc039.loans[0].lenderCode     | lc039                            |
      | results.lc039.loans[0].index          | 1                                |
      | results.lc039.loans[0].amount         | notnull                          |
      | results.lc039.loans[0].interestRate   | notnull                          |
      | results.lc039.loans[0].term           | notnull                          |
      | results.lc039.loans[0].totalCost      | notnull                          |
      | results.lc039.loans[0].monthlyPayment | notnull                          |
      | results.lc039.loans[0].apr            | notnull                          |
      | results.lc039.loans[0].originationFee | notnull                          |
      | results.lc039.loans[0].offerUrl       | notnull                          |
      | results.lc039.loans[0].expirationDt   | notnull                          |
      | results.lc039.loans[0].lenderOfferId  | notnull                          |
      | results.lc014.status                  | SUCCESS                          |
      | results.lc014.lenderTransactionId     | session_lc014lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                            |
      | results.lc014.loans[0].index          | 1                                |
      | results.lc014.loans[0].amount         | notnull                          |
      | results.lc014.loans[0].interestRate   | notnull                          |
      | results.lc014.loans[0].term           | notnull                          |
      | results.lc014.loans[0].totalCost      | notnull                          |
      | results.lc014.loans[0].monthlyPayment | notnull                          |
      | results.lc014.loans[0].apr            | notnull                          |
      | results.lc014.loans[0].originationFee | notnull                          |
      | results.lc014.loans[0].offerUrl       | notnull                          |
      | results.lc014.loans[0].expirationDt   | notnull                          |
      | results.lc014.loans[0].lenderOfferId  | notnull                          |
      | results.lc024.status                  | SUCCESS                          |
      | results.lc024.lenderTransactionId     | session_lc024lenderTransactionId |
      | results.lc024.loans[0].lenderCode     | lc024                            |
      | results.lc024.loans[0].index          | 1                                |
      | results.lc024.loans[0].amount         | notnull                          |
      | results.lc024.loans[0].interestRate   | notnull                          |
      | results.lc024.loans[0].term           | notnull                          |
      | results.lc024.loans[0].totalCost      | notnull                          |
      | results.lc024.loans[0].monthlyPayment | notnull                          |
      | results.lc024.loans[0].apr            | notnull                          |
      | results.lc024.loans[0].originationFee | notnull                          |
      | results.lc024.loans[0].offerUrl       | notnull                          |
      | results.lc024.loans[0].expirationDt   | notnull                          |
      | results.lc024.loans[0].lenderOfferId  | notnull                          |
      | results.lc022.status                  | SUCCESS                          |
      | results.lc022.lenderTransactionId     | session_lc022lenderTransactionId |
      | results.lc022.loans[0].lenderCode     | lc022                            |
      | results.lc022.loans[0].index          | 1                                |
      | results.lc022.loans[0].amount         | notnull                          |
      | results.lc022.loans[0].interestRate   | notnull                          |
      | results.lc022.loans[0].term           | notnull                          |
      | results.lc022.loans[0].totalCost      | notnull                          |
      | results.lc022.loans[0].monthlyPayment | notnull                          |
      | results.lc022.loans[0].apr            | notnull                          |
      | results.lc022.loans[0].originationFee | notnull                          |
      | results.lc022.loans[0].offerUrl       | notnull                          |
      | results.lc022.loans[0].expirationDt   | notnull                          |
      | results.lc022.loans[0].lenderOfferId  | notnull                          |
      | results.lc020.status                  | SUCCESS                          |
      | results.lc020.lenderTransactionId     | session_lc020lenderTransactionId |
      | results.lc020.loans[0].lenderCode     | lc020                            |
      | results.lc020.loans[0].index          | 1                                |
      | results.lc020.loans[0].amount         | notnull                          |
      | results.lc020.loans[0].interestRate   | notnull                          |
      | results.lc020.loans[0].term           | notnull                          |
      | results.lc020.loans[0].totalCost      | notnull                          |
      | results.lc020.loans[0].monthlyPayment | notnull                          |
      | results.lc020.loans[0].apr            | notnull                          |
      | results.lc020.loans[0].originationFee | notnull                          |
      | results.lc020.loans[0].offerUrl       | notnull                          |
      | results.lc020.loans[0].expirationDt   | notnull                          |
      | results.lc020.loans[0].lenderOfferId  | notnull                          |
      | results.lc023.status                  | ERROR                            |
      | results.lc023.lenderTransactionId     | session_lc023lenderTransactionId |
      | results.lc032.status                  | DECLINED                         |
      | results.lc032.lenderTransactionId     | session_lc032lenderTransactionId |
     # | results.lc008.status                  | DECLINED                                 |
     # | results.lc008.lenderTransactionId     | session_lc008lenderTransactionId         |
      | results.lc029.status                  | ERROR                            |
      | results.lc029.lenderTransactionId     | session_lc029lenderTransactionId |
        # Get Call to retrieve customer loan profile from loanprofile and locked offers from loanoffers table
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                            |
      | firstName                           | notnull                          |
      | lastName                            | notnull                          |
      | yob                                 | notnull                          |
      | address1                            | notnull                          |
      | city                                | notnull                          |
      | state                               | notnull                          |
      | zip                                 | notnull                          |
      | email                               | notnull                          |
      | phone                               | notnull                          |
      | loanPurpose                         | CC_REFINANCE                     |
      | loanTerm                            | 36                               |
      | loanAmount                          | 10000                            |
      | employmentStatus                    | EMPLOYED                         |
      | annualIncome                        | 99000                            |
      | homeOwner                           | true                             |
      | monthlyHousingPayment               | 4000                             |
      | loans.lc033.status                  | SUCCESS                          |
      | loans.lc033.lenderTransactionId     | session_lc033lenderTransactionId |
      | loans.lc033.vendorOfferRequestId    | notnull                          |
      | loans.lc033.loans[0].lenderCode     | lc033                            |
      | loans.lc033.loans[0].index          | 1                                |
      | loans.lc033.loans[0].amount         | notnull                          |
      | loans.lc033.loans[0].interestRate   | notnull                          |
      | loans.lc033.loans[0].monthlyPayment | notnull                          |
      | loans.lc033.loans[0].term           | notnull                          |
      | loans.lc033.loans[0].apr            | notnull                          |
      | loans.lc033.loans[0].offerUrl       | notnull                          |
      | loans.lc033.loans[0].originationFee | notnull                          |
      | loans.lc033.loans[0].lenderOfferId  | notnull                          |
      | loans.lc033.loans[0].expirationDt   | notnull                          |
      | loans.lc033.loans[0].totalCost      | notnull                          |
      | loans.lc039.status                  | SUCCESS                          |
      | loans.lc039.lenderTransactionId     | session_lc039lenderTransactionId |
      | loans.lc039.vendorOfferRequestId    | notnull                          |
      | loans.lc039.loans[0].lenderCode     | lc039                            |
      | loans.lc039.loans[0].index          | 1                                |
      | loans.lc039.loans[0].amount         | notnull                          |
      | loans.lc039.loans[0].interestRate   | notnull                          |
      | loans.lc039.loans[0].monthlyPayment | notnull                          |
      | loans.lc039.loans[0].term           | notnull                          |
      | loans.lc039.loans[0].apr            | notnull                          |
      | loans.lc039.loans[0].offerUrl       | notnull                          |
      | loans.lc039.loans[0].originationFee | notnull                          |
      | loans.lc039.loans[0].lenderOfferId  | notnull                          |
      | loans.lc039.loans[0].expirationDt   | notnull                          |
      | loans.lc039.loans[0].totalCost      | notnull                          |
      | loans.lc014.status                  | SUCCESS                          |
      | loans.lc014.lenderTransactionId     | session_lc014lenderTransactionId |
      | loans.lc014.vendorOfferRequestId    | notnull                          |
      | loans.lc014.loans[0].lenderCode     | lc014                            |
      | loans.lc014.loans[0].index          | 1                                |
      | loans.lc014.loans[0].amount         | notnull                          |
      | loans.lc014.loans[0].interestRate   | notnull                          |
      | loans.lc014.loans[0].monthlyPayment | notnull                          |
      | loans.lc014.loans[0].term           | notnull                          |
      | loans.lc014.loans[0].apr            | notnull                          |
      | loans.lc014.loans[0].offerUrl       | notnull                          |
      | loans.lc014.loans[0].originationFee | notnull                          |
      | loans.lc014.loans[0].lenderOfferId  | notnull                          |
      | loans.lc014.loans[0].expirationDt   | notnull                          |
      | loans.lc014.loans[0].totalCost      | notnull                          |
      | loans.lc024.status                  | SUCCESS                          |
      | loans.lc024.lenderTransactionId     | session_lc024lenderTransactionId |
      | loans.lc024.vendorOfferRequestId    | notnull                          |
      | loans.lc024.loans[0].lenderCode     | lc024                            |
      | loans.lc024.loans[0].index          | 1                                |
      | loans.lc024.loans[0].amount         | notnull                          |
      | loans.lc024.loans[0].interestRate   | notnull                          |
      | loans.lc024.loans[0].monthlyPayment | notnull                          |
      | loans.lc024.loans[0].term           | notnull                          |
      | loans.lc024.loans[0].apr            | notnull                          |
      | loans.lc024.loans[0].offerUrl       | notnull                          |
      | loans.lc024.loans[0].originationFee | notnull                          |
      | loans.lc024.loans[0].lenderOfferId  | notnull                          |
      | loans.lc024.loans[0].expirationDt   | notnull                          |
      | loans.lc024.loans[0].totalCost      | notnull                          |
      | loans.lc022.status                  | SUCCESS                          |
      | loans.lc022.lenderTransactionId     | session_lc022lenderTransactionId |
      | loans.lc022.vendorOfferRequestId    | notnull                          |
      | loans.lc022.loans[0].lenderCode     | lc022                            |
      | loans.lc022.loans[0].index          | 1                                |
      | loans.lc022.loans[0].amount         | notnull                          |
      | loans.lc022.loans[0].interestRate   | notnull                          |
      | loans.lc022.loans[0].monthlyPayment | notnull                          |
      | loans.lc022.loans[0].term           | notnull                          |
      | loans.lc022.loans[0].apr            | notnull                          |
      | loans.lc022.loans[0].offerUrl       | notnull                          |
      | loans.lc022.loans[0].originationFee | notnull                          |
      | loans.lc022.loans[0].lenderOfferId  | notnull                          |
      | loans.lc022.loans[0].expirationDt   | notnull                          |
      | loans.lc022.loans[0].totalCost      | notnull                          |
      | loans.lc032.status                  | DECLINED                         |
      | loans.lc032.lenderTransactionId     | session_lc032lenderTransactionId |
      | loans.lc032.vendorOfferRequestId    | notnull                          |
      | loans.lc036.status                  | DECLINED                         |
      | loans.lc036.lenderTransactionId     | session_lc036lenderTransactionId |
      | loans.lc036.vendorOfferRequestId    | notnull                          |
      | loans.lc020.status                  | SUCCESS                          |
      | loans.lc020.lenderTransactionId     | session_lc020lenderTransactionId |
      | loans.lc020.vendorOfferRequestId    | notnull                          |
      | loans.lc020.loans[0].lenderCode     | lc020                            |
      | loans.lc020.loans[0].index          | 1                                |
      | loans.lc020.loans[0].amount         | notnull                          |
      | loans.lc020.loans[0].interestRate   | notnull                          |
      | loans.lc020.loans[0].monthlyPayment | notnull                          |
      | loans.lc020.loans[0].term           | notnull                          |
      | loans.lc020.loans[0].apr            | notnull                          |
      | loans.lc020.loans[0].offerUrl       | notnull                          |
      | loans.lc020.loans[0].originationFee | notnull                          |
      | loans.lc020.loans[0].lenderOfferId  | notnull                          |
      | loans.lc020.loans[0].expirationDt   | notnull                          |
      | loans.lc020.loans[0].totalCost      | notnull                          |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                                    |
      | lenderTransactionId      | session_lc022lenderTransactionId         |
      | ttl                      | notnull                                  |
      | status                   | SUCCESS                                  |
      | lenderCode               | lc033                                    |
      | expirationDt             | notnull                                  |
      | customerId               | session_customerId                       |
      | offers[0].amount         | notnull                                  |
      | offers[0].apr            | notnull                                  |
      | offers[0].expirationDt   | notnull                                  |
      | offers[0].index          | 1                                        |
      | offers[0].interestRate   | notnull                                  |
      | offers[0].lenderCode     | lc033                                    |
      | offers[0].lenderOfferId  | notnull                                  |
      | offers[0].monthlyPayment | notnull                                  |
      | offers[0].offerUrl       | notnull                                  |
      | offers[0].originationFee | notnull                                  |
      | offers[0].term           | notnull                                  |
      | offers[0].totalCost      | notnull                                  |
      | transactionId            | notnull                                  |
      | xRefId                   | pl-redesign-scenario-happyflowalllenders |
      | xRefType                 | DaaS                                     |
    # Call to boe to rank the loan offers received from lenders
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                                               | Value                                    |
      | firstName                                                | notnull                                  |
      | lastName                                                 | notnull                                  |
      | yob                                                      | notnull                                  |
      | address1                                                 | notnull                                  |
      | city                                                     | notnull                                  |
      | state                                                    | notnull                                  |
      | zip                                                      | notnull                                  |
      | email                                                    | notnull                                  |
      | phone                                                    | notnull                                  |
      | loanPurpose                                              | CC_REFINANCE                             |
      | loanTerm                                                 | 36                                       |
      | loanAmount                                               | 10000                                    |
      | employmentStatus                                         | EMPLOYED                                 |
      | annualIncome                                             | 99000                                    |
      | homeOwner                                                | true                                     |
      | monthlyHousingPayment                                    | 4000                                     |
      | plFlag                                                   | notnull                                  |
      | offers[0].lenderCode                                     | lc033                                    |
      | offers[0].rank                                           | notnull                                  |
      | offers[0].index                                          | notnull                                  |
      | offers[0].amount                                         | notnull                                  |
      | offers[0].interestRate                                   | notnull                                  |
      | offers[0].term                                           | notnull                                  |
      | offers[0].monthlyPayment                                 | notnull                                  |
      | offers[0].apr                                            | notnull                                  |
      | offers[0].originationFee                                 | notnull                                  |
      | offers[0].lenderOfferId                                  | notnull                                  |
      | offers[0].totalCost                                      | notnull                                  |
      | offers[0].vendorOfferRequestId                           | pl-redesign-scenario-happyflowalllenders |
      | offers[0].lenderTransactionId                            | session_lenderTransactionId              |
      | offers[0].offerUrl                                       | notnull                                  |
      | offers[0].expirationDt                                   | notnull                                  |
      | offers[0].displayFlag                                    | notnull                                  |
      | offers[0].offerAttributes.is_active                      | notnull                                  |
      | offers[0].offerAttributes.vendor_name                    | notnull                                  |
      | offers[0].offerAttributes.offer_name                     | notnull                                  |
      | offers[0].offerAttributes.offer_engine_offer_id          | notnull                                  |
      | offers[0].offerAttributes.vendor_offer_link              | notnull                                  |
      | offers[0].offerAttributes.vendor_offer_links.default     | notnull                                  |
      | offers[0].offerAttributes.offer_class                    | notnull                                  |
      | offers[0].offerAttributes.offer_type                     | pd                                       |
      | offers[0].offerAttributes.revision_id                    | notnull                                  |
      | offers[0].offerAttributes.offer_engine_name              | personal_lender                          |
      | offers[0].offerAttributes.image_paths.untitled_1         | notnull                                  |
      | offers[0].offerAttributes.attributes.Loan                | notnull                                  |
      | offers[0].offerAttributes.values.Display                 | notnull                                  |
      | offers[0].offerAttributes.values.Loan.ReferenceOfferCode | notnull                                  |
    # Call to retrieve oauth2 token to access boe private route
    Given I create a new shared service oauth2 token
    And I create a new private experian boe service request to the /boe/rank/personalloans endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/boe/lockedoffers_ranking.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value   |
      | plFlag                              | notnull |
      | personalLoanOffers[0].lenderOfferId | notnull |
      | personalLoanOffers[0].displayFlag   | notnull |
      | personalLoanOffers[0].displayRank   | notnull |

