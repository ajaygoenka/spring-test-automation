package com.experian.test.api.step_definitions;

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


public class DisputeStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(DisputeStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private DisputeApi disputeApi;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) dispute service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        disputeApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(disputeApi);
    }
    @And("^I encode the customerId (.*) and subscriptionId (.*)$")
    public void iEncodeTheCustomerIdCustomerIdAndSubscriptionIdSubscriptionId(String customerId, String subscriptionId) {
        log.info("MonitoredAccount: " + encode(subscriptionId));
        log.info("CustomerSuppliedData: " + encodeCustomerId(customerId));
    }
}