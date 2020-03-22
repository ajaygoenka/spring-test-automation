@api @Bosst
Feature:Super Friends: Validate the Boost and PFM  Journey

  Scenario: Validate the link of connectinfo for Boost
    # Create a new free user with below given profile
    Given I create a new paid customer using at_ecwt106 offer tags and below details
      | SSN       | 666420216    |
      | firstName | ADALBERTO    |
      | lastName  | MAGLIARO     |
      | dob       | 1950-01-01   |
      | street    | 661 EMILY DR |
      | city      | Bozeman      |
      | state     | MT           |
      | zip       | 59718        |
    #profile-372
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

    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the Enrollment Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/enrollmentstatus endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the tradelinestatusupdatebatch
    Given I create a new external experian financialActivity service request to the /api/financial-activity/tradelinestatusupdatebatch endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 204

      #Get the tradelinereport
    Given I create a new external experian financialActivity service request to the /api/financial-activity/tradelinereport endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 412

     #Get the connectinfo
    Given I create a new external experian financialActivity service request to the /api/financial-activity/connectinfo endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                  |
      | link      | contain-customerId partnerId signature |

  Scenario Outline: Validate the report  for Boost
    And save the value of <UserName> as userName
     # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn         | off              |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken

    # Validate the Accounts
    Given I create a new external experian financialActivity service request to the /api/financial-activity/accounts endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                | Value     |
      | result[0].accountBalance                 |           |
      | result[0].accountId                      |           |
      | result[0].accountType                    | CHECKING  |
      | result[0].accountTypeGroup               | Cash      |
      | result[0].connectionInfo.status          | CONNECTED |
      | result[0].institutionAccountName         |           |
      | result[0].institutionAccountNumberMasked |           |
      | result[0].institutionName                |           |
      | result[0].institutionProfileId           |           |
      | result[0].oAuth                          | false     |
      | result[0].offerCodes                     |           |
      | result[0].supplierInstitutionId          |           |
      | result[0].transactionRetrievalStatus     | COMPLETE  |

    # Validate the Enrollments Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/enrollmentstatus endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value |
      | offerCodes |       |

    # Validate the tradeline Status Update Batch
    Given I create a new external experian financialActivity service request to the /api/financial-activity/tradelinestatusupdatebatch endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                         | Value   |
      | startReportData.reportId          | notnull |
      | startReportData.reportDate        | notnull |
      | startReportData.score             | 520     |
      | startReportData.thinFile          | true    |
      | endReportData.reportId            | notnull |
      | endReportData.reportDate          | notnull |
      | endReportData.score               | 553     |
      | endReportData.thinFile            | false   |
      | paymentRecordsAdded               |         |
      | paymentRecordsRemoved             |         |
      | tradelineStatusCounts.USER_OPT_IN | 3       |

    # Validate the tradeline report
    Given I create a new external experian financialActivity service request to the /api/financial-activity/tradelinereport endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                     | Value            |
      | tradelines[0].tradelineAccountNumber          | notnull          |
      | tradelines[0].tradelineAccountNumberFormatted | notnull          |
      | tradelines[0].category                        | WIRELESS         |
      | tradelines[0].status                          | USER_OPT_IN      |
      | tradelines[0].statusDate                      | notnull          |
      | tradelines[0].payee                           | T-Mobile         |
      | tradelines[0].averagePaymentAmount            | notnull          |
      | tradelines[0].latestPaidAmount                | notnull          |
      | tradelines[0].accountOwnerName                | notnull          |
      | tradelines[0].accountOwnerAddress             | notnull          |
      | tradelines[0].lastValidationStatus            | notnull          |
      | tradelines[0].lastValidationStatusDt          | notnull          |
      | tradelines[0].paymentRecords                  |                  |
      | tradelines[0].tradelineSource                 |                  |
      | tradelines[0].tradelineAccountNumber          | notnull          |
      | tradelines[0].tradelineAccountNumberFormatted | notnull          |
      | tradelines[0].category                        | WIRELESS         |
      | tradelines[0].status                          | USER_OPT_IN      |
      | tradelines[0].statusDate                      | notnull          |
      | tradelines[0].payee                           | T-Mobile         |
      | tradelines[0].averagePaymentAmount            | notnull          |
      | tradelines[0].latestPaidAmount                | notnull          |
      | tradelines[0].accountOwnerName                | notnull          |
      | tradelines[0].accountOwnerAddress             | notnull          |
      | tradelines[0].lastValidationStatus            | notnull          |
      | tradelines[0].lastValidationStatusDt          | notnull          |
      | tradelines[0].paymentRecords                  |                  |
      | tradelines[0].tradelineSource                 |                  |
      | tradelines[1].tradelineAccountNumber          | notnull          |
      | tradelines[1].tradelineAccountNumberFormatted | notnull          |
      | tradelines[1].category                        | UTILITY          |
      | tradelines[1].status                          | USER_OPT_IN      |
      | tradelines[1].statusDate                      | notnull          |
      | tradelines[1].payee                           | Greenville Water |
      | tradelines[1].averagePaymentAmount            | notnull          |
      | tradelines[1].latestPaidAmount                | notnull          |
      | tradelines[1].accountOwnerName                | notnull          |
      | tradelines[1].accountOwnerAddress             | notnull          |
      | tradelines[1].lastValidationStatus            | notnull          |
      | tradelines[1].lastValidationStatusDt          | notnull          |
      | tradelines[1].paymentRecords                  |                  |
      | tradelines[1].tradelineSource                 |                  |
      | tradelines[2].tradelineAccountNumber          | notnull          |
      | tradelines[2].tradelineAccountNumberFormatted | notnull          |
      | tradelines[2].category                        | UTILITY          |
      | tradelines[2].status                          | USER_OPT_IN      |
      | tradelines[2].statusDate                      | notnull          |
      | tradelines[2].payee                           | Tennessee Elect  |
      | tradelines[2].averagePaymentAmount            | notnull          |
      | tradelines[2].latestPaidAmount                | notnull          |
      | tradelines[2].accountOwnerName                | notnull          |
      | tradelines[2].accountOwnerAddress             | notnull          |
      | tradelines[2].lastValidationStatus            | notnull          |
      | tradelines[2].lastValidationStatusDt          | notnull          |
      | tradelines[2].paymentRecords                  |                  |
      | tradelines[2].tradelineSource                 |                  |


    #    Get call to pull utility report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                             | Value |
      | reportInfo.creditFileInfo[0].accounts |       |

