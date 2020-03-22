package com.experian.test.api.step_definitions;

import com.experian.test.api.PersonalLoansApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioSession;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import static org.springframework.test.util.AssertionErrors.assertEquals;


public class PersonalLoanStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(PersonalLoanStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private PersonalLoansApi personalLoansApi;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private EnvSetup envSetup;


    @Given("^I create a new (internal experian|external experian) personalloans service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        personalLoansApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(personalLoansApi);
    }


    @And("^make sure following attributes exist within response data with correct values in LoanOffers Table$")
    public void makeSureFollowingAttributesExistWithinResponseDataWithCorrectValuesInLoanOffersTable(DataTable table) throws Throwable {
        JSONObject obj = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getLoanOffersTable(),"lenderTransactionId", scenarioSession.getData("lenderTransactionId"));
        commonStepDefinition.validateDynamoDbAttribute(obj, table);
    }

    @And("^make sure following attributes exist within response data with correct values in CustomerLoanProfile Table$")
    public void makeSureFollowingAttributesExistWithinResponseDataWithCorrectValuesInCustomerLoanProfileTable(DataTable table) throws Throwable {
        JSONObject obj = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getCustomerLoanProfileTable(),"customerId", scenarioSession.getData("customerId"));
        commonStepDefinition.validateDynamoDbAttribute(obj, table);
    }

    @And("^I want to delete the entry from LoanOffers Table for (.*)$")
    public void iWantToDeleteTheEntryFromLoanOffersTableForLendertanxId(String lenderTrxId) throws Throwable{
        if(lenderTrxId.contains("session")){
            lenderTrxId =  scenarioSession.getData(lenderTrxId.substring(lenderTrxId.indexOf("_") + 1, lenderTrxId.length()));
        }
        envSetup.getBaseEnvSetup().getDynmamoDBUtil().deleteItem(envSetup.getLoanOffersTable(),"lenderTransactionId",lenderTrxId);

    }
}