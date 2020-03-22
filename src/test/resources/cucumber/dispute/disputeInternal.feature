@disputeInternal
Feature:Endeavour: DISPUTE - INTERNAL ROUTE

  @stg
  Scenario: DISPUTE-INTERNAL[1] - GET CDF - ROUTE "/api/dispute/cdfs"
    And save the value of 9820053c1278495bbefa0c597cc6575b as customerId
    Given I create a new internal experian childMonitoring service request to the /api/dispute/cdfs endpoint
    And I add the default headers to the request
    And I send the GET request with response type ByteArray
    Then The response status code should be 200