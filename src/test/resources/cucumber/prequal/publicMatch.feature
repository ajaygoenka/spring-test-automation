@prequal @publicmatch @leadcapture

Feature: Validate the Public Match Lead Capture

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code for internal lead capture
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/internal.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | leadId    | b1f8b8fa9c9d7b73f49a39025bf781d8287750fb  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 200 and lead id gererated remains same for the email id
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/leadid_same.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | leadId    | 9d89b5d9d5f34a8ec93cab03ce3a3e8d3315a162  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 200 when empty matched offers passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/empty_offers.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | leadId    | fb31d8ec1ae398c7d99fedf7ca1d955cecb2c53e  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify lead id if the offers reaches max of matched offers attribute limit
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/max_offers.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | leadId    | 909bbe9028ec77e8d016f5e5d5bf006c7d0c35c4  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 for empty email id
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/empty_email.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 for empty source
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/empty_source.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 when subsource attribute not passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/nosubsource_property.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 when matchedoffers property not passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/nomatchedoffers_property.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 when email id property not passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/noemailid_property.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 when intents property not passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/nointents_property.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 for empty intents
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/empty_intents.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 200 and lead id generated for empty subsource
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/empty_subscource.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | leadId    | ccb9adde72603318101eee57f919ed4debc4a924  |

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify response code 400 when source attribute not passed
    Given I create a new internal experian leadcapture service request to the /leadcapture/lead/prequal endpoint
    And I add the default headers to the request
    And I add a json request body using the file /json_objects/prequal/nosource_property.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 400

  Scenario: TC_PREQUAL_PUBLICMATCH - C_TC_Verify customer profile details based on lead id
    Given I create a new internal experian prequal service request to the /prequal/rightoffers/publicmatch/8182332ac0c02bb84f70db18e7af34ac633584e6 endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                                      |
      | prospectId               | a18827bb2cdf4b5f88cdd066e4ef7f88           |
      | firstName                | JAMES                                      |
      | lastName                 | MORTON                                     |
      | address                  | notnull                                    |
      | lastFourOfSSN            | 7752                                       |
      | vendorOfferRequestId     | 36ffdccd-5e7c-486d-8a60-3c45b599aa8a       |
      | email                    | stasis-low@consumerinfo.com                |
      | status                   | MATCHED                                    |
      | leadId                   | 8182332ac0c02bb84f70db18e7af34ac633584e6   |
      | createDt                 | 2020-01-08T22:18:58.490Z                   |
      | leadSent                 | true                                       |





