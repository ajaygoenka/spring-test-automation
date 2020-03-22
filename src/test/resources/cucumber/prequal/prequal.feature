@prequal

Feature: Validate that Prequal

  @AUT-4164
  Scenario: TC_PREQUAL_PERSONALIZEDOFF - TC_Verify user with personalized off receives generic offers from Prequal
    And save the value of int_generic_off_sv as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value       |
      | zones     | contain-100 |
      | prequal   | false       |

  @AUT-4165
  Scenario: TC_PLPQ_FREEUSER_MEMBERTYPE - TC_Verify Prelogin prequal returns member type "fr" for free user with macthed offers
    And save the value of int_jason_corderorivera_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value |
      | offers.prequal   | true  |
      | offers.zones.100 |       |

  @AUT-4166
  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F10006 - TC_Verify Prelogin prequal response has no amex offer A016F10006 and no prequal offer A016000006
    And save the value of int_pvk_debbies_testamex_1 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F10006 A016F A016000006 |

  @AUT-4167
  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F20006 - TC_Verify Prelogin prequal response has no amex offer A016F20006
    And save the value of int_pvk_jamesk_testamex_2 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F20006 A016F A016000006 |

  @AUT-4168
  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F30006 - TC_Verify Prelogin prequal response has no amex offer A016F30006 and no prequal offer A016000006
    And save the value of int_pvk_william_testamex_3 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F30006 A016F A016000006 |

  @AUT-4169
  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F40006 - TC_Verify Prelogin prequal response has no amex offer A016F40006
    And save the value of int_pvk_roland_amextest_4 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F40006 A016F A016000006 |

  @AUT-4170
  Scenario: TC_PLPQ_OLLOFIRMOFFER_SUPPRESSION_A026F00002_A026F00003 - TC_Verify Prelogin prequal response has no Ollo Firm offers A026F00002 & A026F00003
    And save the value of int_pvk_roland_amextest_4 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes      | Value |
      | offers.prequal | true  |

  Scenario: TC_PLPQ_PAID_MEMBERTYPE - TC_Verify Prelogin prequal returns member type "p" for paid user with macthed offers
    And save the value of int_michelle_dunlap_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value |
      | offers.prequal   | true  |
      | offers.zones.100 |       |
      | locked           | false |
      | frozen           | false |
      | memberType       | p     |

  Scenario: TC_PREQUAL_HAPPYFLOW - TC_Verify prequal response contains only matched for you offers
    And save the value of int_monica_susan_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value                    |
      | prequal    | true                     |
      | zones.100  |                          |
      | derogatory | false                    |
      | zones.100  | contain-displayFlag":"Y" |

  Scenario: TC_PREQUAL_ROUTE_SHOULDHAVE_A026000002 - TC_Verify prequal response contains only matched for you offers
    And save the value of int_laurie_anderson_1 as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                    |
      | prequal   | true                     |
      | zones.100 | contain-displayFlag":"Y" |
      | zones.100 | contain-A026000002       |

  Scenario: TC_PREQUAL_RIIND_CHECK - TC_Verify prequal response contains only matched for you offers
    And save the value of int_darin_bierling_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                             |
      | prequal   | true                              |
      | zones.100 | contain-"ri_ind":"R" "ri_ind":"I" |

  Scenario: TC_PREQUAL_PREAPPROVED_FLAG_CHECK - TC_Verify prequal response contains only matched for you offers
    And save the value of int_james_paiduser_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                     |
      | prequal   | true                                      |
      | zones.100 | contain-"IsPreApproved":"True" A018000003 |

  Scenario: TC_PREQUAL_RESTRICTED_STATE - TC_Verify prequal returns generic offers for users in restricted states
    And save the value of int_pvk_restricted_robertb_nv_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                           |
      | prequal   | false                           |
      | zones.100 | not contain-"IsGeneric":"False" |

  Scenario: TC_PREQUAL_LASTVIEWEDOFFER - TC_Verify lastviewed offers updated in dynamo table for new offers
    And save the value of int_dean_vonachen_1 as userName
    And save the value of password as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/viewed/100 endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/prequal/rightoffer_100.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200 or 204

  Scenario: TC_PREQUAL_ADD_REMOVE_BOOKMARK - TC_Verify if we can add and remove bookmarks for save cards in dynamo table
    And save the value of int_fcs_debbie_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/bookmark endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/prequal/add_remove.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200

  Scenario: TC_PREQUAL_CREDITFROZEN - TC_Verify frozen user receives generic offers
    And save the value of int_ophelia_forzen_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                           |
      | prequal   | false                           |
      | zones.100 | not contain-"IsGeneric":"False" |

  Scenario: TC_PREQUAL_APOLLO_RIGHTOFFER - TC_Verify prequal returns matched offers for apollo users
    And save the value of apollo_gordon09o as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value      |
      | prequal    | true       |
      | source     | rightoffer |
      | derogatory | false      |
      | zones.100  |            |

  Scenario: TC_PREQUAL_APOLLO_RIGHTOFFER - TC_verify prequal accepts any of the interest query params
    And save the value of apollo_gordon09o as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter interest with value balance-transfer
    And I add a query parameter interest with value travel
    And I add a query parameter interest with value no-annual-fee
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | prequal   | true       |
      | source    | rightoffer |
      | zones.100 |            |

  Scenario: TC_PREQUAL_APOLLO_RIGHTOFFER - TC_Verify prequal accepts empty interest query param when given none
    And save the value of apollo_gordon09o as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter interest with value none
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value      |
      | prequal   | true       |
      | source    | rightoffer |
      | zones.100 |            |

