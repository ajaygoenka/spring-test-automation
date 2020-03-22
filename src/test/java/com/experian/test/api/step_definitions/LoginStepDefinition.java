package com.experian.test.api.step_definitions;

import com.experian.test.api.ClickstreamApi;
import com.experian.test.api.LoginApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.JSONUtils;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.json.JSONObject;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import java.util.List;


public class LoginStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(LoginStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private LoginApi loginApi;

    @Autowired
    private EnvSetup envSetup;

    @Autowired
    public JSONUtils jsonUtils;


    @Given("^I create a new (internal experian|external experian) login service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        loginApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(loginApi);
    }

    @And("^make sure following attributes exist within response data with correct values in Customer Login Table$")
    public void iShouldConfirmFollowingAttributesArePresentInCustomerLoginDynamoTable(DataTable table) throws Throwable {
        JSONObject obj =  envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getCustomerLoginTable(),"userName",scenarioSession.getData("userName"),"tenantId","1");
        commonStepDefinition.validateDynamoDbAttribute(obj ,table);
    }




    @And("^make sure following attributes exist within response data with correct values in Subscription Payment Table$")
    public void iShouldConfirmFollowingAttributesArePresentInSubscriptionPaymentDynamoTable(DataTable table) throws Throwable {
        JSONObject obj =  envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getSubscriptionPaymentTable(),"customerId",scenarioSession.getData("customerId"),"subscriptionHistoryId",scenarioSession.getData("subscriptionHistoryId"));
        commonStepDefinition.validateDynamoDbAttribute(obj ,table);
    }

    @And("^make sure following attributes exist within response data with correct values in Vault Account Table$")
    public void iShouldConfirmFollowingAttributesArePresentInVaultAccountDynamoTable(DataTable table) throws Throwable {
        JSONObject obj =  envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getVaultAccountTable(),"customerId",scenarioSession.getData("customerId"));
        commonStepDefinition.validateDynamoDbAttribute(obj ,table);
    }


}


    /*
    @And("^I delete the Offers with OfferID from DynamoDB OFFERS table$")
    public void iDeleteTheTestOffersByOfferIDFromDynamoDB() throws Throwable {
        envSetup.getBaseEnvSetup().getDynmamoDBUtil().deleteItem(envSetup.getOfferTable(),"offerId",scenarioSession.getData("offerId"));

    }

    @And("^I Create the offer data into the offer table with json body using the file (.*)$")
    public void ICreatetheofferdataintotheoffertable(String json , DataTable table) throws Throwable {
        envSetup.getBaseEnvSetup().getDynmamoDBUtil().insertJSONintoDynamoTable(envSetup.getOfferTable(),"offerId", scenarioSession.getData("offerId"),json,table,scenarioSession);

     }

*/