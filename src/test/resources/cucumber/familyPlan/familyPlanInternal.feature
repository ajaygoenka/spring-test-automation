@familyplanInternal @endeavour @api
Feature:Endeavour: FAMILY PLAN  - INTERNAL Routes

  Scenario Outline: FAMILY PLAN [1] - GET FAMILY SECONDARY MEMBER by familymembershipId - /internal/familyplan/v1/member/{{familymembershipId}} METHOD: GET
    # for given Below Data
    Given save the value of <USER_ID> as USER_ID
    Given save the value of <customerId> as customerId

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

     # PRE CONDITION - ADD FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId

    #GET FAMILY MEMBER DETAILS - INTERNAL ROUTE
    Given I create a new internal experian familyplan service request to the /familyplan/v1/member/{familyMemberId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | pending     |
      | firstName | notnull     |
      | lastName  | MYLANDER    |
      | email     | notnull     |
      | familyMemberId          |   session_familyMemberId   |
      | customerId              |   notnull                  |
      | subscriptionHistoryId   |   notnull                  |

#GET FAMILY MEMBER DETAILS - INTERNAL ROUTE
    Given I create a new internal experian familyplan service request to the /familyplan/v1/customer/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | pending     |
      | firstName | notnull     |
      | lastName  | MYLANDER    |
      | email     | notnull     |
      | familyMemberId          |   notnull  |
      | customerId              |   notnull  |
      | subscriptionHistoryId   |   notnull  |

 #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId


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

    #POST CONDITION to clean up the data -REMOVE FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/remove endpoint
    And I add the following headers to the request
      |Content-Type | application/json |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/removemember.json replacing values:
      | familyMemberId | session_familyMemberId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | USER_ID        | customerId                       |
      | familyplanAuto | 9b6dc6bc86644b5d803d01b94aeee962 |
    #@stage
    #Examples:
     # | USER_ID             |
     # | familyplanstageauto |



  Scenario Outline: FAMILY PLAN [2] - GET FAMILY SECONDARY MEMBER by customer Id - /familyplan/v1/customer/{customerId} METHOD: GET
    # for given Below Data
    Given save the value of <USER_ID> as USER_ID
    Given save the value of <customerId> as customerId

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

     # PRE CONDITION - ADD FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId


    #GET FAMILY MEMBER DETAILS - INTERNAL ROUTE
    Given I create a new internal experian familyplan service request to the /familyplan/v1/customer/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | pending     |
      | firstName | notnull     |
      | lastName  | MYLANDER    |
      | email     | notnull     |
      | familyMemberId          |   notnull  |
      | customerId              |   notnull  |
      | subscriptionHistoryId   |   notnull  |

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId


    #POST CONDITION to clean up the data -REMOVE FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/remove endpoint
    And I add the following headers to the request
      |Content-Type | application/json |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/removemember.json replacing values:
      | familyMemberId | session_familyMemberId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | USER_ID        | customerId                       |
      | familyplanAuto | 9b6dc6bc86644b5d803d01b94aeee962 |
    #@stage
    #Examples:
     # | USER_ID             |
     # | familyplanstageauto |



  Scenario Outline: FAMILY PLAN [3] - UPDATE FAMILY SECONDARY MEMBER - /internal/familyplan/v1/member METHOD: PUT
    # for given Below Data
    Given save the value of <USER_ID> as USER_ID
    Given save the value of <customerId> as customerId
    Given save the value of <secondaryCustomerId> as secondaryCustomerId
    Given save the value of <familyMemberId> as familyMemberId

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


     # UPDATE FAMILY MEMBER
    Given I create a new internal experian familyplan service request to the /familyplan/v1/member endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/updatemember.json replacing values:
      | familyMemberId | session_familyMemberId |
      | secondaryCustomerId | session_secondaryCustomerId |
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | USER_ID           | secondaryCustomerId             |  familyMemberId                   | customerId                       |
      | familyplanAutotwo | 9905d4cb59604667ba3411c3f286d53b | 92c7abeb7350482a92bd2f45edffb2f8 | 85d94220fc16408aa380531a5685767d |
    #@stage
    #Examples:
     # | USER_ID             |
     # | familyplanstageauto |



  Scenario Outline: FAMILY PLAN [4] - UPDATE FAMILY SECONDARY MEMBER - /internal/familyplan/v1/customer/{customerId}/member  - from sales force METHOD: POST
    # for given Below Data
    Given save the value of <USER_ID> as USER_ID
    Given save the value of <customerId> as customerId

      #ADD FAMILY MEMBER
    Given I create a new internal experian familyplan service request to the /familyplan/v1/customer/{customerId}/member endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId


    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

   #POST CONDITION to clean up the data -REMOVE FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/remove endpoint
    And I add the following headers to the request
      |Content-Type | application/json |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/removemember.json replacing values:
      | familyMemberId | session_familyMemberId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200




    @int
    Examples:
      | USER_ID        | customerId                       |
      | familyplanAuto | 9b6dc6bc86644b5d803d01b94aeee962 |


    #@stage
    #Examples:
     # | USER_ID             |
     # | familyplanstageauto |




  @ignore @fpcleanup
  Scenario Outline: FAMILY PLAN - CLEAN UP
    # for given Below Data
    Given save the value of <USER_ID> as USER_ID
    Given save the value of <customerId> as customerId

    #GET FAMILY MEMBER DETAILS - INTERNAL ROUTE
    Given I create a new internal experian familyplan service request to the /familyplan/v1/customer/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | pending     |
      | firstName | notnull     |
      | lastName  | MYLANDER    |
      | email     | notnull     |
      | familyMemberId          |   notnull  |
      | customerId              |   notnull  |
      | subscriptionHistoryId   |   notnull  |

 #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId


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

    #POST CONDITION to clean up the data -REMOVE FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/remove endpoint
    And I add the following headers to the request
      |Content-Type | application/json |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/removemember.json replacing values:
      | familyMemberId | session_familyMemberId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | USER_ID        | customerId                       |
      | familyplanAuto | 9b6dc6bc86644b5d803d01b94aeee962 |
    #@stage
    #Examples:
     # | USER_ID             |
     # | familyplanstageauto |
