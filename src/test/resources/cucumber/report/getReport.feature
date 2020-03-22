@api @report
Feature:Super Friends: Get multiple report for free and Paid Users

  Scenario: Verify forceload report for a free credit score  1B1S user
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

    #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  Scenario: Verify experian score latest report  for a free credit score 1B1S user
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

            #    Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Get lasest report of Experian
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  Scenario: Verify history report for a free credit score 1B1S user
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
    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  Scenario: Verify nextrefresh report for a free credit score  1B1S user
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
    #    Get call to pull next refresh
    Given I create a new external experian report service request to the /api/report/nextrefresh endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  Scenario: Verify compare all score report for a free credit score  1B1S user
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

    #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/history/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  Scenario: Verify compare all  report and scores for 3B3S user
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

    #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/history/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     # request for upgrade offer for this Customer to get 3b report
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter placementId with value upgrade
    And I add a query parameter context with value 3b
    And I add a query parameter pageContext with value upgrade
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                          |
      | result[0].id         | notnull                        |
      | result[0].productKey | eiw_premium_trial_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1 |
      | placementId | upgrade           |
      | trackLinkId | null              |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

      # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | 4457010000000009     |
      | creditCard.cvv        | 349                  |
      | creditCard.expMonth   | 11                   |
      | creditCard.expYear    | 2025                 |
      | creditCard.isPrimary  | true                 |
      | upsellCondition       | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                          |
      | customerId | session_customerId             |
      | productKey | eiw_premium_trial_subscription |
      | status     | A                              |
   # Get api report
    Given I create a new external experian report service request to the /api/report endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/offers/benefit.json replacing values:
      | benefitId | B70 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute reportInfo.reportId as reportId
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value   |
      | reportInfo.reportId | notnull |

      #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value   |
      | reportInfo.reportId | notnull |

    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value   |
      | experian[0].id   | notnull |
      | equifax[0].id    | notnull |
      | transunion[0].id | notnull |

    #    Get call to pull next refresh
    Given I create a new external experian report service request to the /api/report/nextrefresh endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                   | Value   |
      | nextReportRefresh.benefitId | notnull |

    #    Get call to pull Compare all report based on reportId
    Given I create a new external experian report service request to the /api/report/{reportId}/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value      |
      | reportInfo.reportId                 | notnull    |
      | reportInfo.creditFileInfo[0].source | experian   |
      | reportInfo.creditFileInfo[1].source | equifax    |
      | reportInfo.creditFileInfo[2].source | transunion |


    #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/history/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value   |
      | experian[0].id      | notnull |
      | experian[0].score   | notnull |
      | equifax[0].id       | notnull |
      | equifax[0].score    | notnull |
      | transUnion[0].id    | notnull |
      | transUnion[0].score | notnull |

    #    Get call to pull Compare all report for score
    Given I create a new external experian report service request to the /api/report/scores/{reportId}/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value      |
      | experian[0].id       | notnull    |
      | experian[0].bureau   | Experian   |
      | equifax[0].id        | notnull    |
      | equifax[0].bureau    | Equifax    |
      | transunion[0].id     | notnull    |
      | transunion[0].bureau | TransUnion |

  @ignore
  Scenario: Verify Industrial  score for  user
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

    #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Get Report History
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/history/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     # request for upgrade offer for this Customer to get 3b report
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter placementId with value additionalFicoScoresUpgrade
    And I add a query parameter pageContext with value additional_fico_scores_upgrade
    And I add a query parameter tags with value ia_1b1s_mrtgfis100,ia_1b1s_autofis100,ia_1b1s_bcrdfis100
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And I save the value of attribute result[2].id as offerId_3
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                 |
      | result[0].id         | notnull                               |
      | result[0].productKey | 1b1s_mrtg_fico_industry_transactional |
      | result[1].id         | notnull                               |
      | result[1].productKey | 1b1s_auto_fico_industry_transactional |
      | result[2].id         | notnull                               |
      | result[2].productKey | 1b1s_bcrd_fico_industry_transactional |

    # Ge the offer Quote Id      ????
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | array--session_offerId_1--session_offerId_2--session_offerId_3 |
      | placementId | additionalFicoScoresUpgrade                                    |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

      # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | 4457010000000009     |
      | creditCard.cvv        | 349                  |
      | creditCard.expMonth   | 11                   |
      | creditCard.expYear    | 2025                 |
      | creditCard.isPrimary  | true                 |
      | upsellCondition       | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                          |
      | customerId | session_customerId             |
      | productKey | eiw_premium_trial_subscription |
      | status     | A                              |

  Scenario: Verify industrial score for paid users
    Given I create a new paid customer using at_eiwpt102 offer tags
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

    #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/forcereload endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute reportInfo.reportId as reportId
    And make sure following attributes exist within response data with correct values
      | Atributes           | Value   |
      | reportInfo.reportId | notnull |

      #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/history endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

     #Get call to pull member latest report EX
    Given I create a new external experian report service request to the /api/report/scores/latestreport/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

      #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/history/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

       #    Get call to pull Compare all report
    Given I create a new external experian report service request to the /api/report/scores/{reportId}/CA endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #Get call to pull member benefit report
    Given I create a new external experian report service request to the /api/report/scores/history/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    #    Get call to pull next refresh
    Given I create a new external experian report service request to the /api/report/nextrefresh endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    Given I create a new external experian report service request to the /api/report/scores/{reportId}/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    Given I create a new external experian report service request to the /api/report/{reportId}/EX endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
