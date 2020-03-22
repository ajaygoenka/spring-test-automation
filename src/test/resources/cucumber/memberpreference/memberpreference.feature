@memberpreference
Feature:Justice League: Integration Tests for Member Preference

  @AUT-4026
  Scenario: Happy Flow - Update showTerms and Enabled
    And save the value of int_jason_corderorivera_1 as userName
    And I create a new secure token with existing Customer ID and member scope
    #Verify Response Code and Check showTerms Attributes value false
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | false |
    # Verify Response Code and Update showTerms Attributes to True
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.enabled   | false |
      | prequal.showTerms | false |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | false |
   # Verify Response Code and Check showTerms Attributes value true
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | false |
    # Verify Response Code and Update showTerms Attributes to False
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.enabled   | true |
      | prequal.showTerms | true |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | true  |
      | prequal.showTerms | true  |

  @AUT-4027
  Scenario: Credit File Frozen - showTerm
    And save the value of int_ophelia_forzen_sv as userName
    And I create a new secure token with existing Customer ID and member scope
    #Verify Response Code and Check showTerms Attributes value false
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | false |
    # Verify Response Code and Update showTerms Attributes to True
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.showTerms | true |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.showTerms | true  |
   # Verify Response Code and Check showTerms Attributes value true
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | true  |
    # Verify Response Code and Update showTerms Attributes to False
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.showTerms | false |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.showTerms | false |

  @AUT-4028
  Scenario: Unscorable User -  Update showTerm only
    And save the value of kathy_noscore as userName
    And save the value of Password@1 as password
    And I create a new secure token with existing Customer ID and member scope
    #Verify Response Code and Check showTerms Attributes value false
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | false |
    # Verify Response Code and Update showTerms Attributes to True
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.showTerms | true |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.showTerms | true  |
   # Verify Response Code and Check showTerms Attributes value true
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | true  |
    # Verify Response Code and Update showTerms Attributes to False
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences.json replacing values:
      | prequal.showTerms | false |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.showTerms | false |

  @AUT-4029
  Scenario: Apollo Member Preference - Update Enabled only
    And save the value of apollo_gordonty2c as userName
    And save the value of Password3 as password
    And I create a new secure token with existing Customer ID and member scope
    #Verify Response Code and Check showTerms Attributes value false
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | false |
      | prequal.showTerms | true  |
    # Verify Response Code and Update showTerms Attributes to True
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences_enable.json replacing values:
      | prequal.enabled | true |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | true  |
   # Verify Response Code and Check showTerms Attributes value true
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes        | Value |
      | prequal.enabled   | true  |
      | prequal.showTerms | true  |
    # Verify Response Code and Update showTerms Attributes to False
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences_enable.json replacing values:
      | prequal.enabled | false |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | false |

  @AUT-4030
  Scenario: Restrcited State Member Preference - Enabled only
    And save the value of marciaiglesia20161124 as userName
    And save the value of password as password
    And I create a new secure token with existing Customer ID and member scope
    #Verify Response Code and Check showTerms Attributes value false
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | false |
    # Verify Response Code and Update showTerms Attributes to True
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences_enable.json replacing values:
      | prequal.enabled | true |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | true  |
   # Verify Response Code and Check showTerms Attributes value true
    Given I create a new external experian memberpreference service request to the /api/memberpreference/getPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | true  |
    # Verify Response Code and Update showTerms Attributes to False
    Given I create a new external experian memberpreference service request to the /api/memberpreference/setPreferences endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/memberpreference/setPreferences_enable.json replacing values:
      | prequal.enabled | false |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200
    And make sure following attributes exist within response data with correct values
      | Attributes      | Value |
      | prequal.enabled | false |