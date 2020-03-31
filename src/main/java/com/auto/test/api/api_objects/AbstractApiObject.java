package com.auto.test.api.api_objects;

import com.auto.test.utils.JSONUtils;
import com.auto.test.utils.DateUtils;
import com.auto.test.utils.XMLUtils;
import com.auto.test.utils.file.FileUtils;
import com.auto.test.session.ScenarioSession;
import com.fasterxml.jackson.databind.util.ISO8601Utils;
import lombok.Getter;
import lombok.Setter;
import org.apache.http.client.HttpClient;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.impl.client.HttpClients;
import org.dom4j.Document;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.client.UnknownHttpStatusCodeException;
import org.springframework.web.util.UriComponentsBuilder;

import java.io.*;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.ParsePosition;
import java.util.*;

import static org.springframework.util.SerializationUtils.serialize;

@Component
@Scope("cucumber-glue")
@Getter
@Setter
public abstract class AbstractApiObject {

    private   static final Logger       log = (Logger) LoggerFactory.getLogger(AbstractApiObject.class);

    public    static String             API_VERSION_NUMBER;
    protected int                       responseStatusCode;
    protected String                    responseStatusReason;
    protected String                    baseUrl, responseBody, xmlPayLoad, requestJson;
    public    JSONObject                jsonObject;
    protected JSONArray                 jsonArray;
    protected ResponseEntity            responseEntity;
    protected HttpStatus                responseStatus;
    protected HttpHeaders               responseHeaders, requestHeaders;
    protected HttpEntity                requestEntity;
    protected Document                  xmlResponseBody;
    protected UriComponentsBuilder      builder;
    protected MultiValueMap<String, String> parameters;
    protected HttpEntity<MultiValueMap<String, String>> parametersWithHeaders;

    protected Object                    body, errorBody;

    public    RestTemplate              restTemplate;   //Added for Reusable Send Request Method

    @Autowired
    protected ScenarioSession scenarioSession;

    @Autowired
    protected DateUtils dateUtils;

    @Autowired
    protected JSONUtils jsonUtils;

    public AbstractApiObject() {
        restTemplate = new RestTemplate();
        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
        HttpClient httpClient = HttpClients.custom().setSSLHostnameVerifier(new NoopHostnameVerifier()).build();
        int defaultTimeout = 30000;
        requestFactory.setHttpClient(httpClient);
        requestFactory.setConnectTimeout(defaultTimeout);
        requestFactory.setReadTimeout(defaultTimeout);
        requestFactory.setConnectionRequestTimeout(defaultTimeout);
        restTemplate.setRequestFactory(requestFactory);
        requestHeaders = new HttpHeaders();



    }

    public abstract void setBaseUrl(String endpoint, String intOrExt);

    public void addHeaders(Map<String, String> headersMap, boolean useDefaultHeaders) {
        requestHeaders.setAll(headersMap);
        addHeaders(useDefaultHeaders);
    }

    public void addHeaders(Map<String, String> headersMap) {
        addHeaders(headersMap,true);
    }

    public void addHeaders(boolean useDefaultHeaders) {
        if(useDefaultHeaders){
            requestHeaders.set("Content-Type",MediaType.APPLICATION_JSON_VALUE);
            requestHeaders.set("Accept", MediaType.APPLICATION_JSON_VALUE);
        }
        requestHeaders.set("x-api-version", API_VERSION_NUMBER);
        requestEntity = new HttpEntity(requestJson, requestHeaders);
    }

    public void removeHeaders(String key) {
        requestHeaders.remove(key);
    }

    public void removeParams() {
        parametersWithHeaders = null;
    }

    public void loadXMLFile(String fileName) throws Exception {
        xmlPayLoad = FileUtils.loadFile(fileName);
    }

    public String getXMLPayload() {
        return xmlPayLoad;
    }

    public String addJSONRequestBodyFromFile(String fileName) throws Exception {
        String requestJson = FileUtils.loadFile(fileName);
        addJSONRequestBodyData(requestJson);

        return  requestJson;
    }

    public void addJSONRequestBodyData(String jsonData) {
        requestEntity = new HttpEntity<String>(jsonData, requestHeaders);
        //scenarioSession.putData("jsonContent", jsonData);
    }


    public void addJsonContentToparam(MultiValueMap<String, String> jsonContent) throws Exception {

        parametersWithHeaders = new HttpEntity<MultiValueMap<String, String>>(jsonContent,requestHeaders);
        scenarioSession.putData("jsonContent", jsonContent.toString());
        log.info(requestEntity.toString());
    }


    public void addJsonContentToBody(Map<String, String> jsonContent) throws Exception {

        JSONObject requestBody = new JSONObject();
        jsonContent.forEach((key, value) -> {
            log.info("Adding JSON content to request - Key : " + key + " Value : " + value);
            requestBody.put(key, value);
        });

        requestEntity = new HttpEntity(requestBody.toString(), requestHeaders);
        scenarioSession.putData("jsonContent", requestBody.toString());
        log.info(requestEntity.toString());
    }

