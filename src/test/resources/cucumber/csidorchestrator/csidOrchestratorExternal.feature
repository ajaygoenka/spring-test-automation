@csidOrchestratorExtrenal @api @endeavour
Feature:Endeavour: CSID-ORCHESTRATOR - EXTERNAL Route

  @ignore
  Scenario:  CSID-ORCHESTRATOR-EXTERNAL[1] - CHILD SCAN by SubscriptionId- METHOD: POST

     # for given Below Data
    Given I create a new free customer using at_frsas103 offer tags
    And I save the value of attribute customerId as customerId
    And I create a new secure token with existing Customer ID and member scope


    Given I create a new external experian csidOrchestrator service request to the /api/csid-orchestrator/v1/childscan/{subscriptionId} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/csidOrchestrator/postchildscan.json replacing values:
      | firstName   | aruna       |
      | ssn         | 9digit-ssn  |
    And I send the POST request with response type String
    Then The response status code should be 200


  Scenario: CSID-ORCHESTRATOR-EXTERNAL[2] - Add a darkweb match info request- DARK WEB EMAIL- METHOD: POST
        # for given Below Data
    Given I create a new free customer using at_frsas103 offer tags
    And I create a new secure token with existing Customer ID and member scope

    Given I create a new external experian csidOrchestrator service request to the /api/csid-orchestrator/v1/darkweb/email endpoint
    And I add the default headers to the request
    When I add the customerid to the header
    #And I add the secure token to the header
    And I add a jsonContent to the request body using file /json_objects/csidOrchestrator/darkwebemail.json replacing values:
      | email | fake_email |
    And I send the POST request with response type ByteArray
    Then The response status code should be 200


  @ignore
  Scenario Outline: CSID-ORCHESTRATOR-EXTERNAL[3] - DARK WEB REPORT- METHOD: GET
        # for given Below Data
    Given save the value of <customerId> as customerId
    And I embed the Scenario Session value of type customerId in report
    Given save the value of <subscriptionId> as subscriptionId
    And I embed the Scenario Session value of type subscriptionId in report


    Given I create a new external experian csidOrchestrator service request to the /api/csid-orchestrator/v1/darkweb/report/{matchinfo}/{email} endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 200

    @int @ignore
    Examples:
      | customerId                       | subscriptionId |
      | 2d12970feffe4d83b0e502580e11afa8 | fd567ffe-92d2-4a63-b5d0-7c53cb9a766e |
   # @stg
   # Examples:
    #  | customerId                       | subscriptionId |
     # | 896416c0c34748218aacf36ba3ec110e |                |














