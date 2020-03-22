@stg  @endeavour
Feature:Endeavour: ITP service- EXTERNAL ROUTE

  @stg
  Scenario: ITP-EXTERNAL[1] - CREATE SUBSCRIPTION in CSID through ITP service- ROUTE "api/itp/protection/{subscriptionId}" in STAGE
    Given save the value of 07e0b428-deb1-4009-9a77-5c098385ce77 as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 82956d5093d444c7975e95bfaa1b991d as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of asa.jacobson as userId

    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[2] - GET SUBSCRIPTION from CSID through ITP service- ROUTE "api/itp/protection/{subscriptionId}" in STAGE
     # for given Below Data
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report

     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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
      | Cyber Data.dob | 19510101 |

  @stg
  Scenario: ITP-EXTERNAL[3] - GET COURT V1 ALERTS from CSID through ITP service- ROUTE "api/itp/alertdetail/v1/CourtRecords/{alertId}/{subscriptionId}" in STAGE
     # for given Below Data
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8971434 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[4] - GET COURT ALERTS from CSID through ITP service- ROUTE "api/itp/alertdetail/CourtRecords/{alertId}/{subscriptionId}" in STAGE
    # for given Below Data
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8971434 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[5] - GET SEX OFFENDER V1 ALERTS from CSID through ITP service- ROUTE "/api/itp/alertdetail/v1/SexOffender/{alertId}/{subscriptionId}" in STAGE
     # for given Below Data
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8971429 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[6] - GET SEX OFFENDER ALERTS from CSID through ITP service- ROUTE "/api/itp/alertdetail/SexOffender/{alertId}/{subscriptionId}" in STAGE
     # for given Below Data
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 8971429 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[7] - GET CYBER AGENT ALERTS from CSID through ITP service- ROUTE "api/itp/childalertdetail/v1/CyberAgent/{alertId}/{subscriptionId}/{childSubId}" in STAGE
   # for given Below Data

    Given save the value of 5b93387171794cceabaddfe5210794c9 as childSubId
    And I embed the Scenario Session value of type childSubId in report
    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report

    Given save the value of 8992653 as alertId
    And I embed the Scenario Session value of type alertId in report


     # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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

  @stg
  Scenario: ITP-EXTERNAL[8] - GET SSNTRACE ALERTS from CSID through ITP service- ROUTE "/api/itp/childalertdetail/v1/SSNTRACE/{alertId}/{subscriptionId}/{childSubId}" in STAGE
  # for given Below Data

    Given save the value of 06667572-8281-4818-80f4-1a62574bfffe as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of 90a962115e124da9b9a92b98f63c56d5 as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of oda.daugherty as userId
    And I embed the Scenario Session value of type userId in report
    Given save the value of 5b93387171794cceabaddfe5210794c9 as childSubId
    Given save the value of 8992654 as alertId
    And I embed the Scenario Session value of type alertId in report

  # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | OFF |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_real_username |
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
