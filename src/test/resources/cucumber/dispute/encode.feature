Feature:ENCODE

  @ignore
  Scenario Outline:Endeavour: ENCODE
    And save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    And I encode the customerId <customerId> and subscriptionId <subscriptionId>
    @stg @ignore
    Examples:
      | customerId                       | subscriptionId                   |
      | 61e3d3cc01ca44fc82280b8d9219b412 | 8d581b0240bf455a91a407eebcdebe0a |

    @int @ignore
    Examples:
      | customerId                       | subscriptionId                       |
      | dc68316eca51420b8ab6f991d5c2d8f5 | c0072758-b845-4771-b03e-8ddf22d90d74 |