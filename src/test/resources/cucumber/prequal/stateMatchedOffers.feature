@prequal @publicmatch @statematchedoffers

Feature: Validate TX, KS and LA State MATCHED offers

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and MATCHED Offers for User from TX State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            | 5664                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1204 16TH ST                                |
      | address.city             | SOUTH HOUSTON                               |
      | address.state            | TX                                          |
      | address.zip              | 77587                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | JASON                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and MATCHED Offers for User from KS State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JASON                                       |
      | lastName                 | BOGROFF                                     |
      | lastFourOfSSN            | 5664                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 5100 3RD ST 2                               |
      | address.city             | GARDEN CITY                                 |
      | address.state            | KS                                          |
      | address.zip              | 67846                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | JASON                                     |
  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and MATCHED Offers for User from LA State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | HATTIE                                      |
      | lastName                 | JAY                                         |
      | lastFourOfSSN            | 3466                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 148 CORETTA DR                              |
      | address.city             | AVONDALE                                    |
      | address.state            | LA                                          |
      | address.zip              | 70094                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | HATTIE                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set True for user from TX, KS and LA state
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b1f8b8fa9c9d7b73f49a39025bf781d8287750fb endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | HATTIE                                     |
      | lastName                 | JAY                                        |
      | address.state            | LA                                         |
      | lastFourOfSSN            | 3466                                       |
      | email                    | ketaki.kunte@experianinteractive.com       |
      | status                   | MATCHED                                    |
      | leadId                   | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb   |
      | createDt                 | notnull                                    |
      | leadSent                 | true                                       |



