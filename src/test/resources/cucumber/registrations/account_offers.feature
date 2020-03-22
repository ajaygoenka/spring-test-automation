@api @registration
Feature:Shield: Create Customer using Offers

  @free
  Scenario Outline: Create Customer using free offers
    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type | client_credentials |
      | scope      | registration       |
      | client_id  | experian           |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken

    # Get call to get offerId by providing offer tags
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter placementId with value shoppingCart
    And I add a query parameter tags with value <offer_tags>
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId
    And I embed the <offer_tags> value of type offer_tags in report as text

    # Post call for OP1 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1account.json replacing values:
      | customer.email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call to get the offerQuoteId
    Given I create a new external experian registration service request to the /api/registration/offerquote endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1offerquote.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId

    # Post call to validate the UserName
    Given I create a new external experian registration service request to the /api/login/username endpoint
    And I remove the Authorization headers to the request
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/registration/postop2username.json replacing values:
      | userName | fake_username |
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value |
      | isUsernameAvailable | true  |

    #Post call for OP2 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop2account.json replacing values:
      | offerQuoteId   | session_offerQuoteId |
      | login.userName | session_userName     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for Question Set
    Given I create a new external experian registration service request to the /api/registration/oowquestions endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3ioQuestion.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute questionSetId as questionSetId

    #Post call for term and conditions
    Given I create a new external experian registration service request to the /api/globalterms/customer/allterms endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postglobalterms.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for OP3 Activations
    Given I create a new external experian registration service request to the /api/registration/activation endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3activation_free.json replacing values:
      | offerQuoteId          | session_offerQuoteId  |
      | answers.questionSetId | session_questionSetId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute token as secureToken
    And I save the value of attribute subscription.id as subscriptionId
    And I save the value of attribute subscription.subscriptionHistoryId as subscriptionHistoryId
    And I save the value of attribute subscription.packageName as packageName


    # Post call for OP4
    Given I create a new external experian registration service request to the /api/registration/op4 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postop4submitsurvey.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I embed the Scenario Session value of type userName in report

    #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report


    # Validate in Customer Login Table
    And make sure following attributes exist within response data with correct values in Customer Login Table
      | Atributes           | Value              |
      | userName            | session_userName   |
      | customerId          | session_customerId |
      | loginStatus         | ACTIVE             |
      | lastPasswordResetDt | notnull            |
      | passSalt            | notnull            |
      | password            | notnull            |
      | pin                 | notnull            |

  # Validate in Customer profile Table
    And make sure following attributes exist within response data with correct values in Customer Profile Table
      | Atributes                 | Value                  |
      | customerId                | session_customerId     |
      | accountId                 | notnull                |
      | accountStatus             | ACTIVE                 |
      | authenticatedDt           | notnull                |
      | authenticatedId           | 50                     |
      | clientId                  | notnull                |
      | createDt                  | notnull                |
      | currentAddress            | notnull                |
      | currentAddressVerifyLevel | notnull                |
      | customerSsnValidated      | notnull                |
      | DOB                       | 1954-01-01             |
      | email                     | session_customer.email |
      | emailOptIn                | false                  |
      | emailValidation           | notnull                |
      | experianPin               | notnull                |
      | firstName                 | PATRICIA               |
      | hashExperianPin           | notnull                |
      | hashLastFourSSN           | notnull                |
      | hashSSN                   | notnull                |
      | lastFourSSN               | notnull                |
      | lastName                  | BABIN                  |
      | orderFunnel               | registration           |
      | pc                        | dir_exp_0              |
      | phone                     | notnull                |
      | SSN                       | notnull                |

     # Validate in Subscription Table
    And make sure following attributes exist within response data with correct values in Subscription Table
      | Atributes             | Value                                            |
      | activationDt          | notnull                                          |
      | benefitIds            | sort-B90,B14,B25,B18,B19,B62,B20,B10,B21,B22,B24 |
      | correlationId         | notnull                                          |
      | createDt              | notnull                                          |
      | customerId            | session_customerId                               |
      | description           | Free Membership                                  |
      | discountApplied       | false                                            |
      | name                  | notnull                                          |
      | offerQuoteId          | session_offerQuoteId                             |
      | packageName           | session_packageName                              |
      | productKey            | <productKey>                                     |
      | showTermsAndCondition | false                                            |
      | status                | A                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                    |
      | subscriptionId        | session_subscriptionId                           |
      | subscriptionTypeId    | ect                                              |
      | termsString           | notnull                                          |

    # Validate in Subscription History Table
    And make sure following attributes exist within response data with correct values in Subscription History Table
      | Atributes             | Value                                       |
      | activatedToday        | false                                       |
      | activationDt          | notnull                                     |
      | benefitIds            | B20,B10,B21,B22,B24,B14,B25,B18,B90,B19,B62 |
      | benefitIdsAdded       | B20,B10,B21,B22,B24,B14,B25,B18,B90,B19,B62 |
      | customerId            | notnull                                     |
      | offerGroupId          | notnull                                     |
      | offerId               | notnull                                     |
      | offerName             | notnull                                     |
      | offerQuoteId          | session_offerQuoteId                        |
      | offerType             | Base                                        |
      | productKey            | <productKey>                                |
      | sessionId             | notnull                                     |
      | sourceSystemId        | ONLINE                                      |
      | status                | ActivationCompleted                         |
      | subscriptionHistoryId | session_subscriptionHistoryId               |
      | subscriptionId        | session_subscriptionId                      |
      | subscriptionTypeId    | ect                                         |

     # Validate in Subscription Benefit  Table
    And make sure following attributes exist within response data with correct values in Subscription Benefit Table
      | Atributes  | Value                                       |
      | benefitId  | B90,B14,B25,B18,B19,B62,B20,B10,B21,B22,B24 |
      | customerId | session_customerId                          |


     # Validate in Enrollment Benefit   Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit Table
      | Atributes  | Value                                              |
      | benefitId  | EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXPOSITIVE,QUESTSM30 |
      | customerId | session_customerId                                 |

     # Validate in Enrollment Benefit History Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit History Table
      | Atributes  | Value                                              |
      | benefitId  | EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXPOSITIVE,QUESTSM30 |
      | customerId | session_customerId                                 |

    Examples:
      | offer_tags  | productKey                                         |
      | at_frsas102 | free_report_score_alerts_eiw_subscription          |
      | at_frsas103 | free_report_score_alerts_eiw_identity_subscription |

  @paidmonthlyplus
  Scenario Outline: Create Customer using Paid monthly plus offers
    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type | client_credentials |
      | scope      | registration       |
      | client_id  | experian           |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken

    # Get call to get offerId by providing offer tags
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter placementId with value shoppingCart
    And I add a query parameter tags with value <offer_tags>
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId

    # Post call for OP1 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1account.json replacing values:
      | customer.email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call to get the offerQuoteId
    Given I create a new external experian registration service request to the /api/registration/offerquote endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1offerquote.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId

    # Post call to validate the UserName
    Given I create a new external experian registration service request to the /api/login/username endpoint
    And I remove the Authorization headers to the request
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/registration/postop2username.json replacing values:
      | userName | fake_username |
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value |
      | isUsernameAvailable | true  |

    #Post call for OP2 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop2account.json replacing values:
      | offerQuoteId   | session_offerQuoteId |
      | login.userName | session_userName     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for Question Set
    Given I create a new external experian registration service request to the /api/registration/oowquestions endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3ioQuestion.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute questionSetId as questionSetId

    #Post call for term and conditions
    Given I create a new external experian registration service request to the /api/globalterms/customer/allterms endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postglobalterms.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for OP3 Activations
    Given I create a new external experian registration service request to the /api/registration/activation endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3activation.json replacing values:
      | offerQuoteId          | session_offerQuoteId  |
      | answers.questionSetId | session_questionSetId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute token as secureToken
    And I save the value of attribute subscription.id as subscriptionId
    And I save the value of attribute subscription.subscriptionHistoryId as subscriptionHistoryId
    And I save the value of attribute subscription.packageName as packageName

    # Post call for OP4
    Given I create a new external experian registration service request to the /api/registration/op4 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postop4submitsurvey.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I embed the Scenario Session value of type userName in report


    #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report

     # Validate in Customer Login Table
    And make sure following attributes exist within response data with correct values in Customer Login Table
      | Atributes           | Value              |
      | userName            | session_userName   |
      | customerId          | session_customerId |
      | loginStatus         | ACTIVE             |
      | lastPasswordResetDt | notnull            |
      | passSalt            | notnull            |
      | password            | notnull            |
      | pin                 | notnull            |

  # Validate in Customer profile Table
    And make sure following attributes exist within response data with correct values in Customer Profile Table
      | Atributes                 | Value                  |
      | customerId                | session_customerId     |
      | accountId                 | notnull                |
      | accountStatus             | ACTIVE                 |
      | authenticatedDt           | notnull                |
      | authenticatedId           | 50                     |
      | clientId                  | notnull                |
      | createDt                  | notnull                |
      | currentAddress            | notnull                |
      | currentAddressVerifyLevel | notnull                |
      | customerSsnValidated      | notnull                |
      | DOB                       | 1954-01-01             |
      | email                     | session_customer.email |
      | emailOptIn                | false                  |
      | emailValidation           | notnull                |
      | experianPin               | notnull                |
      | firstName                 | PATRICIA               |
      | hashExperianPin           | notnull                |
      | hashLastFourSSN           | notnull                |
      | hashSSN                   | notnull                |
      | lastFourSSN               | notnull                |
      | lastName                  | BABIN                  |
      | orderFunnel               | registration           |
      | pc                        | dir_exp_0              |
      | phone                     | notnull                |
      | SSN                       | notnull                |

     # Validate in Subscription Table
    And make sure following attributes exist within response data with correct values in Subscription Table
      | Atributes             | Value                                                                                                                                                            |
      | activationDt          | notnull                                                                                                                                                          |
      | benefitIds            | sort-B1,B10,B11,B12,B14,B18,B19,B2,B20,B21,B22,B25,B29,B35,B4,B5,B8,B88                                                                                          |
      | correlationId         | notnull                                                                                                                                                          |
      | createDt              | notnull                                                                                                                                                          |
      | customerId            | session_customerId                                                                                                                                               |
      | description           | Good credit begins with knowing where you credit is today, learning how to make smarter financial decisions tomorrow, and protecting your credit moving forward. |
      | discountApplied       | false                                                                                                                                                            |
      | name                  | notnull                                                                                                                                                          |
      | offerQuoteId          | session_offerQuoteId                                                                                                                                             |
      | packageName           | session_packageName                                                                                                                                              |
      | productKey            | <productKey>                                                                                                                                                     |
      | showTermsAndCondition | false                                                                                                                                                            |
      | status                | A                                                                                                                                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                                                                                                                                    |
      | subscriptionId        | session_subscriptionId                                                                                                                                           |
      | subscriptionTypeId    | ect                                                                                                                                                              |
      | termsString           | notnull                                                                                                                                                          |

    # Validate in Subscription History Table
    And make sure following attributes exist within response data with correct values in Subscription History Table
      | Atributes             | Value                                                              |
      | activatedToday        | false                                                              |
      | activationDt          | notnull                                                            |
      | benefitIds            | B20,B10,B21,B11,B22,B88,B12,B35,B14,B25,B29,B18,B19,B1,B2,B4,B5,B8 |
      | benefitIdsAdded       | B20,B10,B21,B11,B22,B88,B12,B35,B14,B25,B29,B18,B19,B1,B2,B4,B5,B8 |
      | customerId            | notnull                                                            |
      | offerGroupId          | notnull                                                            |
      | offerId               | notnull                                                            |
      | offerName             | notnull                                                            |
      | offerQuoteId          | session_offerQuoteId                                               |
      | offerType             | Base                                                               |
      | productKey            | <productKey>                                                       |
      | sessionId             | notnull                                                            |
      | sourceSystemId        | ONLINE                                                             |
      | status                | ActivationCompleted                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                                      |
      | subscriptionId        | session_subscriptionId                                             |
      | subscriptionTypeId    | ect                                                                |

     # Validate in Subscription Benefit  Table
    And make sure following attributes exist within response data with correct values in Subscription Benefit Table
      | Atributes  | Value                                                              |
      | benefitId  | B1,B10,B11,B12,B14,B18,B19,B2,B20,B21,B22,B25,B29,B35,B4,B5,B8,B88 |
      | customerId | session_customerId                                                 |


     # Validate in Enrollment Benefit   Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit Table
      | Atributes  | Value                                                     |
      | benefitId  | EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON |
      | customerId | session_customerId                                        |

     # Validate in Enrollment Benefit History Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit History Table
      | Atributes  | Value                                                     |
      | benefitId  | EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON |
      | customerId | session_customerId                                        |

       # Validate in Subscription Payment Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Subscription Payment Table
      | Atributes             | Value                         |
      | billingClient         | Vault                         |
      | billingFrequency      | Monthly                       |
      | billingPlanIds        | notnull                       |
      | correlationId         | notnull                       |
      | customerId            | session_customerId            |
      | nextBillDate          | notnull                       |
      | subscriptionHistoryId | session_subscriptionHistoryId |
      | subscriptionId        | session_subscriptionId        |
      | vaultStatus           | active                        |
    # Validate in Vault Account Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Vault Account Table
      | Atributes       | Value              |
      | correlationId   | notnull            |
      | customerId      | session_customerId |
      | vaultCustomerId | notnull            |
    Examples:
      | offer_tags | productKey                  |
      | at_ecwt106 | ecw_trial_subscription      |
      | at_ecwd101 | ecw_discounted_subscription |

  @paidannual
  Scenario Outline: Create Customer using Plus Annual offers
    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type | client_credentials |
      | scope      | registration       |
      | client_id  | experian           |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken

    # Get call to get offerId by providing offer tags
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter placementId with value shoppingCart
    And I add a query parameter tags with value <offer_tags>
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId

    # Post call for OP1 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1account.json replacing values:
      | customer.email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call to get the offerQuoteId
    Given I create a new external experian registration service request to the /api/registration/offerquote endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1offerquote.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId

    # Post call to validate the UserName
    Given I create a new external experian registration service request to the /api/login/username endpoint
    And I remove the Authorization headers to the request
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/registration/postop2username.json replacing values:
      | userName | fake_username |
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value |
      | isUsernameAvailable | true  |

    #Post call for OP2 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop2account.json replacing values:
      | offerQuoteId   | session_offerQuoteId |
      | login.userName | session_userName     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for Question Set
    Given I create a new external experian registration service request to the /api/registration/oowquestions endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3ioQuestion.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute questionSetId as questionSetId

    #Post call for term and conditions
    Given I create a new external experian registration service request to the /api/globalterms/customer/allterms endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postglobalterms.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for OP3 Activations
    Given I create a new external experian registration service request to the /api/registration/activation endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3activation.json replacing values:
      | offerQuoteId          | session_offerQuoteId  |
      | answers.questionSetId | session_questionSetId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute token as secureToken
    And I save the value of attribute subscription.id as subscriptionId
    And I save the value of attribute subscription.subscriptionHistoryId as subscriptionHistoryId
    And I save the value of attribute subscription.packageName as packageName

    # Post call for OP4
    Given I create a new external experian registration service request to the /api/registration/op4 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postop4submitsurvey.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I embed the Scenario Session value of type userName in report

   #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report

      # Validate in Customer Login Table
    And make sure following attributes exist within response data with correct values in Customer Login Table
      | Atributes           | Value              |
      | userName            | session_userName   |
      | customerId          | session_customerId |
      | loginStatus         | ACTIVE             |
      | lastPasswordResetDt | notnull            |
      | passSalt            | notnull            |
      | password            | notnull            |
      | pin                 | notnull            |

  # Validate in Customer profile Table
    And make sure following attributes exist within response data with correct values in Customer Profile Table
      | Atributes                 | Value                  |
      | customerId                | session_customerId     |
      | accountId                 | notnull                |
      | accountStatus             | ACTIVE                 |
      | authenticatedDt           | notnull                |
      | authenticatedId           | 50                     |
      | clientId                  | notnull                |
      | createDt                  | notnull                |
      | currentAddress            | notnull                |
      | currentAddressVerifyLevel | notnull                |
      | customerSsnValidated      | notnull                |
      | DOB                       | 1954-01-01             |
      | email                     | session_customer.email |
      | emailOptIn                | false                  |
      | emailValidation           | notnull                |
      | experianPin               | notnull                |
      | firstName                 | PATRICIA               |
      | hashExperianPin           | notnull                |
      | hashLastFourSSN           | notnull                |
      | hashSSN                   | notnull                |
      | lastFourSSN               | notnull                |
      | lastName                  | BABIN                  |
      | orderFunnel               | registration           |
      | pc                        | dir_exp_0              |
      | phone                     | notnull                |
      | SSN                       | notnull                |

     # Validate in Subscription Table
    And make sure following attributes exist within response data with correct values in Subscription Table
      | Atributes             | Value                                                                                                                                                            |
      | activationDt          | notnull                                                                                                                                                          |
      | benefitIds            | sort-B10,B12,B14,B18,B19,B2,B20,B21,B22,B25,B29,B31,B35,B4,B48,B5,B53,B8,B88                                                                                     |
      | correlationId         | notnull                                                                                                                                                          |
      | createDt              | notnull                                                                                                                                                          |
      | customerId            | session_customerId                                                                                                                                               |
      | description           | Good credit begins with knowing where you credit is today, learning how to make smarter financial decisions tomorrow, and protecting your credit moving forward. |
      | discountApplied       | false                                                                                                                                                            |
      | name                  | notnull                                                                                                                                                          |
      | offerQuoteId          | session_offerQuoteId                                                                                                                                             |
      | packageName           | session_packageName                                                                                                                                              |
      | productKey            | <productKey>                                                                                                                                                     |
      | showTermsAndCondition | false                                                                                                                                                            |
      | status                | A                                                                                                                                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                                                                                                                                    |
      | subscriptionId        | session_subscriptionId                                                                                                                                           |
      | subscriptionTypeId    | ect                                                                                                                                                              |
      | termsString           | notnull                                                                                                                                                          |

    # Validate in Subscription History Table
    And make sure following attributes exist within response data with correct values in Subscription History Table
      | Atributes             | Value                                                                   |
      | activatedToday        | false                                                                   |
      | activationDt          | notnull                                                                 |
      | benefitIds            | B20,B31,B53,B10,B21,B22,B88,B12,B35,B14,B25,B48,B18,B29,B19,B2,B4,B5,B8 |
      | benefitIdsAdded       | B20,B31,B53,B10,B21,B22,B88,B12,B35,B14,B25,B48,B18,B29,B19,B2,B4,B5,B8 |
      | customerId            | notnull                                                                 |
      | offerGroupId          | notnull                                                                 |
      | offerId               | notnull                                                                 |
      | offerName             | notnull                                                                 |
      | offerQuoteId          | session_offerQuoteId                                                    |
      | offerType             | Base                                                                    |
      | productKey            | <productKey>                                                            |
      | sessionId             | notnull                                                                 |
      | sourceSystemId        | ONLINE                                                                  |
      | status                | ActivationCompleted                                                     |
      | subscriptionHistoryId | session_subscriptionHistoryId                                           |
      | subscriptionId        | session_subscriptionId                                                  |
      | subscriptionTypeId    | ect                                                                     |

     # Validate in Subscription Benefit  Table
    And make sure following attributes exist within response data with correct values in Subscription Benefit Table
      | Atributes  | Value                                                                   |
      | benefitId  | B20,B31,B53,B10,B21,B22,B88,B12,B35,B14,B25,B48,B18,B29,B19,B2,B4,B5,B8 |
      | customerId | session_customerId                                                      |


     # Validate in Enrollment Benefit   Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit Table
      | Atributes  | Value                                                                  |
      | benefitId  | CSID_DARKWEB,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON |
      | customerId | session_customerId                                                     |

     # Validate in Enrollment Benefit History Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit History Table
      | Atributes  | Value                                                                  |
      | benefitId  | CSID_DARKWEB,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON |
      | customerId | session_customerId                                                     |

       # Validate in Subscription Payment Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Subscription Payment Table
      | Atributes             | Value                         |
      | billingClient         | Vault                         |
      | billingFrequency      | Annually                      |
      | billingPlanIds        | notnull                       |
      | correlationId         | notnull                       |
      | customerId            | session_customerId            |
      | nextBillDate          | notnull                       |
      | subscriptionHistoryId | session_subscriptionHistoryId |
      | subscriptionId        | session_subscriptionId        |
      | vaultStatus           | active                        |


    # Validate in Vault Account Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Vault Account Table
      | Atributes       | Value              |
      | correlationId   | notnull            |
      | customerId      | session_customerId |
      | vaultCustomerId | notnull            |

    Examples:
      | offer_tags | productKey                   |
      | at_eiwa100 | eiw_annual_bill_subscription |

  @premium
  Scenario Outline: Create Customer using Premium offers
    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type | client_credentials |
      | scope      | registration       |
      | client_id  | experian           |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken

    # Get call to get offerId by providing offer tags
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter placementId with value shoppingCart
    And I add a query parameter tags with value <offer_tags>
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId

    # Post call for OP1 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1account.json replacing values:
      | customer.email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call to get the offerQuoteId
    Given I create a new external experian registration service request to the /api/registration/offerquote endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1offerquote.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId

    # Post call to validate the UserName
    Given I create a new external experian registration service request to the /api/login/username endpoint
    And I remove the Authorization headers to the request
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/registration/postop2username.json replacing values:
      | userName | fake_username |
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value |
      | isUsernameAvailable | true  |

    #Post call for OP2 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop2account.json replacing values:
      | offerQuoteId   | session_offerQuoteId |
      | login.userName | session_userName     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for Question Set
    Given I create a new external experian registration service request to the /api/registration/oowquestions endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3ioQuestion.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute questionSetId as questionSetId

    #Post call for term and conditions
    Given I create a new external experian registration service request to the /api/globalterms/customer/allterms endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postglobalterms.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for OP3 Activations
    Given I create a new external experian registration service request to the /api/registration/activation endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3activation.json replacing values:
      | offerQuoteId          | session_offerQuoteId  |
      | answers.questionSetId | session_questionSetId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute token as secureToken
    And I save the value of attribute subscription.id as subscriptionId
    And I save the value of attribute subscription.subscriptionHistoryId as subscriptionHistoryId
    And I save the value of attribute subscription.packageName as packageName

    # Post call for OP4
    Given I create a new external experian registration service request to the /api/registration/op4 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postop4submitsurvey.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I embed the Scenario Session value of type userName in report

 #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report

       # Validate in Customer Login Table
    And make sure following attributes exist within response data with correct values in Customer Login Table
      | Atributes           | Value              |
      | userName            | session_userName   |
      | customerId          | session_customerId |
      | loginStatus         | ACTIVE             |
      | lastPasswordResetDt | notnull            |
      | passSalt            | notnull            |
      | password            | notnull            |
      | pin                 | notnull            |

  # Validate in Customer profile Table
    And make sure following attributes exist within response data with correct values in Customer Profile Table
      | Atributes                 | Value                  |
      | customerId                | session_customerId     |
      | accountId                 | notnull                |
      | accountStatus             | ACTIVE                 |
      | authenticatedDt           | notnull                |
      | authenticatedId           | 50                     |
      | clientId                  | notnull                |
      | createDt                  | notnull                |
      | currentAddress            | notnull                |
      | currentAddressVerifyLevel | notnull                |
      | customerSsnValidated      | notnull                |
      | DOB                       | 1954-01-01             |
      | email                     | session_customer.email |
      | emailOptIn                | false                  |
      | emailValidation           | notnull                |
      | experianPin               | notnull                |
      | firstName                 | PATRICIA               |
      | hashExperianPin           | notnull                |
      | hashLastFourSSN           | notnull                |
      | hashSSN                   | notnull                |
      | lastFourSSN               | notnull                |
      | lastName                  | BABIN                  |
      | orderFunnel               | registration           |
      | pc                        | dir_exp_0              |
      | phone                     | notnull                |
      | SSN                       | notnull                |

     # Validate in Subscription Table
    And make sure following attributes exist within response data with correct values in Subscription Table
      | Atributes             | Value                                                                                                                                                            |
      | activationDt          | notnull                                                                                                                                                          |
      | benefitIds            | sort-<benefitid>                                                                                                                                                 |
      | correlationId         | notnull                                                                                                                                                          |
      | createDt              | notnull                                                                                                                                                          |
      | customerId            | session_customerId                                                                                                                                               |
      | description           | Good credit begins with knowing where you credit is today, learning how to make smarter financial decisions tomorrow, and protecting your credit moving forward. |
      | discountApplied       | false                                                                                                                                                            |
      | name                  | notnull                                                                                                                                                          |
      | offerQuoteId          | session_offerQuoteId                                                                                                                                             |
      | packageName           | session_packageName                                                                                                                                              |
      | productKey            | <productKey>                                                                                                                                                     |
      | showTermsAndCondition | false                                                                                                                                                            |
      | status                | A                                                                                                                                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                                                                                                                                    |
      | subscriptionId        | session_subscriptionId                                                                                                                                           |
      | subscriptionTypeId    | ect                                                                                                                                                              |
      | termsString           | notnull                                                                                                                                                          |

    # Validate in Subscription History Table
    And make sure following attributes exist within response data with correct values in Subscription History Table
      | Atributes             | Value                         |
      | activatedToday        | false                         |
      | activationDt          | notnull                       |
      | benefitIds            | <benefitid>                   |
      | benefitIdsAdded       | <benefitid>                   |
      | customerId            | notnull                       |
      | offerGroupId          | notnull                       |
      | offerId               | notnull                       |
      | offerName             | notnull                       |
      | offerQuoteId          | session_offerQuoteId          |
      | offerType             | Base                          |
      | productKey            | <productKey>                  |
      | sessionId             | notnull                       |
      | sourceSystemId        | ONLINE                        |
      | status                | ActivationCompleted           |
      | subscriptionHistoryId | session_subscriptionHistoryId |
      | subscriptionId        | session_subscriptionId        |
      | subscriptionTypeId    | ect                           |

     # Validate in Subscription Benefit  Table
    And make sure following attributes exist within response data with correct values in Subscription Benefit Table
      | Atributes  | Value              |
      | benefitId  | <benefitid>        |
      | customerId | session_customerId |


     # Validate in Enrollment Benefit   Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit Table
      | Atributes  | Value              |
      | benefitId  | <benefitvalue>     |
      | customerId | session_customerId |

     # Validate in Enrollment Benefit History Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit History Table
      | Atributes  | Value              |
      | benefitId  | <benefitvalue>     |
      | customerId | session_customerId |

       # Validate in Subscription Payment Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Subscription Payment Table
      | Atributes             | Value                         |
      | billingClient         | Vault                         |
      | billingFrequency      | Monthly                       |
      | billingPlanIds        | notnull                       |
      | correlationId         | notnull                       |
      | customerId            | session_customerId            |
      | nextBillDate          | notnull                       |
      | subscriptionHistoryId | session_subscriptionHistoryId |
      | subscriptionId        | session_subscriptionId        |
      | vaultStatus           | active                        |


    # Validate in Vault Account Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Vault Account Table
      | Atributes       | Value              |
      | correlationId   | notnull            |
      | customerId      | session_customerId |
      | vaultCustomerId | notnull            |

    Examples:
      | offer_tags  | productKey                          | benefitid                                                                                              | benefitvalue                                                                           |
      | at_ecwpd105 | ecw_premium_discounted_subscription | B31,B33,B22,B88,B34,B12,B35,B25,B29,B18,B19,B2,B3,B4,B5,B8,B30                                         | EQCM,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON,TUCM                    |
      | at_eiwpt104 | eiw_premium_trial_subscription      | B22,B88,B67,B68,B25,B48,B29,B70,B31,B54,B55,B12,B56,B35,B57,B58,B59,B17,B18,B19,B2,B3,B4,B5,B8,B60,B61 | CSID_PREMIUM,EQCM,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON,PIPPA,TUCM |

  @permiumannual
  Scenario Outline: Create Customer using Premium annual offers
    # Post call for oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded |
      | Accept       | application/json, text/plain, */* |
    And I add the following json content to the param of the request
      | grant_type | client_credentials |
      | scope      | registration       |
      | client_id  | experian           |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute access_token as secureToken

    # Get call to get offerId by providing offer tags
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter placementId with value shoppingCart
    And I add a query parameter tags with value <offer_tags>
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId

    # Post call for OP1 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1account.json replacing values:
      | customer.email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call to get the offerQuoteId
    Given I create a new external experian registration service request to the /api/registration/offerquote endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop1offerquote.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId

    # Post call to validate the UserName
    Given I create a new external experian registration service request to the /api/login/username endpoint
    And I remove the Authorization headers to the request
    And I add the default headers to the request
    And I add a jsonContent to the request body using file /json_objects/registration/postop2username.json replacing values:
      | userName | fake_username |
    And I send the POST request with response type String
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value |
      | isUsernameAvailable | true  |

    #Post call for OP2 Account
    Given I create a new external experian registration service request to the /api/registration/account endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop2account.json replacing values:
      | offerQuoteId   | session_offerQuoteId |
      | login.userName | session_userName     |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for Question Set
    Given I create a new external experian registration service request to the /api/registration/oowquestions endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3ioQuestion.json replacing values:
      | offerId | session_offerId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute questionSetId as questionSetId

    #Post call for term and conditions
    Given I create a new external experian registration service request to the /api/globalterms/customer/allterms endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postglobalterms.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

    # Post call for OP3 Activations
    Given I create a new external experian registration service request to the /api/registration/activation endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/registration/postop3activation.json replacing values:
      | offerQuoteId          | session_offerQuoteId  |
      | answers.questionSetId | session_questionSetId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute token as secureToken
    And I save the value of attribute subscription.id as subscriptionId
    And I save the value of attribute subscription.subscriptionHistoryId as subscriptionHistoryId
    And I save the value of attribute subscription.packageName as packageName


    # Post call for OP4
    Given I create a new external experian registration service request to the /api/registration/op4 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/registration/postop4submitsurvey.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I embed the Scenario Session value of type userName in report

  #Get call to get the CustomerId by passing the login
    Given I create a new internal experian login service request to the /login/byusername/{userName} endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute customerId as customerId
    And I embed the Scenario Session value of type customerId in report

      # Validate in Customer Login Table
    And make sure following attributes exist within response data with correct values in Customer Login Table
      | Atributes           | Value              |
      | userName            | session_userName   |
      | customerId          | session_customerId |
      | loginStatus         | ACTIVE             |
      | lastPasswordResetDt | notnull            |
      | passSalt            | notnull            |
      | password            | notnull            |
      | pin                 | notnull            |

  # Validate in Customer profile Table
    And make sure following attributes exist within response data with correct values in Customer Profile Table
      | Atributes                 | Value                  |
      | customerId                | session_customerId     |
      | accountId                 | notnull                |
      | accountStatus             | ACTIVE                 |
      | authenticatedDt           | notnull                |
      | authenticatedId           | 50                     |
      | clientId                  | notnull                |
      | createDt                  | notnull                |
      | currentAddress            | notnull                |
      | currentAddressVerifyLevel | notnull                |
      | customerSsnValidated      | notnull                |
      | DOB                       | 1954-01-01             |
      | email                     | session_customer.email |
      | emailOptIn                | false                  |
      | emailValidation           | notnull                |
      | experianPin               | notnull                |
      | firstName                 | PATRICIA               |
      | hashExperianPin           | notnull                |
      | hashLastFourSSN           | notnull                |
      | hashSSN                   | notnull                |
      | lastFourSSN               | notnull                |
      | lastName                  | BABIN                  |
      | orderFunnel               | registration           |
      | pc                        | dir_exp_0              |
      | phone                     | notnull                |
      | SSN                       | notnull                |

     # Validate in Subscription Table
    And make sure following attributes exist within response data with correct values in Subscription Table
      | Atributes             | Value                                                                                                                                                            |
      | activationDt          | notnull                                                                                                                                                          |
      | benefitIds            | sort-B12,B17,B18,B19,B2,B22,B25,B29,B3,B31,B35,B4,B48,B5,B54,B55,B56,B57,B58,B59,B60,B61,B67,B68,B8,B85,B88                                                      |
      | correlationId         | notnull                                                                                                                                                          |
      | createDt              | notnull                                                                                                                                                          |
      | customerId            | session_customerId                                                                                                                                               |
      | description           | Good credit begins with knowing where you credit is today, learning how to make smarter financial decisions tomorrow, and protecting your credit moving forward. |
      | discountApplied       | false                                                                                                                                                            |
      | name                  | notnull                                                                                                                                                          |
      | offerQuoteId          | session_offerQuoteId                                                                                                                                             |
      | packageName           | session_packageName                                                                                                                                              |
      | productKey            | <productKey>                                                                                                                                                     |
      | showTermsAndCondition | false                                                                                                                                                            |
      | status                | A                                                                                                                                                                |
      | subscriptionHistoryId | session_subscriptionHistoryId                                                                                                                                    |
      | subscriptionId        | session_subscriptionId                                                                                                                                           |
      | subscriptionTypeId    | ect                                                                                                                                                              |
      | termsString           | notnull                                                                                                                                                          |

    # Validate in Subscription History Table
    And make sure following attributes exist within response data with correct values in Subscription History Table
      | Atributes             | Value                                                                                                  |
      | activatedToday        | false                                                                                                  |
      | activationDt          | notnull                                                                                                |
      | benefitIds            | B22,B88,B67,B68,B25,B48,B29,B31,B54,B55,B12,B56,B35,B57,B58,B59,B17,B18,B19,B2,B3,B4,B5,B8,B60,B61,B85 |
      | benefitIdsAdded       | B22,B88,B67,B68,B25,B48,B29,B31,B54,B55,B12,B56,B35,B57,B58,B59,B17,B18,B19,B2,B3,B4,B5,B8,B60,B61,B85 |
      | customerId            | notnull                                                                                                |
      | offerGroupId          | notnull                                                                                                |
      | offerId               | notnull                                                                                                |
      | offerName             | notnull                                                                                                |
      | offerQuoteId          | session_offerQuoteId                                                                                   |
      | offerType             | Base                                                                                                   |
      | productKey            | <productKey>                                                                                           |
      | sessionId             | notnull                                                                                                |
      | sourceSystemId        | ONLINE                                                                                                 |
      | status                | ActivationCompleted                                                                                    |
      | subscriptionHistoryId | session_subscriptionHistoryId                                                                          |
      | subscriptionId        | session_subscriptionId                                                                                 |
      | subscriptionTypeId    | ect                                                                                                    |

     # Validate in Subscription Benefit  Table
    And make sure following attributes exist within response data with correct values in Subscription Benefit Table
      | Atributes  | Value                                                                                                  |
      | benefitId  | B22,B88,B67,B68,B25,B48,B29,B31,B54,B55,B12,B56,B35,B57,B58,B59,B17,B18,B19,B2,B3,B4,B5,B8,B60,B61,B85 |
      | customerId | session_customerId                                                                                     |


     # Validate in Enrollment Benefit   Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit Table
      | Atributes  | Value                                                                                  |
      | benefitId  | CSID_PREMIUM,EQCM,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON,PIPPA,TUCM |
      | customerId | session_customerId                                                                     |

     # Validate in Enrollment Benefit History Table
    And make sure following attributes exist within response data with correct values in Enrollment Benefit History Table
      | Atributes  | Value                                                                                  |
      | benefitId  | CSID_PREMIUM,EQCM,EXCB,EXCL,EXCM,EXCU,EXDORMANT,EXLU,EXPOSITIVE,EX_SCOREMON,PIPPA,TUCM |
      | customerId | session_customerId                                                                     |


       # Validate in Subscription Payment Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Subscription Payment Table
      | Atributes             | Value                         |
      | billingClient         | Vault                         |
      | billingFrequency      | Annually                      |
      | billingPlanIds        | notnull                       |
      | correlationId         | notnull                       |
      | customerId            | session_customerId            |
      | nextBillDate          | notnull                       |
      | subscriptionHistoryId | session_subscriptionHistoryId |
      | subscriptionId        | session_subscriptionId        |
      | vaultStatus           | active                        |


    # Validate in Vault Account Table
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values in Vault Account Table
      | Atributes       | Value              |
      | correlationId   | notnull            |
      | customerId      | session_customerId |
      | vaultCustomerId | notnull            |



    Examples:
      | offer_tags  | productKey                                    |
      | at_eiwpa103 | eiw_premium_annual_bill_identity_subscription |





