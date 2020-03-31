@ssn_check

Feature: Validate that SSN Check

  @s1 @smoke
  Scenario: Validate that SSN is off
    Given I create a new external auto login service request to the /api/compdata/v1/comparisondata endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/profile/ssn_check.json
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value       |
      | request.Rating | Exceptional |

