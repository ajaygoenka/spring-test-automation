package com.experian.test.api.step_definitions;

import com.experian.test.api.api_objects.AbstractApiObject;
import com.experian.test.api.config.spring.ApiTestConfig;
import com.experian.test.session.ScenarioKey;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.*;
import com.experian.test.utils.aws.S3Util;
import com.github.javafaker.Faker;
import cucumber.api.DataTable;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.runtime.ScenarioImpl;
import org.hamcrest.core.Is;
import org.json.JSONObject;
import org.junit.Assert;
import org.skyscreamer.jsonassert.JSONAssert;
import org.skyscreamer.jsonassert.JSONCompareMode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.*;

import static org.hamcrest.CoreMatchers.containsString;
import static org.junit.Assert.*;
import static org.junit.Assert.assertThat;

@ContextConfiguration(classes = ApiTestConfig.class)
public class CommonStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(CommonStepDefinition.class);

    protected Scenario scenario;

    private AbstractApiObject apiObject;

    @Autowired
    public ScenarioSession scenarioSession;

    @Autowired
    public CustomerUtil customerUtil;

    @Autowired
    public S3Util s3Util;

    @Autowired
    public DateUtils dateUtils;

    @Autowired
    public JSONUtils jsonUtils;


    public void setApiObject(AbstractApiObject apiObject) {
        this.apiObject = apiObject;
    }

    /**
     * Get a reference to the current cucumber scenario
     * Supports writing text and xml to report within test steps
     *
     * @param scenario
     */
    @Before
    public void before(Scenario scenario) throws Exception {
        this.scenario = scenario;

    }

    @After
    public void after() throws Exception {
        String index = "*";
        String splunkquery;
        if (scenario.isFailed()) {
            if (System.getProperty("environment").equalsIgnoreCase("dev")) {
                index = "%20index=corvette_dev";
            } else if (System.getProperty("environment").equalsIgnoreCase("int")) {
                index = "%20index=corvette_int";
            } else if (System.getProperty("environment").equalsIgnoreCase("stg")) {
                index = "%20index=corvette_stage";
            }

            splunkquery = "<a href=\"https://experiancs.splunkcloud.com/en-US/app/ecs_app/search?q=" + scenarioSession.getData("sessionId") + index + "\">Splunk Query</a>";
            scenario.write("Error Message : " + ((ScenarioImpl) scenario).getError().getMessage());
            scenario.write("sessionId : " + scenarioSession.getData("sessionId"));
            scenario.embed(splunkquery.getBytes(), "text/html");

        }

    }


    public void embedTextInReport(String text) {
        scenario.write(text);
    }

    public void embedXmlInReport(String xml) {
        xml = "<textarea readonly>" + xml + "</textarea>";
        scenario.write(xml);
    }

    @Given("^I have loaded my data from the xml file (.*)$")
    public void i_have_loaded_my_data_from_xml_file(String customerDataXML) throws Throwable {
        apiObject.loadXMLFile(customerDataXML);
    }

    @When("^I add the following headers to the request$")
    public void add_the_following_headers_to_the_request(DataTable headersTable) throws Throwable {
        Map headersMap = new HashMap<String, String>();
        String header_name, header_value;
        for (List<String> row : headersTable.raw()) {
            header_name = row.get(0);
            header_value = row.get(1);
            // generate random value for that header which have random mentioned in its value as [<keyName>-random]
            if (header_value.contains("random")) {
                String session_key = header_value.substring(0, header_value.indexOf('-'));
                header_value = header_value.replace("random", String.valueOf(System.currentTimeMillis()));
                scenarioSession.putData(session_key, header_value);

            } else if (header_value.contains("auth_token")) {
                header_value = header_value.replace("auth_token", scenarioSession.getData("token_type") + " " + scenarioSession.getData("access_token"));
                log.info("Authorization : " + header_value);
            } else if (header_value.contains("UUID")) {
                String session_key = header_value.substring(0, header_value.indexOf('-'));
                header_value = this.apiObject.generateUUID();
                scenarioSession.putData(session_key, header_value);
            } else if (header_value.contains("session_")) {
                header_value = scenarioSession.getData(header_value.substring(header_value.indexOf("_") + 1, header_value.length()));
            }
            headersMap.put(header_name, header_value);
        }
        apiObject.addHeaders(headersMap);
    }

    @When("^I add the following headers to the request without default parameters$")
    public void add_the_following_headers_to_the_requestwithoutdefaultparamters(DataTable headersTable) throws Throwable {
        Map headersMap = new HashMap<String, String>();
        String header_name, header_value;
        for (List<String> row : headersTable.raw()) {
            header_name = row.get(0);
            header_value = row.get(1);
            // generate random value for that header which have random mentioned in its value as [<keyName>-random]
            if (header_value.contains("random")) {
                String session_key = header_value.substring(0, header_value.indexOf('-'));
                header_value = header_value.replace("random", String.valueOf(System.currentTimeMillis()));
                scenarioSession.putData(session_key, header_value);

            } else if (header_value.contains("auth_token")) {
                header_value = header_value.replace("auth_token", scenarioSession.getData("token_type") + " " + scenarioSession.getData("access_token"));
                log.info("Authorization : " + header_value);
            } else if (header_value.contains("UUID")) {
                String session_key = header_value.substring(0, header_value.indexOf('-'));
                header_value = this.apiObject.generateUUID();
                scenarioSession.putData(session_key, header_value);
            } else if (header_value.contains("session_")) {
                header_value = scenarioSession.getData(header_value.substring(header_value.indexOf("_") + 1, header_value.length()));
            }
            headersMap.put(header_name, header_value);
        }
        apiObject.addHeaders(headersMap, false);
    }

    @When("^I add the default headers to the request$")
    public void add_the_default_headers_to_the_request() throws Throwable {
        apiObject.addHeaders(true);
    }

    @When("^I remove the (.*) headers to the request$")
    public void remove_the_following_headers_to_the_request(String key) throws Throwable {
        apiObject.removeHeaders(key);
    }

    @When("^I remove all the params from the request$")
    public void remove_the_following_params_to_the_request() throws Throwable {
        apiObject.removeParams();
    }


    @When("^I add a query parameter (.*) with value (.*)$")
    public void i_add_a_query_param_xxx_with_value_yyy(String key, String value) throws Throwable {
        // Set the query parameter on the request url
        if (value.equals("createdCustomerId"))
            value = scenarioSession.getData(ScenarioKey.CUSTOMER_ID.getKey());
        if (value.equals("customerId"))
            value = customerUtil.getCustomer().getCustomerId();
        apiObject.setQueryParameter(key, value);
    }

    @When("^I wait for (.*) seconds$")
    public void i_wait_for_seconds(int waitTimeInSeconds) throws Throwable {
        Thread.sleep(waitTimeInSeconds * 1000);
    }

    @Then("^The response status code should be (\\d+)$")
    public void the_response_status_code_should_be(int statusCode) throws Throwable {
        log.info(apiObject.getResponseBody());
        assertTrue("Expected Status not received: Expected " + statusCode + ", Got: " + apiObject.getStatusCode() + ":" + apiObject.getResponseStatusReason(), statusCode == apiObject.getStatusCode());

    }

    @Given("^I add a json request body using the file (.*)$")
    public void add_a_json_request_data_from_file(String dataFile) throws Throwable {
        apiObject.addJSONRequestBodyFromFile(dataFile);
    }

    @Given("^I add the following json request body:$")
    public void add_a_json_request_data_embedded(String dataFile) throws Throwable {
        apiObject.addJSONRequestBodyData(dataFile);
    }

    @Given("^I add the following json content to the body of the request$")
    public void i_add_the_following_jsonContent_to_the_body_of_the_request(Map<String, String> requestBody) throws Throwable {
        apiObject.addJsonContentToBody(requestBody);
    }

    @Given("^I add the following json content to the param of the request$")
    public void i_add_the_following_jsonContent_to_the_param_of_the_request(DataTable paramTable) throws Throwable {
        MultiValueMap<String, String> bodymap = new LinkedMultiValueMap<>();
        Map requestBody = new HashMap<String, String>();
        String param_name, param_value;
        for (List<String> row : paramTable.raw()) {
            param_name = row.get(0);
            param_value = row.get(1);

            if (param_value.contains("session_"))
                param_value = scenarioSession.getData(param_value.substring(param_value.indexOf("_") + 1, param_value.length()));

            log.info(param_name + " = " + param_value);

            requestBody.put(param_name, param_value);
        }
        bodymap.setAll(requestBody);
        apiObject.addJsonContentToparam(bodymap);
    }

    @When("^I send the (GET|PUT|PATCH|POST|DELETE) request with response type (.*)$")
    public void i_send_the_request_with_response_type(String requestType, String responseType) throws Throwable {
        apiObject.sendRequestToService(requestType, responseType);
    }

    @Then("^The (.*) json node is equal to \"(.*)\"$")
    public void the_json_node_is_equal_to(String nodeName, String expValue) throws Throwable {
        String actValue = jsonUtils.getNodeValue(apiObject.getResponseJson(), nodeName);
        assertEquals("Didnt find the expected node value", expValue, actValue);
    }

    @Then("^The response body is equal to \"(.*)\"$")
    public void the_respose_body_is_equal_to(String expResponseBody) throws Throwable {
        assertEquals("Response body was not as expected", expResponseBody, apiObject.getResponseBody().trim());
    }

    @Then("^make sure following attributes (exist|doesnot exist|exist notEqual) within response data with correct values$")
    public void makeSureFollowingAttributesArePresentWithinResponse(String presence, DataTable table) throws Throwable {
        List<List<String>> rows = table.raw();
        for (int i = 1; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);
            String value = rows.get(i).get(1);

            if (presence.equals("exist") || presence.equals("exist notEqual"))
                assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(apiObject.getResponseJson(), attribute));
            else
                assertFalse("Not Expected: " + attribute + " But Found", jsonUtils.isNodePresent(apiObject.getResponseJson(), attribute));

            if (!value.isEmpty()) {
                if (presence.equals("exist")) {
                    if (value.equals("today")) {
                        assertTrue("Date mismatch", dateUtils.getToday().equals(apiObject.getNodeValueAsTodaysDate(attribute)));
                    } else if (value.contains("today+") || value.contains("today +")) {
                        value = value.replaceAll("\\s", "");
                        //scenario.write(value + " : " +dateUtils.getModifiedDate(dateUtils.getSimpleDateFormat("yyyy-MM-dd", "UTC"), "+", Integer.parseInt(value.substring(value.indexOf("+") + 1, value.length()))));
                        //scenario.write(attribute + " : " +apiObject.getNodeValueAsTodaysDate(attribute));
                        assertTrue("Date mismatch", dateUtils.getModifiedDate(dateUtils.getSimpleDateFormat("yyyy-MM-dd", "UTC"), "+", Integer.parseInt(value.substring(value.indexOf("+") + 1, value.length()))).equals(apiObject.getNodeValueAsTodaysDate(attribute)));
                    } else if (value.contains("today-") || value.contains("today -")) {
                        value = value.replaceAll("\\s", "");
                        //scenario.write(value + " : " +dateUtils.getModifiedDate(dateUtils.getSimpleDateFormat("yyyy-MM-dd", "UTC"), "-", Integer.parseInt(value.substring(value.indexOf("+") + 1, value.length()))));
                        //scenario.write(attribute + " : " +apiObject.getNodeValueAsTodaysDate(attribute));
                        assertTrue("Date mismatch", dateUtils.getModifiedDate(dateUtils.getSimpleDateFormat("yyyy-MM-dd", "UTC"), "-", Integer.parseInt(value.substring(value.indexOf("+") + 1, value.length()))).equals(apiObject.getNodeValueAsTodaysDate(attribute)));
                    } else if (value.contains("session_")) {
                        assertEquals(attribute + " didn't match expected", scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length())), jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
                    } else if (value.contains("contain") && !value.startsWith("not")) {
                        value = value.replace("contain-", "");
                        List expword = new ArrayList(Arrays.asList(value.split(" ")));
                        for (int j = 0; j < expword.size(); j++) {
                            //assertThat(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), containsString(expword.get(j).toString().trim()));
                            assertThat(expword.get(j).toString().trim() + " doesn't exist in the response body", jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), containsString(expword.get(j).toString().trim()));
                        }
                    } else if (value.contains("contain") && value.startsWith("not")) {
                        value = value.replace("not", "");
                        value = value.replace("contain-", "").trim();
                        List expword = new ArrayList(Arrays.asList(value.split(" ")));
                        for (int j = 0; j < expword.size(); j++) {
                            assertTrue(expword.get(j).toString().trim() + " exist in the response body", !(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute).contains(expword.get(j).toString().trim())));
                        }
                    } else if (value.contains("notnull") || value.contains("not null")) {
                        assertNotNull((jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute)));
                    } else if (value.equalsIgnoreCase("IsInteger")) {
                        assertTrue("attribute type is not Integer , value = " + jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), StringUtils.isInteger(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute)));
                    } else if (value.contains(">") || value.contains(">=") || value.contains("=>") || value.contains("<") || value.contains("<=") || value.contains("=<") || value.contains("=")) {
                        assertTrue("value is not match as  expected , value = " + jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), StringUtils.isValidOperator(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), value));
                    } else if (value.contains("sort-")) {
                        value = value.replace("sort-", "");
                        List expList = new ArrayList(Arrays.asList(value.split(",")));
                        Collections.sort(expList);
                        List actList = new ArrayList(Arrays.asList(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute).split(",")));
                        Collections.sort(actList);
                        assertEquals(attribute + " didn't match expected", expList, actList);
                        assertTrue(attribute + " didn't match expected", expList.size() == actList.size() && expList.containsAll(actList) && actList.containsAll(expList));

                    } else
                        assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
                } else if (presence.equals("exist notEqual"))
                    assertNotEquals(value, jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
            }
        }
    }


    @And("^I embed the (.*) value of type (session|attribute) in report$")
    public void embedTheScenarioValueInReportSession_Attribute(String value, String key) {
        if (key.equals("session")) {
            //Syntax value  : "keyname" from "I save the value of attribute (.*) as (.*)" step definition.
            scenario.write(value + " : " + scenarioSession.getData(value));
        } else if (key.equals("attribute")) {
            // Syntax value : data[0].attribute
            scenario.write(value + " : " + jsonUtils.getNodeValue(apiObject.getResponseJson(), value).toString());
            scenarioSession.putData(value.substring(value.indexOf(".") + 1, value.length()), jsonUtils.getNodeValue(apiObject.getResponseJson(), value).toString());
        }
    }

    @And("^I (save|embed) the (.*) value of type (.*) in report as text$")
    public void embedTheScenarioValueInReportText(String choice, String value, String key) {
        //value : "Any text" and Key : "Any type"
        if (choice.equals("embed")) {
            embedTextInReport(key + " : " + value);
        }
        scenarioSession.putData(key, value);
    }

    @And("^I embed the Scenario Session value of type (.*) in report$")
    public void embedTheScenarioValue(String key) {
        if (!scenarioSession.getData(key).equalsIgnoreCase(null))
            embedTextInReport(key + " : " + scenarioSession.getData(key));
    }

    @Then("^The response headers should contain the following items$")
    public void the_headers_should_contain_the_following_items(DataTable dataTable) throws Throwable {
        Set<Map.Entry<String, List<String>>> headersSet = apiObject.getHeaders().entrySet();
        Set<String> headersKeySet = apiObject.getHeaders().keySet();
        System.out.println(headersSet);
        System.out.println(headersKeySet);

        List<List<String>> rows = dataTable.raw();
        for (int i = 0; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);
            assertTrue("Expected: " + attribute + " Not Found", headersKeySet.contains(attribute));
        }
    }

    /*
     *  if you want to instert the array foramt in request body use "-" between each string
     *  eg. LC014--  -> ["LC014"]  , LC014--LC032  -> ["LC014",""LC032]
     *
     * */
    @And("^I add a jsonContent to the request body using file (.*) (replacing|deleting) values:$")
    public void add_and_edit_JsonContent_using_filename(String file_name, String action, DataTable dataTable) throws Throwable {

        String json_file_content = apiObject.addJSONRequestBodyFromFile(file_name);
        JSONObject json_to_send = new JSONObject(json_file_content);

        List<List<String>> rows = dataTable.raw();
        for (int i = 0; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);

            if (action.equals("replacing")) {
                String value = rows.get(i).get(1);

                if (value.contains("random")) {
                    String key = value.substring(0, value.indexOf('-'));
                    value = value.replace("random", String.valueOf(System.currentTimeMillis()));
                    scenarioSession.putData(key, value);

                } else if (value.contains("9digit")) {
                    String key = attribute;
                    value = String.valueOf(RandomUtils.randomInt(123456780, 890000000));
                    scenarioSession.putData(key, value);
                } else if (value.equalsIgnoreCase("fake_email")) {
                    String key = attribute;
                    value = value.replace("fake_email", new Faker().internet().safeEmailAddress());
                    scenarioSession.putData(key, value);

                } else if (value.equalsIgnoreCase("fake_username")) {
                    String key = attribute;
                    value = value.replace("fake_username", new Faker().name().username());
                    value = value + RandomUtils.randomAlphaString(2);
                    value = value.toLowerCase();
                    scenarioSession.putData(key, value);

                } else if (value.contains("customAlpha")) {
                    String key = value.substring(0, value.indexOf('-'));
                    value = RandomUtils.randomAlphaString(15);
                    scenarioSession.putData(key, value);

                } else if (value.equalsIgnoreCase("null")) {
                    value = null;

                } else if (value.contains("session_")) {
                    value = scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length()));

                } else if (value.contains("dynamic")) {
                    if (value.split("-")[1].equalsIgnoreCase("alpha")) {
                        value = RandomUtils.randomAlphaString(10);
                        scenarioSession.putData("dynamic" + attribute, value);
                    } else if (value.split("-")[1].equalsIgnoreCase("alphaNum")) {
                        value = RandomUtils.randomAlphaNumString(12);
                        scenarioSession.putData("dynamic" + attribute, value);
                    }
                }

                json_to_send = jsonUtils.modifyJSONAttributes(json_to_send, attribute, value);

            } else if (action.equals("deleting"))
                if (attribute.contains("."))
                    json_to_send = jsonUtils.modifyJSONAttributes(json_to_send, attribute, action);
                else
                    json_to_send.remove(attribute);
        }
        apiObject.addJSONRequestBodyData(json_to_send.toString());
    }

    @When("^I add the secure token to the header$")
    public void add_secure_token_to_the_header() throws Throwable {
        Map headersMap = new HashMap<String, String>();
        headersMap.put("Authorization", "Bearer " + scenarioSession.getData(ScenarioKey.SECURE_TOKEN.getKey()));
        apiObject.addHeaders(headersMap);
    }

    @When("^I add the customerid to the header$")
    public void add_customerid_to_the_header() throws Throwable {
        Map headersMap = new HashMap<String, String>();
        headersMap.put("x-customerid", scenarioSession.getData(ScenarioKey.CUSTOMER_ID.getKey()));
        apiObject.addHeaders(headersMap);
    }

    @And("^I save the value of attribute (.*) as (.*)$")
    public void iSaveTheValueOfAttributeNameAsKeyName(String attribute, String keyName) throws Throwable {
        if (attribute.equals(ScenarioKey.BROKER_PAYLOAD.getKey()))
            apiObject.jsonObject = new JSONObject(scenarioSession.getData(ScenarioKey.BROKER_PAYLOAD.getKey()));
        else if (attribute.contains("customerId")) {
            if (customerUtil.getCustomer() == null)
                customerUtil.createEmptyIDaaSCustomer();
            customerUtil.getCustomer().setCustomerId(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
        }

        scenarioSession.putData(keyName, jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
        log.info(keyName + " = " + scenarioSession.getData(keyName));
    }

    @And("^save the value of (.*) as (.*)$")
    public void iSaveTheValueOfAttribute(String value, String keyName) throws Throwable {
        scenarioSession.putData(keyName, value.trim());
        log.info(keyName + " = " + scenarioSession.getData(keyName));
    }

    @And("^I see an empty data response from service$")
    public void iSeeAnEmptyDataResponseFromService() throws Throwable {
        if (jsonUtils.isNodePresent(apiObject.getResponseJson(), "data"))
            assertEquals("Response is not Empty ", "[]", jsonUtils.getNodeValue(apiObject.getResponseJson(), "data"));
        else
            assertTrue("Expected: attribute Not Found", false);
    }


    @Then("^make sure following file (exist|doesnot exist) (.*)  in (.*) within (.*) S3 bucket$")
    public void makeSureFollowingFileExistinBucket(String presence, String filename, String folder, String bucketname) throws Throwable {
        if (presence.equals("exist") || presence.equals("exist notEqual"))
            assertTrue("Expected: " + filename + " Not Found", s3Util.isFilePresent(bucketname, folder, filename));
        else
            assertFalse("Not Expected: " + filename + " But Found", s3Util.isFilePresent(bucketname, folder, filename));
    }

    @Then("^make sure following sorted (.*) attributes (exist|exist notEqual) within response data with correct values$")
    public void makeSureFollowingsortedAttributesArePresentWithinResponse(String param, String presence, DataTable table) throws Throwable {
        List<List<String>> rows = table.raw();
        for (int i = 1; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);
            String value = rows.get(i).get(1);
            if (!presence.equals("exist") && !presence.equals("exist notEqual")) {
                Assert.assertFalse("Not Expected: " + attribute + " But Found", this.jsonUtils.isNodePresent(apiObject.sortJsonByKey(apiObject.getResponseJson(), param), attribute));
            } else {
                Assert.assertTrue("Expected: " + attribute + " Not Found", this.jsonUtils.isNodePresent(apiObject.sortJsonByKey(apiObject.getResponseJson(), param), attribute));
            }

            if (!value.isEmpty()) {
                if (presence.equals("exist")) {
                    assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(apiObject.sortJsonByKey(apiObject.getResponseJson(), param), attribute));
                } else if (presence.equals("exist notEqual"))
                    assertNotEquals(value, jsonUtils.getNodeValue(apiObject.sortJsonByKey(apiObject.getResponseJson(), param), attribute));
            }
        }
    }


    @Then("^validate response with this (.*) file by removing below attributes and using compare method (IN_ORDER|RANDOM_ORDER)$")
    public void validateResponseWithThisFileByRemovingBelowAttributes(String file_name, String compareType, DataTable table) throws Throwable {
        String json_file_content = apiObject.addJSONRequestBodyFromFile(file_name);
        JSONObject expectedJSON = new JSONObject(json_file_content);
        JSONObject actualJSON = apiObject.getResponseJson();

        List<List<String>> rows = table.raw();
        for (int i = 1; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);
            if (attribute.contains(".")) {
                expectedJSON = jsonUtils.modifyJSONAttributes(expectedJSON, attribute, "deleting");
                actualJSON = jsonUtils.modifyJSONAttributes(actualJSON, attribute, "deleting");
            } else {
                expectedJSON.remove(attribute);
                actualJSON.remove(attribute);
            }
        }


        if (compareType.equalsIgnoreCase("IN_ORDER")) {
            log.info("Strict Order Comparison");
            JSONAssert.assertEquals(expectedJSON, actualJSON, JSONCompareMode.STRICT_ORDER);
        } else if (compareType.equalsIgnoreCase("RANDOM_ORDER")) {
            log.info("Lenient Comparison for Random Order");
            JSONAssert.assertEquals(expectedJSON, actualJSON, JSONCompareMode.LENIENT);
        }

    }


    //-----------------------------------------DynamoDb Common Code --------------------------------------------
    /*
     * Validate DynamoDb Attributes based on Json Object and Datatable
     * */
    public void validateDynamoDbAttribute(JSONObject obj, DataTable table) throws Throwable {
        apiObject.setJsonObject(obj);
        List<List<String>> rows = table.raw();
        for (int i = 1; i < rows.size(); i++) {
            String attribute = rows.get(i).get(0);
            String value = rows.get(i).get(1);

            if (!attribute.isEmpty())
                Assert.assertTrue("Expected: " + attribute + " Not Found", jsonUtils.isNodePresent(apiObject.getResponseJson(), attribute));

            if (!value.isEmpty())
                if (value.contains("session_")) {
                    assertEquals(attribute + " didn't match expected", scenarioSession.getData(value.substring(value.indexOf("_") + 1, value.length())), jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
                } else if (value.contains("notnull")) {
                    assertNotNull((jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute)));
                } else if (value.contains("sort-")) {
                    value = value.replace("sort-", "");
                    List expList = new ArrayList(Arrays.asList(value.split(",")));
                    Collections.sort(expList);
                    List actList = new ArrayList(Arrays.asList(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute).split(",")));
                    Collections.sort(actList);
                    assertEquals(attribute + " didn't match expected", expList, actList);
                    assertTrue(attribute + " didn't match expected", expList.size() == actList.size() && expList.containsAll(actList) && actList.containsAll(expList));
                } else if (value.contains("contain")) {
                    value = value.replace("contain-", "");
                    List expword = new ArrayList(Arrays.asList(value.split(" ")));
                    for (int j = 0; j < expword.size(); j++) {
                        assertThat(jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute), containsString(expword.get(j).toString().trim()));
                    }

                } else {

                    assertEquals(attribute + " didn't match expected", value, jsonUtils.getNodeValue(apiObject.getResponseJson(), attribute));
                }

        }
    }


    //-----------------------------------------S3 Common Code ---------------------------------------------------

    @Given("^I upload file (.*) into (.*) bucket with the key name (.*) into S3")
    public void Iuploadfileintobucketwiththekeyname(String filename, String bucketname, String keyname) throws Throwable {
        s3Util.uploadObject(bucketname, keyname, filename);
    }

    @Then("^I delete the following file (.*) from the service (.*) in S3 bucket$")
    public void IdeletethefollowingfilefromtheserviceS3bucket(String keyname, String bucketname) throws Throwable {
        s3Util.deleteObject(bucketname, keyname);
    }


}


