@leadcapture

Feature:Hydra: Validate lead capture for multiple source

  @LC01
  Scenario: Validate lead capture for source MCE
    Given I create a new external experian leadcapture service request to the /api/leadcapture/lead endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/leadcapture/leadcapture.json replacing values:
      | emailAddress | fake_email |
      | source       | MCE        |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I embed the Scenario Session value of type emailAddress in report

  @LC02
  Scenario: Validate lead capture for source Experian Website
    Given I create a new external experian leadcapture service request to the /api/leadcapture/lead endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/leadcapture/leadcapture.json replacing values:
      | emailAddress | fake_email       |
      | source       | Experian Website |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I embed the Scenario Session value of type emailAddress in report

  @LC03
  Scenario: Validate lead capture for source Blog
    Given I create a new external experian leadcapture service request to the /api/leadcapture/lead endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/leadcapture/leadcapture.json replacing values:
      | emailAddress | fake_email |
      | source       | Blog       |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I embed the Scenario Session value of type emailAddress in report

  @LC04
  Scenario: Validate lead capture for source publicpq
    Given I create a new external experian leadcapture service request to the /api/leadcapture/lead endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/leadcapture/leadcapture.json replacing values:
      | emailAddress | fake_email |
      | source       | publicpq   |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I embed the Scenario Session value of type emailAddress in report
