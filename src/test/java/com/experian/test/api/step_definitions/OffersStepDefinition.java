package com.experian.test.api.step_definitions;

import com.experian.test.api.OffersApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.JSONUtils;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.DataTable;
import org.json.JSONObject;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.CoreMatchers.containsString;
import static org.junit.Assert.*;
import static org.springframework.test.util.AssertionErrors.assertEquals;


public class OffersStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(OffersStepDefinition.class);

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private OffersApi offersApi;

    @Autowired
    private EnvSetup envSetup;

    @Autowired
    public JSONUtils jsonUtils;


    @Given("^I create a new (internal experian|external experian) offers service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        offersApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(offersApi);
    }


    @And("^make sure following attributes exist within response data with correct values in Subscription Table$")
    public void iShouldConfirmFollowingAttributesArePresentInSubscriptionDynamoTable(DataTable table) throws Throwable {
        JSONObject obj = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getSubscriptionTable(), "customerId", scenarioSession.getData("customerId"),"subscriptionId",scenarioSession.getData("subscriptionId"));
        commonStepDefinition.validateDynamoDbAttribute(obj ,table);
    }

    @And("^make sure following attributes exist within response data with correct values in Subscription History Table$")
    public void iShouldConfirmFollowingAttributesArePresentInSubscriptionHistoryDynamoTable(DataTable table) throws Throwable {
        String obj = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTableUsingIndex(envSetup.getSubscriptionHistoryTable(), "subscriptionHistoryId-index","subscriptionHistoryId ", scenarioSession.getData("subscriptionHistoryId"));
        commonStepDefinition.validateDynamoDbAttribute(new JSONObject(obj),table);
    }

    @And("^make sure following attributes exist within response data with correct values in Subscription Benefit Table$")
    public void iShouldConfirmFollowingAttributesArePresentInSubscriptionBenefitDynamoTable(DataTable table) throws Throwable {
        ArrayList<JSONObject> TableData = null;
        TableData = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getAllResultsFromTable(envSetup.getSubscriptionBenefitTable(), "subscriptionId", scenarioSession.getData("subscriptionId"), "customerId,benefitId");
        assertTrue("tableData row is empty", TableData.size()>0);

        for(int j = 0; j < TableData.size(); j++ ) {
            offersApi.setJsonObject(TableData.get(j));

            List<List<String>> rows = table.raw();
            for (int i = 1; i < rows.size(); i++) {
                String attribute = rows.get(i).get(0);
                String value = rows.get(i).get(1);

                    if (!attribute.isEmpty())
                        Assert.assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(offersApi.getResponseJson(), attribute));

                    if (!value.isEmpty())  {

                        if (value.contains("session_")) {
                            assertEquals(attribute + " didn't match expected", scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length())), jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                        } else if (value.contains("notnull")) {
                            assertNotNull(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                        }else if (attribute.contains("benefitId")) {
                            assertThat(attribute + " didn't match expected",value,containsString(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute)));
                            assertTrue(attribute + " count didn't match expected",value.split(",").length == TableData.size());
                        } else {
                            assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                        }
                    }

                }



        }

        }

    @And("^make sure following attributes exist within response data with correct values in Enrollment Benefit Table$")
    public void iShouldConfirmFollowingAttributesArePresentInEnrollmentBenefitDynamoTable(DataTable table) throws Throwable {
        ArrayList<JSONObject> TableData = null;
        TableData = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getAllResultsFromTable(envSetup.getEnrollmentBenefitTable(), "subscriptionId", scenarioSession.getData("subscriptionId"), "customerId,benefitId");
        assertTrue("tableData row is empty", TableData.size()>0);

        for(int j = 0; j < TableData.size(); j++ ) {
            offersApi.setJsonObject(TableData.get(j));

            List<List<String>> rows = table.raw();
            for (int i = 1; i < rows.size(); i++) {
                String attribute = rows.get(i).get(0);
                String value = rows.get(i).get(1);

                if (!attribute.isEmpty())
                    Assert.assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(offersApi.getResponseJson(), attribute));

                if (!value.isEmpty())  {

                    if (value.contains("session_")) {
                        assertEquals(attribute + " didn't match expected", scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length())), jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    } else if (value.contains("notnull")) {
                        assertNotNull(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    }else if (attribute.contains("benefitId")) {
                        assertThat(attribute + " didn't match expected",value,containsString(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute)));
                        assertTrue(attribute + " count didn't match expected",value.split(",").length == TableData.size());
                    } else {
                        assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    }
                }

            }



        }


    }

    @And("^make sure following attributes exist within response data with correct values in Enrollment Benefit History Table$")
    public void iShouldConfirmFollowingAttributesArePresentInEnrollmentBenefitHistoryDynamoTable(DataTable table) throws Throwable {
        ArrayList<JSONObject> TableData = null;
        TableData = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getAllResultsFromTable(envSetup.getEnrollmentBenefitHistoryTable(), "subscriptionId", scenarioSession.getData("subscriptionId"), "customerId,benefitId");
        assertTrue("tableData row is empty", TableData.size()>0);
        for(int j = 0; j < TableData.size(); j++ ) {
            offersApi.setJsonObject(TableData.get(j));

            List<List<String>> rows = table.raw();
            for (int i = 1; i < rows.size(); i++) {
                String attribute = rows.get(i).get(0);
                String value = rows.get(i).get(1);

                if (!attribute.isEmpty())
                    Assert.assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(offersApi.getResponseJson(), attribute));

                if (!value.isEmpty())  {

                    if (value.contains("session_")) {
                        assertEquals(attribute + " didn't match expected", scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length())), jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    } else if (value.contains("notnull")) {
                        assertNotNull(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    }else if (attribute.contains("benefitId")) {
                        assertThat(attribute + " didn't match expected",value,containsString(jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute)));
                    } else {
                        assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(offersApi.getResponseJson(), attribute));
                    }
                }

            }



        }





    }

}

