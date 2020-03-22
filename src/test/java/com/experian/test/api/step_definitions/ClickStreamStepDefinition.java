package com.experian.test.api.step_definitions;

import com.experian.test.api.ClickstreamApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Arrays;


public class ClickStreamStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(ClickStreamStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private ClickstreamApi clickstreamApi;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) clickstream service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        clickstreamApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(clickstreamApi);
    }


    @Given("^I generate a marketingId for the existing customerId$")
    public void iGenerateAMarketingIdForTheExistingCustomerId() throws Throwable{
        clickstreamApi.setBaseUrl("/api/clickstream/uilog","external experian");
        commonStepDefinition.setApiObject(clickstreamApi);
        clickstreamApi.addHeaders(true);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.add_a_json_request_data_from_file("/json_objects/registration/marketing.json");
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("marketingid", "marketingId");;
    }
}