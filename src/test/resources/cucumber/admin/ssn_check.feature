@ssn_check

Feature: Validate that SSN Check

  Scenario: Validate that SSN is off
    Given I create a new external experian login service request to the /admin/serviceconfig endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/profile/ssn_check.json
    And I send the POST request with response type String
    Then The response status code should be 200
