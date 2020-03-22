@api @endeavour @salesForceExternal
Feature:Endeavour: SALESFORCE - EXTERNAL Route

  Scenario Outline: SALESFORCE-EXTERNAL[1] - GET CUSTOMER DETAILS - ROUTE "/api/salesforce/customer/{customerId}"
    #PRE CONDITION - TEST DATA CREATION
    #Given I create a new free customer using at_frsas102 offer tags
    Given save the value of <customerId> as customerId

    # Post call for CRMO oauth token
    Given I create a new external experian oauth service request to the /api/oauth/token endpoint
    And I add the following headers to the request without default parameters
      | Content-Type | application/x-www-form-urlencoded; charset=UTF-8 |
      | Accept       | application/json, text/plain, */* |
      | x-fn | OFF |
    And I add a json request body using the file /json_objects/salesforce/crm.txt
    And I send the POST request with response type String
    Then The response status code should be 200

     # SAVE secure token
    And I save the value of attribute access_token as secureToken
    
    #GET CUSTOMER DETAILS
    Given I create a new external experian salesForce service request to the /api/salesforce/customer/{customerId} endpoint
    And I add the following headers to the request without default parameters
      | Accept       | application/json |
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

  @int
    Examples:
      | customerId                       |
      |b55aa47d8ac34659bad80bd89c2bba16 |

  Scenario: SALESFORCE-EXTERNAL[2] - TEST DATA
    #PRE CONDITION - TEST DATA CREATION
    Given I create a new free customer using at_frsas102 offer tags