#  @int
#    Examples:
#      | UserName      |
#      | cecile.wizadr |

    @stg
    Examples:
      | UserName           |
      | deandre.lubowitzit |

  @ignore
  Scenario: Validate the link of connectinfo for PFM
    # Create a new free user with below given profile
    Given I create a new paid customer using at_ecwt106 offer tags and below details
      | SSN       | 666169032            |
      | firstName | Joe                  |
      | lastName  | Ball                 |
      | dob       | 1950-01-01           |
      | street    | 141 BERTHA AVE CLYDE |
      | city      | CLYDE                |
      | state     | OH                   |
      | zip       | 43410-2019           |
    #profile-304
    And I create a new secure token with existing Customer ID and member scope
     # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn         | off              |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken

    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the accounts Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/accounts endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #Get the Enrollment Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/enrollmentstatus endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the connectinfo
    Given I create a new external experian financialActivity service request to the /api/financial-activity/connectinfo endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter offerCode with value TXMON
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                      |
      | link      | contain-customerId partnerId pfm signature |

  @ignore
  Scenario Outline: Validate the account and transaction  of PFM
    And save the value of <UserName> as userName
    And I create a new secure token with existing Customer ID and member scope
     # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn         | off              |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken

    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the accounts Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/accounts endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #Get the Enrollment Status
    Given I create a new external experian financialActivity service request to the /api/financial-activity/enrollmentstatus endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get the connectinfo
    Given I create a new external experian financialActivity service request to the /api/financial-activity/connectinfo endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter offerCode with value TXMON
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                      |
      | link      | contain-customerId partnerId pfm signature |

    @int
    Examples:
      | UserName      |
      | daine.hyattgg |

#    @stg
#    Examples:
#      | UserName                         |
#      | 896416c0c34748218aacf36ba3ec110e |

