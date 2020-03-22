@crmodataExternal @endeavour @api
Feature:Endeavour: CRMO DATA  - EXTERNAL Routes

  Scenario Outline: CRMO DATA-EXTERNAL[1] - GET ODATA ROOT - ROUTE "/api/crmodata/corvette.svc/$metadata" - METHOD: GET
        # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/$metadata endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token |
    And I send the GET request with response type XML
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 825d01c100784780b9cefd470136e9f6 | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |


  Scenario Outline: CRMO DATA-EXTERNAL[2] - GET LOGIN HISTORIES - ROUTE "/api/crmodata/corvette.svc/LoginHistories?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type
    Given save the value of <customerId> as customerId


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/LoginHistories?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 56b3e5c3f9804238a85d874b78ce465b | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[3] - GET REPORT HISTORIES - ROUTE "/api/crmodata/corvette.svc/ReportHistories?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/ReportHistories?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 203918da741c4ec5803303892371990f | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[4] - GET BILLING SOURCES - ROUTE "/api/crmodata/corvette.svc/BillingSources?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/BillingSources?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 203918da741c4ec5803303892371990f | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[5] - GET BILLING HISTORY EVENTS - ROUTE "/api/crmodata/corvette.svc/BillingHistoryEvents?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/BillingHistoryEvents?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 203918da741c4ec5803303892371990f | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[6] - GET CREDIT ALERTS - ROUTE "/api/crmodata/corvette.svc/CreditAlerts?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/CreditAlerts?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 54427c67371c44c8a125b5434f7eae6a | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[7] - GET CUSTOMER PROFILE HISTORY - ROUTE "/api/crmodata/corvette.svc/CustomerProfileHistories?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/CustomerProfileHistories?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 54427c67371c44c8a125b5434f7eae6a | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |


  Scenario Outline: CRMO DATA-EXTERNAL[8] - GET IDENTITY ALERTS - ROUTE "/api/crmodata/corvette.svc/IdentityAlerts?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/IdentityAlerts?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 897e17beaaeb4b87b4178edf1f9bd3a2 | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[9] - GET MBG SUBSCRIPTIONS - ROUTE "/api/crmodata/corvette.svc/MBGSubscriptions?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/MBGSubscriptions?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 825d01c100784780b9cefd470136e9f6 | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[10] - GET SUBSCRIPTIONS - ROUTE "/api/crmodata/corvette.svc/Subscriptions?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/Subscriptions?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 897e17beaaeb4b87b4178edf1f9bd3a2 | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |

  Scenario Outline: CRMO DATA-EXTERNAL[11] - GET LOCK UNLOCK SCHEDULED HISTORIES - ROUTE "/api/crmodata/corvette.svc/LockUnlockScheduleHistories?%24top=51&%24filter=customerId%20eq%20%{customerId}" - METHOD: GET
    # for given Below Data
    Given save the value of <client_id> as client_id
    Given save the value of <customerId> as client_secret
    Given save the value of Bearer as token_type


    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type     | client_credentials |
      | scope          | crm                |
      | client_id      | <client_id>        |
      | client_secret  | <customerId>       |
    And I send the POST request with response type String
    Then The response status code should be 200

    # SAVE secure token
    And I save the value of attribute access_token as access_token

    Given I create a new external experian crmodata service request to the /api/crmodata/corvette.svc/LockUnlockScheduleHistories?%24top=51&%24filter=customerId%20eq%20%27<customerId>%27 endpoint
    And I add the following headers to the request without default parameters
      | Authorization | auth_token      |
      | Content-Type | application/json |
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       | client_id                        |
      | 43ced99dcbe04b4382503e55d9a4dffa | 309b53eda4cb46ab89b2b10dbee5a06a |
    #@stg
    #Examples:
    #  | customerId                       |
    #  | 87704719ec5a4dba9109292a51a0b2a3 |