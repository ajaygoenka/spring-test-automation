@prequal @publicmatch @happyflow

Feature: Validate the Public Match Prequal Happy Flow

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 200 for Public Prequal Happy Flow
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | SUSAN                                       |
      | lastName                 | BROUSSARD                                   |
      | lastFourOfSSN            | 8672                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 4145 DEVON DR                               |
      | address.city             | INDIANAPOLIS                                |
      | address.state            | IN                                          |
      | address.zip              | 46226                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | SUSAN                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response for Public Prequal Happy Flow
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | LAURIE                                      |
      | lastName                 | ANDERSON                                    |
      | lastFourOfSSN            | 5730                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 9817 LOOP BLVD APT G                        |
      | address.city             | CALIFORNIA CITY                             |
      | address.state            | CA                                          |
      | address.zip              | 93505                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | LAURIE                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set True for user with Matched Offers sent to Exact Target
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b1f8b8fa9c9d7b73f49a39025bf781d8287750fb endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | LAURIE                                     |
      | lastName                 | ANDERSON                                   |
      | address.state            | CA                                         |
      | lastFourOfSSN            | 5730                                       |
      | email                    | ketaki.kunte@experianinteractive.com       |
      | status                   | MATCHED                                    |
      | leadId                   | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb   |
      | createDt                 | notnull                                    |
      | leadSent                 | true                                       |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify TTL Date set to 24 months for Public Match Users
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | ROBERT                                      |
      | lastName                 | BARRETT                                     |
      | lastFourOfSSN            | 1527                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 2271 HAWAII AVE SW                          |
      | address.city             | HURON                                       |
      | address.state            | SD                                          |
      | address.zip              | 57350                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | ROBERT                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Offers with ri_ind "X" and "R"
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | TABACE                                      |
      | lastName                 | BROWN                                       |
      | lastFourOfSSN            | 4773                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 12158 FIRESTONE BLVD STE A                  |
      | address.city             | NORWALK                                     |
      | address.state            | CA                                          |
      | address.zip              | 90650                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | TABACE                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Offers with ri_ind "I"
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | LAURIE                                      |
      | lastName                 | ANDERSON                                    |
      | lastFourOfSSN            | 5730                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 9817 LOOP BLVD APT G                        |
      | address.city             | CALIFORNIA                                  |
      | address.state            | CA                                          |
      | address.zip              | 93505                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | LAURIE                                    |