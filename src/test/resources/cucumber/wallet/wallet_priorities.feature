Feature: Validate Priorities

  @issue:AUT-3801
  Scenario: update priorities is null
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643   |
      | walletProfile.monthlySpending                | 2500  |
      | walletProfile.priority                       | null  |
      | walletProfile.spendingByCategory.GAS         | 21000 |
      | walletProfile.spendingByCategory.DINING      | 310   |
      | walletProfile.spendingByCategory.GROCERIES   | 0     |
      | walletProfile.spendingByCategory.TRAVEL      | 170   |
      | walletProfile.spendingByCategory.DEPT_STORES | 200   |
      | walletProfile.spendingByCategory.OTHER       | 20000 |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update priorities is CASH_BACK
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643       |
      | walletProfile.monthlySpending                | 2500      |
      | walletProfile.priority                       | CASH_BACK |
      | walletProfile.spendingByCategory.GAS         | 21000     |
      | walletProfile.spendingByCategory.DINING      | 310       |
      | walletProfile.spendingByCategory.GROCERIES   | 0         |
      | walletProfile.spendingByCategory.TRAVEL      | 170       |
      | walletProfile.spendingByCategory.DEPT_STORES | 200       |
      | walletProfile.spendingByCategory.OTHER       | 20000     |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value     |
      | customerId                                   |           |
      | walletProfile.monthlySpending                | 41680     |
      | walletProfile.priority                       | CASH_BACK |
      | walletProfile.defaultMonthlySpending         | false     |
      | walletProfile.spendingByCategory.GAS         | 21000     |
      | walletProfile.spendingByCategory.GROCERIES   | 0         |
      | walletProfile.spendingByCategory.TRAVEL      | 170       |
      | walletProfile.spendingByCategory.DEPT_STORES | 200       |
      | walletProfile.spendingByCategory.DINING      | 310       |
      | walletProfile.spendingByCategory.OTHER       | 20000     |

  @issue:AUT-3801
  Scenario: update priorities is travel
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643    |
      | walletProfile.monthlySpending                | 2500   |
      | walletProfile.priority                       | TRAVEL |
      | walletProfile.spendingByCategory.GAS         | 21000  |
      | walletProfile.spendingByCategory.DINING      | 310    |
      | walletProfile.spendingByCategory.GROCERIES   | 0      |
      | walletProfile.spendingByCategory.TRAVEL      | 170    |
      | walletProfile.spendingByCategory.DEPT_STORES | 200    |
      | walletProfile.spendingByCategory.OTHER       | 20000  |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value  |
      | customerId                                   |        |
      | walletProfile.monthlySpending                | 41680  |
      | walletProfile.priority                       | TRAVEL |
      | walletProfile.defaultMonthlySpending         | false  |
      | walletProfile.spendingByCategory.GAS         | 21000  |
      | walletProfile.spendingByCategory.GROCERIES   | 0      |
      | walletProfile.spendingByCategory.TRAVEL      | 170    |
      | walletProfile.spendingByCategory.DEPT_STORES | 200    |
      | walletProfile.spendingByCategory.DINING      | 310    |
      | walletProfile.spendingByCategory.OTHER       | 20000  |

  @issue:AUT-3801
  Scenario: update priorities is SAVE_MONEY
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643        |
      | walletProfile.monthlySpending                | 2500       |
      | walletProfile.priority                       | SAVE_MONEY |
      | walletProfile.spendingByCategory.GAS         | 21000      |
      | walletProfile.spendingByCategory.DINING      | 310        |
      | walletProfile.spendingByCategory.GROCERIES   | 0          |
      | walletProfile.spendingByCategory.TRAVEL      | 170        |
      | walletProfile.spendingByCategory.DEPT_STORES | 200        |
      | walletProfile.spendingByCategory.OTHER       | 20000      |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value      |
      | customerId                                   |            |
      | walletProfile.monthlySpending                | 41680      |
      | walletProfile.priority                       | SAVE_MONEY |
      | walletProfile.defaultMonthlySpending         | false      |
      | walletProfile.spendingByCategory.GAS         | 21000      |
      | walletProfile.spendingByCategory.GROCERIES   | 0          |
      | walletProfile.spendingByCategory.TRAVEL      | 170        |
      | walletProfile.spendingByCategory.DEPT_STORES | 200        |
      | walletProfile.spendingByCategory.DINING      | 310        |
      | walletProfile.spendingByCategory.OTHER       | 20000      |

  @issue:AUT-3801
  Scenario: update priorities is REWARDS
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643     |
      | walletProfile.monthlySpending                | 2500    |
      | walletProfile.priority                       | REWARDS |
      | walletProfile.spendingByCategory.GAS         | 21000   |
      | walletProfile.spendingByCategory.DINING      | 310     |
      | walletProfile.spendingByCategory.GROCERIES   | 0       |
      | walletProfile.spendingByCategory.TRAVEL      | 170     |
      | walletProfile.spendingByCategory.DEPT_STORES | 200     |
      | walletProfile.spendingByCategory.OTHER       | 20000   |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update priorities is cash_back
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_pr.json replacing values:
      | creditScore                                  | 643       |
      | walletProfile.monthlySpending                | 2500      |
      | walletProfile.priority                       | cash_back |
      | walletProfile.spendingByCategory.GAS         | 21000     |
      | walletProfile.spendingByCategory.DINING      | 310       |
      | walletProfile.spendingByCategory.GROCERIES   | 0         |
      | walletProfile.spendingByCategory.TRAVEL      | 170       |
      | walletProfile.spendingByCategory.DEPT_STORES | 200       |
      | walletProfile.spendingByCategory.OTHER       | 20000     |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400
