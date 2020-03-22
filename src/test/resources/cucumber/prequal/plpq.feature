@plpq

Feature: Validate that PLPQ

  @AUT-3999
  Scenario: TC_PLPQ_Verify Prequal response for Frozen User
    And save the value of int_ophelia_forzen_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    # bureaulock_Verify Freeze Status Code F for Credit Freeze User
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                 | Value |
      | response.freezeStatusCode | F     |
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | offers.prequal           | false |
      | locked                   | false |
      | frozen                   | true  |
      | offers.zones.100[0].rank |       |

  @AUT-4000
  Scenario: TC_PLPQ_Verify Prequal response for Texas State User
    And save the value of int_lockedtexas_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | true       |
      | offers.profileState      | TX         |
      | offers.source            | rightoffer |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.zones.100[0].rank |            |

  @AUT-4001
  Scenario: TC_PLPQ_Verify Prequal response for KS State User
    And save the value of int_paul_la_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | true       |
      | offers.profileState      | KS         |
      | offers.source            | rightoffer |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.zones.100[0].rank |            |

  @AUT-4004
  Scenario: TC_PLPQ_Verify Prequal response for Apollo User with Tradelines
    And save the value of apollo_joyclyn as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | true       |
      | offers.profileState      | UT         |
      | offers.source            | rightoffer |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.zones.100[0].rank |            |

  @AUT-4002
  Scenario: TC_PLPQ_Verify Prequal response for Credit File Locked User
    And save the value of int_lockedusr_phillip_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes               | Value |
      | response.lockStatusCode |       |
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | offers.prequal           | true  |
      | locked                   |       |
      | offers.zones.100[0].rank |       |

  @AUT-4003
  Scenario: TC_PLPQ_Verify Prequal response for FCS user
    And save the value of int_fcs_debbie_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 404
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | offers.prequal           | true  |
      | locked                   |       |
      | offers.zones.100[0].rank |       |

  @AUT-4005
  Scenario: TC_PLPQ_Verify Ollo  Firm Offers Suppression
    And save the value of int_pvk_roland_amextest_4 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                             |
      | userProfile.firstName    | notnull                           |
      | offers.prequal           | true                              |
      | offers.profileState      | CA                                |
      | offers.source            | rightoffer                        |
      | offers.requestId         | notnull                           |
      | offers.baseRequestId     | notnull                           |
      | locked                   | false                             |
      | frozen                   | false                             |
      | memberType               | fr                                |
      | offers.zones.100[0].rank |                                   |
      | offers.zones.100         | not contain-A026F00002 A026F00003 |

  @AUT-4006
  Scenario: TC_PLPQ_Verify Amex Offer Suppression A016F10006
    And save the value of int_pvk_debbies_testamex_1 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                             |
      | offers.prequal           | true                              |
      | locked                   | false                             |
      | frozen                   | false                             |
      | offers.zones.100[0].rank |                                   |
      | offers.zones.100         | not contain-A016F10006 A016000006 |

  @AUT-4007
  Scenario: TC_PLPQ_Verify Amex Offer Suppression A016F20006
    And save the value of int_pvk_jamesk_testamex_2 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                  |
      | offers.prequal           | true                   |
      | locked                   | false                  |
      | frozen                   | false                  |
      | offers.zones.100[0].rank |                        |
      | offers.zones.100         | not contain-A016F20006 |
      | offers.zones.100         | contain-A016000006     |

  @AUT-4008
  Scenario: TC_PLPQ_Verify Amex Offer Suppression A016F30006
    And save the value of int_pvk_william_testamex_3 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                             |
      | offers.prequal           | true                              |
      | locked                   | false                             |
      | frozen                   | false                             |
      | offers.zones.100[0].rank |                                   |
      | offers.zones.100         | not contain-A016F30006 A016000006 |

  @AUT-4009
  Scenario: TC_PLPQ_Verify Amex Offer Suppression A016F40006
    And save the value of int_pvk_roland_amextest_4 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                  |
      | offers.prequal           | true                   |
      | locked                   | false                  |
      | frozen                   | false                  |
      | offers.zones.100[0].rank |                        |
      | offers.zones.100         | not contain-A016F40006 |
      | offers.zones.100         | contain-A016000006     |

  @AUT-4010
  Scenario: TC_C_PLPQ_Verify for Delayed Auth
    And save the value of int_gary_delayedauth_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    Given I create a new internal experian profile service request to the /profile/customer/{customerId} endpoint
    And I add the default headers to the request
    And I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | customer.authenticatedId | 5     |
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | offers.prequal           | true  |
      | locked                   | false |
      | frozen                   | false |
      | offers.zones.100[0].rank |       |

  @AUT-4011
  Scenario: TC_PLPQ_Verify Member Type for Paid User
    And save the value of int_michelle_dunlap_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian fulfillment service request to the /api/fulfillment/subscription endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value          |
      | terms[0].price | IsNumber > 0.0 |
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value |
      | offers.prequal           | true  |
      | memberType               | p     |
      | offers.zones.100[0].rank |       |

  @AUT-4012
  Scenario: TC_PLPQ_Verify Member Type for Free User
    And save the value of int_jason_corderorivera_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian fulfillment service request to the /api/fulfillment/subscription endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value          |
      | terms[0].price | IsNumber = 0.0 |
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value   |
      | offers.prequal           | true    |
      | memberType               | fr      |
      | offers.zones.100[0].rank |         |
      | offers.requestId         | notnull |
      | offers.baseRequestId     | notnull |

  @AUT-4013
  Scenario: TC_PLPQ_Verify Firm Offers in Prequal Response
    And save the value of int_jason_corderorivera_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                         |
      | userProfile.firstName    | notnull                       |
      | offers.prequal           | true                          |
      | offers.profileState      | CA                            |
      | offers.source            | rightoffer                    |
      | offers.requestId         | notnull                       |
      | offers.baseRequestId     | notnull                       |
      | locked                   | false                         |
      | frozen                   | false                         |
      | memberType               | fr                            |
      | offers.zones.100[0].rank |                               |
      | offers.zones.100         | contain-IsGeneric IsFirmOffer |

  @AUT-4014
  Scenario: TC_PLPQ_Verify Preapproved Offers in Prequal Response
    And save the value of int_james_paiduser_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value                 |
      | userProfile.firstName    | notnull               |
      | offers.prequal           | true                  |
      | offers.profileState      | AZ                    |
      | offers.source            | rightoffer            |
      | offers.requestId         | notnull               |
      | offers.baseRequestId     | notnull               |
      | locked                   | false                 |
      | frozen                   | false                 |
      | memberType               | p                     |
      | offers.zones.100[0].rank |                       |
      | offers.zones.100         | contain-IsPreApproved |

  @AUT-4015
  Scenario: TC_PLPQ_Verify Only Generic Offers for Opt Out User
    And save the value of int_generic_off_sv as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value             |
      | memberType               | p                 |
      | offers.zones.100[0].rank |                   |
      | offers.zones.100         | contain-IsGeneric |
      | offers.source            | rightoffer        |
      | locked                   | false             |
      | frozen                   | false             |

  @AUT-4016
  Scenario: TC_PLPQ_Verify PLPQ response for FCR user
    And save the value of int_anthony_fcr_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | true       |
      | memberType               | fr         |
      | offers.zones.100[0].rank |            |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.source            | rightoffer |

  @AUT-4017
  Scenario: TC_PLPQ_Verify PLPQ response for No Score User
    And save the value of kathy_noscore as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | false      |
      | memberType               | p          |
      | offers.zones.100[0].rank |            |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.source            | rightoffer |
      | locked                   | false      |
      | frozen                   | false      |

  @AUT-4018
  Scenario: TC_PLPQ_Verify PLPQ response for Restricted State User
    And save the value of kathy_noscore as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                | Value      |
      | offers.prequal           | false      |
      | offers.profileState      | OR         |
      | memberType               | p          |
      | offers.zones.100[0].rank |            |
      | offers.requestId         | notnull    |
      | offers.baseRequestId     | notnull    |
      | offers.source            | rightoffer |
      | locked                   | false      |
      | frozen                   | false      |

