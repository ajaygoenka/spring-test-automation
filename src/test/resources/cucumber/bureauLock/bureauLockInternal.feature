@api @endeavour @bureauLockInternal
Feature:Endeavour: BUREAULOCK  - INTERNAL Routes


  Scenario Outline: BUREAULOCK-INTERNAL[1] - LOCK CREDIT FILE - ROUTE "internal/bureaulock/consumercredit/v1/locks/{customerId}" - METHOD : POST
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    #LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #POST TEST to UNLOCK
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
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
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |

  Scenario Outline: BUREAULOCK-INTERNAL[2] - UNLOCK CREDIT FILE - ROUTE "internal/bureaulock/consumercredit/v1/locks/{customerId}" - METHOD : PUT
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    # PRE-CONDITION  TO LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #UNLOCK THE CREDIT FILE
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
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
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[3] - GET THE LOCK STATUS OF THE CREDIT FILE - ROUTE "internal/bureaulock/consumercredit/v1/locks/{customerId}" - METHOD : GET
    # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    # GET THE CREDIT FILE LOCK UNLOCK STATUS
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
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
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[4] - GET SCHEDULE LOCK STATUS - ROUTE "/internal/bureaulock/schedule/{customerId}" - METHOD : GET
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    #GET THE SCHEDULED LOCK STATUS
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[5] - GET SCHEDULE LOCK HISTORY - ROUTE "/internal/bureaulock/schedule/{customerId}/history" - METHOD : GET
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    #GET THE SCHEDULED LOCK HISTORY
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId}/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[6] - SCHEDULE LOCK - ROUTE "/internal/bureaulock/schedule/{customerId}" - METHOD : POST
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    #LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/bureauLock/internalscheduledLock.json replacing values:
      | subscriptionId | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success   | true |

    #POST CONDITION to canel the scehdule lock
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | status       | CANCELLED |



    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[7] - CANCEL SCHEDULE LOCK - ROUTE "/internal/bureaulock/schedule/{customerId}" - METHOD : DELETE
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    # PRE - CONDITION LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/bureauLock/internalscheduledLock.json replacing values:
      | subscriptionId | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success   | true |

    #CANCEL THE SCHEDULED LOCK by Customer id
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the DELETE request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | status       | CANCELLED |



    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[8] - CANCEL SCHEDULE LOCK FROM SALES FORCE - ROUTE "/internal/bureaulock/schedule/{customerId}" - METHOD : PUT
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    # PRE - CONDITION LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/bureauLock/internalscheduledLock.json replacing values:
      | subscriptionId | session_subscriptionId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | success   | true |

    #CANCEL THE SCHEDULED LOCK by Customer id from SALES FORCE
    Given I create a new internal experian BureauLock service request to the /bureaulock/schedule/{customerId} endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    Given I add a json request body using the file /json_objects/bureauLock/cancelScheduledLock.json
    And I send the PUT request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | status       | CANCELLED |
      |cancelReason  | MEMBERSHIP_CHANGE|



    @int
    Examples:
      | customerId                       | subscriptionId                       | USER_ID            |
      | a6ece4c7ad67457dba03a9c978f8dca0 | 7e3ced00-b704-47b6-a58f-8b01ad475345 | int_aru_lockunlock |
    #@stg
    #Examples:
    # | customerId                       | subscriptionId                   | USER_ID        |
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |


  Scenario Outline: BUREAULOCK-INTERNAL[9] - LOCK CREDIT FILE - ROUTE "internal/bureaulock/consumercredit/v1/locks/{customerId}/prucn" - METHOD : PUT
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report
    Given save the value of <USER_ID> as USER_ID
    And I embed the Scenario Session value of type USER_ID in report

    #PRE - CONDITION - TO LOCK the CREDIT FILE BY CUSTOMER ID
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the POST request with response type ByteArray
    Then The response status code should be 201
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | statusText   | Created |

    #UNLOCK THE CREDIT FILE
    Given I create a new internal experian BureauLock service request to the /bureaulock/consumercredit/v1/locks/{customerId}/prucn endpoint
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
    # | f3ca2c49b25c4157937635bbec0eb8f9 | bd1fc095-c762-4426-91fc-d46d2d9cab13 | aut.phillip.logothetis.200129175013 |