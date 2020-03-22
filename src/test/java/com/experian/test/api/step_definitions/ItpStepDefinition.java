package com.experian.test.api.step_definitions;

import com.experian.test.api.ItpApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

//@ContextConfiguration(classes = ApiTestConfig.class)
public class ItpStepDefinition {
    private static final Logger log = (Logger) LoggerFactory.getLogger(ItpStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private ItpApi  itpApi;

    @Autowired
    private EnvSetup envSetup;
    @Given("^I create a new (internal experian|external experian) ITP service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        itpApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(itpApi);
    }



}
