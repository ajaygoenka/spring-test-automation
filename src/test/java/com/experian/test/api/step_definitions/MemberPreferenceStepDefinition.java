package com.experian.test.api.step_definitions;

import com.experian.test.api.AlertsApi;
import com.experian.test.api.MemberPreferenceApi;
import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


public class MemberPreferenceStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(MemberPreferenceStepDefinition.class);

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private MemberPreferenceApi memberPreferenceApi;




    @Given("^I create a new (internal experian|external experian) memberpreference service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        memberPreferenceApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(memberPreferenceApi);
    }

}