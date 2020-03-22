@api @loans
Feature:Justice League: Integration Tests for Personal Loans

  @lc023avant
  Scenario: Verify status code and post lock loan offers for Avant lender - LC023
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                                                                     |
      | result    | ["lc039","lc014","lc036","lc024","lc023","lc022","lc033","lc032","lc020","lc008","lc029"] |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC023-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc023.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc014payoff
  Scenario: Verify status code and post lock loan offers for Payoff lender - LC014
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc014.lenderTransactionId |       |
        # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc033opploans
  Scenario: Verify status code and post lock loan offers for Payoff lender - LC033
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC033-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc033.lenderTransactionId |       |
        # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc024lendingclub
  Scenario: Verify status code and post lock loan offers for Lending Club lender - LC024
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC024-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc024.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc032axos
  Scenario: Verify status code and post lock loan offers for BOFI/AXOS lender - LC032
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes            | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 99000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC032-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc032.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc020onemainfinancial
  Scenario: Verify status code and post lock loan offers for OneMainFinancial - LC020
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
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
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 10000        |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | notnull      |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | lc020-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc020.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


  @loanamountforalllenders
  Scenario: Verify status code and post lock loan offers for all lenders given loan amount 8K in request payload
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC023--LC032--LC014--LC029--LC008 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc023.lenderTransactionId |       |
      | results.lc032.lenderTransactionId |       |
      | results.lc014.lenderTransactionId |       |
      | results.lc029.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc029bestegg
  Scenario: Verify status code and post lock loan offers for BestEgg/Marlette lender - LC029
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC029-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc029.lenderTransactionId |       |

  @lc022suntrustlightstream
  Scenario: Verify status code and post lock loan offers for BestEgg/Marlette lender - LC029
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC022-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc022.lenderTransactionId |       |

  Scenario: Verify post lock loan offers for Axos-Payoff-LendingClub lenders
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014--LC032--LC023--LC024 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc014.lenderTransactionId |       |
      | results.lc032.lenderTransactionId |       |
      | results.lc023.lenderTransactionId |       |
      | results.lc024.lenderTransactionId |       |


  Scenario: Verify post lock loan offers for all lenders when annual income passed less than 25K in request payload
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 20000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 20000        |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC014--LC032--LC023--LC024 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc014.lenderTransactionId |       |
      | results.lc032.lenderTransactionId |       |
      | results.lc023.lenderTransactionId |       |
      | results.lc024.lenderTransactionId |       |

  @diffloanpurposeemploymentstatus
  Scenario Outline: Verify post lock loan offers for all lenders passing multiple combinations of employment status and loan purpose  in request to lender
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | employmentStatus | <Employment_Status> |
      | loanPurpose      | <loan_Purpose>      |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value               |
      | loanPurpose           | <loan_Purpose>      |
      | loanTerm              | 36                  |
      | loanAmount            | 8000                |
      | employmentStatus      | <Employment_Status> |
      | annualIncome          | 100000              |
      | homeOwner             | true                |
      | monthlyHousingPayment | 4000                |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | <lender> |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    Examples:
      | Employment_Status | loan_Purpose       | lender                     |
    #  | STUDENT           | HOME_IMPROVEMENT   | LC014--LC032--LC023--LC024 |
      | RETIRED           | MAJOR_PURCHASE     | LC014--LC032--LC023--LC024 |
      | MILITARY          | UNEXPECTED_COST    | LC014--LC032--LC023--LC024 |
      | NOT_EMPLOYED      | OTHER              | LC014--LC032--LC023--LC024 |
      | EMPLOYED          | DEBT_CONSOLIDATION | LC039--                    |
      | EMPLOYED          | HOME_IMPROVEMENT   | LC039--                    |
      | EMPLOYED          | MAJOR_PURCHASE     | LC039--                    |
      | EMPLOYED          | UNEXPECTED_COST    | LC039--                    |
      | EMPLOYED          | OTHER              | LC039--                    |
   #   | NOT_EMPLOYED      | CC_REFINANCE       | LC039--                    |
      | EMPLOYED          | CC_REFINANCE       | LC039--                    |
      | STUDENT           | CC_REFINANCE       | LC039--                    |
   #   | RETIRED           | CC_REFINANCE       | LC039--                    |
  #    | MILITARY          | CC_REFINANCE       | LC039--                    |
  #    | SELF_EMPLOYED     | CC_REFINANCE       | LC039--                    |
  #    | EMPLOYED          | DEBT_CONSOLIDATION | LC023--                    |
      | NOT_EMPLOYED      | UNEXPECTED_COST    | LC023--                    |
      | RETIRED           | OTHER              | LC023--                    |
      | STUDENT           | CC_REFINANCE       | LC023--                    |
      | MILITARY          | HOME_IMPROVEMENT   | LC023--                    |
      | SELF_EMPLOYED     | MAJOR_PURCHASE     | LC023--                    |
      | SELF_EMPLOYED     | MAJOR_PURCHASE     | LC029--                    |
   #   | EMPLOYED          | CC_REFINANCE       | LC029--                    |

  @loanamountlessorhigh
  Scenario Outline: Verify status code and post lock loan offers for all lenders when loan amount given less than or greater than lender range specified in Bento
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | loanAmount | <loan_amount> |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value         |
      | loanPurpose           | CC_REFINANCE  |
      | loanTerm              | 36            |
      | loanAmount            | <loan_amount> |
      | employmentStatus      | EMPLOYED      |
      | annualIncome          | 100000        |
      | homeOwner             | true          |
      | monthlyHousingPayment | 4000          |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | <lenders> |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    Examples:
      | loan_amount | lenders |
      | 500         | LC014-- |
      | 90000       | LC014-- |
      | 500         | LC024-- |
      | 90000       | LC024-- |
      | 500         | LC029-- |
      | 90000       | LC029-- |
      | 1000        | LC023-- |
      | 40000       | LC023-- |
      | 500         | LC039-- |
      | 90000       | LC039-- |

  @loanterm144lc039upgrade
  Scenario: Verify status code and post lock loan offers for all lenders with Loan Term 144 passed in request payload
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | loanTerm | 144 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 144          |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 100000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC039-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc039.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @ignore
  Scenario: Verify Success, Error and Declined mock responses for all lenders
      # Post Call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
    And I add the following json content to the param of the request
      | grant_type | password                 |
      | scope      | member                   |
      | client_id  | experian                 |
      | username   | int_mihcael_upgrade_sv_5 |
      | password   | Password1                |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC022-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc022.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @lc008lendingpoint
  Scenario: Verify status code and post lock loan offers for LendinghPoint lender - LC0008
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # Get call for personal loans lender
    Given I create a new external experian personalloans service request to the /api/personalloans/lenders endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Put Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/customerloanprofileupdate.json replacing values:
      | annualIncome | 110000 |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value        |
      | loanPurpose           | CC_REFINANCE |
      | loanTerm              | 36           |
      | loanAmount            | 8000         |
      | employmentStatus      | EMPLOYED     |
      | annualIncome          | 110000       |
      | homeOwner             | true         |
      | monthlyHousingPayment | 4000         |
      # Get Call for prequal
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     # Post Call for lock
    Given I create a new external experian personalloans service request to the /api/personalloans/loanoffers/lock endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/personalloans/lockoffer.json replacing values:
      | lenders | LC008-- |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value |
      | results.lc008.lenderTransactionId |       |
      # Get Call for Customer Personal Loan Profile
    Given I create a new external experian personalloans service request to the /api/personalloans/customer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