    public String getNodeValueAsTodaysDate(String node_name) {
        Date date = getNodeValueAsDate(node_name);
        if (date != null)
            return dateUtils.getSimpleDateFormat("yyyy-MM-dd", "UTC").format(date);
        return null;
    }

    public Date getNodeValueAsDate(String node_name) {
        String date = jsonUtils.getNodeValue(jsonObject, node_name);
        if (date != null) {
            try {
                ParsePosition pos = new ParsePosition(0);
                return ISO8601Utils.parse(date, pos);
            }
            catch(ParseException pe) { log.warn("Failed to parse a date string.", pe);  }
        }
        return null;
    }

    public int getStatusCode() {
        return responseStatusCode;
    }

    public String getResponseStatusReason() {
        return responseStatusReason;
    }

    public HttpHeaders getHeaders() {
        return responseHeaders;
    }

    private void extractSimpleJSONResponse() {
        log.debug(responseBody);
        if (responseBody.contains("{") && responseBody.contains("}"))
            responseBody = responseBody.substring(responseBody.indexOf('{'), responseBody.lastIndexOf('}') + 1); // trim [ and ] at the start & end of json response
         jsonObject = new JSONObject(responseBody);
    }

    public void extractEncodedJSONResponse() {
        try {
            if(responseStatusCode == 400 || responseStatusCode == 570 || responseStatusCode == 500 || responseStatusCode == 550 || responseStatusCode == 502 || responseStatusCode == 404)
                body = errorBody;
            else if(responseEntity == null)
                body = errorBody;
            else
                body = responseEntity.getBody();

            byte[] response_bytes = new byte[0];
            if(body instanceof byte[]) {
                response_bytes = (byte[]) body;
            }else {
                response_bytes = serialize(responseEntity.getBody());
            }

            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(response_bytes), "UTF-8"));

            StringBuilder builder = new StringBuilder();
            String response;
            while ((response = bufferedReader.readLine()) != null) {
                builder.append(response);
            }
            String json_response = builder.toString().replaceAll("\\u0000","");
            log.info("json_response=="+json_response);
            responseBody = json_response;
            // It is an array, just grab the first element for now
            if(json_response.startsWith("[")) {
                JSONArray jsonArray = new JSONArray(json_response);

                if(jsonArray.length() > 0) {
                    Object obj = jsonArray.get(0);
                    if(obj instanceof JSONObject) {
                        jsonObject = (JSONObject) jsonArray.get(0);
                    }
                }
            } else {
                jsonObject = new JSONObject(json_response);
            }

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void extractXMLResponse() {
        log.info(responseBody);
        xmlResponseBody = XMLUtils.readXMLString(responseBody);
    }

    public JSONObject getResponseJson(){
        return jsonObject;
    }

    public String getResponseBody() {
        return responseBody;
    }

    public void setQueryParameter(String key, String value) throws UnsupportedEncodingException {
        // Each parameter value needs to be encoded otherwise you get unexpected behaviour from the called service
        builder  = builder.queryParam(key, URLEncoder.encode(value, "UTF-8"));
        log.debug("Value before encoding="+value);
        log.debug("Value after encoding="+URLEncoder.encode(value, "UTF-8"));
    }

    public String getURLParameters() {
        return builder.toUriString();
    }

