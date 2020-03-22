Feature: Validate rank Sources

  @issue:AUT-3801
  Scenario: update ranksource is Card_Coach
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_rs.json replacing values:
      | creditScore                          | 720        |
      | walletProfile.monthlySpending        | 2500       |
      | walletProfile.defaultMonthlySpending | true       |
      | walletProfile.rankSource             | Card_Coach |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update ranksource is CREDIT_MATCH
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_rs.json replacing values:
      | creditScore                          | 720          |
      | walletProfile.monthlySpending        | 2500         |
      | walletProfile.defaultMonthlySpending | true         |
      | walletProfile.priority               | CASH_BACK    |
      | walletProfile.rankSource             | CREDIT_MATCH |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value        |
      | customerId                                   |              |
      | walletProfile.monthlySpending                | 2500         |
      | walletProfile.rankSource                     | CREDIT_MATCH |
      | walletProfile.priority                       | CASH_BACK    |
      | walletProfile.defaultMonthlySpending         | false        |
      | walletProfile.spendingByCategory.GAS         | 160          |
      | walletProfile.spendingByCategory.GROCERIES   | 350          |
      | walletProfile.spendingByCategory.TRAVEL      | 170          |
      | walletProfile.spendingByCategory.DEPT_STORES | 150          |
      | walletProfile.spendingByCategory.DINING      | 310          |
      | walletProfile.spendingByCategory.OTHER       | 1360         |

  @issue:AUT-3801
  Scenario: update ranksource is CARD_COACH
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_rs.json replacing values:
      | creditScore                          | 720        |
      | walletProfile.monthlySpending        | 2500       |
      | walletProfile.defaultMonthlySpending | true       |
      | walletProfile.priority               | CASH_BACK  |
      | walletProfile.rankSource             | CARD_COACH |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value      |
      | customerId                                   |            |
      | walletProfile.monthlySpending                | 2500       |
      | walletProfile.rankSource                     | CARD_COACH |
      | walletProfile.priority                       | CASH_BACK  |
      | walletProfile.defaultMonthlySpending         | false      |
      | walletProfile.spendingByCategory.GAS         | 160        |
      | walletProfile.spendingByCategory.GROCERIES   | 350        |
      | walletProfile.spendingByCategory.TRAVEL      | 170        |
      | walletProfile.spendingByCategory.DEPT_STORES | 150        |
      | walletProfile.spendingByCategory.DINING      | 310        |
      | walletProfile.spendingByCategory.OTHER       | 1360       |

  @issue:AUT-3801
  Scenario: update ranksource is ""
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_rs.json replacing values:
      | creditScore                          | 720       |
      | walletProfile.monthlySpending        | 2500      |
      | walletProfile.defaultMonthlySpending | true      |
      | walletProfile.priority               | CASH_BACK |
      | walletProfile.rankSource             |           |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400

  @issue:AUT-3801
  Scenario: update ranksource is integer
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new internal experian wallet service request to the /wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/wallet_profile_rs.json replacing values:
      | creditScore                          | 720       |
      | walletProfile.monthlySpending        | 2500      |
      | walletProfile.defaultMonthlySpending | true      |
      | walletProfile.priority               | CASH_BACK |
      | walletProfile.rankSource             | 200       |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 400
