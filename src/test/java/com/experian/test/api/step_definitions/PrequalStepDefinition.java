package com.experian.test.api.step_definitions;

import com.experian.test.api.PersonalLoansApi;
import com.experian.test.api.PrequalApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


import static org.hamcrest.MatcherAssert.assertThat;
import static org.junit.Assert.assertTrue;


public class PrequalStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(PrequalStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private PrequalApi prequalApi;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) prequal service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        prequalApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(prequalApi);
    }

    @Then("^The response status code should be (\\d+) or (\\d+)$")
    public void the_response_status_code_should_be(int statusCode1, int statusCode2) throws Throwable {
        log.info(prequalApi.getResponseBody());
        assertTrue("Expected Status not received: Expected " + statusCode1 +" or "+ statusCode2+ ", Got: " + prequalApi.getStatusCode() + ":" + prequalApi.getResponseStatusReason(), statusCode1 == prequalApi.getStatusCode() ||statusCode2 == prequalApi.getStatusCode());
    }

}