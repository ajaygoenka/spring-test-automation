@api @loanspayoff
Feature:Justice League: Integration Tests for Personal Loans PayOff Lender - LC014

  @lc014happyflowfreeuser
  Scenario: Verify status code, Success status and loan attributes for post lock offers for LC014
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666089526   |
      | firstName | MICHAEL     |
      | lastName  | HURD        |
      | dob       | 1980-02-26  |
      | street    | PO BOX 5566 |
      | city      | RIVERSIDE   |
      | state     | CA          |
      | zip       | 92517       |
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders call to retrieve pre-qualified lender codes from globalconfig dynamo table
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes | Value                                                                             |
      | result     | ["lc039","lc014","lc036","lc024","lc023","lc022","lc033","lc032","lc020","lc008","lc029"] |
      | result     | contain-lc014                                                                     |
   # POST ssn call to validate last 4 digit of ssn given by the user before post lock offers (required for UI lock offers only)
    Given I create a new external experian personalloans service request to the /api/personalloans/customer/ssn endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/last4ssn.json replacing values:
      | lastFourOfSsn | 9526 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
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
      | lenders | LC014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
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
      | loanAmount                          | 10000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | 1                           |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | lc014                       |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc014lowloanamount
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given < 5K
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666089526   |
      | firstName | MICHAEL     |
      | lastName  | HURD        |
      | dob       | 1980-02-26  |
      | street    | PO BOX 5566 |
      | city      | RIVERSIDE   |
      | state     | CA          |
      | zip       | 92517       |
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Update user's Personal Loan Profile
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
    # Get Call to retrieve Customer Personal Loan Profile
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
    # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
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
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | 1                           |
      | offers[0].lenderCode     | lc014                       |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc014highloanamount
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given > 35K
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Update user's Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 50000        |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Personal Loan Profile
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
      | loanAmount            | 50000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | 36                          |
      | loanAmount                          | 50000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | 1                           |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc014annualincome<25K
  Scenario Outline: Verify Status code and Error Status for post lock offers when annual income given less than 25K
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
   # And make sure following attributes exist within response data with correct values
   # Update user's Personal Loan Profile
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
    # Get Call to retrieve Customer Personal Loan Profile
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
      | loanAmount            | 10000           |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
     # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | lc014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                        | Value                       |
      | results.lc014.lenderTransactionId | session_lenderTransactionId |
      | results.lc014.status              | ERROR                       |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value           |
      | loanPurpose           | CC_REFINANCE    |
      | loanTerm              | 36              |
      | loanAmount            | 10000           |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
      | loans                 |                 |
    Examples:
      | annual_income |
      | 0             |
      | 15000         |

  @lc014highannualincome
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given > 150k
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666089526   |
      | firstName | MICHAEL     |
      | lastName  | HURD        |
      | dob       | 1980-02-26  |
      | street    | PO BOX 5566 |
      | city      | RIVERSIDE   |
      | state     | CA          |
      | zip       | 92517       |
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Update user's Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 190000       |
      | loanAmount            | 10000        |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Personal Loan Profile
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
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 190000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | 36                          |
      | loanAmount                          | 10000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 190000                      |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | 1                           |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc014differentloanterm
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers for different loan term values passed
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # And make sure following attributes exist within response data with correct values
    # Update user's Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 10000        |
      | loanTerm              | <loan_term>  |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Personal Loan Profile
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
      | loanTerm              | <loan_term>  |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
     # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | lc014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | <loan_term>                 |
      | loanAmount                          | 10000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | notnull                     |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |
    Examples:
      | loan_term |
     # | 1         |
     # | 6         |
      | 9         |
      | 12        |
     # | 18        |
     # | 22        |
      | 24        |
     # | 25        |
     # | 26        |
    # | 36        |
     # | 48        |
      | 60        |
    #  | 72        |
      | 84        |
      | 144       |
     # | 180       |

  @lc014homeownershiptrueorfalse
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers when home ownership true/false passed
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Update user's Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000        |
      | loanAmount            | 10000        |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | <home_owner> |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Personal Loan Profile
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
      | homeOwner             | <home_owner> |
      | monthlyHousingPayment | 4000         |
     # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | lc014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | CC_REFINANCE                |
      | loanTerm                            | 36                          |
      | loanAmount                          | 10000                       |
      | employmentStatus                    | EMPLOYED                    |
      | annualIncome                        | 99000                       |
      | homeOwner                           | <home_owner>                |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | notnull                     |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |
    Examples:
      | home_owner |
      | true       |
      | false      |

  @lc014loanpurposeemploymentstatus
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers for different combination of loan purpose and employment status
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get Lenders to retrieve pre-qualified lender codes
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Update user's Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome          | 99000               |
      | loanAmount            | 10000               |
      | loanTerm              | 36                  |
      | loanPurpose           | <loan_purpose>      |
      | employmentStatus      | <employment_status> |
      | homeOwner             | true                |
      | monthlyHousingPayment | 4000                |
      | profileChanged        | false               |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call to retrieve Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value               |
      | firstName             | notnull             |
      | lastName              | notnull             |
      | yob                   | notnull             |
      | address1              | notnull             |
      | city                  | notnull             |
      | state                 | notnull             |
      | zip                   | notnull             |
      | email                 | notnull             |
      | phone                 | notnull             |
      | loanPurpose           | <loan_purpose>      |
      | loanTerm              | 36                  |
      | loanAmount            | 10000               |
      | employmentStatus      | <employment_status> |
      | annualIncome          | 99000               |
      | homeOwner             | true                |
      | monthlyHousingPayment | 4000                |
    # Verify response status code and post api offers for lock offers call
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | lc014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc014.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                            | Value                       |
      | results.lc014.status                  | SUCCESS                     |
      | results.lc014.lenderTransactionId     | session_lenderTransactionId |
      | results.lc014.loans[0].lenderCode     | lc014                       |
      | results.lc014.loans[0].index          | 1                           |
      | results.lc014.loans[0].amount         | notnull                     |
      | results.lc014.loans[0].interestRate   | notnull                     |
      | results.lc014.loans[0].term           | notnull                     |
      | results.lc014.loans[0].monthlyPayment | notnull                     |
      | results.lc014.loans[0].apr            | notnull                     |
      | results.lc014.loans[0].originationFee | notnull                     |
      | results.lc014.loans[0].offerUrl       | notnull                     |
      | results.lc014.loans[0].expirationDt   | notnull                     |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                          | Value                       |
      | loanPurpose                         | <loan_purpose>              |
      | loanTerm                            | 36                          |
      | loanAmount                          | 10000                       |
      | employmentStatus                    | <employment_status>         |
      | annualIncome                        | 99000                       |
      | homeOwner                           | true                        |
      | monthlyHousingPayment               | 4000                        |
      | loans.lc014.status                  | SUCCESS                     |
      | loans.lc014.lenderTransactionId     | session_lenderTransactionId |
      | loans.lc014.loans[0].lenderCode     | lc014                       |
      | loans.lc014.loans[0].index          | 1                           |
      | loans.lc014.loans[0].amount         | notnull                     |
      | loans.lc014.loans[0].interestRate   | notnull                     |
      | loans.lc014.loans[0].monthlyPayment | notnull                     |
      | loans.lc014.loans[0].term           | notnull                     |
      | loans.lc014.loans[0].apr            | notnull                     |
      | loans.lc014.loans[0].offerUrl       | notnull                     |
      | loans.lc014.loans[0].expirationDt   | notnull                     |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes               | Value                       |
      | lenderTransactionId      | session_lenderTransactionId |
      | ttl                      | notnull                     |
      | status                   | SUCCESS                     |
      | lenderCode               | lc014                       |
      | expirationDt             | notnull                     |
      | customerId               | session_customerId          |
      | offers[0].amount         | notnull                     |
      | offers[0].apr            | notnull                     |
      | offers[0].expirationDt   | notnull                     |
      | offers[0].index          | notnull                     |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | lc014                       |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |
    Examples:
      | employment_status | loan_purpose       |
      | STUDENT           | OTHER              |
   #   | STUDENT           | UNEXPECTED_COST    |
   #   | STUDENT           | CC_REFINANCE       |
      | EMPLOYED          | DEBT_CONSOLIDATION |
      | EMPLOYED          | HOME_IMPROVEMENT   |
      | EMPLOYED          | MAJOR_PURCHASE     |
   #   | EMPLOYED          | UNEXPECTED_COST    |
   #   | EMPLOYED          | OTHER              |
      | EMPLOYED          | CC_REFINANCE       |
      | NOT_EMPLOYED      | OTHER              |
   #   | NOT_EMPLOYED      | CC_REFINANCE       |
   #   | NOT_EMPLOYED      | UNEXPECTED_COST    |
      | RETIRED           | MAJOR_PURCHASE     |
   #   | RETIRED           | OTHER              |
   #   | RETIRED           | CC_REFINANCE       |
      | MILITARY          | HOME_IMPROVEMENT   |
   #   | MILITARY          | UNEXPECTED_COST    |
   #   | MILITARY          | CC_REFINANCE       |
      | SELF_EMPLOYED     | CC_REFINANCE       |
    #  | SELF_EMPLOYED     | MAJOR_PURCHASE     |
   #   | SELF_EMPLOYED     | DEBT_CONSOLIDATION |
    #  | SELF_EMPLOYED     | UNEXPECTED_COST    |
    #  | SELF_EMPLOYED     | OTHER              |
   #   | SELF_EMPLOYED     | HOME_IMPROVEMENT   |

