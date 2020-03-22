@api @endeavour @childMonitoringInternal
Feature:Endeavour: CHILD MONITORING   - INTERNAL Route

  @childmonitoringPostChild
  Scenario Outline: [1] CHILDMONIORING-INTERNAL - ADD CHILD - ROUTE "childmonitoring/child"
    # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/child endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<filename> replacing values:
      | firstName | firstName-customAlpha |
      | ssn       | 9digit-ssn            |

    And I send the POST request with response type ByteArray
    Then The response status code should be 200

      #SAVE THE CHILD SUBSCRIPTION ID
    And I save the value of attribute childSubscriptionId as childSubscriptionId


        # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken
     #CLEAN UP - DELETE CHILD
    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child/archive endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/deleteChildINT.json replacing values:
      | firstName           | firstName-customAlpha       |
      | ssn                 | 9digit-ssn                  |
      | childSubscriptionId | session_childSubscriptionId |

    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | filename                 | USER_ID                          |
      | 8bc0cfa5ca6b48439d757052af715142 | f1512d89-386c-499b-b9f6-55f29d78cb02 | addChildINTInternal.json | aut.walter.browning.200107112551 |
    @stg
    Examples:
      | customerId                       | subscriptionId                       | filename                   | USER_ID         |
      | fd6d577f2e6143dab8efa534de02ff73 | e7a2a85f-6b25-4ae8-bc34-0fb09a8f5fc5 | addChildStageInternal.json | stage_aru_fplan |


  @childmonitoringGetChildren
  Scenario Outline: [2] CHILDMONIORING-INTERNAL - FETCH ALL THE CHILDREN - ROUTE "/childmonitoring/{customerId}/children"
    # for given Below Data
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/{customerId}/children endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       |
      | 8bc0cfa5ca6b48439d757052af715142 |

    @stg
    Examples:
      | customerId                       |
      | fd6d577f2e6143dab8efa534de02ff73 |


  @childmonitoringGetchilddetails
  Scenario Outline: [3] CHILDMONIORING-INTERNAL - FETCH CHILD INFORMATION - ROUTE "/internal/childmonitoring/{customerId}/child/{childSubscriptionId}"
    # for given Below Data
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <childSubscriptionId> as childSubscriptionId
    And I embed the Scenario Session value of type childSubscriptionId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/{customerId}/child/{childSubscriptionId} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | customerId                       | childSubscriptionId              |
      | 61e3d3cc01ca44fc82280b8d9219b412 | 8d581b0240bf455a91a407eebcdebe0a |

    @int
    Examples:
      | customerId                       | childSubscriptionId              |
      | 5c01cf140547480f87c0b004ebb808f6 | 2f7b5c14fafc4c1bba15b4056c64e3b2 |


  @childmonitoringGetAllChilddetails
  Scenario Outline: [4] CHILDMONIORING-INTERNAL - FETCH ALL CHILDREN - ROUTE "/internal/childmonitoring/{customerId}/child/allchildren"
    # for given Below Data
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/{customerId}/allchildren endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | customerId                       |
      | fd6d577f2e6143dab8efa534de02ff73 |

    @int
    Examples:
      | customerId                       |
      | 87704719ec5a4dba9109292a51a0b2a3 |


  @childmonitoringDeleteChild
  Scenario Outline: [5] CHILDMONIORING-INTERNAL - ROUTE "/internal/childmonitoring/child/archive"
        #PRECONDITION
     # for given Below Data
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/child endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<filename> replacing values:
      | firstName | firstName-customAlpha |
      | ssn       | 9digit-ssn            |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
      #SAVE THE CHILD SUBSCRIPTION ID
    And I save the value of attribute childSubscriptionId as childSubscriptionId

    #SCENARIO EXECUTION
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/child/archive endpoint
    And I add the default headers to the request
    And I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/deleteChild.json replacing values:
      | childSubscriptionId | session_childSubscriptionId |
      | customerId          | session_customerId          |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200



    @int
    Examples:
      | customerId                       | subscriptionId                       | filename             |
      | 0a19dc7286e743c4a80fc264aaec692f | 64f95722-deb2-4c54-acf9-f3a71a72c247 | addChildINTArch.json |

    @stg
    Examples:
      | customerId                       | subscriptionId                   | filename           |
      | fd6d577f2e6143dab8efa534de02ff73 | e7a2a85f6b254ae8bc340fb09a8f5fc5 | addChildStage.json |

  @childmonitoringChildScanreport
  Scenario Outline: [6] CHILDMONIORING-INTERNAL - ROUTE "/internal/childmonitoring/{customerId}/childscanreport/{childSubscriptionId}"
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <childSubscriptionId> as childSubscriptionId
    And I embed the Scenario Session value of type childSubscriptionId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/{customerId}/childscanreport/{childSubscriptionId} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | customerId                       | childSubscriptionId              |
      | 5c01cf140547480f87c0b004ebb808f6 | 2f7b5c14fafc4c1bba15b4056c64e3b2 |

    @stg
    Examples:
      | customerId                       | childSubscriptionId              |
      | 61e3d3cc01ca44fc82280b8d9219b412 | 8d581b0240bf455a91a407eebcdebe0a |

  @childmonitoringAddManyChild @ignore
  Scenario Outline: [7] CHILDMONIORING-INTERNAL -  ROUTE "/internal/childmonitoring/children"
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/children endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<filename> replacing values:
      | firstName | firstName-customAlpha |
      | ssn       | 9digit-ssn            |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200


       #SAVE THE CHILD SUBSCRIPTION ID
    And I save the value of attribute childSubscriptionId as childSubscriptionId

    #POST TEST CONDITION - CLEAN UP
    Given I create a new internal experian childMonitoring service request to the /childmonitoring/child/archive endpoint
    And I add the default headers to the request
    And I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/deleteChild.json replacing values:
      | childSubscriptionId | session_childSubscriptionId |
      | customerId          | session_customerId          |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    @int @ignore
    Examples:
      | customerId                       | subscriptionId                       | filename         |
      | fd6d577f2e6143dab8efa534de02ff73 | e7a2a85f-6b25-4ae8-bc34-0fb09a8f5fc5 | addChildINT.json |

    @stg @ignore
    Examples:
      | customerId                       | subscriptionId                       | filename           |
      | fd6d577f2e6143dab8efa534de02ff73 | e7a2a85f-6b25-4ae8-bc34-0fb09a8f5fc5 | addChildStage.json |


  @childmonitoringPostChildScanReport @ignore
  Scenario Outline: [8] CHILDMONIORING-INTERNAL -  ROUTE "/internal/childmonitoring/childscanreport"
    Given save the value of  <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of  <childSubscriptionId> as childSubscriptionId
    And I embed the Scenario Session value of type childSubscriptionId in report

    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken

    Given I create a new internal experian childMonitoring service request to the /childmonitoring/childscanreport endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/childScan.json replacing values:
      | childSubscriptionId | session_childSubscriptionId |
      | customerId          | session_customerId          |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    @int @ignore
    Examples:
      | customerId                       | childSubscriptionId              |
      | b78398541d3747cf97237805f64ac053 | d6cca0fec6c34607a98005b5a68d5a44 |

    @stg @ignore
    Examples:
      | customerId                       | childSubscriptionId              |
      | 61e3d3cc01ca44fc82280b8d9219b412 | 8d581b0240bf455a91a407eebcdebe0a |







