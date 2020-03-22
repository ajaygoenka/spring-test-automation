package com.experian.test.api.step_definitions;

import com.experian.test.api.AlertsApi;
import com.experian.test.api.DisputeApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import static com.experian.test.utils.Base64Util.encode;
import static com.experian.test.utils.Base64Util.encodeCustomerId;


public class AlertsStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(AlertsStepDefinition.class);

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private AlertsApi alertsApi;




    @Given("^I create a new (internal experian|external experian) alerts service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        alertsApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(alertsApi);
    }

}