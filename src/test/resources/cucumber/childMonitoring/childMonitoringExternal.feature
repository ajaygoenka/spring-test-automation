@api @endeavour @childMonitoringExternal
Feature:Endeavour: CHILD MONITORING  - EXTERNAL Route


  Scenario Outline: CHILDMONIORING-EXTERNAL[1] - ADD CHILD - ROUTE "/api/childmonitoring/child"
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

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
    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<filename> replacing values:
      | firstName | firstName-customAlpha |
      | ssn       | 9digit-ssn            |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
  #SAVE THE CHILD SUBSCRIPTION ID
    And I save the value of attribute childSubscriptionId as childSubscriptionId

    #CLEAN UP - DELETE CHILD
    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child/archive endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<deletefilename> replacing values:
      | firstName           | firstName-customAlpha       |
      | ssn                 | 9digit-ssn                  |
      | childSubscriptionId | session_childSubscriptionId |

    And I send the POST request with response type ByteArray
    Then The response status code should be 200


    @stg
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | filename                       | deletefilename      |
      | b9bc9da5b7cc43ee8239443db5c4a939 | 70cacdceba9e42669567ba0f62ad1994 | brittny.kuhnbf | addChildPostExternalStage.json | deleteChildINT.json |
    @int
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | filename                     | deletefilename      |
      | 87704719ec5a4dba9109292a51a0b2a3 | 7edb26b99c974220be94943c8bf20975 | rickie.bernier | addChildPostExternalINT.json | deleteChildINT.json |


  Scenario Outline: CHILDMONIORING-EXTERNAL[2] - FETCH ALL CHILD DETAILS - ROUTE "/api/childmonitoring/children"
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

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


    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/children endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200



    @stg
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        |
      | b9bc9da5b7cc43ee8239443db5c4a939 | 70cacdceba9e42669567ba0f62ad1994 | brittny.kuhnbf |
    @int
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        |
      | 87704719ec5a4dba9109292a51a0b2a3 | 7edb26b99c974220be94943c8bf20975 | rickie.bernier |

  Scenario Outline: CHILDMONIORING-EXTERNAL[3] - FETCH CHILD DETAILS- ROUTE  "/api/childmonitoring/child_info/{childSubscriptionId} by childSubscriptionId
       # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report
    Given save the value of <childSubscriptionId> as childSubscriptionId

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

    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child_info/{childSubscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | childSubscriptionId              |
      | b9bc9da5b7cc43ee8239443db5c4a939 | 70cacdceba9e42669567ba0f62ad1994 | brittny.kuhnbf | a2a3d59c5aec491b8b8da5a34cda3df7 |
    @int
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | childSubscriptionId              |
      | 87704719ec5a4dba9109292a51a0b2a3 | 7edb26b99c974220be94943c8bf20975 | rickie.bernier | 0e890cbc738e42a29c21fb1fc4605191 |

  Scenario Outline: CHILDMONIORING-EXTERNAL[4] - DELETE CHILD - ROUTE "/api/childmonitoring/child/archive"
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

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


    #ADD CHILD to REMOVE - PRECONDITION
    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<filename> replacing values:
      | firstName | firstName-customAlpha |
      | ssn       | 9digit-ssn            |

    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    And I save the value of attribute childSubscriptionId as childSubscriptionId

    #DELETE CHILD
    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/child/archive endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/<deletefilename> replacing values:
      | firstName           | firstName-customAlpha       |
      | ssn                 | 9digit-ssn                  |
      | childSubscriptionId | session_childSubscriptionId |

    And I send the POST request with response type ByteArray
    Then The response status code should be 200


    @stg
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | filename                       | deletefilename      |
      | 896416c0c34748218aacf36ba3ec110e | 61c2a579e22341d4a4030bf87fe0456a | wilburn.lehner | addChildPostExternalStage.json | deleteChildINT.json |

    @int
    Examples:
      | customerId                       | subscriptionId                   | USER_ID        | filename                     | deletefilename      |
      | 87704719ec5a4dba9109292a51a0b2a3 | 7edb26b99c974220be94943c8bf20975 | rickie.bernier | addChildPostExternalINT.json | deleteChildINT.json |

  Scenario Outline: CHILDMONIORING-EXTERNAL[5] - CHILD SCAN - ROUTE "/api/childmonitoring/childscan/children"
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

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


    Given I create a new external experian childMonitoring service request to the /api/childmonitoring/childscan/children endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


    #@stg
    @ignore
    Examples:
      | customerId | subscriptionId | USER_ID | filename |
      |            |                |         |          |
    #@int
    @ignore
    Examples:
      | customerId | subscriptionId | USER_ID | filename |
      |            |                |         |          |