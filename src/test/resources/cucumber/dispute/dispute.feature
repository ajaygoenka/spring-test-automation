@api @endeavour @dispute

Feature:Endeavour: Validate Dispute Journey

  @SDS01
  Scenario: View and access dispute center online for free offer customers for a specific account
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
    # Validate the Health of dispute
    Given I create a new external experian dispute service request to the /api/dispute/health endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value |
      | status    | UP    |
    # Validate the consents of dispute
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/consents endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Accept Global Terms for Dispute
    Given I create a new external experian globalterms service request to the /api/globalterms/customer/termacceptance endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    # Post call for consents
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/consents endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/dispute/empty.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdfsId
    And I embed the Scenario Session value of type cdfsId in report
    And make sure following attributes exist within response data with correct values
      | Atributes | Value   |
      | id        | notnull |
  # Start a new Dispute
    Given I create a new external experian dispute service request to the /api/dispute/cdfs endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #Get the information of cdis
    Given I create a new external experian dispute service request to the /api/dispute/cdis endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdisId
    And I embed the Scenario Session value of type cdisId in report
    And I save the value of attribute positiveTradeRecords[0].auxData.objectId as objectId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | date         | notnull |
      | isDisputable | true    |
    # Dispute on account
    Given I create a new external experian dispute service request to the /api/dispute/disputes/{cdisId}/descriptors endpoint
    And I add the following headers to the request
      | x-objectID | session_objectId |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | isDisputable | notnull |
      | underDispute | notnull |
    # Validate Personal Statemetns
    Given I create a new external experian dispute service request to the /api/dispute/cdis/{cdisId}/statementOptions/009 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @SDS02 @onlyint @ignore
  Scenario: View report for a specific account for closed dispute
    Given save the value of pauline_pidfn as userName
    # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken
    # Validate the Health of dispute
    Given I create a new external experian dispute service request to the /api/dispute/health endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value |
      | status    | UP    |
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/consents endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdfsId
    And I embed the Scenario Session value of type cdfsId in report
    And make sure following attributes exist within response data with correct values
      | Atributes | Value   |
      | id        | notnull |
      #Get the information of cdis
    Given I create a new external experian dispute service request to the /api/dispute/cdis endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdisId
    And I embed the Scenario Session value of type cdisId in report
    # Get all completed disputes
    Given I create a new external experian dispute service request to the /api/dispute/cdfs endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].alertId as alertId
    And I embed the Scenario Session value of type alertId in report
    And make sure following attributes exist within response data with correct values
      | Atributes         | Value   |
      | result[0].alertId | notnull |
     #Get the information of alertId
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/{alertId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value   |
      | alertId        | notnull |
      | cdfDateCreated | notnull |
      | cdfId          | notnull |
      | reportNumber   | notnull |
    # Validate Personal Statemetns
    Given I create a new external experian dispute service request to the /api/dispute/cdis/{cdisId}/statementOptions/009 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @SDS03
  Scenario: Validate the GET call for health of dispute
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
    # Validate the Health of dispute
    Given I create a new external experian dispute service request to the /api/dispute/health endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value |
      | status    | UP    |

  @SDS04
  Scenario: Validate the GET call for consents of dispute
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
    # Validate the consents of dispute
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/consents endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @SDS05
  Scenario: Validate the POST call for consents of dispute
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
    # Post call for consents
    Given I create a new external experian dispute service request to the /api/dispute/cdfs/consents endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/dispute/empty.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdfsId
    And I embed the Scenario Session value of type cdfsId in report
    And make sure following attributes exist within response data with correct values
      | Atributes | Value   |
      | id        | notnull |

  @SDS06
  Scenario: Validate the GET call for cdfs in dispute
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
    Given I create a new external experian dispute service request to the /api/dispute/cdfs endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @SDS07
  Scenario: Validate the GET call for cdis in dispute
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
   #Get the information of cdis
    Given I create a new external experian dispute service request to the /api/dispute/cdis endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdisId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | date         | notnull |
      | isDisputable | true    |

  @SDS08
  Scenario: Validate the GET call for descriptors in dispute
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
    #Get the information of cdis
    Given I create a new external experian dispute service request to the /api/dispute/cdis endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdisId
    And I embed the Scenario Session value of type cdisId in report
    And I save the value of attribute positiveTradeRecords[0].auxData.objectId as objectId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | date         | notnull |
      | isDisputable | true    |
    # Dispute on account
    Given I create a new external experian dispute service request to the /api/dispute/disputes/{cdisId}/descriptors endpoint
    And I add the following headers to the request
      | x-objectID | session_objectId |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | isDisputable | notnull |
      | underDispute | notnull |

  @SDS09
  Scenario: Validate the GET call for Personal Statemetns in dispute
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
      #Get the information of cdis
    Given I create a new external experian dispute service request to the /api/dispute/cdis endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as cdisId
    And I embed the Scenario Session value of type cdisId in report
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | date         | notnull |
      | isDisputable | true    |
    # Validate Personal Statemetns
    Given I create a new external experian dispute service request to the /api/dispute/cdis/{cdisId}/statementOptions/009 endpoint
    And I embed the Scenario Session value of type cdisId in report
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
