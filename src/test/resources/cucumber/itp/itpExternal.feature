@int @api @endeavour @ITPexternal
Feature:Endeavour: ITP service- EXTERNAL ROUTE

  @ITPPostExternal
  Scenario: ITP-EXTERNAL- CREATE SUBSCRIPTION in CSID through ITP service- ROUTE "api/itp/protection/{subscriptionId}"

    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report

    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | ssession_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Create POST call for ITP
    Given I create a new external experian ITP service request to the /api/itp/protection/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/itp/postBody.json replacing values:
      | subscriberNumber | session_subscriptionId |
      | parentId         | session_customerId     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value    |
      | Cyber Data.dob | 19320101 |


  @ITPGetExternal
  Scenario: ITP-EXTERNAL[2] - GET SUBSCRIPTION from CSID through ITP service- ROUTE "api/itp/protection/{subscriptionId}"
     # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report

     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Create GET call for ITP
    Given I create a new external experian ITP service request to the /api/itp/protection/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

      #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value    |
      | Cyber Data.dob | 19320101 |

  @ITPGetExternalCourtAlertV1
  Scenario: ITP-EXTERNAL[3] - GET COURT V1 ALERTS from CSID through ITP service- ROUTE "api/itp/alertdetail/v1/CourtRecords/{alertId}/{subscriptionId}"
     # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8965192 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | ssession_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Get Call for court records from CSID
    Given I create a new external experian ITP service request to the /api/itp/alertdetail/v1/CourtRecords/{alertId}/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
      #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value        |
      | serviceName | CourtRecords |

  @ITPGetExternalCourtAlert
  Scenario: ITP-EXTERNAL[4] - GET COURT ALERTS from CSID through ITP service- ROUTE "api/itp/alertdetail/CourtRecords/{alertId}/{subscriptionId}"
    # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8965192 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #Get court records
    Given I create a new external experian ITP service request to the /api/itp/alertdetail/CourtRecords/{alertId}/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value                         |
      | ProductSubject | Court Records Alert from CSID |

  @ITPGetExternalSexOffenderAlertV1
  Scenario: ITP-EXTERNAL[5] - GET SEX OFFENDER V1 ALERTS from CSID through ITP service- ROUTE "/api/itp/alertdetail/v1/SexOffender/{alertId}/{subscriptionId}"
     # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8965193 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Get SEX OFFENDER Alert from CSID
    Given I create a new external experian ITP service request to the /api/itp/alertdetail/v1/SexOffender/{alertId}/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value       |
      | serviceName | SexOffender |

  @ITPGetExternalSexOffenderAlert
  Scenario: ITP-EXTERNAL[6] - GET SEX OFFENDER ALERTS from CSID through ITP service- ROUTE "/api/itp/alertdetail/SexOffender/{alertId}/{subscriptionId}"
     # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8965193 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Get SEX OFFENDER Alert from CSID
    Given I create a new external experian ITP service request to the /api/itp/alertdetail/SexOffender/{alertId}/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value                       |
      | ProductSubject | Sex Offender Alert for CSID |


  @ITPGetExternalCYBERAgentAlert
  Scenario: ITP-EXTERNAL[7] - GET CYBER AGENT ALERTS from CSID through ITP service- ROUTE "api/itp/childalertdetail/v1/CyberAgent/{alertId}/{subscriptionId}/{childSubId}"
   # for given Below Data
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of ea769329c4794395a5051b403cebec43 as childSubId
    And I embed the Scenario Session value of type childSubId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8967181 as alertId
    And I embed the Scenario Session value of type alertId in report

     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #Get cyber agent alert from CSID
    Given I create a new external experian ITP service request to the /api/itp/childalertdetail/v1/CyberAgent/{alertId}/{subscriptionId}/{childSubId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value      |
      | serviceName | CyberAgent |


  @ITPGetExternalSSNTRACEAlert
  Scenario: ITP-EXTERNAL[8] - GET SSNTRACE ALERTS from CSID through ITP service- ROUTE "/api/itp/childalertdetail/v1/SSNTRACE/{alertId}/{subscriptionId}/{childSubId}"
  # for given Below Data
    Given save the value of ea769329c4794395a5051b403cebec43 as childSubId
    Given save the value of 5a246f23-f176-4ab5-ae1d-6f39b6686728 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 897e17beaaeb4b87b4178edf1f9bd3a2 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of jim.steuber as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8967200 as alertId
    And I embed the Scenario Session value of type alertId in report
  # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_userId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #Get SSNTRACE alert from CSID
    Given I create a new external experian ITP service request to the /api/itp/childalertdetail/v1/SSNTRACE/{alertId}/{subscriptionId}/{childSubId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value    |
      | serviceName | SSNTrace |
