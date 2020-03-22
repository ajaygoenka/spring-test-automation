@prequal @publicmatch @edgecases

Feature: Validate Edge Cases

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 400 for missing input First Name
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                |                                             |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            | 5664                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1204 16TH ST                                |
      | address.city             | SOUTH HOUSTON                               |
      | address.state            | TX                                          |
      | address.zip              | 77587                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 400
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value                              |
      | size must be between 1 and 100    | publicProfileRequest.firstName     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 400 for missing input Last Name
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 |                                             |
      | lastFourOfSSN            | 5664                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1204 16TH ST                                |
      | address.city             | SOUTH HOUSTON                               |
      | address.state            | TX                                          |
      | address.zip              | 77587                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 400
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value                              |
      | size must be between 1 and 100    | publicProfileRequest.lastName      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 400 for missing input last 4 SSN
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            |                                             |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1204 16TH ST                                |
      | address.city             | SOUTH HOUSTON                               |
      | address.state            | TX                                          |
      | address.zip              | 77587                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 400
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value                              |
      | size must be between 4 and 4      | publicProfileRequest.lastFourOfSSN |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 400 for missing input Email ID
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            | 5664                                        |
      | email                    |                                             |
      | address.streetAddress1   | 1204 16TH ST                                |
      | address.city             | SOUTH HOUSTON                               |
      | address.state            | TX                                          |
      | address.zip              | 77587                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 400
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value                              |
      | size must be between 1 and 100    | publicProfileRequest.email         |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 400 for missing input Address fields
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            | 5664                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address                  |                                             |
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Empty Offers for ID Verify FAILED user
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | ROBERT                                      |
      | lastName                 | BARRETT                                     |
      | lastFourOfSSN            | 1527                                        |
      | email                    | statsis-low@consumerinfo.com                |
      | address.streetAddress1   | 2271 HAWAII AVE SW                          |
      | address.city             | HURON                                       |
      | address.state            | SD                                          |
      | address.zip              | 57350                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | ROBERT                                    |
      | offers    | []                                        |
  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set False for No Lead to Exact Target
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JULIE                                       |
      | lastName                 | MURREL                                      |
      | lastFourOfSSN            | 2887                                        |
      | email                    | statsis-low@consumerinfo.com                |
      | address.streetAddress1   | 5311 S LAWNDALE AVE                         |
      | address.city             | CHICAGO                                     |
      | address.state            | IL                                          |
      | address.zip              | 60632                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | JULIE                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify No Leads Sent to Exact Target for Under 21 User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | ROBERT                                      |
      | lastName                 | BARRETT                                     |
      | lastFourOfSSN            | 1527                                        |
      | email                    | statsis-low@consumerinfo.com                |
      | address.streetAddress1   | 2271 HAWAII AVE SW                          |
      | address.city             | HURON                                       |
      | address.state            | SD                                          |
      | address.zip              | 57350                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | ROBERT                                    |