#----------------------------------------------Last------------------------------------------------------
  Scenario: TC_PREQUAL_RESTRICTED_STATEUSER - TC_Verify prequal returns generic offers for users in restricted states
    And save the value of int_pvk_restricted_robertb_nv_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                           |
      | prequal   | false                           |
      | zones.100 | not contain-"IsGeneric":"False" |

  Scenario: TC_PREQUAL_KS_STATEUSER - TC_Verify prequal returns pq offers
    And save the value of int_paul_la_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value |
      | prequal      | true  |
      | profileState | KS    |
      | zones.110    |       |

  Scenario: TC_PREQUAL_TX_STATEUSER - TC_Verify prequal response has only credit offers and no loan offers
    And save the value of int_timothy_wallet_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes    | Value |
      | prequal      | true  |
      | profileState | TX    |
      | zones.110    |       |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_PERSONALIZEDOFFEROPTOUTUSER - TC_Verify response for prequal customer data
    And save the value of int_generic_off_sv as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_HAPPYFLOW - TC_Verify response for prequal customer data
    And save the value of int_lockedusr_phillip_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_RESTRICTED_STATE - TC_Verify response for prequal customer data
    And save the value of int_pvk_restricted_robertb_nv_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_CREDITFROZEN - TC_Verify response for prequal customer data
    And save the value of int_ophelia_forzen_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes  | Value |
      | successful | false |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_UNDER21_USER - TC_Verify response for prequal customer data
    And save the value of int_under21usr_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_APOLLO_USER - TC_Verify response for prequal customer data
    And save the value of apollo_gordon09o as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_FREEUSER - TC_Verify response for prequal customer data
    And save the value of int_jason_corderorivera_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_PAIDUSER - TC_Verify response for prequal customer data
    And save the value of miglesias1 as userName
    And save the value of password as password
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_VERIFY_CUSTOMERDATA_RESPONSE_CREDITIFILELOCKED_USER - TC_Verify response for prequal customer data
    And save the value of int_lockedusr_phillip_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/customerdata endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes            | Value                                                                                                         |
      | successful           | true                                                                                                          |
      | annualSpending       | IsInteger                                                                                                     |
      | balanceCarried       |                                                                                                               |
      | cardCluster          |                                                                                                               |
      | highestCardApr       |                                                                                                               |
      | loanCluster          |                                                                                                               |
      | numberOfCardAccounts |                                                                                                               |
      | segment              |                                                                                                               |
      | omrtg                |                                                                                                               |
      | scoreChange          |                                                                                                               |
      | inTheMarketModel     | contain-debtToIncome itmmPL itmmRET itmmMTG itmmSL incomeInsight itmmHE smCM03 balTransferIndex itmmAU itmmBC |

  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F10003 - TC_Verify Prelogin prequal response has no amex offer A016F10003 and no prequal offer A016000003
    And save the value of int_emond_a016f10003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F10003 A016F A016000003 |

  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F20003 - TC_Verify Prelogin prequal response has no amex offer A016F20003
    And save the value of int_michael_a016f20003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                        |
      | offers.prequal   | true                         |
      | offers.zones.100 | not contain-A016F20003 A016F |
      | offers.zones.100 | contain-A016000003           |

  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F30003 - TC_Verify Prelogin prequal response has no amex offer A016F30003 and no prequal offer A016000003
    And save the value of int_julie_a016f30003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                                   |
      | offers.prequal   | true                                    |
      | offers.zones.100 | not contain-A016F30003 A016F A016000003 |

  Scenario: TC_PLPQ_AMEXFIRMOFFER_SUPPRESSION_A016F40003 - TC_Verify Prelogin prequal response has no amex offer A016F40003
    And save the value of int_mary_a016f40003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I generate a marketingId for the existing customerId
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer/prelogin/{marketingId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes        | Value                        |
      | offers.prequal   | true                         |
      | offers.zones.100 | not contain-A016F40003 A016F |
      | offers.zones.100 | contain-A016000003           |

  Scenario: TC_PREQUAL_OMP_AMEXFIRMOFFER_SUPPRESSION_A016F10003 - TC_Verify OMP prequal response has no amex offer A016F10003 and no prequal offer A016000003
    And save the value of int_emond_a016f10003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/omp endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter source with value rightoffer
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                   |
      | prequal   | true                                    |
      | zones.100 | not contain-A016F10003 A016F A016000003 |

  Scenario: TC_PREQUAL_OMP_AMEXFIRMOFFER_SUPPRESSION_A016F20003 - TC_Verify OMP prequal response has no amex offer A016F20003 yes Prequal A016000003
    And save the value of int_michael_a016f20003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/omp endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter source with value rightoffer
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                        |
      | prequal   | true                         |
      | zones.100 | contain-A016000003           |
      | zones.100 | not contain-A016F20003 A016F |

  Scenario: TC_PREQUAL_OMP_AMEXFIRMOFFER_SUPPRESSION_A016F30003 - TC_Verify OMP prequal response has no amex offer A016F30003 and no prequal offer A016000003
    And save the value of int_julie_a016f30003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/omp endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter source with value rightoffer
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                                   |
      | prequal   | true                                    |
      | zones.100 | not contain-A016F30003 A016F A016000003 |

  Scenario: TC_PREQUAL_OMP_AMEXFIRMOFFER_SUPPRESSION_A016F40003 - TC_Verify OMP prequal response has no amex offer A016F40003 Yes Prequal  A016000003
    And save the value of int_mary_a016f40003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/omp endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a query parameter source with value rightoffer
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                        |
      | prequal   | true                         |
      | zones.100 | contain-A016000003           |
      | zones.100 | not contain-A016F40003 A016F |

  Scenario: TC_PREQUAL_LOGGEDIN_YES_AMEXFIRMOFFER_A016F10003_NO_PREQUAL_A016000003 (Test) - TC_Verify loggedin prequal response has amex firm offer A016F10003 and no prequal A016000003 offer
    And save the value of int_emond_a016f10003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                    |
      | prequal   | true                     |
      | zones.100 | contain-A016F10003 A016F |
      | zones.100 | not contain-A016000003   |

  Scenario: TC_PREQUAL_LOGGEDIN_NO_AMEXFIRMOFFER_A016F20003_YES_PREQUAL_A016000003 (Control) - TC_Verify Loggedin prequal response has no amex offer A016F20003 and Yes prequal A016000003
    And save the value of int_michael_a016f20003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                        |
      | prequal   | true                         |
      | zones.100 | contain-A016000003           |
      | zones.100 | not contain-A016F20003 A016F |

  Scenario: TC_PREQUAL_LOGGEDIN_YES_AMEXFIRMOFFER_A016F30003_NO_PREQUAL_ A016000003 (Test) - TC_Verify loggedin prequal response has amex firm offer A016F30003 and no prequal offer A016000003
    And save the value of int_julie_a016f30003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                    |
      | prequal   | true                     |
      | zones.100 | contain-A016F30003 A016F |
      | zones.100 | not contain-A016000003   |

  Scenario: TC_PREQUAL_LOGGEDIN_NO_AMEXFIRMOFFER_A016F40003_YES_PREQUAL_A016000003 (Control) - TC_Verify OMP prequal response has no amex offer A016F40003
    And save the value of int_mary_a016f40003_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian prequal service request to the /api/prequal/v1/rightoffer endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes | Value                        |
      | prequal   | true                         |
      | zones.100 | contain-A016000003           |
      | zones.100 | not contain-A016F40003 A016F |

