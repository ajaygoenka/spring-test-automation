@api @endeavour @ITPInternal
Feature:Endeavour: ITP service- INTERNAL ROUTES

  @ITPPostInternal
  Scenario Outline: ITP-INTERNAL[1] - POST subscription details through ITP service- ROUTE "internal/itp/protection/{subscriptionId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/protection/{subscriptionId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/itp/postBody.json replacing values:
      | subscriberNumber | session_subscriptionId |
      | parentId         | session_customerId     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | stg | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | 897e17beaaeb4b87b4178edf1f9bd3a2 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d |

  @ITPGetInternal
  Scenario Outline: ITP-INTERNAL[2] - GET subscription details through ITP service- ROUTE "internal/itp/protection/{subscriptionId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/protection/{subscriptionId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | stg | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | 897e17beaaeb4b87b4178edf1f9bd3a2 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d |


  @ITPGetInternalSexOffenderV1
  Scenario Outline: ITP-INTERNAL[3] - GET SEX OFFENDER details through ITP service- ROUTE "/internal/itp/sexoffenders/v1/{subscriptionId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/sexoffenders/v1/{subscriptionId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | stg | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d |

  @ITPGetInternalSexOffender
  Scenario Outline: ITP-INTERNAL[4] - GET SEX OFFENDER details through ITP service- ROUTE "/internal/itp/sexoffenders/{subscriptionId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/sexoffenders/{subscriptionId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | stg | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d |

  @ITPGetInternalChildDetails
  Scenario Outline: ITP-INTERNAL[5] - GET SEX OFFENDER details through ITP service- ROUTE "internal/itp/childmonitoring/v1/{customerId}/child/{subscriptionId}/{childId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <childId> as childId
    And I embed the Scenario Session value of type childId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/childmonitoring/v1/{customerId}/child/{subscriptionId}/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | stg | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 | 5b93387171794cceabaddfe5210794c9 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d | d975a854e4284e27b3fccda361679328 |

  @ITPPostInternalChildupdate
  Scenario Outline:  ITP-INTERNAL[6] - POST CHILD subscription details through ITP service- ROUTE "internal/itp/childmonitoring/v1/{customerId}/child/{subscriptionId}/{childId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <childId> as childId
    And I embed the Scenario Session value of type childId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/childmonitoring/v1/{customerId}/child/{subscriptionId}/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I add a jsonContent to the request body using file /json_objects/itp/postBody.json replacing values:
      | subscriberNumber | session_childId    |
      | parentId         | session_customerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | stg | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 | 5b93387171794cceabaddfe5210794c9 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d | d975a854e4284e27b3fccda361679328 |

  @ITPGetInternalAlertreport
  Scenario Outline: ITP-INTERNAL[7] - GET SEX OFFENDER details through ITP service- ROUTE "internal/itp/childmonitoring/v1/child/alertsreports/{childId}" by Subscription Id
    # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <childId> as childId
    And I embed the Scenario Session value of type childId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/childmonitoring/v1/child/alertsreports/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @stg
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | stg | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 | 5b93387171794cceabaddfe5210794c9 |

    @int
    Examples:
      | ENV | subscriptionId                       | customerId                       | childId                          |
      | int | 463fc346-eed9-48c5-ac45-37f3252bcf0e | ffab20a79f414d47a7482f7802c5dc8d | d975a854e4284e27b3fccda361679328 |


  @ITPGetInternalAlert @deprecated
  Scenario Outline: ITP-INTERNAL[8] - GET SEX OFFENDER details through ITP service- ROUTE "internal/itp/childalertdetail/v1/SSNTrace/{customerId}/{alertId}/{parentId}/{childId}" by CUSTOMER Id
    # for given Below Data
    Given save the value of <parentId> as parentId
    And I embed the Scenario Session value of type parentId in report
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <childId> as childId
    And I embed the Scenario Session value of type childId in report
    Given save the value of <alertId> as alertId
    And I embed the Scenario Session value of type alertId in report

    # Internal GET call for ITP
    Given I create a new internal experian ITP service request to the /internal/itp/childalertdetail/v1/SSNTrace/{customerId}/{alertId}/{parentId}/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


    @int @ignore
    Examples:
      | parentId                             | customerId                       | childId                          | alertId |
      | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | 897e17beaaeb4b87b4178edf1f9bd3a2 | ea769329c4794395a5051b403cebec43 | 8967200 |

    @stg @ignore
    Examples:
      | parentId                             | customerId                       | childId                          | alertId |
      | 06667572-8281-4818-80f4-1a62574bfffe | 90a962115e124da9b9a92b98f63c56d5 | 5b93387171794cceabaddfe5210794c9 |         |


  @ITPGetInternalCYBERAgentAlert
  Scenario Outline: ITP-INTERNAL[9] - GET CYBER AGENT ALERTS from CSID through ITP service- ROUTE "/itp/childalertdetail/v1/CyberAgent/{alertId}/{parentId}/{childId}"
   # for given Below Data
    Given save the value of <subscriptionId> as parentId
    Given save the value of <childId> as childId
    Given save the value of <userId> as userId
    Given save the value of <alertId> as alertId
    Given save the value of <customerId> as customerId



    #Get cyber agent alert from CSID
    Given I create a new internal experian ITP service request to the /internal/itp/childalertdetail/v1/CyberAgent/{alertId}/{parentId}/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value      |
      | serviceName | CyberAgent |

    @int @ignore
    Examples:
      | subscriptionId                       | childId                          | alertId | customerId                       | userId |
      | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | ea769329c4794395a5051b403cebec43 | 8967197 | 897e17beaaeb4b87b4178edf1f9bd3a2 | jim.steuber |

    #@stg @ignore
    #Examples:
    #  | parentId                             | childId                          | alertId |
     # | 06667572-8281-4818-80f4-1a62574bfffe | 5b93387171794cceabaddfe5210794c9 |         |

  @ITPGetInternalSocailMediaAlert
  Scenario Outline: ITP-INTERNAL[10] - GET CYBER AGENT ALERTS from CSID through ITP service- ROUTE "/socialmediareport/{alertId}/{subscriptionId}"
   # for given Below Data
    Given save the value of <subscriptionId> as subscriptionId
    Given save the value of <alertId> as alertId

    #Get Social Media alert from CSID for Adult
    Given I create a new internal experian ITP service request to the /internal/itp/socialmediareport/{alertId}/{subscriptionId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value      |
      | serviceName | CyberAgent |

    @int @ignore
    Examples:
      | subscriptionId                       | childId                          | alertId |
      | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | c49e7e2db2f7417a9ef5e8d1a40ae033 | 9230627 |

    @stg @ignore
    Examples:
      | parentId                             | childId                          | alertId |
      | 06667572-8281-4818-80f4-1a62574bfffe | 5b93387171794cceabaddfe5210794c9 |         |

  @ITPGetInternalChildSocialMediaReport
  Scenario Outline: ITP-INTERNAL[11] - GET CYBER AGENT ALERTS from CSID through ITP service- ROUTE "/socialmediareport/{alertId}/{parentId}/{childId}"
   # for given Below Data
    Given save the value of <subscriptionId> as parentId
    Given save the value of <childId> as childId
    Given save the value of <alertId> as alertId


    #Get cyber agent alert from CSID
    Given I create a new internal experian ITP service request to the /intenal/itp/socialmediareport/{alertId}/{parentId}/{childId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
     #Verification
    And make sure following attributes exist within response data with correct values
      | Atributes   | Value      |
      | serviceName | CyberAgent |

    @int @ignore
    Examples:
      | subscriptionId                       | childId                          | alertId |
      | 5a246f23-f176-4ab5-ae1d-6f39b6686728 | c49e7e2db2f7417a9ef5e8d1a40ae033 | 9230627 |

    @stg @ignore
    Examples:
      | parentId                             | childId                          | alertId |
      | 06667572-8281-4818-80f4-1a62574bfffe | 5b93387171794cceabaddfe5210794c9 |         |

