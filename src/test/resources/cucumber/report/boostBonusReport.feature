@api @report @boostBonusReport
Feature:Super Friends: On-Demand Boost Bonus report

  Scenario: GET bonusreport for boost for member with benefit
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value    |
      | reportInfo.reportId | notnull  |
      | reportInfo.isNew    | true     |
      | reportInfo.bonus    | false    |
      | reportInfo.type     | EXPERIAN |
     #    Get call to pull on demand boost bonus report with query param trigger as empty
    Given I create a new internal experian report service request to the /report/v1/pullBonusReport endpoint
    And I add a query parameter trigger with value invalid
    And I add the default headers to the request
    And I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 400
    #    Get call to pull on demand boost bonus report
    Given I create a new internal experian report service request to the /report/v1/pullBonusReport endpoint
    And I add a query parameter trigger with value ScoreBoost
    And I add the default headers to the request
    And I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value    |
      | reportInfo.reportId | notnull  |
      | reportInfo.isNew    | true     |
      | reportInfo.bonus    | true     |
      | reportInfo.type     | EXPERIAN |
    And make sure following attributes exist within response data with correct values in BonusResources Table
      | Atributes     | Value      |
      | BonusStatus   | Fulfilled  |
      | TriggerSource | ScoreBoost |
    And the bonusResources table now has 1 record/s
#    Verify that bonus report is pulled when Calling On demand Bonus Report api again
    Given I create a new internal experian report service request to the /report/v1/pullBonusReport endpoint
    And I add a query parameter trigger with value ScoreBoost
    And I add the default headers to the request
    And I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And the bonusResources table now has 2 record/s

