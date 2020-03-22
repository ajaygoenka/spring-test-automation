package com.experian.test.api.step_definitions;

import com.experian.test.api.AlertsApi;
import com.experian.test.api.BoeApi;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


public class BoesStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(BoesStepDefinition.class);

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private BoeApi boeApi;




    @Given("^I create a new (private experian|internal experian|external experian) boe service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        boeApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(boeApi);
    }

}