@prequal @publicmatch @publicprequal

Feature: Validate the Public Prequal User Scenarios

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 200 and Status REJECTED for ID Verify Failed User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/json                      |
    And I add a query parameter x-fn with value on
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

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for REJECTED User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/0d8f99803e50dc0e13c3057aedd1416b7796f2a6 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | ROBERT                                     |
      | lastName                 | BARRETT                                    |
      | address.state            | SD                                         |
      | lastFourOfSSN            | 1527                                       |
      | email                    | statsis-low@consumerinfo.com               |
      | status                   | REJECTED                                   |
      | leadId                   | 0d8f99803e50dc0e13c3057aedd1416b7796f2a6   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 200 and Status REJECTED for user below 21 years
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | REYES                                       |
      | lastName                 | LONGORIA                                    |
      | lastFourOfSSN            | 9080                                        |
      | email                    | emaildomain123@gmail.com                    |
      | address.streetAddress1   | 3730 PREAKNESS PL 1072                      |
      | address.city             | PALM HARBOR                                 |
      | address.state            | FL                                          |
      | address.zip              | 34684                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | REYES                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for User Under 21 years
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b344fca8a55cdf9dbf833f3e83695da3209d5554 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | REYES                                      |
      | lastName                 | LONGORIA                                   |
      | address.state            | FL                                         |
      | lastFourOfSSN            | 9080                                       |
      | email                    | emaildomain123@gmail.com                   |
      | status                   | REJECTED                                   |
      | leadId                   | b344fca8a55cdf9dbf833f3e83695da3209d5554   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 200 and Status REJECTED for Blocked File User
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

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for Blocked User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/0d8f99803e50dc0e13c3057aedd1416b7796f2a6 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | JULIE                                      |
      | lastName                 | MURREL                                     |
      | address.state            | IL                                         |
      | lastFourOfSSN            | 2887                                       |
      | email                    | statsis-low@consumerinfo.com               |
      | status                   | REJECTED                                   |
      | leadId                   | 0d8f99803e50dc0e13c3057aedd1416b7796f2a6   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for User with No Trade
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | PATRICK                                     |
      | lastName                 | MERCADO                                     |
      | lastFourOfSSN            | 2943                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1764 MOONSTONE DR                           |
      | address.city             | VIRGINIA BEACH                              |
      | address.state            | VA                                          |
      | address.zip              | 23456                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | PATRICK                                   |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set True for User with No Trade Matched Offers
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b1f8b8fa9c9d7b73f49a39025bf781d8287750fb endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | PATRICK                                    |
      | lastName                 | MERCADO                                    |
      | address.state            | VA                                         |
      | lastFourOfSSN            | 2943                                       |
      | email                    | ketaki.kunte@experianinteractive.com       |
      | status                   | NOMATCH                                    |
      | leadId                   | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb   |
      | createDt                 | notnull                                    |
      | leadSent                 | true                                       |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for Credit File Locked User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | PHILLIP                                     |
      | lastName                 | LOGOTHETIS                                  |
      | lastFourOfSSN            | 4447                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 13983 GUNNERS PL                            |
      | address.city             | CENTREVILLE                                 |
      | address.state            | VA                                          |
      | address.zip              | 20121                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | PHILLIP                                   |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set True for Credit File Locked  User with Matched Offers
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b1f8b8fa9c9d7b73f49a39025bf781d8287750fb endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | PHILLIP                                    |
      | lastName                 | LOGOTHETIS                                 |
      | address.state            | VA                                         |
      | lastFourOfSSN            | 4447                                       |
      | email                    | ketaki.kunte@experianinteractive.com       |
      | status                   | MATCHED                                    |
      | leadId                   | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb   |
      | createDt                 | notnull                                    |
      | leadSent                 | true                                       |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response for User with Only One Offer
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | LONNIE                                      |
      | lastName                 | ADAMS                                       |
      | lastFourOfSSN            | 5367                                        |
      | email                    | ketaki.kunte@experianinteractive.com        |
      | address.streetAddress1   | 1351 N COUNTRY LN                           |
      | address.city             | WASILLA                                     |
      | address.state            | AK                                          |
      | address.zip              | 99654                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | LONNIE                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - H_TC_Verify Lead Sent Set True for Thin File User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/b1f8b8fa9c9d7b73f49a39025bf781d8287750fb endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | LONNIE                                     |
      | lastName                 | ADAMS                                      |
      | address.state            | AK                                         |
      | lastFourOfSSN            | 5367                                       |
      | email                    | ketaki.kunte@experianinteractive.com       |
      | status                   | MATCHED                                    |
      | leadId                   | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb   |
      | createDt                 | notnull                                    |
      | leadSent                 | true                                       |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for Thin File User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JAMES                                       |
      | lastName                 | MORTON                                      |
      | lastFourOfSSN            | 7752                                        |
      | email                    | stasis-low@consumerinfo.com                 |
      | address.streetAddress1   | 294 SUMMERHILL RD                           |
      | address.city             | EAST BRUNSWICK                              |
      | address.state            | NJ                                          |
      | address.zip              | 08816                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | MATCHED                                   |
      | firstName | JAMES                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for Deceased SSN
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | SHARON                                      |
      | lastName                 | LLOYD                                       |
      | lastFourOfSSN            | 9973                                        |
      | email                    | testemail123@gmail.com                      |
      | address.streetAddress1   | N618 MAPLE GROVE RD                         |
      | address.city             | MERRILL                                     |
      | address.state            | WI                                          |
      | address.zip              | 54452                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | SHARON                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for Deceased SSN
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/bbfc3c4c4f30675933b9ba2baa5a0ee86fcab8f3 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | SHARON                                     |
      | lastName                 | LLOYD                                      |
      | address.state            | WI                                         |
      | lastFourOfSSN            | 9973                                       |
      | email                    | testemail123@gmail.com                     |
      | status                   | REJECTED                                   |
      | leadId                   | bbfc3c4c4f30675933b9ba2baa5a0ee86fcab8f3   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for Bankrupt User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | CHRISTOPH                                   |
      | lastName                 | BOYES                                       |
      | lastFourOfSSN            | 0571                                        |
      | email                    | testemail12@gmail.com                       |
      | address.streetAddress1   | 30 MIZZELL RD                               |
      | address.city             | COLUMBIANA                                  |
      | address.state            | AL                                          |
      | address.zip              | 35051                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | REJECTED                                  |
      | firstName | CHRISTOPH                                 |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for Bankrupt User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/5522a8f32f8fb202cfa39ad31279cbb85acb7983 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | CHRISTOPH                                  |
      | lastName                 | BOYES                                      |
      | address.state            | AL                                         |
      | lastFourOfSSN            | 0571                                       |
      | email                    | testemail12@gmail.com                      |
      | status                   | REJECTED                                   |
      | leadId                   | 5522a8f32f8fb202cfa39ad31279cbb85acb7983   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for NO Record Found
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | WILLIAMS                                    |
      | lastName                 | KARLA                                       |
      | lastFourOfSSN            | 9539                                        |
      | email                    | Supriya.Dighe@experianinteractive.com       |
      | address.streetAddress1   | 22329 DEER PARK DR                          |
      | address.city             | CHUGIAK                                     |
      | address.state            | AK                                          |
      | address.zip              | 99567                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | WILLIAMS                                  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for No Record Found User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | WILLIAMS                                   |
      | lastName                 | KARLA                                      |
      | address.state            | AK                                         |
      | lastFourOfSSN            | 9539                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Public Prequal Response for Credit File Frozen User
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | OPHELIA                                     |
      | lastName                 | BETTS                                       |
      | lastFourOfSSN            | 4447                                        |
      | email                    | Supriya.Dighe@experianinteractive.com       |
      | address.streetAddress1   | 1801 E PINCHOT AVE                          |
      | address.city             | PHOENIX                                     |
      | address.state            | AZ                                          |
      | address.zip              | 85016                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | OPHELIA                                   |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for Credit File Frozen User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | OPHELIA                                    |
      | lastName                 | BETTS                                      |
      | address.state            | AZ                                         |
      | lastFourOfSSN            | 4447                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code 200 and Status NO MATCH when no offers returned by prequal
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | MARK                                        |
      | lastName                 | BURROUGHS                                   |
      | lastFourOfSSN            | 5473                                        |
      | email                    | Supriya.Dighe@experianinteractive.com       |
      | address.streetAddress1   | 3204 PARKER ST                              |
      | address.city             | AMARILLO                                    |
      | address.state            | TX                                          |
      | address.zip              | 79109                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | MARK                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent Set False for user with NOMATCH offers
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | MARK                                       |
      | lastName                 | BURROUGHS                                  |
      | address.state            | TX                                         |
      | lastFourOfSSN            | 5473                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |











