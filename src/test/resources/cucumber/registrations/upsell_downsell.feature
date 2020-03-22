@api @updown

Feature:Shield: Validate Upsell and Downsell from offer to offer

  @UD01
  Scenario: Upsell from productKey free_report_score_alerts_eiw_subscription of population acquisition_default to productKey ecw_trial_subscription of population direct_customer_exp
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

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                     |
      | billingSourceResponse.billingStatus | INACTIVE                                  |
      | subscription.name                   | contain-Experian CreditWorks Basic        |
      | subscription.packageName            | contain-Experian CreditWorks Basic        |
      | subscription.productKey             | free_report_score_alerts_eiw_subscription |
      | subscription.status                 | A                                         |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 0.0                                       |
      | subscription.terms[0].priceAsDouble | 0.0                                       |
      | subscription.terms[0].termType      | Membership                                |

    # request for upgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers/ml endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/offers/upgrade.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerId
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                  |
      | id         | notnull                |
      | productKey | ecw_trial_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId       |
      | trackLinkId | header-member-upgrade |
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
      | offerQuoteId | session_offerQuoteId |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 10 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes     | Value                  |
      | customerId    | session_customerId     |
      | productKey    | ecw_trial_subscription |
      | paymentStatus | active                 |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      | billingSourceResponse.billingSource | CreditCard                                                              |
      | billingSourceResponse.billingStatus | ACTIVE                                                                  |
#      | billingSourceResponse.nextBillDate  | today + 9                                                               |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                    |
      | creditCard.expMonth                 | 11                                                                      |
      | creditCard.expYear                  | 2025                                                                    |
      | creditCard.paymentMethodId          | notnull                                                                 |
      | creditCard.type                     | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                 |
      | subscription.benefitIds             | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                            |
      | subscription.packageName            | contain-Experian CreditWorks                                            |
      | subscription.productKey             | ecw_trial_subscription                                                  |
      | subscription.status                 | A                                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 21.95                                                                   |
      | subscription.terms[0].frequency     | Recurring                                                               |
      | subscription.terms[0].priceAsDouble | 21.95                                                                   |
      | subscription.terms[0].billingPeriod | Month                                                                   |
      | subscription.terms[0].termType      | Membership                                                              |

  @UD02
  Scenario: Upsell from productKey ecw_trial_subscription of population acquisition_default to productKey eiw_premium_discounted_subscription of population membership_plus
    Given I create a new paid customer using at_ecwt106 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      # Validate Customer Details
      | billingSourceResponse.billingSource | CreditCard                                                              |
      | billingSourceResponse.billingStatus | ACTIVE                                                                  |
 #     | billingSourceResponse.nextBillDate  | today + 9                                                               |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                    |
      | creditCard.expMonth                 | 11                                                                      |
      | creditCard.expYear                  | 2025                                                                    |
      | creditCard.paymentMethodId          | notnull                                                                 |
      | creditCard.type                     | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                 |
      | subscription.benefitIds             | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                            |
      | subscription.packageName            | contain-Experian CreditWorks                                            |
      | subscription.productKey             | ecw_trial_subscription                                                  |
      | subscription.status                 | A                                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 21.95                                                                   |
      | subscription.terms[0].frequency     | Recurring                                                               |
      | subscription.terms[0].priceAsDouble | 21.95                                                                   |
      | subscription.terms[0].billingPeriod | Month                                                                   |
      | subscription.terms[0].termType      | Membership                                                              |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_discounted_subscription       |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes     | Value                               |
      | customerId    | session_customerId                  |
      | productKey    | eiw_premium_discounted_subscription |
      | paymentStatus | active                              |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 31                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B67 |
      | subscription.name                   | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName            | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey             | eiw_premium_discounted_subscription                                                                         |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 24.99                                                                                                       |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 24.99                                                                                                       |
      | subscription.terms[0].billingPeriod | Month                                                                                                       |
      | subscription.terms[0].termType      | Membership                                                                                                  |

  @UD03
  Scenario: Downsell from productKey ecw_trial_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_subscription of population membership_plus
    Given I create a new paid customer using at_ecwt106 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      # Validate Customer Details
      | billingSourceResponse.billingSource | CreditCard                                                              |
      | billingSourceResponse.billingStatus | ACTIVE                                                                  |
  #    | billingSourceResponse.nextBillDate  | today + 9                                                               |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                    |
      | creditCard.expMonth                 | 11                                                                      |
      | creditCard.expYear                  | 2025                                                                    |
      | creditCard.paymentMethodId          | notnull                                                                 |
      | creditCard.type                     | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                 |
      | subscription.benefitIds             | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                            |
      | subscription.packageName            | contain-Experian CreditWorks                                            |
      | subscription.productKey             | ecw_trial_subscription                                                  |
      | subscription.status                 | A                                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 21.95                                                                   |
      | subscription.terms[0].frequency     | Recurring                                                               |
      | subscription.terms[0].priceAsDouble | 21.95                                                                   |
      | subscription.terms[0].billingPeriod | Month                                                                   |
      | subscription.terms[0].termType      | Membership                                                              |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_discounted_subscription       |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                      | Value                                     |
      | customerId                     | session_customerId                        |
      | productKey                     | ecw_trial_subscription                    |
      | status                         | ActivationPending                         |
      | pendingSubscription.productKey | free_report_score_alerts_eiw_subscription |
      | pendingSubscription.price      | 0.0                                       |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                   | Value                                                                   |
      | billingSourceResponse.billingSource         | CreditCard                                                              |
      | billingSourceResponse.billingStatus         | ACTIVE                                                                  |
 #     | billingSourceResponse.nextBillDate          | today + 9                                                               |
      | billingSourceResponse.accountBalance        | 0.0                                                                     |
      # Validate Credit Card  Details
      | creditCard.cardNumber                       | 0009                                                                    |
      | creditCard.expMonth                         | 11                                                                      |
      | creditCard.expYear                          | 2025                                                                    |
      | creditCard.paymentMethodId                  | notnull                                                                 |
      | creditCard.type                             | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate                 | notnull                                                                 |
      | subscription.benefitIds                     | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                           | contain-Experian CreditWorks                                            |
      | subscription.packageName                    | contain-Experian CreditWorks                                            |
      | subscription.productKey                     | ecw_trial_subscription                                                  |
      | subscription.status                         | ActivationPending                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price                 | 21.95                                                                   |
      | subscription.terms[0].frequency             | Recurring                                                               |
      | subscription.terms[0].priceAsDouble         | 21.95                                                                   |
      | subscription.terms[0].billingPeriod         | Month                                                                   |
      | subscription.terms[0].termType              | Membership                                                              |
      # Validate Pending Subscriptions
      | subscription.pendingSubscription.productKey | free_report_score_alerts_eiw_subscription                               |
      | subscription.pendingSubscription.price      | 0.0                                                                     |
      | subscription.pendingSubscription.offerName  | contain-Experian CreditWorks Basic                                      |

  @UD04
  Scenario: Upsell from productKey ecw_discounted_subscription of population acquisition_default to productKey eiw_premium_discounted_subscription of population membership_plus
    Given I create a new paid customer using at_ecwd101 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      | billingSourceResponse.billingSource | CreditCard                                                              |
      | billingSourceResponse.billingStatus | ACTIVE                                                                  |
 #     | billingSourceResponse.nextBillDate  | today + 31                                                              |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                    |
      | creditCard.expMonth                 | 11                                                                      |
      | creditCard.expYear                  | 2025                                                                    |
      | creditCard.paymentMethodId          | notnull                                                                 |
      | creditCard.type                     | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                 |
      | subscription.benefitIds             | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                            |
      | subscription.packageName            | contain-Experian CreditWorks                                            |
      | subscription.productKey             | ecw_discounted_subscription                                             |
      | subscription.status                 | A                                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 19.95                                                                   |
      | subscription.terms[0].frequency     | Recurring                                                               |
      | subscription.terms[0].priceAsDouble | 19.95                                                                   |
      | subscription.terms[0].billingPeriod | Month                                                                   |
      | subscription.terms[0].termType      | Membership                                                              |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_discounted_subscription       |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 20 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                               |
      | customerId | session_customerId                  |
      | productKey | eiw_premium_discounted_subscription |
      | status     | A                                   |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 31                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B67 |
      | subscription.name                   | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName            | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey             | eiw_premium_discounted_subscription                                                                         |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 24.99                                                                                                       |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 24.99                                                                                                       |
      | subscription.terms[0].billingPeriod | Month                                                                                                       |
      | subscription.terms[0].termType      | Membership                                                                                                  |

  @UD05
  Scenario: Downsell from productKey ecw_discounted_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_subscription of population membership_plus
    Given I create a new paid customer using at_ecwd101 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      | billingSourceResponse.billingSource | CreditCard                                                              |
      | billingSourceResponse.billingStatus | ACTIVE                                                                  |
#      | billingSourceResponse.nextBillDate  | today + 31                                                              |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                    |
      | creditCard.expMonth                 | 11                                                                      |
      | creditCard.expYear                  | 2025                                                                    |
      | creditCard.paymentMethodId          | notnull                                                                 |
      | creditCard.type                     | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                 |
      | subscription.benefitIds             | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                            |
      | subscription.packageName            | contain-Experian CreditWorks                                            |
      | subscription.productKey             | ecw_discounted_subscription                                             |
      | subscription.status                 | A                                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 19.95                                                                   |
      | subscription.terms[0].frequency     | Recurring                                                               |
      | subscription.terms[0].priceAsDouble | 19.95                                                                   |
      | subscription.terms[0].billingPeriod | Month                                                                   |
      | subscription.terms[0].termType      | Membership                                                              |


    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_discounted_subscription       |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                      | Value                                     |
      | customerId                     | session_customerId                        |
      | productKey                     | ecw_discounted_subscription               |
      | status                         | ActivationPending                         |
      | pendingSubscription.productKey | free_report_score_alerts_eiw_subscription |
      | pendingSubscription.price      | 0.0                                       |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                   | Value                                                                   |
      | billingSourceResponse.billingSource         | CreditCard                                                              |
      | billingSourceResponse.billingStatus         | ACTIVE                                                                  |
#      | billingSourceResponse.nextBillDate          | today + 31                                                              |
      # Validate Credit Card  Details
      | creditCard.cardNumber                       | 0009                                                                    |
      | creditCard.expMonth                         | 11                                                                      |
      | creditCard.expYear                          | 2025                                                                    |
      | creditCard.paymentMethodId                  | notnull                                                                 |
      | creditCard.type                             | Visa                                                                    |
      # Validate Subscription or Membership  Details
      | subscription.activationDate                 | notnull                                                                 |
      | subscription.benefitIds                     | sort-B1,B10,B14,B25,B35,B11,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                           | contain-Experian CreditWorks                                            |
      | subscription.packageName                    | contain-Experian CreditWorks                                            |
      | subscription.productKey                     | ecw_discounted_subscription                                             |
      | subscription.status                         | ActivationPending                                                       |
     # Validate Billing Price Details
      | subscription.terms[0].price                 | 19.95                                                                   |
      | subscription.terms[0].frequency             | Recurring                                                               |
      | subscription.terms[0].priceAsDouble         | 19.95                                                                   |
      | subscription.terms[0].billingPeriod         | Month                                                                   |
      | subscription.terms[0].termType              | Membership                                                              |

      # Validate Pending Subscriptions
      | subscription.pendingSubscription.productKey | free_report_score_alerts_eiw_subscription                               |
      | subscription.pendingSubscription.price      | 0.0                                                                     |
      | subscription.pendingSubscription.offerName  | contain-Experian CreditWorks Basic                                      |

  @UD06
  Scenario: Upsell from productKey eiw_annual_bill_subscription of population acquisition_default to productKey eiw_premium_annual_bill_subscription of population membership_plus_annual_bill
    Given I create a new paid customer using at_eiwa100 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                        |
      | billingSourceResponse.billingSource | CreditCard                                                                   |
      | billingSourceResponse.billingStatus | ACTIVE                                                                       |
#      | billingSourceResponse.nextBillDate  | today + 366                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                         |
      | creditCard.expMonth                 | 11                                                                           |
      | creditCard.expYear                  | 2025                                                                         |
      | creditCard.paymentMethodId          | notnull                                                                      |
      | creditCard.type                     | Visa                                                                         |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                      |
      | subscription.benefitIds             | sort-B48,B10,B14,B53,B25,B35,B31,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks Plus                                            |
      | subscription.packageName            | contain-Experian CreditWorks Plus                                            |
      | subscription.productKey             | eiw_annual_bill_subscription                                                 |
      | subscription.status                 | A                                                                            |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 99.99                                                                        |
      | subscription.terms[0].frequency     | Recurring                                                                    |
      | subscription.terms[0].priceAsDouble | 99.99                                                                        |
      | subscription.terms[0].billingPeriod | Annual                                                                       |
      | subscription.terms[0].termType      | Membership                                                                   |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_annual_bill_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 20 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                |
      | customerId | session_customerId                   |
      | productKey | eiw_premium_annual_bill_subscription |
      | status     | A                                    |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 366                                                                                                 |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B67,B88 |
      | subscription.name                   | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName            | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey             | eiw_premium_annual_bill_subscription                                                                        |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 249.99                                                                                                      |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 249.99                                                                                                      |
      | subscription.terms[0].billingPeriod | Annual                                                                                                      |
      | subscription.terms[0].termType      | Membership                                                                                                  |

  @UD07
  Scenario: Downsell from productKey eiw_annual_bill_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_subscription of population membership_plus_annual_bill
    Given I create a new paid customer using at_eiwa100 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                        |
      | billingSourceResponse.billingSource | CreditCard                                                                   |
      | billingSourceResponse.billingStatus | ACTIVE                                                                       |
#      | billingSourceResponse.nextBillDate  | today + 366                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                         |
      | creditCard.expMonth                 | 11                                                                           |
      | creditCard.expYear                  | 2025                                                                         |
      | creditCard.paymentMethodId          | notnull                                                                      |
      | creditCard.type                     | Visa                                                                         |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                      |
      | subscription.benefitIds             | sort-B48,B10,B14,B53,B25,B35,B31,B12,B5,B2,B4,B8,B18,B19,B20,B21,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks Plus                                            |
      | subscription.packageName            | contain-Experian CreditWorks Plus                                            |
      | subscription.productKey             | eiw_annual_bill_subscription                                                 |
      | subscription.status                 | A                                                                            |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 99.99                                                                        |
      | subscription.terms[0].frequency     | Recurring                                                                    |
      | subscription.terms[0].priceAsDouble | 99.99                                                                        |
      | subscription.terms[0].billingPeriod | Annual                                                                       |
      | subscription.terms[0].termType      | Membership                                                                   |


    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_premium_annual_bill_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |


    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 20 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                     |
      | customerId | session_customerId                        |
      | productKey | free_report_score_alerts_eiw_subscription |
      | status     | A                                         |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                            |
      | billingSourceResponse.billingSource | CreditCard                                       |
      | billingSourceResponse.billingStatus | INACTIVE                                         |
      | billingSourceResponse.nextBillDate  |                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                             |
      | creditCard.expMonth                 | 11                                               |
      | creditCard.expYear                  | 2025                                             |
      | creditCard.paymentMethodId          | notnull                                          |
      | creditCard.type                     | Visa                                             |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                          |
      | subscription.benefitIds             | sort-B10,B14,B25,B18,B19,B20,B21,B22,B24,B90,B62 |
      | subscription.name                   | contain-Experian CreditWorks Basic               |
      | subscription.packageName            | contain-Experian CreditWorks Basic               |
      | subscription.productKey             | free_report_score_alerts_eiw_subscription        |
      | subscription.status                 | A                                                |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 0.0                                              |
      | subscription.terms[0].priceAsDouble | 0.0                                              |
      | subscription.terms[0].termType      | Membership                                       |

  @UD08
  Scenario: Downsell from productKey ecw_premium_discounted_subscription of population acquisition_default to productKey eiw_immediate_bill_plus_subscription of population membership_premium
    Given I create a new paid customer using at_ecwpd105 offer tags
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
    And I wait for 25 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                               |
      | billingSourceResponse.billingSource | CreditCard                                                          |
      | billingSourceResponse.billingStatus | ACTIVE                                                              |
#      | billingSourceResponse.nextBillDate  | today + 31                                                          |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                |
      | creditCard.expMonth                 | 11                                                                  |
      | creditCard.expYear                  | 2025                                                                |
      | creditCard.paymentMethodId          | notnull                                                             |
      | creditCard.type                     | Visa                                                                |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                             |
      | subscription.benefitIds             | sort-B34,B30,B3,B25,B35,B31,B12,B5,B2,B4,B8,B18,B19,B22,B29,B33,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                        |
      | subscription.packageName            | contain-Experian CreditWorks                                        |
      | subscription.productKey             | ecw_premium_discounted_subscription                                 |
      | subscription.status                 | A                                                                   |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 19.99                                                               |
      | subscription.terms[0].frequency     | Recurring                                                           |
      | subscription.terms[0].priceAsDouble | 19.99                                                               |
      | subscription.terms[0].billingPeriod | Month                                                               |
      | subscription.terms[0].termType      | Membership                                                          |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_immediate_bill_plus_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |


    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                |
      | customerId | session_customerId                   |
      | productKey | eiw_immediate_bill_plus_subscription |
      | status     | A                                    |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                           |
      | billingSourceResponse.billingSource | CreditCard                                                      |
      | billingSourceResponse.billingStatus | ACTIVE                                                          |
#      | billingSourceResponse.nextBillDate  | today + 31                                                      |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                            |
      | creditCard.expMonth                 | 11                                                              |
      | creditCard.expYear                  | 2025                                                            |
      | creditCard.paymentMethodId          | notnull                                                         |
      | creditCard.type                     | Visa                                                            |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                         |
      | subscription.benefitIds             | sort-B48,B69,B3,B25,B35,B11,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks Plus                               |
      | subscription.packageName            | contain-Experian CreditWorks Plus                               |
      | subscription.productKey             | eiw_immediate_bill_plus_subscription                            |
      | subscription.status                 | A                                                               |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 14.99                                                           |
      | subscription.terms[0].frequency     | Recurring                                                       |
      | subscription.terms[0].priceAsDouble | 14.99                                                           |
      | subscription.terms[0].billingPeriod | Month                                                           |
      | subscription.terms[0].termType      | Membership                                                      |

  @UD09
  Scenario: Downsell from productKey ecw_premium_discounted_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_subscription of population membership_premium
    Given I create a new paid customer using at_ecwpd105 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                               |
      | billingSourceResponse.billingSource | CreditCard                                                          |
      | billingSourceResponse.billingStatus | ACTIVE                                                              |
 #     | billingSourceResponse.nextBillDate  | today + 31                                                          |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                |
      | creditCard.expMonth                 | 11                                                                  |
      | creditCard.expYear                  | 2025                                                                |
      | creditCard.paymentMethodId          | notnull                                                             |
      | creditCard.type                     | Visa                                                                |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                             |
      | subscription.benefitIds             | sort-B34,B30,B3,B25,B35,B31,B12,B5,B2,B4,B8,B18,B19,B22,B29,B33,B88 |
      | subscription.name                   | contain-Experian CreditWorks                                        |
      | subscription.packageName            | contain-Experian CreditWorks                                        |
      | subscription.productKey             | ecw_premium_discounted_subscription                                 |
      | subscription.status                 | A                                                                   |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 19.99                                                               |
      | subscription.terms[0].frequency     | Recurring                                                           |
      | subscription.terms[0].priceAsDouble | 19.99                                                               |
      | subscription.terms[0].billingPeriod | Month                                                               |
      | subscription.terms[0].termType      | Membership                                                          |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_immediate_bill_plus_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |


    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                      | Value                                     |
      | customerId                     | session_customerId                        |
      | productKey                     | ecw_premium_discounted_subscription       |
      | status                         | ActivationPending                         |
      | pendingSubscription.productKey | free_report_score_alerts_eiw_subscription |
      | pendingSubscription.price      | 0.0                                       |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                   | Value                                                               |
      | billingSourceResponse.billingSource         | CreditCard                                                          |
      | billingSourceResponse.billingStatus         | ACTIVE                                                              |
#      | billingSourceResponse.nextBillDate          | today + 31                                                          |
      # Validate Credit Card  Details
      | creditCard.cardNumber                       | 0009                                                                |
      | creditCard.expMonth                         | 11                                                                  |
      | creditCard.expYear                          | 2025                                                                |
      | creditCard.paymentMethodId                  | notnull                                                             |
      | creditCard.type                             | Visa                                                                |
      # Validate Subscription or Membership  Details
      | subscription.activationDate                 | notnull                                                             |
      | subscription.benefitIds                     | sort-B34,B30,B3,B25,B35,B31,B12,B5,B2,B4,B8,B18,B19,B22,B29,B33,B88 |
      | subscription.name                           | contain-Experian CreditWorks                                        |
      | subscription.packageName                    | contain-Experian CreditWorks                                        |
      | subscription.productKey                     | ecw_premium_discounted_subscription                                 |
      | subscription.status                         | ActivationPending                                                   |
     # Validate Billing Price Details
      | subscription.terms[0].price                 | 19.99                                                               |
      | subscription.terms[0].frequency             | Recurring                                                           |
      | subscription.terms[0].priceAsDouble         | 19.99                                                               |
      | subscription.terms[0].billingPeriod         | Month                                                               |
      | subscription.terms[0].termType              | Membership                                                          |
      # Validate Pending Subscriptions
      | subscription.pendingSubscription.productKey | free_report_score_alerts_eiw_subscription                           |
      | subscription.pendingSubscription.price      | 0.0                                                                 |
      | subscription.pendingSubscription.offerName  | contain-Experian CreditWorks Basic                                  |

  @UD10
  Scenario: Downsell from productKey eiw_premium_trial_subscription of population acquisition_default to productKey eiw_immediate_bill_plus_subscription of population membership_premium
    Given I create a new paid customer using at_eiwpt104 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 11                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B67 |
      | subscription.name                   | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName            | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey             | eiw_premium_trial_subscription                                                                              |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 24.99                                                                                                       |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 24.99                                                                                                       |
      | subscription.terms[0].billingPeriod | Month                                                                                                       |
      | subscription.terms[0].termType      | Membership                                                                                                  |


    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_immediate_bill_plus_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |


    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                |
      | customerId | session_customerId                   |
      | productKey | eiw_immediate_bill_plus_subscription |
      | status     | A                                    |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                           |
      | billingSourceResponse.billingSource | CreditCard                                                      |
      | billingSourceResponse.billingStatus | ACTIVE                                                          |
#      | billingSourceResponse.nextBillDate  | today + 31                                                      |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                            |
      | creditCard.expMonth                 | 11                                                              |
      | creditCard.expYear                  | 2025                                                            |
      | creditCard.paymentMethodId          | notnull                                                         |
      | creditCard.type                     | Visa                                                            |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                         |
      | subscription.benefitIds             | sort-B48,B69,B3,B25,B35,B11,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88 |
      | subscription.name                   | contain-Experian CreditWorks Plus                               |
      | subscription.packageName            | contain-Experian CreditWorks Plus                               |
      | subscription.productKey             | eiw_immediate_bill_plus_subscription                            |
      | subscription.status                 | A                                                               |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 14.99                                                           |
      | subscription.terms[0].frequency     | Recurring                                                       |
      | subscription.terms[0].priceAsDouble | 14.99                                                           |
      | subscription.terms[0].billingPeriod | Month                                                           |
      | subscription.terms[0].termType      | Membership                                                      |

  @UD11
  Scenario: Downsell from productKey eiw_premium_trial_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_subscription of population membership_premium
    Given I create a new paid customer using at_eiwpt104 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 11                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B67 |
      | subscription.name                   | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName            | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey             | eiw_premium_trial_subscription                                                                              |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 24.99                                                                                                       |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 24.99                                                                                                       |
      | subscription.terms[0].billingPeriod | Month                                                                                                       |
      | subscription.terms[0].termType      | Membership                                                                                                  |


    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                     |
      | result[0].id         | notnull                                   |
      | result[0].productKey | eiw_immediate_bill_plus_subscription      |
      | result[1].id         | notnull                                   |
      | result[1].productKey | free_report_score_alerts_eiw_subscription |


    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
      | reasonCode            | CO1001               |
      | reasonComment         | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                      | Value                                     |
      | customerId                     | session_customerId                        |
      | productKey                     | eiw_premium_trial_subscription            |
      | status                         | ActivationPending                         |
      | pendingSubscription.productKey | free_report_score_alerts_eiw_subscription |
      | pendingSubscription.price      | 0.0                                       |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                   | Value                                                                                                       |
      | billingSourceResponse.billingSource         | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus         | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate          | today + 11                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber                       | 0009                                                                                                        |
      | creditCard.expMonth                         | 11                                                                                                          |
      | creditCard.expYear                          | 2025                                                                                                        |
      | creditCard.paymentMethodId                  | notnull                                                                                                     |
      | creditCard.type                             | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate                 | notnull                                                                                                     |
      | subscription.benefitIds                     | sort-B48,B70,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B67 |
      | subscription.name                           | contain-Experian CreditWorks Premium                                                                        |
      | subscription.packageName                    | contain-Experian CreditWorks Premium                                                                        |
      | subscription.productKey                     | eiw_premium_trial_subscription                                                                              |
      | subscription.status                         | ActivationPending                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price                 | 24.99                                                                                                       |
      | subscription.terms[0].frequency             | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble         | 24.99                                                                                                       |
      | subscription.terms[0].billingPeriod         | Month                                                                                                       |
      | subscription.terms[0].termType              | Membership                                                                                                  |
      # Validate Pending Subscriptions
      | subscription.pendingSubscription.productKey | free_report_score_alerts_eiw_subscription                                                                   |
      | subscription.pendingSubscription.price      | 0.0                                                                                                         |
      | subscription.pendingSubscription.offerName  | contain-Experian CreditWorks Basic                                                                          |

  @UD12
  Scenario: Downsell from productKey eiw_premium_annual_bill_identity_subscription of population acquisition_default to productKey eiw_annual_bill_identity_lite_subscription of population membership_identity_annual_bill
    Given I create a new paid customer using at_eiwpa103 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 366                                                                                                 |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B85,B88,B67 |
      | subscription.name                   | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.packageName            | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.productKey             | eiw_premium_annual_bill_identity_subscription                                                               |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 199.99                                                                                                      |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 199.99                                                                                                      |
      | subscription.terms[0].billingPeriod | Annual                                                                                                      |
      | subscription.terms[0].termType      | Membership                                                                                                  |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                              |
      | result[0].id         | notnull                                            |
      | result[0].productKey | free_report_score_alerts_eiw_identity_subscription |
      | result[1].id         | notnull                                            |
      | result[1].productKey | eiw_annual_bill_identity_lite_subscription         |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_2      |
      | placementId | subscriptionmanagement |
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
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 20 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                      |
      | customerId | session_customerId                         |
      | productKey | eiw_annual_bill_identity_lite_subscription |
      | status     | A                                          |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                         |
      | billingSourceResponse.billingSource | CreditCard                                                                    |
      | billingSourceResponse.billingStatus | ACTIVE                                                                        |
