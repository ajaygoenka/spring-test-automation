@prequal @publicmatch @restrictedstate

Feature: Validate the Public Match Prequal Restricted State

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from NV State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/nomatchNVstate.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | LINDA                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for NV State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | LINDA                                      |
      | lastName                 | GRIMM                                      |
      | address.state            | NV                                         |
      | lastFourOfSSN            | 4006                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from MA State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | MARY                                        |
      | lastName                 | ARIAIL                                      |
      | lastFourOfSSN            | 0533                                        |
      | address.streetAddress1   | 19 ALFRED ST                                |
      | address.city             | FALL RIVER                                  |
      | address.state            | MA                                          |
      | address.zip              | 02721                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | MARY                                      |


  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for MA State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | MARY                                       |
      | lastName                 | ARIAIL                                     |
      | address.state            | MA                                         |
      | lastFourOfSSN            | 0533                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from ME State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JOHN                                        |
      | lastName                 | HAMMER                                      |
      | lastFourOfSSN            | 6530                                        |
      | address.streetAddress1   | 230 E ELM ST                                |
      | address.city             | YARMOUTH                                    |
      | address.state            | ME                                          |
      | address.zip              | 04096                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | JOHN                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for ME State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | JOHN                                       |
      | lastName                 | HAMMER                                     |
      | address.state            | ME                                         |
      | lastFourOfSSN            | 6530                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from NH State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JESSICA                                     |
      | lastName                 | BERRY                                       |
      | lastFourOfSSN            | 8027                                        |
      | address.streetAddress1   | 33 JONES FARM RD                            |
      | address.city             | PELHAM                                      |
      | address.state            | NH                                          |
      | address.zip              | 03076                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | JESSICA                                   |


  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for NH State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | JESSICA                                    |
      | lastName                 | BERRY                                      |
      | address.state            | NH                                         |
      | lastFourOfSSN            | 8027                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from ND State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | JAMES                                       |
      | lastName                 | BOS                                         |
      | lastFourOfSSN            | 0468                                        |
      | address.streetAddress1   | RR 1 BOX 226 212                            |
      | address.city             | DEVILS LAKE                                 |
      | address.state            | ND                                          |
      | address.zip              | 58301                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | JAMES                                     |


  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for ND State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | JAMES                                      |
      | lastName                 | BOS                                        |
      | address.state            | ND                                         |
      | lastFourOfSSN            | 0468                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from OR State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | CANDY                                       |
      | lastName                 | BREMER                                      |
      | lastFourOfSSN            | 3730                                        |
      | address.streetAddress1   | 942 E 18TH AVE                              |
      | address.city             | EUGENE                                      |
      | address.state            | OR                                          |
      | address.zip              | 97403                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | CANDY                                     |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for OR State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | CANDY                                      |
      | lastName                 | BREMER                                     |
      | address.state            | OR                                         |
      | lastFourOfSSN            | 3730                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from WV State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | ANGELA                                      |
      | lastName                 | WAGNER                                      |
      | lastFourOfSSN            | 9310                                        |
      | address.streetAddress1   | 1345 S 52ND AVE                             |
      | address.city             | WHITESVILLE                                 |
      | address.state            | WV                                          |
      | address.zip              | 25209                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | ANGELA                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for WV State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | ANGELA                                     |
      | lastName                 | WAGNER                                     |
      | address.state            | WV                                         |
      | lastFourOfSSN            | 9310                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from PA State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | GINA                                        |
      | lastName                 | BALLOUTINE                                  |
      | lastFourOfSSN            | 2279                                        |
      | address.streetAddress1   | 5155 CARNEGIE ST                            |
      | address.city             | PITTSBURGH                                  |
      | address.state            | PA                                          |
      | address.zip              | 15201                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | GINA                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for PA State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | GINA                                       |
      | lastName                 | BALLOUTINE                                 |
      | address.state            | PA                                         |
      | lastFourOfSSN            | 2279                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from RI State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | CHARLOTTE                                   |
      | lastName                 | BOWEN                                       |
      | lastFourOfSSN            | 5701                                        |
      | address.streetAddress1   | 16 PEARCE AVE                               |
      | address.city             | CRANSTON                                    |
      | address.state            | RI                                          |
      | address.zip              | 02910                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | CHARLOTTE                                 |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for RI State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | CHARLOTTE                                  |
      | lastName                 | BOWEN                                      |
      | address.state            | RI                                         |
      | lastFourOfSSN            | 5701                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Response Code and NOMATCH offers for user from VT State
    Given I create a new external experian prequal service request to the /api/prequal/public endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/prequal/nomatchNVstate.json replacing values:
      | firstName                | BRENDA                                      |
      | lastName                 | RIGGS                                       |
      | lastFourOfSSN            | 7390                                        |
      | address.streetAddress1   | 101 North Carson Street                     |
      | address.city             | S HERO                                      |
      | address.state            | VT                                          |
      | address.zip              | 05486                                       |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | status    | NOMATCH                                   |
      | firstName | BRENDA                                    |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify Lead Sent set False for VT State User
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | notnull                                    |
      | firstName                | BRENDA                                     |
      | lastName                 | RIGGS                                      |
      | address.state            | VT                                         |
      | lastFourOfSSN            | 7390                                       |
      | email                    | supriya.dighe@experianinteractive.com      |
      | status                   | NOMATCH                                    |
      | leadId                   | cc781d5744ed1140ee5f7dfcc8ef685fe6c6944f   |
      | createDt                 | notnull                                    |
      | leadSent                 | false                                      |
















