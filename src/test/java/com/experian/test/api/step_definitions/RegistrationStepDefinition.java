package com.experian.test.api.step_definitions;

import com.experian.test.api.RegistrationApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;


public class RegistrationStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(RegistrationStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private RegistrationApi registrationApi;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) registration service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        registrationApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(registrationApi);
    }



}