package com.experian.test.api.step_definitions;

import com.experian.test.api.LoginApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.JSONUtils;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.json.JSONObject;
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

