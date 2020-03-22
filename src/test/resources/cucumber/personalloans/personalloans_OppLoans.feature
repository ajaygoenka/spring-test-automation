@api @loansopploans
Feature:Justice League: Integration Tests for Personal Loans Opploans Lender - LC033

  @lc033happyflowfreeuser
  Scenario: Verify status code, Success status and loan attributes for post lock offers for LC033
    # Create a new free user with below given profile
   # Given I create a new free customer with this 0000126284C5K referenceId and at_frsas102 offer tags
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc033lowloanamount
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given < 1K
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | loanAmount            | 500          |
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
      | loanAmount            | 500          |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
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
      | loanAmount                          | 500                         |
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
      | offers[0].lenderCode     | lc033                       |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc033highloanamount
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given > 4K
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
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
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc033lowannualincome
  Scenario Outline: Verify Status code and Error Status for post lock offers when annual income given less than 18K
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | loanAmount            | 3000            |
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
      | loanAmount            | 3000            |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
     # Verify response status code and post api offers for lock offers call
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
      | Attributes                        | Value                       |
      | results.lc033.lenderTransactionId | session_lenderTransactionId |
      | results.lc033.status              | ERROR                       |
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
      | loanAmount            | 3000            |
      | employmentStatus      | EMPLOYED        |
      | annualIncome          | <annual_income> |
      | homeOwner             | true            |
      | monthlyHousingPayment | 4000            |
      | loans                 |                 |
    Examples:
      | annual_income |
      | 0             |
      | 15000         |

  @lc033highannualincome
  Scenario: Verify Status code, Success Status and loan attribute values for post lock offers when Loan Amount given > 150k
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | offers[0].lenderCode     | notnull                     |
      | offers[0].monthlyPayment | notnull                     |
      | offers[0].offerUrl       | notnull                     |
      | offers[0].originationFee | notnull                     |
      | offers[0].term           | notnull                     |
      | transactionId            | notnull                     |
      | xRefId                   | notnull                     |
      | xRefType                 | notnull                     |

  @lc033declinedstatus
  Scenario: Verify Status code and Declined Status for post lock offers when annual income given 19K
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | annualIncome          | 19000        |
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
      | annualIncome          | 19000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
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
      | Attributes                        | Value                       |
      | results.lc033.lenderTransactionId | session_lenderTransactionId |
      | results.lc033.status              | DECLINED                    |
      | results.lc033.loans               |                             |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                      | Value                       |
      | loanPurpose                     | CC_REFINANCE                |
      | loanTerm                        | 36                          |
      | loanAmount                      | 3000                        |
      | employmentStatus                | EMPLOYED                    |
      | annualIncome                    | 19000                       |
      | homeOwner                       | true                        |
      | monthlyHousingPayment           | 4000                        |
      | loans.lc033.status              | DECLINED                    |
      | loans.lc033.lenderTransactionId | session_lenderTransactionId |
      | loans.lc033.loans               |                             |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes          | Value                       |
      | lenderTransactionId | session_lenderTransactionId |
      | ttl                 | notnull                     |
      | status              | DECLINED                    |
      | lenderCode          | lc033                       |
      | expirationDt        | notnull                     |
      | customerId          | session_customerId          |
      | reason              | notnull                     |
      | transactionId       | notnull                     |
      | xRefId              | notnull                     |
      | xRefType            | notnull                     |
      | offers              |                             |
      | reason              | contain-601                 |

  @lc033declinedincomenotprovided
  Scenario: Verify Declined Status code 332 for post lock offers when annual income not provided
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | loanAmount            | 3000         |
      | loanTerm              | 36           |
      | loanPurpose           | CC_REFINANCE |
      | employmentStatus      | EMPLOYED     |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      | profileChanged        | false        |
      | annualIncome          | 0            |
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
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
    # Verify response status code and post api offers for lock offers call
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
      | Attributes                        | Value                       |
      | results.lc033.lenderTransactionId | session_lenderTransactionId |
      | results.lc033.status              | DECLINED                    |
      | results.lc033.loans               |                             |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                      | Value                       |
      | loanPurpose                     | CC_REFINANCE                |
      | loanTerm                        | 36                          |
      | loanAmount                      | 3000                        |
      | employmentStatus                | EMPLOYED                    |
      | annualIncome                    | null                        |
      | homeOwner                       | true                        |
      | monthlyHousingPayment           | 4000                        |
      | loans.lc033.status              | DECLINED                    |
      | loans.lc033.lenderTransactionId | session_lenderTransactionId |
      | loans.lc033.loans               |                             |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes          | Value                       |
      | lenderTransactionId | session_lenderTransactionId |
      | ttl                 | notnull                     |
      | status              | DECLINED                    |
      | lenderCode          | lc033                       |
      | expirationDt        | notnull                     |
      | customerId          | session_customerId          |
      | reason              | notnull                     |
      | transactionId       | notnull                     |
      | xRefId              | notnull                     |
      | xRefType            | notnull                     |
      | offers              |                             |
    And make sure following attributes exist within response data with correct values
      | Attributes | Value       |
      | reason     | contain-332 |

  @lc033declinedrestrictedstatecode
  Scenario: Verify Declined status code 402 for post lock offers when is from non eligible state
    Given I create a new paid customer using at_eiwpt102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1982-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | Costa Mesa          |
      | state     | CA                  |
      | zip       | 92626               |
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
      | lenders | LC033-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc033.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                        | Value                       |
      | results.lc033.lenderTransactionId | session_lenderTransactionId |
      | results.lc033.status              | DECLINED                    |
      | results.lc033.loans               |                             |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                      | Value                       |
      | loanPurpose                     | CC_REFINANCE                |
      | loanTerm                        | 36                          |
      | loanAmount                      | 3000                        |
      | employmentStatus                | EMPLOYED                    |
      | annualIncome                    | 99000                       |
      | homeOwner                       | true                        |
      | monthlyHousingPayment           | 4000                        |
      | loans.lc033.status              | DECLINED                    |
      | loans.lc033.lenderTransactionId | session_lenderTransactionId |
      | loans.lc033.loans               |                             |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes          | Value                       |
      | lenderTransactionId | session_lenderTransactionId |
      | ttl                 | notnull                     |
      | status              | DECLINED                    |
      | lenderCode          | lc033                       |
      | expirationDt        | notnull                     |
      | customerId          | session_customerId          |
      | reason              | notnull                     |
      | transactionId       | notnull                     |
      | xRefId              | notnull                     |
      | xRefType            | notnull                     |
      | offers              |                             |
    And make sure following attributes exist within response data with correct values
      | Attributes | Value       |
      | reason     | contain-402 |

  @lc033declinedstreetaddressmissing
  Scenario: Verify Declined status code 342 for post lock offers when street address not sent/missing
    Given save the value of gerardo.sauer_sv_auto as userName
    #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report
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
      | lenders | LC033-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute results.lc033.lenderTransactionId as lenderTransactionId
    And I embed the Scenario Session value of type lenderTransactionId in report
    And make sure following attributes exist within response data with correct values
      | Attributes                        | Value                       |
      | results.lc033.lenderTransactionId | session_lenderTransactionId |
      | results.lc033.status              | SUCCESS                     |
      | results.lc033.loans               |                             |
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes                      | Value                       |
      | loanPurpose                     | CC_REFINANCE                |
      | loanTerm                        | 36                          |
      | loanAmount                      | 3000                        |
      | employmentStatus                | EMPLOYED                    |
      | annualIncome                    | 99000                       |
      | homeOwner                       | true                        |
      | monthlyHousingPayment           | 4000                        |
      | loans.lc033.status              | SUCCESS                     |
      | loans.lc033.lenderTransactionId | session_lenderTransactionId |
      | loans.lc033.loans               |                             |
    And make sure following attributes exist within response data with correct values in LoanOffers Table
      | Attributes          | Value                       |
      | lenderTransactionId | session_lenderTransactionId |
      | ttl                 | notnull                     |
      | status              | SUCCESS                     |
      | lenderCode          | lc033                       |
      | expirationDt        | notnull                     |
      | customerId          | session_customerId          |
      | transactionId       | notnull                     |
      | xRefId              | notnull                     |
      | xRefType            | notnull                     |
      | offers              | notnull                     |
    And make sure following attributes exist within response data with correct values
      | Attributes | Value       |
      | reason     | contain-342 |

  @lc033differentloanterm
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers for different loan term values passed
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | loanAmount            | 3000         |
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
    #  | 36        |
     # | 48        |
     # | 60        |
    #  | 72        |
      | 84        |
      | 144       |
     # | 180       |

  @lc033homeownershiptrueorfalse
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers when home ownership true/false passed
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | loanAmount            | 3000         |
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
      | loanAmount            | 3000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | <home_owner> |
      | monthlyHousingPayment | 4000         |
     # Verify response status code and post api offers for lock offers call
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
      | homeOwner                           | <home_owner>                |
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

  @lc033loanpurposeemploymentstatus
  Scenario Outline: Verify status code, Success status and loan attribute values for post lock offers for different combination of loan purpose and employment status
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666403377           |
      | firstName | JULIA               |
      | lastName  | NOVOTNY             |
      | dob       | 1980-02-26          |
      | street    | 976 N MARTINWOOD DR |
      | city      | BIRMINGHAM          |
      | state     | AL                  |
      | zip       | 35235               |
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
      | annualIncome          | 99000               |
      | loanAmount            | 3000                |
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
      | loanAmount            | 3000                |
      | employmentStatus      | <employment_status> |
      | annualIncome          | 99000               |
      | homeOwner             | true                |
      | monthlyHousingPayment | 4000                |
    # Verify response status code and post api offers for lock offers call
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
      | loanAmount                          | 3000                        |
      | employmentStatus                    | <employment_status>         |
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
      | offers[0].index          | notnull                     |
      | offers[0].interestRate   | notnull                     |
      | offers[0].lenderCode     | lc033                       |
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
   #   | SELF_EMPLOYED     | CC_REFINANCE       |
    #  | SELF_EMPLOYED     | MAJOR_PURCHASE     |
   #   | SELF_EMPLOYED     | DEBT_CONSOLIDATION |
    #  | SELF_EMPLOYED     | UNEXPECTED_COST    |
    #  | SELF_EMPLOYED     | OTHER              |
   #   | SELF_EMPLOYED     | HOME_IMPROVEMENT   |

