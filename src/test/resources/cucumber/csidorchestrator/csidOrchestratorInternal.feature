@api @endeavour @csidOrchestratorInternal
Feature:Endeavour: CSID-ORCHESTRATOR - INTERNAL Route

    Scenario: CSID-ORCHESTRATOR-INTERNAL[1] - CYBER REPORT - DARK WEB REPORT ALERT
      Given I create a new free customer using at_frsas103 offer tags
      And I create a new secure token with existing Customer ID and member scope
    # login through api
      Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
      And I add the following headers to the request
        | x-fn         | off              |
      And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
        | username | session_userName |
      And I send the POST request with response type String
      Then The response status code should be 200
      And I save the value of attribute token.accessToken as secureToken

      Given I create a new internal experian csidOrchestrator service request to the /csid-orchestrator/v1/darkwebReportAlert/{customerId}/{subscriptionId} endpoint
      And I add the default headers to the request
      And I send the GET request with response type ByteArray
     Then The response status code should be 200
      And make sure following attributes exist within response data with correct values
        | Atributes                       | Value   |
        | memberDarkwebScanTimeFrequency  | notnull |


    Scenario: CSID-ORCHESTRATOR-INTERNAL[2] - PROCESS THROTTLE QUEUE EVENTS
      Given I create a new internal experian csidOrchestrator service request to the /csid-orchestrator/v1/processThrottleQueueEvents endpoint
      And I add the default headers to the request
      And I send the GET request with response type ByteArray
      Then The response status code should be 200

    Scenario: CSID-ORCHESTRATOR-INTERNAL[3] - PROCESS DARK WEB THROTTLE QUEUE EVENTS
      Given I create a new internal experian csidOrchestrator service request to the /csid-orchestrator/v1/processMemberDwScanThrottleQueueEvents endpoint
      And I add the default headers to the request
      And I send the GET request with response type ByteArray
      Then The response status code should be 200

    Scenario: CSID-ORCHESTRATOR-INTERNAL[4] - PROCESS CHILD SCAN THROTTLE QUEUE EVENTS
      Given I create a new internal experian csidOrchestrator service request to the /csid-orchestrator/v1/processChildScanThrottleQueueEvents endpoint
      And I add the default headers to the request
      And I send the GET request with response type ByteArray
      Then The response status code should be 200