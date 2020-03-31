package com.auto.test.api.step_definitions;

import com.auto.test.api.LoginApi;
import com.auto.test.api.config.EnvSetup;
import com.auto.test.session.ScenarioSession;
import com.auto.test.utils.JSONUtils;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


public class LoginStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(LoginStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private LoginApi loginApi;

    @Autowired
    private EnvSetup envSetup;

    @Autowired
    public JSONUtils jsonUtils;


    @Given("^I create a new (internal auto|external auto) login service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        loginApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(loginApi);
    }

}