#      | billingSourceResponse.nextBillDate  | today + 366                                                                   |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                          |
      | creditCard.expMonth                 | 11                                                                            |
      | creditCard.expYear                  | 2025                                                                          |
      | creditCard.paymentMethodId          | notnull                                                                       |
      | creditCard.type                     | Visa                                                                          |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                       |
      | subscription.benefitIds             | sort-B10,B14,B53,B25,B35,B12,B68,B5,B4,B8,B18,B19,B20,B21,B22,B24,B88,B83,B76 |
      | subscription.name                   | contain-Experian IdentityWorks Core                                           |
      | subscription.packageName            | contain-Experian IdentityWorks Core                                           |
      | subscription.productKey             | eiw_annual_bill_identity_lite_subscription                                    |
      | subscription.status                 | A                                                                             |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 49.99                                                                         |
      | subscription.terms[0].frequency     | Recurring                                                                     |
      | subscription.terms[0].priceAsDouble | 49.99                                                                         |
      | subscription.terms[0].billingPeriod | Annual                                                                        |
      | subscription.terms[0].termType      | Membership                                                                    |

  @UD13
  Scenario: Downsell from productKey eiw_premium_annual_bill_identity_subscription of population acquisition_default to productKey free_report_score_alerts_eiw_identity_subscription of population membership_identity_annual_bill
    Given I create a new paid customer using at_eiwpa103 offer tags
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
    And I wait for 20 seconds

  # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
 #     | billingSourceResponse.nextBillDate  | today + 366                                                                                                 |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B85,B88,B67 |
      | subscription.name                   | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.packageName            | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.productKey             | eiw_premium_annual_bill_identity_subscription                                                               |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 199.99                                                                                                      |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 199.99                                                                                                      |
      | subscription.terms[0].billingPeriod | Annual                                                                                                      |
      | subscription.terms[0].termType      | Membership                                                                                                  |

    # request for downgrade offer for this Customer
    Given I create a new external experian offers service request to the /api/offers endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a query parameter context with value membership
    And I send the GET request with response type JSONArray
    Then The response status code should be 200
    And I save the value of attribute result[0].id as offerId_1
    And I save the value of attribute result[1].id as offerId_2
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                              |
      | result[0].id         | notnull                                            |
      | result[0].productKey | free_report_score_alerts_eiw_identity_subscription |
      | result[1].id         | notnull                                            |
      | result[1].productKey | eiw_annual_bill_identity_lite_subscription         |

    # Ge the offer Quote Id
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/subscription endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_offerquoteid.json replacing values:
      | offerId     | session_offerId_1      |
      | placementId | subscriptionmanagement |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I save the value of attribute id as offerQuoteId
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value   |
      | id           | notnull |
      | offerGroupId | notnull |

    # reason code for downshell
    Given I create a new external experian fulfillment service request to the /api/fulfillment/downsell/reasoncode endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200


    # Upsell/Downsell the Customer
    Given I create a new external experian fulfillment service request to the /api/fulfillment/customer/activate endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/fulfillment/upsell_carddetails.json replacing values:
      | offerQuoteId          | session_offerQuoteId |
      | creditCard.cardNumber | null                 |
      | creditCard.cvv        | null                 |
      | creditCard.expMonth   | null                 |
      | creditCard.expYear    | null                 |
      | creditCard.isPrimary  | null                 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And I wait for 20 seconds
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                                              |
      | customerId | session_customerId                                 |
      | productKey | free_report_score_alerts_eiw_identity_subscription |
      | status     | A                                                  |

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                              |
      | billingSourceResponse.billingSource | CreditCard                                         |
      | billingSourceResponse.billingStatus | INACTIVE                                           |
      | billingSourceResponse.nextBillDate  |                                                    |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                               |
      | creditCard.expMonth                 | 11                                                 |
      | creditCard.expYear                  | 2025                                               |
      | creditCard.paymentMethodId          | notnull                                            |
      | creditCard.type                     | Visa                                               |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                            |
      | subscription.benefitIds             | sort-B10,B14,B25,B18,B19,B20,B21,B22,B24,B90,B62   |
      | subscription.name                   | contain-Experian IdentityWorks Basic               |
      | subscription.packageName            | contain-Experian IdentityWorks Basic               |
      | subscription.productKey             | free_report_score_alerts_eiw_identity_subscription |
      | subscription.status                 | A                                                  |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 0.0                                                |
      | subscription.terms[0].priceAsDouble | 0.0                                                |
      | subscription.terms[0].termType      | Membership                                         |