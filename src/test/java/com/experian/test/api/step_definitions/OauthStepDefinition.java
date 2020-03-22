package com.experian.test.api.step_definitions;

import com.experian.test.api.OauthApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioSession;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class OauthStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(OauthStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private OauthApi oauthApi;

    @Autowired
    private EnvSetup envSetup;


    @And("^Saved value (.*) as (.*)$")
    public void savedvalueas(String value, String keyName) throws Throwable {
        scenarioSession.putData(keyName,value);
    }

    @Given("^I create a new (internal experian|external experian) oauth service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        oauthApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(oauthApi);
    }

    @Given("^I create a new secure token with (random|blank|existing|UUID) Customer ID and (.*) scope$")
    public void createSecureToken(String custId, String scopeValue) throws Throwable {

        List<List<String>> requestList = null;
        DataTable requestDataTable = null;
        String userName = null;
        String password = "Password1";

        if (!(scenarioSession.getData("password") == null)) {
            password = scenarioSession.getData("password");
        }

        oauthApi.setBaseUrl("/api/oauth/token", "external experian");
        commonStepDefinition.setApiObject(oauthApi);
        Map headersMap = new HashMap<String, String>();
        headersMap.put("Content-Type", "application/x-www-form-urlencoded");
        oauthApi.addHeaders(headersMap,false);

        if (custId.equals("existing"))
            userName = scenarioSession.getData("userName");

        requestList = Arrays.asList(Arrays.asList("grant_type", "password"),Arrays.asList("scope", scopeValue),Arrays.asList("client_id", "experian"),Arrays.asList("username", userName),Arrays.asList("password", password));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.i_add_the_following_jsonContent_to_the_param_of_the_request(requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "String");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("access_token", "secureToken");
    }




}