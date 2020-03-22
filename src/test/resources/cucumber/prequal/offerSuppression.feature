@prequal @publicmatch @offersuppression

Feature: Validate Firm Offer Suppression

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Amex Firm Offer Suppression A016F00006
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | MITCHELL                                    |
      | lastName                 | FALLIN                                      |
      | lastFourOfSSN            | 9765                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 902 EASTERN VIEW DR                         |
      | address.city             | FREDERICKSBRG                               |
      | address.state            | VA                                          |
      | address.zip              | 22405                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes         | Value                                     |
      | status            | MATCHED                                   |
      | firstName         | MITCHELL                                  |
      | offers.offer_id   | A026F00003                                |