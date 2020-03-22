@api @endeavour @pii
Feature:Endeavour: PII service- INTERNAL ROUTES

  @PIIgetInternal
  Scenario Outline: PII-INTERNAL[1] - Get customer PII by customer ID  "/internal/pii/customers/{customerId}/piis"
    # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report


    # Internal GET call for PII
    Given I create a new internal experian PII service request to the /internal/pii/customers/{customerId}/piis endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    And make sure following attributes exist within response data with correct values
      | Atributes | Value |
      | ssn       | <ssn> |

    @int
    Examples:
      | customerId                       | ssn       |
      | 86cb303f565541069489107848e301db | 666253437 |

    @stg
    Examples:
      | customerId                       | ssn       |
      | f9152e7af320455cb2a213e4cbcfe98f | 666263675 |

