@report @getScoresLatestReport

Feature:Super Friends: Get Latest Score SUPER-26

  Scenario: Verify response for Get Scores from latestReport for a Dispute Limited user
    Given I create a new free customer using at_ltdreg100 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 404
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 404
    And make sure following attributes exist within response data with correct values
      | Atributes             | Value           |
      | fieldErrors[0].field  | score           |
      | fieldErrors[0].detail | no scores found |

  Scenario: Verify response for Get Scores from latestReport for a FCR user
    Given I create a new free customer using at_fcras105 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_FCR.json file by removing below attributes and using compare method IN_ORDER
      | Atributes              |
      | experian[0].id         |
      | experian[0].scoreDate  |
      | experian[0].createDate |
      | experian[0].sourceId   |

  Scenario: Verify response for Get Scores from latestReport for a FCS 1b1s user
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_FCS.json file by removing below attributes and using compare method IN_ORDER
      | Atributes              |
      | experian[0].id         |
      | experian[0].scoreDate  |
      | experian[0].createDate |
      | experian[0].sourceId   |

  Scenario: Verify response for Get Scores from latestReport for a 1B1S-IS No Benefit user with benefit B63
    Given I create a new paid customer using at_1b1s111 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_1b1s-is.json file by removing below attributes and using compare method RANDOM_ORDER
      | Atributes              |
      | experian[0].id         |
      | experian[0].scoreDate  |
      | experian[0].createDate |
      | experian[0].sourceId   |
      | experian[1].id         |
      | experian[1].scoreDate  |
      | experian[1].createDate |
      | experian[1].sourceId   |
      | experian[2].id         |
      | experian[2].scoreDate  |
      | experian[2].createDate |
      | experian[2].sourceId   |
      | experian[3].id         |
      | experian[3].scoreDate  |
      | experian[3].createDate |
      | experian[3].sourceId   |
      | experian[4].id         |
      | experian[4].scoreDate  |
      | experian[4].createDate |
      | experian[4].sourceId   |
      | experian[5].id         |
      | experian[5].scoreDate  |
      | experian[5].createDate |
      | experian[5].sourceId   |
      | experian[6].id         |
      | experian[6].scoreDate  |
      | experian[6].createDate |
      | experian[6].sourceId   |

  Scenario: Verify response for Get Latest Score for a 3B3S-IS No Benefit user with benefit B52
    Given I create a new paid customer using at_3b3s111 offer tags
    And I create a new secure token with existing Customer ID and member scope
    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EQ endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_EQ.json file by removing below attributes and using compare method IN_ORDER
      | Atributes             |
      | equifax[0].id         |
      | equifax[0].scoreDate  |
      | equifax[0].createDate |
      | equifax[0].sourceId   |
      #    Get call for latest Scores
    Given I create a new external experian report service request to the /api/report/scores/latestreport/TU endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_TU.json file by removing below attributes and using compare method IN_ORDER
      | Atributes                |
      | transunion[0].id         |
      | transunion[0].scoreDate  |
      | transunion[0].createDate |
      | transunion[0].sourceId   |

  Scenario: Verify response for Get Latest Score for a Premium user that has 3b3s-is latest report
    Given I create a new paid customer using at_eiwpt102 offer tags
    And I create a new secure token with existing Customer ID and member scope
      # Post Call to pull a 3B report
    Given I create a new external experian report service request to the /api/report endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/report/postreportbenefitId.json replacing values:
      | benefitId | B85 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_1b1s-is.json file by removing below attributes and using compare method RANDOM_ORDER
      | Atributes              |
      | experian[0].id         |
      | experian[0].scoreDate  |
      | experian[0].createDate |
      | experian[0].sourceId   |
      | experian[1].id         |
      | experian[1].scoreDate  |
      | experian[1].createDate |
      | experian[1].sourceId   |
      | experian[2].id         |
      | experian[2].scoreDate  |
      | experian[2].createDate |
      | experian[2].sourceId   |
      | experian[3].id         |
      | experian[3].scoreDate  |
      | experian[3].createDate |
      | experian[3].sourceId   |
      | experian[4].id         |
      | experian[4].scoreDate  |
      | experian[4].createDate |
      | experian[4].sourceId   |
      | experian[5].id         |
      | experian[5].scoreDate  |
      | experian[5].createDate |
      | experian[5].sourceId   |
      | experian[6].id         |
      | experian[6].scoreDate  |
      | experian[6].createDate |
      | experian[6].sourceId   |
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EQ endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_EQ.json file by removing below attributes and using compare method IN_ORDER
      | Atributes             |
      | equifax[0].id         |
      | equifax[0].scoreDate  |
      | equifax[0].createDate |
      | equifax[0].sourceId   |
    Given I create a new external experian report service request to the /api/report/scores/latestreport/TU endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And validate response with this /json_objects/report/response_score_latest_TU.json file by removing below attributes and using compare method IN_ORDER
      | Atributes                |
      | transunion[0].id         |
      | transunion[0].scoreDate  |
      | transunion[0].createDate |
      | transunion[0].sourceId   |
