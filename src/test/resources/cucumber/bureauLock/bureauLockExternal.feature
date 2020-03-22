@api @bureauLockExternal @endeavour
Feature:Endeavour: BUREAULOCK  - EXTERNAL Route


  Scenario Outline: BUREAULOCK-EXTERNAL[1] - LOCK CREDIT FILE - ROUTE "api/bureaulock/consumercredit/v1/locks" - METHOD : POST
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #POST TEST CONDITION - UNLOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | OK |

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
     #| f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |

  Scenario Outline: BUREAULOCK-EXTERNAL[2] - LOCK CREDIT FILE - ROUTE "api/bureaulock/consumercredit/v1/locks" METHOD : PUT
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #PRE TEST CONDITION
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #UNLOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | OK |

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |

  Scenario Outline: BUREAULOCK-EXTERNAL[3] - SCHEDULE LOCK THE CREDIT FILE - ROUTE "/api/bureaulock/schedule" METHOD : POST
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #SCHEDULE LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/bureauLock/scheduledLock.json replacing values:
      | username | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success   | true |

   # POST TEST CONDITION CANCEL THE SCHEDULED LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-EXTERNAL[4] - SCHEDULE LOCK STATUS OF THE CREDIT FILE - ROUTE "/api/bureaulock/schedule" METHOD : GET
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken


    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    #And make sure following attributes exist within response data with correct values
    #  | Atributes    | Value   |
    #  | success   | true |


    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |

  Scenario Outline: BUREAULOCK-EXTERNAL[5] - GET LOCK STATUS OF THE CREDIT FILE - ROUTE "api/bureaulock/consumercredit/v1/locks" - METHOD : GET
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    # Get status
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | OK |

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
     #| f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-EXTERNAL[6] - CANCEL SCHEDULE LOCK - ROUTE "/api/bureaulock/schedule" METHOD : DELETE
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #PRE - TEST CONDITION SCHEDULE LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/bureauLock/scheduledLock.json replacing values:
      | username | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success   | true |

   #CANCEL THE SCHEDULED LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-EXTERNAL[7] - SCHEDULE LOCK - ROUTE "/api/bureaulock/schedule" METHOD : POST
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #SCHEDULE LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/bureauLock/scheduledLock.json replacing values:
      | username | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success       | true |
      | requestType   | L |

   #POST TEST CONDITION - CANCEL THE SCHEDULED LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |

   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-EXTERNAL[8] - SCHEDULE UNLOCK - ROUTE "/api/bureaulock/schedule" METHOD : POST
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken

    #LOCK THE CREDIT LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #GET LOCK STATUS
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | OK |

    #SCHEDULE UN LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/bureauLock/scheduledUnlock.json replacing values:
      | username | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success       | true |
      | requestType   | U |

   #CANCEL THE SCHEDULED LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/schedule endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200

    #UNLOCK the credit file
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | OK |

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |

   # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-EXTERNAL[9] - LOCK twice - ROUTE "/api/bureaulock/consumercredit/v1/locks" METHOD : POST
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
      | x-fn         | OFF              |
    And I add a jsonContent to the request body using file /json_objects/childMonitoring/secureToken.json replacing values:
      | username | session_USER_ID |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute token.accessToken as secureToken


    #LOCK THE CREDIT LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

     #LOCK TWICE THE CREDIT LOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 403

    #UNLOCK
    Given I create a new external experian BureauLock service request to the /api/bureaulock/consumercredit/v1/locks endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200


    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |

     # @stg
    #Examples:
    #  | customerId                       | subscriptionId                   | USER_ID        |
    #  | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |
