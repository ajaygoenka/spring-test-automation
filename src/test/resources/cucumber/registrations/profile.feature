@api @profile

Feature:Gravity: Validate My Profile and Membership based on offer details

  @PF01
  Scenario: Validate profile and membership of free customer with offer Experian CreditWorks Basic and tag as at_frsas102
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                            |
      # Validate Customer Details
      | customer.accountId                  | notnull                                          |
      | customer.dob                        | 1954                                             |
      | customer.email                      | session_customer.email                           |
      | customer.emailOptIn                 | false                                            |
      | customer.emailValidation            | notnull                                          |
      | customer.isVerified                 | true                                             |
      | customer.name.first                 | PATRICIA                                         |
      | customer.name.last                  | BABIN                                            |
      | customer.orderFunnel                | registration                                     |
      | customer.userName                   | session_userName                                 |
      | customer.enrolledOn                 | notnull                                          |
      | customer.currentAddress.city        | GRAMPIAN                                      |
      | customer.currentAddress.state       | PA                                              |
      | customer.currentAddress.street      | RR 1 BOX 389                                 |
      | customer.currentAddress.zip         | 16838                                            |
      | customer.phone.area                 | 949                                              |
      | customer.phone.city                 | 555                                              |
      | customer.phone.number               | 1212                                             |
      | customer.phone.type                 | Home                                             |
      | billingSourceResponse.billingStatus | INACTIVE                                         |
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

  @PF02
  Scenario: Validate profile and membership of paid customer with offer Experian IdentityWorks Premium and tag as at_eiwpt102
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                                                     |
      | customer.dob                        | 1954                                                                                                        |
      | customer.email                      | session_customer.email                                                                                      |
      | customer.emailOptIn                 | false                                                                                                       |
      | customer.emailValidation            | notnull                                                                                                     |
      | customer.isVerified                 | true                                                                                                        |
      | customer.name.first                 | PATRICIA                                                                                                    |
      | customer.name.last                  | BABIN                                                                                                       |
      | customer.orderFunnel                | registration                                                                                                |
      | customer.userName                   | session_userName                                                                                            |
      | customer.enrolledOn                 | notnull                                                                                                     |
      | customer.currentAddress.city        | GRAMPIAN                                                                                                 |
      | customer.currentAddress.state       | PA                                                                                                         |
      | customer.currentAddress.street      | RR 1 BOX 389                                                                                            |
      | customer.currentAddress.zip         | 16838                                                                                                       |
      | customer.phone.area                 | 949                                                                                                         |
      | customer.phone.city                 | 555                                                                                                         |
      | customer.phone.number               | 1212                                                                                                        |
      | customer.phone.type                 | Home                                                                                                        |
      | billingSourceResponse.billingSource | CreditCard                                                                                                  |
      | billingSourceResponse.billingStatus | ACTIVE                                                                                                      |
