@csidgateway
Feature:Endeavour: csidgateway - Internal Route


  Scenario Outline: CSID-GATEWAY-INTERNAL[1] - CYBER REPORT - DARK WEB
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report


    Given I create a new internal experian CsidGateway service request to the /csidgateway/v1/cyberReport endpoint
    And I add the following headers to the request
      | Content-Type | application/json |
      | Accept       | application/json |
    #When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int
    Examples:
      | customerId                       |
      | 2d12970feffe4d83b0e502580e11afa8 |
    @stg
    Examples:
      | customerId                       |
      | 896416c0c34748218aacf36ba3ec110e |


  Scenario: generate free test data
    Given I create a new free customer using at_frsas103 offer tags