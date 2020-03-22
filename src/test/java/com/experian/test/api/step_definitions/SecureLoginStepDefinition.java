package com.experian.test.api.step_definitions;

import com.experian.test.api.OauthApi;
import com.experian.test.api.SecureLoginApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class SecureLoginStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(SecureLoginStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private SecureLoginApi secureLoginApi;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) securelogin service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        secureLoginApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(secureLoginApi);
    }

}