#      | billingSourceResponse.nextBillDate  | today + 34                                                                                                  |
      # Validate Credit Card  Details
      | creditCard.cardNumber               | 0009                                                                                                        |
      | creditCard.expMonth                 | 11                                                                                                          |
      | creditCard.expYear                  | 2025                                                                                                        |
      | creditCard.paymentMethodId          | notnull                                                                                                     |
      | creditCard.type                     | Visa                                                                                                        |
      # Validate Subscription or Membership  Details
      | subscription.activationDate         | notnull                                                                                                     |
      | subscription.benefitIds             | sort-B48,B3,B61,B54,B56,B57,B58,B59,B60,B55,B17,B25,B35,B31,B12,B68,B5,B2,B4,B8,B18,B19,B22,B29,B88,B85,B67 |
      | subscription.name                   | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.packageName            | contain-Experian IdentityWorks Premium                                                                      |
      | subscription.productKey             | eiw_premium_trial_30_identity_subscription                                                                  |
      | subscription.status                 | A                                                                                                           |
     # Validate Billing Price Details
      | subscription.terms[0].price         | 19.99                                                                                                       |
      | subscription.terms[0].frequency     | Recurring                                                                                                   |
      | subscription.terms[0].priceAsDouble | 19.99                                                                                                       |
      | subscription.terms[0].billingPeriod | Month                                                                                                       |
      | subscription.terms[0].termType      | Membership                                                                                                  |

  @PF03
  Scenario: Validate profile and membership of paid customer with offer Experian CreditWorks and tag as at_ecwt106
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                 |
      | customer.dob                        | 1954                                                                    |
      | customer.email                      | session_customer.email                                                  |
      | customer.emailOptIn                 | false                                                                   |
      | customer.emailValidation            | notnull                                                                 |
      | customer.isVerified                 | true                                                                    |
      | customer.name.first                 | PATRICIA                                                                |
      | customer.name.last                  | BABIN                                                                   |
      | customer.orderFunnel                | registration                                                            |
      | customer.userName                   | session_userName                                                        |
      | customer.enrolledOn                 | notnull                                                                 |
      | customer.currentAddress.city        | GRAMPIAN                                                             |
      | customer.currentAddress.state       | PA                                                                     |
      | customer.currentAddress.street      | RR 1 BOX 389                                                        |
      | customer.currentAddress.zip         | 16838                                                                   |
      | customer.phone.area                 | 949                                                                     |
      | customer.phone.city                 | 555                                                                     |
      | customer.phone.number               | 1212                                                                    |
      | customer.phone.type                 | Home                                                                    |
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

  @PF04
  Scenario: Validate profile and membership of paid customer with offer Experian CreditWorks and tag as at_ecwd101
    Given I create a new paid customer using at_ecwd101 offer tags
    And I create a new secure token with existing Customer ID and member scope
    # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
  #    | username | dominica.kosswr |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                   |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                 |
      | customer.dob                        | 1954                                                                    |
      | customer.email                      | session_customer.email                                                  |
      | customer.emailOptIn                 | false                                                                   |
      | customer.emailValidation            | notnull                                                                 |
      | customer.isVerified                 | true                                                                    |
      | customer.name.first                 | PATRICIA                                                                |
      | customer.name.last                  | BABIN                                                                   |
      | customer.orderFunnel                | registration                                                            |
      | customer.userName                   | session_userName                                                        |
      | customer.enrolledOn                 | notnull                                                                 |
      | customer.currentAddress.city        | GRAMPIAN                                                             |
      | customer.currentAddress.state       | PA                                                                     |
      | customer.currentAddress.street      | RR 1 BOX 389                                                        |
      | customer.currentAddress.zip         | 16838                                                                   |
      | customer.phone.area                 | 949                                                                     |
      | customer.phone.city                 | 555                                                                     |
      | customer.phone.number               | 1212                                                                    |
      | customer.phone.type                 | Home                                                                    |
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

  @PF05
  Scenario: Validate profile and membership of paid customer with offer Experian CreditWorks Plus and tag as at_eiwa100
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                        |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                      |
      | customer.dob                        | 1954                                                                         |
      | customer.email                      | session_customer.email                                                       |
      | customer.emailOptIn                 | false                                                                        |
      | customer.emailValidation            | notnull                                                                      |
      | customer.isVerified                 | true                                                                         |
      | customer.name.first                 | PATRICIA                                                                     |
      | customer.name.last                  | BABIN                                                                        |
      | customer.orderFunnel                | registration                                                                 |
      | customer.userName                   | session_userName                                                             |
      | customer.enrolledOn                 | notnull                                                                      |
      | customer.currentAddress.city        | GRAMPIAN                                                                  |
      | customer.currentAddress.state       | PA                                                                          |
      | customer.currentAddress.street      | RR 1 BOX 389                                                             |
      | customer.currentAddress.zip         | 16838                                                                        |
      | customer.phone.area                 | 949                                                                          |
      | customer.phone.city                 | 555                                                                          |
      | customer.phone.number               | 1212                                                                         |
      | customer.phone.type                 | Home                                                                         |
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

  @PF06
  Scenario: Validate profile and membership of paid customer with offer Experian CreditWorks and tag as at_ecwpd105
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
      # Validate Customer Details
      | customer.accountId                  | notnull                                                             |
      | customer.dob                        | 1954                                                                |
      | customer.email                      | session_customer.email                                              |
      | customer.emailOptIn                 | false                                                               |
      | customer.emailValidation            | notnull                                                             |
      | customer.isVerified                 | true                                                                |
      | customer.name.first                 | PATRICIA                                                            |
      | customer.name.last                  | BABIN                                                               |
      | customer.orderFunnel                | registration                                                        |
      | customer.userName                   | session_userName                                                    |
      | customer.enrolledOn                 | notnull                                                             |
      | customer.currentAddress.city        | GRAMPIAN                                                         |
      | customer.currentAddress.state       | PA                                                                 |
      | customer.currentAddress.street      | RR 1 BOX 389                                                    |
      | customer.currentAddress.zip         | 16838                                                               |
      | customer.phone.area                 | 949                                                                 |
      | customer.phone.city                 | 555                                                                 |
      | customer.phone.number               | 1212                                                                |
      | customer.phone.type                 | Home                                                                |
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

  @PF07
  Scenario: Validate profile and membership of paid customer with offer Experian CreditWorks Premium and tag as at_eiwpt104
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                                                     |
      | customer.dob                        | 1954                                                                                                        |
      | customer.email                      | session_customer.email                                                                                      |
      | customer.emailOptIn                 | false                                                                                                       |
      | customer.emailValidation            | notnull                                                                                                     |
      | customer.isVerified                 | true                                                                                                        |
      | customer.name.first                 | PATRICIA                                                                                                    |
      | customer.name.last                  | BABIN                                                                                                       |
      | customer.orderFunnel                | registration                                                                                                |
      | customer.userName                   | session_userName                                                                                            |
      | customer.enrolledOn                 | notnull                                                                                                     |
      | customer.currentAddress.city        | GRAMPIAN                                                                                                 |
      | customer.currentAddress.state       | PA                                                                                                         |
      | customer.currentAddress.street      | RR 1 BOX 389                                                                                            |
      | customer.currentAddress.zip         | 16838                                                                                                       |
      | customer.phone.area                 | 949                                                                                                         |
      | customer.phone.city                 | 555                                                                                                         |
      | customer.phone.number               | 1212                                                                                                        |
      | customer.phone.type                 | Home                                                                                                        |
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

  @PF08
  Scenario: Validate profile and membership of paid customer with offer Experian IdentityWorks Premium and tag as at_eiwpa103
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
    And I wait for 5 seconds

    # Get the details of UI Profile
    Given I create a new external experian uiprofile service request to the /api/uiprofile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                           | Value                                                                                                       |
      # Validate Customer Details
      | customer.accountId                  | notnull                                                                                                     |
      | customer.dob                        | 1954                                                                                                        |
      | customer.email                      | session_customer.email                                                                                      |
      | customer.emailOptIn                 | false                                                                                                       |
      | customer.emailValidation            | notnull                                                                                                     |
      | customer.isVerified                 | true                                                                                                        |
      | customer.name.first                 | PATRICIA                                                                                                    |
      | customer.name.last                  | BABIN                                                                                                       |
      | customer.orderFunnel                | registration                                                                                                |
      | customer.userName                   | session_userName                                                                                            |
      | customer.enrolledOn                 | notnull                                                                                                     |
      | customer.currentAddress.city        | GRAMPIAN                                                                                                 |
      | customer.currentAddress.state       | PA                                                                                                         |
      | customer.currentAddress.street      | RR 1 BOX 389                                                                                            |
      | customer.currentAddress.zip         | 16838                                                                                                       |
      | customer.phone.area                 | 949                                                                                                         |
      | customer.phone.city                 | 555                                                                                                         |
      | customer.phone.number               | 1212                                                                                                        |
      | customer.phone.type                 | Home                                                                                                        |
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







