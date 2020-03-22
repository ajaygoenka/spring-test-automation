Feature: Validate Financial Id Transformation

  @issue:AUT-3800
  Scenario: Verify the financial Id in dynamoDb  ???
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/wallet_profile.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 1500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 90    |
      | walletProfile.spendingByCategory.GROCERIES   | 210   |
      | walletProfile.spendingByCategory.TRAVEL      | 100   |
      | walletProfile.spendingByCategory.DEPT_STORES | 90    |
      | walletProfile.spendingByCategory.DINING      | 190   |
      | walletProfile.spendingByCategory.OTHER       | 820   |

  @issue:AUT-3802
  Scenario Outline: Verify response for multiple combinations
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | <creditScore>     |
      | walletProfile.monthlySpending | <monthlySpending> |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value             |
      | customerId                                   |                   |
      | customerId                                   |                   |
      | walletProfile.monthlySpending                | <monthlySpending> |
      | walletProfile.defaultMonthlySpending         |                   |
      | walletProfile.spendingByCategory.GAS         | <gas>             |
      | walletProfile.spendingByCategory.GROCERIES   | <groceries>       |
      | walletProfile.spendingByCategory.TRAVEL      | <travel>          |
      | walletProfile.spendingByCategory.DEPT_STORES | <dpey_store>      |
      | walletProfile.spendingByCategory.DINING      | <dining>          |
      | walletProfile.spendingByCategory.OTHER       | <other>           |
    Examples:
      | creditScore | monthlySpending | gas | groceries | travel | dpey_store | dining | other |
      | 850         | 3920            | 240 | 540       | 270    | 230        | 490    | 2150  |
      | 510         | 440             | 30  | 60        | 30     | 30         | 50     | 240   |
      | 575         | 510             | 30  | 70        | 40     | 30         | 60     | 280   |
      | 666         | 1360            | 80  | 190       | 90     | 80         | 170    | 750   |
      | 680         | 1620            | 100 | 220       | 110    | 90         | 200    | 900   |
      | 695         | 2010            | 120 | 280       | 140    | 120        | 250    | 1100  |
      | 730         | 2630            | 160 | 360       | 180    | 150        | 330    | 1450  |
      | 770         | 3040            | 190 | 420       | 210    | 180        | 380    | 1660  |
      | 355         | 180             | 10  | 20        | 10     | 10         | 20     | 110   |
      | 385         | 100             | 10  | 10        | 10     | 10         | 10     | 50    |

  @issue:AUT-3803
  Scenario: Verify default categories % values calculation based on user providing monthly spending
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |

  @issue:AUT-3801
  Scenario: update the monthly spend for existing data
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 3500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 3500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 220   |
      | walletProfile.spendingByCategory.GROCERIES   | 480   |
      | walletProfile.spendingByCategory.TRAVEL      | 240   |
      | walletProfile.spendingByCategory.DEPT_STORES | 200   |
      | walletProfile.spendingByCategory.DINING      | 430   |
      | walletProfile.spendingByCategory.OTHER       | 1930  |

  @issue:AUT-3804
  Scenario: update the credit score  existing data
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 781  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |

  @issue:AUT-3805
  Scenario: update the credit score  and monthly expense existing data
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 781  |
      | walletProfile.monthlySpending | 3290 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 3290  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 200   |
      | walletProfile.spendingByCategory.GROCERIES   | 450   |
      | walletProfile.spendingByCategory.TRAVEL      | 230   |
      | walletProfile.spendingByCategory.DEPT_STORES | 190   |
      | walletProfile.spendingByCategory.DINING      | 410   |
      | walletProfile.spendingByCategory.OTHER       | 1810  |

  @issue:AUT-3806
  Scenario: value when monthly spending is set to minimmum  for credit score is below the given or defined range
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 350 |
      | walletProfile.monthlySpending | 180 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 180   |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 10    |
      | walletProfile.spendingByCategory.GROCERIES   | 20    |
      | walletProfile.spendingByCategory.TRAVEL      | 10    |
      | walletProfile.spendingByCategory.DEPT_STORES | 10    |
      | walletProfile.spendingByCategory.DINING      | 20    |
      | walletProfile.spendingByCategory.OTHER       | 110   |

  @issue:AUT-3807
  Scenario: value when monthly spending is set to maximum  for credit score is above the given  range
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 880  |
      | walletProfile.monthlySpending | 3680 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 3680  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 230   |
      | walletProfile.spendingByCategory.GROCERIES   | 510   |
      | walletProfile.spendingByCategory.TRAVEL      | 250   |
      | walletProfile.spendingByCategory.DEPT_STORES | 210   |
      | walletProfile.spendingByCategory.DINING      | 460   |
      | walletProfile.spendingByCategory.OTHER       | 2020  |

  @issue:AUT-3808
  Scenario: Verify empty json
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/empty.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3809
  Scenario: Vertify missing monthly spend attribute
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json deleting values:
      | walletProfile.monthlySpending |  |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3810
  Scenario: Verify missing monthly spend attribute and creditScore is null
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_null.json deleting values:
      | walletProfile.monthlySpending |  |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario:  monthly spend attribute and creditScore is null
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/wallet_profile_null.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: Existing record  monthlySpending = ""
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_null.json replacing values:
      | creditScore | 750 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: Existing record  emptyjson
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/empty.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: Existing record  score only 750
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json deleting values:
      | walletProfile.monthlySpending |  |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: Existing record  score and monthly spending blank
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_null.json deleting values:
      | walletProfile.monthlySpending |  |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update categories to negative value
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | walletProfile.spendingByCategory.GAS    | -15 |
      | walletProfile.spendingByCategory.DINING | -1  |
      | walletProfile.spendingByCategory.TRAVEL | -30 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update categories to null value
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | walletProfile.spendingByCategory.DINING | null |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3814
  Scenario: update categories to 0 value
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | walletProfile.spendingByCategory.GAS         | 0 |
      | walletProfile.spendingByCategory.DINING      | 0 |
      | walletProfile.spendingByCategory.GROCERIES   | 0 |
      | walletProfile.spendingByCategory.TRAVEL      | 0 |
      | walletProfile.spendingByCategory.DEPT_STORES | 0 |
      | walletProfile.spendingByCategory.OTHER       | 0 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 0     |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 0     |
      | walletProfile.spendingByCategory.GROCERIES   | 0     |
      | walletProfile.spendingByCategory.TRAVEL      | 0     |
      | walletProfile.spendingByCategory.DEPT_STORES | 0     |
      | walletProfile.spendingByCategory.DINING      | 0     |
      | walletProfile.spendingByCategory.OTHER       | 0     |

  @issue:AUT-3813
  Scenario: update categories maximum value
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | creditScore                                  | 643   |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.spendingByCategory.GAS         | 21000 |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.GROCERIES   | 0     |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 200   |
      | walletProfile.spendingByCategory.OTHER       | 20000 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 41680 |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 21000 |
      | walletProfile.spendingByCategory.GROCERIES   | 0     |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 200   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 20000 |

  @issue:AUT-3812
  Scenario: create  categories
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | creditScore                                  | 643  |
      | walletProfile.monthlySpending                | 2500 |
      | walletProfile.spendingByCategory.GAS         | 500  |
      | walletProfile.spendingByCategory.DINING      | 800  |
      | walletProfile.spendingByCategory.GROCERIES   | 1000 |
      | walletProfile.spendingByCategory.TRAVEL      | 170  |
      | walletProfile.spendingByCategory.DEPT_STORES | 0    |
      | walletProfile.spendingByCategory.OTHER       | 1000 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 3470  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 500   |
      | walletProfile.spendingByCategory.GROCERIES   | 1000  |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 0     |
      | walletProfile.spendingByCategory.DINING      | 800   |
      | walletProfile.spendingByCategory.OTHER       | 1000  |

  @issue:AUT-3811
  Scenario: create  and update categories
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile.json replacing values:
      | creditScore                   | 700  |
      | walletProfile.monthlySpending | 2500 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 160   |
      | walletProfile.spendingByCategory.GROCERIES   | 350   |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 150   |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.OTHER       | 1360  |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/categories/wallet_profile_ca.json replacing values:
      | creditScore                                  | 643  |
      | walletProfile.monthlySpending                | 2500 |
      | walletProfile.spendingByCategory.GAS         | 500  |
      | walletProfile.spendingByCategory.DINING      | 800  |
      | walletProfile.spendingByCategory.GROCERIES   | 1000 |
      | walletProfile.spendingByCategory.TRAVEL      | 170  |
      | walletProfile.spendingByCategory.DEPT_STORES | 0    |
      | walletProfile.spendingByCategory.OTHER       | 1000 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value |
      | customerId                                   |       |
      | walletProfile.monthlySpending                | 3470  |
      | walletProfile.defaultMonthlySpending         | false |
      | walletProfile.spendingByCategory.GAS         | 500   |
      | walletProfile.spendingByCategory.GROCERIES   | 1000  |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 0     |
      | walletProfile.spendingByCategory.DINING      | 800   |
      | walletProfile.spendingByCategory.OTHER       | 1000  |
