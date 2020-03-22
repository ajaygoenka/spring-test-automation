@api @survey
Feature: Call survey api and check response

  @AUT-3869
  Scenario: Validate the survey api for user that has not submitted answers
    # Create a new free user with below given profile
    Given I create a new free customer using at_frsas102 offer tags and below details
      | SSN       | 666685617                 |
      | firstName | Brandi                    |
      | lastName  | Dionne                    |
      | dob       | 1970-01-01                |
      | street    | 3531 Coal Fork Station Dr |
      | city      | Charleston                |
      | state     | WV                        |
      | zip       | 25306                     |


    And I create a new secure token with existing Customer ID and member scope
     # login through api
    Given I create a new external experian securelogin service request to the /api/securelogin/oauth/token endpoint
    And I add the following headers to the request
      | x-fn | off |
    And I add a jsonContent to the request body using file /json_objects/registration/securelogin.json replacing values:
      | username | session_userName |
    And I send the POST request with response type String
    Then The response status code should be 200
    And I save the value of attribute token.accessToken as secureToken

        # Post call for survey api 404
    Given I create a new external experian survey service request to the /api/survey endpoint
    And I add the default headers to the request
    And I add the secure token to the header
    And I send the GET request with response type ByteArray
    Then The response status code should be 404