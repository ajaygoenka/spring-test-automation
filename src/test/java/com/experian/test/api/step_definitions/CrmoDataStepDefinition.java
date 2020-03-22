package com.experian.test.api.step_definitions;

import com.experian.test.api.CrmoDataApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class CrmoDataStepDefinition {
    private static final Logger log = (Logger) LoggerFactory.getLogger(CrmoDataStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private CrmoDataApi cmoDataApi;

    @Autowired
    private EnvSetup envSetup;

    @Given("^I create a new (internal experian|external experian) crmodata service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        cmoDataApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(cmoDataApi);
    }
}
