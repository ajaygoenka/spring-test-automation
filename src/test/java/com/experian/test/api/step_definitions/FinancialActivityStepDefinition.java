package com.experian.test.api.step_definitions;

import com.experian.test.api.FinancialActivityApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


public class FinancialActivityStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(FinancialActivityStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private FinancialActivityApi financialActivityApi;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) financialActivity service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        financialActivityApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(financialActivityApi);
    }

}