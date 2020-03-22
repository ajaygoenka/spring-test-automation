@wallet

Feature: Validate that wallet via prequal

  Scenario: Wallet INT - CREDIT_MATCH Rank Source update external call
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile/retrieve endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/wallet/score.json
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value   |
      | customerId                                   |         |
      | walletProfile.monthlySpending                | notnull |
      | walletProfile.rankSource                     |         |
      | walletProfile.priority                       |         |
      | walletProfile.spendingByCategory.OTHER       | notnull |
      | walletProfile.spendingByCategory.GROCERIES   | notnull |
      | walletProfile.spendingByCategory.TRAVEL      | notnull |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull |
      | walletProfile.spendingByCategory.DINING      | notnull |
      | walletProfile.spendingByCategory.GAS         | notnull |
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a json request body using the file /json_objects/wallet/update_wallet_api.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value        |
      | customerId                                   |              |
      | walletProfile.monthlySpending                | notnull      |
      | walletProfile.rankSource                     | CREDIT_MATCH |
      | walletProfile.priority                       |              |
      | walletProfile.spendingByCategory.OTHER       | notnull      |
      | walletProfile.spendingByCategory.GROCERIES   | notnull      |
      | walletProfile.spendingByCategory.TRAVEL      | notnull      |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull      |
      | walletProfile.spendingByCategory.DINING      | notnull      |
      | walletProfile.spendingByCategory.GAS         | notnull      |

  Scenario: Wallet INT - NO Rank Source Set
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile/retrieve endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/wallet/score.json replacing values:
      | creditScore | 749 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value   |
      | customerId                                   |         |
      | walletProfile.monthlySpending                | notnull |
      | walletProfile.rankSource                     |         |
      | walletProfile.priority                       |         |
      | walletProfile.spendingByCategory.OTHER       | notnull |
      | walletProfile.spendingByCategory.GROCERIES   | notnull |
      | walletProfile.spendingByCategory.TRAVEL      | notnull |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull |
      | walletProfile.spendingByCategory.DINING      | notnull |
      | walletProfile.spendingByCategory.GAS         | notnull |
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a json request body using the file /json_objects/wallet/update_monthly_wallet_api.json
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value   |
      | customerId                                   |         |
      | walletProfile.monthlySpending                | 2820    |
      | walletProfile.rankSource                     |         |
      | walletProfile.priority                       |         |
      | walletProfile.spendingByCategory.OTHER       | notnull |
      | walletProfile.spendingByCategory.GROCERIES   | notnull |
      | walletProfile.spendingByCategory.TRAVEL      | notnull |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull |
      | walletProfile.spendingByCategory.DINING      | notnull |
      | walletProfile.spendingByCategory.GAS         | notnull |

  Scenario: Wallet INT - CARD_COACH
    Given I create a new free customer using at_frsas102 offer tags
    And I create a new secure token with existing Customer ID and member scope
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile/retrieve endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/wallet/score.json replacing values:
      | creditScore | 799 |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value   |
      | customerId                                   |         |
      | walletProfile.monthlySpending                | notnull |
      | walletProfile.rankSource                     |         |
      | walletProfile.priority                       |         |
      | walletProfile.spendingByCategory.OTHER       | notnull |
      | walletProfile.spendingByCategory.GROCERIES   | notnull |
      | walletProfile.spendingByCategory.TRAVEL      | notnull |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull |
      | walletProfile.spendingByCategory.DINING      | notnull |
      | walletProfile.spendingByCategory.GAS         | notnull |
    Given I create a new external experian wallet service request to the /api/prequal/wallet/profile endpoint
    And I add the following headers to the request
      | x-customer-id | session_customerId |
    And I add a jsonContent to the request body using file /json_objects/wallet/update_wallet_api.json replacing values:
      | creditScore              | 799        |
      | walletProfile.rankSource | CARD_COACH |
    And I send the PATCH request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Atributes                                    | Value      |
      | customerId                                   |            |
      | walletProfile.monthlySpending                | notnull    |
      | walletProfile.rankSource                     | CARD_COACH |
      | walletProfile.priority                       |            |
      | walletProfile.spendingByCategory.OTHER       | notnull    |
      | walletProfile.spendingByCategory.GROCERIES   | notnull    |
      | walletProfile.spendingByCategory.TRAVEL      | notnull    |
      | walletProfile.spendingByCategory.DEPT_STORES | notnull    |
      | walletProfile.spendingByCategory.DINING      | notnull    |
      | walletProfile.spendingByCategory.GAS         | notnull    |
