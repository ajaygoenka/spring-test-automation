package com.experian.test.api.step_definitions;

import com.experian.test.api.Oauth2Api;
import com.experian.test.api.OauthApi;
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


public class Oauth2StepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(Oauth2StepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private Oauth2Api oauth2Api;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) oauth2 service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        oauth2Api.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(oauth2Api);
    }

    @Given("^I create a new shared service oauth2 token$")
    public void createSecureToken() throws Throwable {

        List<List<String>> requestList = null;
        DataTable requestDataTable = null;

        oauth2Api.setBaseUrl("/api/oauth2/token", "external experian");
        commonStepDefinition.setApiObject(oauth2Api);
        Map headersMap = new HashMap<String, String>();
        headersMap.put("Content-Type", "application/x-www-form-urlencoded");
        oauth2Api.addHeaders(headersMap,false);
        requestList = Arrays.asList(Arrays.asList("grant_type", "trusted_partner"),Arrays.asList("client_id", "5458900453a952f1ddb7"),Arrays.asList("client_secret", "8893002a0306c61d597fe0b1e8ae738b52163017"),Arrays.asList("partner_customer_id", scenarioSession.getData("customerId")));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.i_add_the_following_jsonContent_to_the_param_of_the_request(requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "String");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("access_token", "secureToken");
    }


}