    public void sendRequestToService(String requestType, String responseTypeName) {
        Class responseType = null;
        if (requestEntity == null) {
            requestEntity = new HttpEntity(requestHeaders);
        } if (parametersWithHeaders != null)
            log.info("requestEntityParameters="+parametersWithHeaders);
        log.info("requestEntity="+requestEntity);

        try {
            if (responseTypeName.equals("String") || responseTypeName.equals("JSONArray") ||
                    responseTypeName.equals("JSONObject") || responseTypeName.equals("HTML") ||
                        responseTypeName.equals("XML")) {
                responseType = Class.forName("java.lang.String");
            } else if (responseTypeName.equals("ByteArray")) {
                responseType = byte[].class;
            }
            log.info("Performing a " + requestType + " to URL:" + builder.build(true).toUri() + " with response type of " + responseType + " converted to " + responseTypeName);

            switch (requestType) {
                case "GET":
                    responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.GET, requestEntity, responseType);
                    break;
                case "HEAD":
                    responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.HEAD, requestEntity, responseType);
                    break;
                case "POST":
                    if (parametersWithHeaders != null)
                        responseEntity = restTemplate.postForEntity(builder.build(true).toUri(), parametersWithHeaders, responseType);
                    else
                        responseEntity = restTemplate.postForEntity(builder.build(true).toUri(), requestEntity, responseType);
                    break;
                case "PUT":
                    if (parametersWithHeaders != null)
                        responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.PUT, parametersWithHeaders, responseType);
                    else
                        responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.PUT, requestEntity, responseType);
                    break;
                case "DELETE":
                    responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.DELETE, requestEntity, responseType);
                    break;
                case "PATCH":
                    responseEntity = restTemplate.exchange(builder.build(true).toUri(), HttpMethod.PATCH, requestEntity, responseType);
                    break;
            }
            responseStatus = responseEntity.getStatusCode();
            responseStatusCode = responseStatus.value();
            responseStatusReason = responseStatus.getReasonPhrase();
            responseHeaders = responseEntity.getHeaders();
            log.info("responseStatus= "+ responseStatus);
            log.info("responseHeaders= "+responseHeaders);

            if (responseEntity != null && responseEntity.getBody() != null) {
                log.info("responseEntity= " + responseEntity);
                responseBody = responseEntity.getBody().toString();

                if (responseTypeName.equals("JSONArray")) {
                    jsonArray = new JSONArray(responseBody); log.info("JSONArray: " + jsonArray);
                    jsonObject = new JSONObject().put("result", jsonArray);
                } else if (responseTypeName.equals("JSONObject")) {
                    jsonObject = new JSONObject(responseBody); log.info("JSONObject: " + jsonObject);
                } else if (responseTypeName.equals("HTML")) {
                    //TODO extractHTMLResponse();
                } else if (responseTypeName.equals("XML")) {
                    extractXMLResponse();
                } else if (responseTypeName.equals("String")) {
                    extractSimpleJSONResponse();
                } else if (responseType.getSimpleName().equals("byte[]")) {
                    extractEncodedJSONResponse();
                }
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();

        } catch (UnknownHttpStatusCodeException unknownExcep) {
            responseStatusCode = unknownExcep.getRawStatusCode();
            responseStatusReason = CustomHttpStatusCode.valueOf(responseStatusCode).getStatusCodeDescription();
            if(responseStatusCode == 550 || responseStatusCode == 570){
                errorBody = unknownExcep.getResponseBodyAsByteArray();
                extractEncodedJSONResponse();
            } else {
                errorBody = unknownExcep.getResponseBodyAsString();
            }

        } catch (HttpStatusCodeException httpEx) {
            // Get response information
            responseStatus = httpEx.getStatusCode();
            responseStatusCode = responseStatus.value();
            responseStatusReason = responseStatus.getReasonPhrase();
            responseHeaders = httpEx.getResponseHeaders();
            responseBody = httpEx.getResponseBodyAsString();
            errorBody = httpEx.getResponseBodyAsByteArray();
            log.warn(httpEx.getMessage() + " from call " + builder.build(true).toUri());
            log.warn(httpEx.getResponseBodyAsString());

            // Catch any Exceptions while trying to convert the response
            try {
                if (!httpEx.getResponseBodyAsString().isEmpty()) {
                    if (responseType.getSimpleName().equals("JSONArray")) {
                        jsonArray = new JSONArray(responseBody);
                    } else if (responseType.getSimpleName().equals("JSONObject")) {
                        jsonObject = new JSONObject(responseBody);
                    } else if (responseTypeName.equals("HTML")) {
                        //TODO extractHTMLResponse();
                    } else if (responseTypeName.equals("XML")) {
                        extractXMLResponse();
                    } else if (responseType.getSimpleName().equals("String")) {
                        extractSimpleJSONResponse();
                    } else if (responseType.getSimpleName().equals("byte[]")) {
                        extractEncodedJSONResponse();
                    }
                }
            } catch (JSONException e) {
                log.warn("Response body was not JSON: "+e.getMessage());
            } catch (NullPointerException ne) {
                log.warn("Response body was empty: "+ne.getMessage()+ " " +ne.toString());
            }
        }
    }

    public void modifyJSONAttributesPerCustomer(JSONObject json_to_send, String attribute_name, String new_value) {
        json_to_send.put(attribute_name, new_value);
    }

    protected String base64Encode(String stringToEncode) {
        return new String(Base64.getEncoder().encode(stringToEncode.getBytes()));
    }

    public ResponseEntity getResponseEntity() {
        return responseEntity;
    }

    /*** Returns the GUID */
    public String generateUUID() {
        return UUID.randomUUID().toString();
    }

    public JSONObject sortJsonByKey(JSONObject responseoutput, String key) throws Throwable {
        JSONArray jsonArr = new JSONArray(jsonUtils.getNodeValue(responseoutput, "data"));
        JSONArray sortedJsonArray = new JSONArray();

        List<JSONObject> jsonValues = new ArrayList<JSONObject>();
        for (int i = 0; i < jsonArr.length(); i++) {
            jsonValues.add(jsonArr.getJSONObject(i));
        }

        Collections.sort(jsonValues, new Comparator<JSONObject>() {
            private String KEY_NAME = key;

            @Override
            public int compare(JSONObject a, JSONObject b) {
                String valA = new String();
                String valB = new String();

                try {
                    valA = (String) a.get(key);
                    valB = (String) b.get(key);
                } catch (JSONException e) {
                    log.info("wrong Key");
                }

                return valA.compareTo(valB);
            }
        });

        for (int i = 0; i < jsonArr.length(); i++) {
            sortedJsonArray.put(jsonValues.get(i));
        }
        JSONObject sortedJsonObject = new JSONObject();
        sortedJsonObject.put("data",sortedJsonArray);
        log.info("sortedjsonObject: " + sortedJsonObject);
        return sortedJsonObject;
    }
}
