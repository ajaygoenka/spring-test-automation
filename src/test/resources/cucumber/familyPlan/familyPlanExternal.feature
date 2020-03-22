@familyplanExternal @api @endeavour
Feature:Endeavour: FAMILY PLAN  - EXTERNAL Routes

  Scenario Outline: FAMILY PLAN [1] - ADD SECONDARY ADULT - ROUTE "/api/familyplan/v1/member" METHOD: POST
        # for given Below Data
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

    #ADD FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId

    #Verify for PENDING STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | status    | pending    |

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
      | USER_ID        |
      | familyplanAuto |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |


  Scenario Outline: FAMILY PLAN [2] - REMOVE SECONDARY ADULT when pending status - ROUTE "/api/familyplan/v1/member/remove" METHOD: POST
        # for given Below Data
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

    #Verify for PENDING STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | status    | pending    |

    #REMOVE FAMILY MEMBER

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
      | USER_ID        |
      | familyplanAuto |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |

  Scenario Outline: FAMILY PLAN [3] - GET SECONDARY ADULT details - pending status - ROUTE "/api/familyplan/v1/member" METHOD: GET
        # for given Below Data
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

    #GET MEMBER DETAILS and Verify for PENDING STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | status    | pending    |
      | firstName | notnull    |
      | lastName  | notnull    |
      | email     | notnull    |


    #POST- CONDITION - REMOVE FAMILY MEMBER

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
      | USER_ID        |
      | familyplanAuto |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |

  Scenario Outline: FAMILY PLAN [4] - RESEND EMAIL - ROUTE "/api/familyplan/v1/member/resend" METHOD: POST
        # for given Below Data
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

    #RESEND EMAIL
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/resend endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/removemember.json replacing values:
      | familyMemberId | session_familyMemberId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #POST- CONDITION - REMOVE FAMILY MEMBER
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
      | USER_ID        |
      | familyplanAuto |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |

  Scenario Outline: FAMILY PLAN [5] - OFFER -shopping cart - ROUTE "api/familyplan/v1/member/{familyMemberId}/offer?placementId=shoppingCart" METHOD: GET
        # for given Below Data
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

    #ADD FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId

    #Verify for PENDING STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | status    | pending    |

    # GET OFFER PLACEMENT
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/{familyMemberId}/offer endpoint
    And I add a query parameter placementId with value shoppingCart
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


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
      | USER_ID        |
      | familyplanAuto |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |


  Scenario Outline: FAMILY PLAN [6] - GET SECONDARY ADULT INFORMTION - ROUTE "/api/familyplan/v1/member/secondaryinfo" METHOD: GET
        # for given Below Data
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

    #GET SECONDARY FAMILY MEMBER DETAILS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member/secondaryinfo endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes         | Value                               |
      | familyMemberId    | 92c7abeb7350482a92bd2f45edffb2f8    |


    @int
    Examples:
      | USER_ID        |
      | familyplanAutoAudlttwo |
    @stage
    Examples:
      | USER_ID             |
      | familyplanstageauto |

  Scenario Outline: FAMILY PLAN [7] - GET SECONDARY ADULT details - ACCEPTED STATUS  METHOD: GET
        # for given Below Data
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

    #Verify for ACCEPTED STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | accepted    |
      | firstName | KNECO       |
      | lastName  | BRIGGS      |
      | email     | notnull     |
      |   familyMemberId        |   92c7abeb7350482a92bd2f45edffb2f8          |



    @int
    Examples:
      | USER_ID            |
      | familyplanAutotwo  |

  @acceptStatus
  Scenario:  FAMILY PLAN [8] - ADD SECONDARY ADULT , REGISTER - VERIFY ACCEPTED status
        # for given Below Data
    Given I create a new paid customer using at_eiwpafmbg100 offer tags
    And I save the value of attribute customerId as primarymemberId
    And I save the value of attribute userName as primaryuser
    And I create a new secure token with existing Customer ID and member scope



    #ADD FAMILY MEMBER
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/familyplan/addmember.json replacing values:
      | firstName | firstName-customAlpha |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #SAVE THE family member Id
    And I save the value of attribute familyMemberId as familyMemberId

    #Verify for PENDING STATUS
    Given I create a new external experian familyplan service request to the /api/familyplan/v1/member endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | status    | pending    |

    #Register Family member
    Given I create a new family customer using at_eiwpfs100 offer tags
    And I save the value of attribute customerId as secondarymemberId
    And I save the value of attribute userName as secondaryuser

    #GET FAMILY MEMBER DETAILS - INTERNAL ROUTE
    Given I create a new internal experian familyplan service request to the /familyplan/v1/member/{familyMemberId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | status    | accepted     |
      | firstName | notnull     |
      | lastName  | notnull    |
      | email     | notnull     |
      | familyMemberId          |   session_familyMemberId   |
      | customerId              |   notnull                  |
      | subscriptionHistoryId   |   notnull                  |