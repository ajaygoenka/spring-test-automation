package com.experian.test.api.step_definitions;


import com.experian.test.api.ReportApi;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.api.step_definitions.CommonStepDefinition;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.JSONUtils;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.And;
import org.json.JSONObject;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertTrue;

public class ReportStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(PersonalLoanStepDefinition.class);
    JSONUtils jsonUtils;

    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private ReportApi reportApi;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private EnvSetup envSetup;

    private int number_of_records_bonusResourceTable;

    @Given("^I create a new (internal experian|external experian) report service request to the (.*) endpoint$")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        reportApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(reportApi);
    }

    @And("^make sure following attributes exist within response data with correct values in BonusResources Table$")
    public void verify_record_inserted_in_dynamo_bonus_resoucre_table(DataTable table) throws Throwable {
        ArrayList<JSONObject> TableData = null;

        TableData = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getAllResultsFromTable(envSetup.getBonusResourcesTable(), "customerId", scenarioSession.getData("customerId"), "customerId,BonusStatus,TriggerSource");

        number_of_records_bonusResourceTable = TableData.size();
        assertTrue("tableData row is empty", TableData.size()>0);
        for(int j = 1; j < TableData.size(); j++ ) {

            List<List<String>> rows = table.raw();
            for (int i = 1; i < rows.size(); i++) {
                String attribute = rows.get(i).get(0);
                String value = rows.get(i).get(1);

                if (!attribute.isEmpty())
                    Assert.assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(TableData.get(j), attribute));

                if (!value.isEmpty())
                    Assert.assertEquals(attribute + " didn\'t match expected", value, jsonUtils.getNodeValue(TableData.get(j), attribute));
            }
        }
    }
    @And("^the bonusResources table now has (\\d+) record/s$")
    public void verify_number_of_records_in_bonus_resource_table(int dbRecordCount) throws Throwable {

        ArrayList<JSONObject> TableData = null;

        TableData = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getAllResultsFromTable(envSetup.getBonusResourcesTable(), "customerId", scenarioSession.getData("customerId"), "customerId,BonusStatus,TriggerSource");

        number_of_records_bonusResourceTable = TableData.size();
        Assert.assertEquals("Number of records in BonusResources table is" + number_of_records_bonusResourceTable, dbRecordCount, number_of_records_bonusResourceTable);


    }

}
