@wallet

Feature: Validate that wallet

  Scenario: Wallet INT - CREDIT_MATCH Rank Source update internal call
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile/retrieve endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/score.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value              |
      | customerId                                   | session_customerId |
      | walletProfile.monthlySpending                | notnull            |
      | walletProfile.defaultMonthlySpending         | true               |
      | walletProfile.spendingByCategory.OTHER       | notnull            |
      | walletProfile.spendingByCategory.GROCERIES   | notnull            |
      | walletProfile.spendingByCategory.TRAVEL      | notnull            |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull            |
      | walletProfile.spendingByCategory.DINING      | notnull            |
      | walletProfile.spendingByCategory.GAS         | notnull            |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/update_wallet_internal.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value              |
      | customerId                                   | session_customerId |
      | walletProfile.monthlySpending                | notnull            |
      | walletProfile.defaultMonthlySpending         | false              |
      | walletProfile.spendingByCategory.OTHER       | notnull            |
      | walletProfile.spendingByCategory.GROCERIES   | notnull            |
      | walletProfile.spendingByCategory.TRAVEL      | notnull            |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull            |
      | walletProfile.spendingByCategory.DINING      | notnull            |
      | walletProfile.spendingByCategory.GAS         | notnull            |

  Scenario: Wallet INT - CARD_COACH
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile/retrieve endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/score.json replacing values:
      | creditScore | 799 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value              |
      | customerId                                   | session_customerId |
      | walletProfile.monthlySpending                | notnull            |
      | walletProfile.defaultMonthlySpending         | true               |
      | walletProfile.spendingByCategory.OTHER       | notnull            |
      | walletProfile.spendingByCategory.GROCERIES   | notnull            |
      | walletProfile.spendingByCategory.TRAVEL      | notnull            |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull            |
      | walletProfile.spendingByCategory.DINING      | notnull            |
      | walletProfile.spendingByCategory.GAS         | notnull            |
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/update_wallet_internal.json replacing values:
      | creditScore                                  | 799        |
      | walletProfile.monthlySpending                | 2600       |
      | walletProfile.defaultMonthlySpending         | false      |
      | walletProfile.priority                       | SAVE_MONEY |
      | walletProfile.rankSource                     | CARD_COACH |
      | walletProfile.spendingByCategory.GAS         | 200        |
      | walletProfile.spendingByCategory.DINING      | 300        |
      | walletProfile.spendingByCategory.GROCERIES   | 600        |
      | walletProfile.spendingByCategory.TRAVEL      | 200        |
      | walletProfile.spendingByCategory.DEPT_STORES | 300        |
      | walletProfile.spendingByCategory.OTHER       | 1000       |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value              |
      | customerId                                   | session_customerId |
      | walletProfile.rankSource                     | CARD_COACH         |
      | walletProfile.priority                       | SAVE_MONEY         |
      | walletProfile.monthlySpending                | 2600               |
      | walletProfile.defaultMonthlySpending         | false              |
      | walletProfile.spendingByCategory.OTHER       | 1000               |
      | walletProfile.spendingByCategory.GROCERIES   | 600                |
      | walletProfile.spendingByCategory.TRAVEL      | 200                |
      | walletProfile.spendingByCategory.DEPT_STORES | 300                |
      | walletProfile.spendingByCategory.DINING      | 300                |
      | walletProfile.spendingByCategory.GAS         | 200                |



