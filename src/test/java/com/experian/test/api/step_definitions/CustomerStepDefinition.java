package com.experian.test.api.step_definitions;

import com.experian.test.api.*;
import com.experian.test.api.config.EnvSetup;
import com.experian.test.session.ScenarioSession;
import com.experian.test.utils.JSONUtils;
import com.experian.test.utils.file.OutputFileWriter;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class CustomerStepDefinition {

    private static final Logger log = (Logger) LoggerFactory.getLogger(CustomerStepDefinition.class);


    @Autowired
    private ScenarioSession scenarioSession;

    @Autowired
    private CommonStepDefinition commonStepDefinition;

    @Autowired
    private CustomerApi customerApi;

    @Autowired
    private OauthApi oauthApi;


    @Autowired
    private OffersApi offersApi;

    @Autowired
    private RegistrationApi registrationApi;

    @Autowired
    private LoginApi loginApi;

    @Autowired
    private EnvSetup envSetup;

    @Autowired
    OutputFileWriter outputFileWriter;

    @Autowired
    public JSONUtils jsonUtils;

    @Given("^I create a new (internal experian|external experian) customers service request to the (.*) endpoint")
    public void create_new_api_request(String intOrExt, String endpoint) throws Throwable {
        customerApi.setBaseUrl(endpoint, intOrExt);
        commonStepDefinition.setApiObject(customerApi);
    }

    @Given("^I create a new (free|paid|family) customer using (.*) offer tags$")
    public void createNewCustomerWithOfferTags(String journey, String offers) throws Throwable {

        List<List<String>> requestList = null;
        DataTable requestDataTable = null;
        Map<String, String> headersMap = new HashMap<String, String>();

        // Create Oauth Token
        oauthApi.setBaseUrl("/api/oauth/token", "external experian");
        commonStepDefinition.setApiObject(oauthApi);
        headersMap.put("Content-Type", "application/x-www-form-urlencoded");
        headersMap.put("Accept", "application/json, text/plain, */*");
        oauthApi.addHeaders(headersMap, false);
        MultiValueMap<String, String> bodymap = new LinkedMultiValueMap<>();
        Map<String, String> requestBody = new HashMap<String, String>();
        requestBody.put("grant_type", "client_credentials");
        requestBody.put("scope", "registration");
        requestBody.put("client_id", "experian");
        bodymap.setAll(requestBody);
        oauthApi.addJsonContentToparam(bodymap);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "String");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("access_token", "secureToken");

        // Get offer Id
        offersApi.setBaseUrl("/api/offers", "external experian");
        commonStepDefinition.setApiObject(offersApi);
        headersMap.clear();
        headersMap.put("Content-Type", "application/json");
        headersMap.put("Accept", "application/json, text/plain, */*");
        offersApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.i_add_a_query_param_xxx_with_value_yyy("placementId", "shoppingCart");
        commonStepDefinition.i_add_a_query_param_xxx_with_value_yyy("tags", offers);
        commonStepDefinition.i_send_the_request_with_response_type("GET", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("id", "offerId");
        ;

        // Post call for Registrations
        registrationApi.setBaseUrl("/api/registration/account", "external experian");
        commonStepDefinition.setApiObject(registrationApi);
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("customer.email", "fake_email"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop1account.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);

        registrationApi.setBaseUrl("/api/registration/offerquote", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();

        if (journey.equalsIgnoreCase("family")) {
            requestList = Arrays.asList(Arrays.asList("offerId", "session_offerId"), Arrays.asList("pageId", "ecs.registration.offerIntercept"), Arrays.asList("familyMemberId", scenarioSession.getData("familyMemberId")));
        } else {
            requestList = Arrays.asList(Arrays.asList("offerId", "session_offerId"));
        }
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop1offerquote.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("id", "offerQuoteId");


        registrationApi.setBaseUrl("/api/login/username", "external experian");
        commonStepDefinition.remove_the_following_headers_to_the_request("Authorization");
        registrationApi.addHeaders(headersMap);
        requestList = Arrays.asList(Arrays.asList("userName", "fake_username"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop2username.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        List<List<String>> attrList = Arrays.asList(Arrays.asList("Attr", "Value"), Arrays.asList("isUsernameAvailable", "true"));
        DataTable attrDataTable = DataTable.create(attrList);
        this.commonStepDefinition.makeSureFollowingAttributesArePresentWithinResponse("exist", attrDataTable);

        registrationApi.setBaseUrl("/api/registration/account", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerQuoteId", "session_offerQuoteId"), Arrays.asList("login.userName", "session_userName"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop2account.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);


        registrationApi.setBaseUrl("/api/registration/oowquestions", "external experian");
        headersMap.put("x-fn", "off");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerId", "session_offerId"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3ioQuestion.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("questionSetId", "questionSetId");

        registrationApi.setBaseUrl("/api/globalterms/customer/allterms", "external experian");
        headersMap.remove("x-fn");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.add_a_json_request_data_from_file("/json_objects/registration/postglobalterms.json");
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);

        registrationApi.setBaseUrl("/api/registration/activation", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerQuoteId", "session_offerQuoteId"), Arrays.asList("answers.questionSetId", "session_questionSetId"));
        requestDataTable = DataTable.create(requestList);
        if (journey.equalsIgnoreCase("free") || journey.equalsIgnoreCase("family"))
            commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3activation_free.json", "replacing", requestDataTable);
        else
            commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3activation.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("token", "secureToken");
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("subscription.id", "subscriptionId");

        registrationApi.setBaseUrl("/api/registration/op4", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.add_a_json_request_data_from_file("/json_objects/registration/postop4submitsurvey.json");
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.embedTheScenarioValue("userName");

        // Get the CustomerId
        loginApi.setBaseUrl("/login/byusername/{userName}", "internal experian");
        commonStepDefinition.setApiObject(loginApi);
        loginApi.addHeaders(headersMap);
        commonStepDefinition.i_send_the_request_with_response_type("GET", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("customerId", "customerId");
        commonStepDefinition.embedTheScenarioValue("customerId");


    }

    @And("^store the customerId in file$")
    public void storeTheCustomerIdInFile() throws IOException {
        outputFileWriter.append("C:\\ECS-NA\\data.txt",scenarioSession.getData("customerId")+"-----"+scenarioSession.getData("userName")+"-----"+scenarioSession.getData("secureToken"));
        outputFileWriter.append("C:\\ECS-NA\\token.txt",scenarioSession.getData("secureToken"));
    }


    @And("^make sure following attributes exist within response data with correct values in Customer Profile Table$")
    public void iShouldConfirmFollowingAttributesArePresentInCustomerProfileDynamoTable(DataTable table) throws Throwable {
        JSONObject obj = envSetup.getBaseEnvSetup().getDynmamoDBUtil().getResultsFromTable(envSetup.getCustomerprofileTable(), "customerId", scenarioSession.getData("customerId"));

        commonStepDefinition.validateDynamoDbAttribute(obj, table);

    }

    @Given("^I create a new (free|paid) customer using (.*) offer tags and below details$")
    public void createNewCustomerWithOfferTagsandbelowdetails(String journey, String offers, Map<String, String> datamap) throws Throwable {

        for (String key : datamap.keySet()) {
            if (key.equalsIgnoreCase("ssn"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("firstName"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("lastName"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("dob"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("street"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("city"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("state"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
            else if (key.equalsIgnoreCase("zip"))
                scenarioSession.putData(key.trim().toLowerCase(), datamap.get(key));
        }

        List<List<String>> requestList = null;
        DataTable requestDataTable = null;
        Map<String, String> headersMap = new HashMap<String, String>();

        // Create Oauth Token
        oauthApi.setBaseUrl("/api/oauth/token", "external experian");
        commonStepDefinition.setApiObject(oauthApi);
        headersMap.put("Content-Type", "application/x-www-form-urlencoded");
        headersMap.put("Accept", "application/json, text/plain, */*");
        oauthApi.addHeaders(headersMap, false);
        MultiValueMap<String, String> bodymap = new LinkedMultiValueMap<>();
        Map<String, String> requestBody = new HashMap<String, String>();
        requestBody.put("grant_type", "client_credentials");
        requestBody.put("scope", "registration");
        requestBody.put("client_id", "experian");
        bodymap.setAll(requestBody);
        oauthApi.addJsonContentToparam(bodymap);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "String");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("access_token", "secureToken");

        // Get offer Id
        offersApi.setBaseUrl("/api/offers", "external experian");
        commonStepDefinition.setApiObject(offersApi);
        headersMap.clear();
        headersMap.put("Content-Type", "application/json");
        headersMap.put("Accept", "application/json, text/plain, */*");
        offersApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.i_add_a_query_param_xxx_with_value_yyy("placementId", "shoppingCart");
        commonStepDefinition.i_add_a_query_param_xxx_with_value_yyy("tags", offers);
        commonStepDefinition.i_send_the_request_with_response_type("GET", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("id", "offerId");
        ;

        // Post call for Registrations
        registrationApi.setBaseUrl("/api/registration/account", "external experian");
        commonStepDefinition.setApiObject(registrationApi);
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("customer.email", "fake_email"), Arrays.asList("customer.name.first", "session_firstname"), Arrays.asList("customer.name.last", "session_lastname"), Arrays.asList("customer.currentAddress.street", "session_street"), Arrays.asList("customer.currentAddress.city", "session_city"), Arrays.asList("customer.currentAddress.state", "session_state"), Arrays.asList("customer.currentAddress.zip", "session_zip"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop1account.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);

        registrationApi.setBaseUrl("/api/registration/offerquote", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerId", "session_offerId"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop1offerquote.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("id", "offerQuoteId");


        registrationApi.setBaseUrl("/api/login/username", "external experian");
        commonStepDefinition.remove_the_following_headers_to_the_request("Authorization");
        registrationApi.addHeaders(headersMap);
        requestList = Arrays.asList(Arrays.asList("userName", "fake_username"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop2username.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        List<List<String>> attrList = Arrays.asList(Arrays.asList("Attr", "Value"), Arrays.asList("isUsernameAvailable", "true"));
        DataTable attrDataTable = DataTable.create(attrList);
        this.commonStepDefinition.makeSureFollowingAttributesArePresentWithinResponse("exist", attrDataTable);

        registrationApi.setBaseUrl("/api/registration/account", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerQuoteId", "session_offerQuoteId"), Arrays.asList("login.userName", "session_userName"), Arrays.asList("customer.dob", "session_dob"), Arrays.asList("customer.ssn", "session_ssn"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop2account.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);


        registrationApi.setBaseUrl("/api/registration/oowquestions", "external experian");
        headersMap.put("x-fn", "off");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerId", "session_offerId"));
        requestDataTable = DataTable.create(requestList);
        commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3ioQuestion.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("questionSetId", "questionSetId");

        registrationApi.setBaseUrl("/api/globalterms/customer/allterms", "external experian");
        headersMap.remove("x-fn");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.add_a_json_request_data_from_file("/json_objects/registration/postglobalterms.json");
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);

        registrationApi.setBaseUrl("/api/registration/activation", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        requestList = Arrays.asList(Arrays.asList("offerQuoteId", "session_offerQuoteId"), Arrays.asList("answers.questionSetId", "session_questionSetId"));
        requestDataTable = DataTable.create(requestList);
        if (journey.equalsIgnoreCase("free"))
            commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3activation_free.json", "replacing", requestDataTable);
        else
            commonStepDefinition.add_and_edit_JsonContent_using_filename("/json_objects/registration/postop3activation.json", "replacing", requestDataTable);
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("token", "secureToken");
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("subscription.id", "subscriptionId");

        registrationApi.setBaseUrl("/api/registration/op4", "external experian");
        registrationApi.addHeaders(headersMap);
        commonStepDefinition.add_secure_token_to_the_header();
        commonStepDefinition.add_a_json_request_data_from_file("/json_objects/registration/postop4submitsurvey.json");
        commonStepDefinition.i_send_the_request_with_response_type("POST", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.embedTheScenarioValue("userName");

        // Get the CustomerId
        loginApi.setBaseUrl("/login/byusername/{userName}", "internal experian");
        commonStepDefinition.setApiObject(loginApi);
        loginApi.addHeaders(headersMap);
        commonStepDefinition.i_send_the_request_with_response_type("GET", "ByteArray");
        commonStepDefinition.the_response_status_code_should_be(200);
        commonStepDefinition.iSaveTheValueOfAttributeNameAsKeyName("customerId", "customerId");
        commonStepDefinition.embedTheScenarioValue("customerId");
        commonStepDefinition.embedTheScenarioValue("subscriptionId");

    }

    @Given("^I create a new (free|paid) customer with this (.*) referenceId and (.*) offer tags$")
    public void createNewCustomerWithReferenceId(String journey, String referenceId, String offers) throws Throwable {
        Map<String, String> customerPiiData = new HashMap<String, String>();

        String json_file_content = customerApi.addJSONRequestBodyFromFile("/json_objects/users/TetrisTestUsers.json");
        JSONObject json_to_send = new JSONObject(json_file_content);
        customerApi.setJsonObject(json_to_send);
        customerPiiData.put("firstName",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".FirstName"));
        customerPiiData.put("lastName",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".LastName"));
        String dob =  jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".DOB");
        customerPiiData.put("dob",dob.split("/")[2]+"-"+dob.split("/")[0]+"-"+dob.split("/")[1]);
        customerPiiData.put("street",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".Address"));
        customerPiiData.put("city",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".City"));
        customerPiiData.put("state",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".State"));
        customerPiiData.put("zip",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".Zip"));
        customerPiiData.put("SSN",jsonUtils.getNodeValue(customerApi.getResponseJson(), referenceId+".SSN"));

        createNewCustomerWithOfferTagsandbelowdetails(journey, offers, customerPiiData);


    }
}