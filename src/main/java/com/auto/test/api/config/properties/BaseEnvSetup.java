package com.auto.test.api.config.properties;

import com.auto.test.api.api_objects.PingApi;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.ResourceAccessException;

import javax.annotation.PostConstruct;

public class BaseEnvSetup {

    private static final Logger log = (Logger) LoggerFactory.getLogger(BaseEnvSetup.class);

/*
    @Autowired
    private DynamoDBUtil dynamoDBUtil;

    @Autowired
    private CloudFormationUtil cloudFormationUtil;
*/


    @Value("${external.api.base}")
    private String BaseUrl;

    @Value("${ping.timeout:180000}")
    private Integer pingTimeout;

    @Value("${ping.required:}")
    private String pingRequired;

    private ApiTestProperties apiTestProperties;
    private String            serviceRegistryTable;
    private String            configTable;

    public BaseEnvSetup(ApiTestProperties apiTestProperties) {
        log.info("Initialising BaseEnvSetup class for tests...");
        this.apiTestProperties = apiTestProperties;
    }

    @PostConstruct
    private void setup() throws Exception {
        log.info("Running tests against " + apiTestProperties.getEnvironment() + " environment");
            /*serviceRegistryTable = cloudFormationUtil.getPhysicalResourceName(System.getenv("NETWORK_STACK"), "ServiceRegistry");
            configTable = cloudFormationUtil.getPhysicalResourceName(System.getenv("NETWORK_STACK"), "ConfigTable");
            dynamoDBUtil.setServiceRegistryTable(serviceRegistryTable);
            dynamoDBUtil.setConfigTable(configTable);*/
    }

    public ApiTestProperties getApiTestProperties() {
        return apiTestProperties;
    }

  /*  public DynamoDBUtil getDynmamoDBUtil() {
        return dynamoDBUtil;
    }

    public CloudFormationUtil getCloudFormationUtil() {
        return cloudFormationUtil;
    }

*/
    public String getBaseUrl() {
        return BaseUrl;
    }

    public String getServiceRegistryTable() {
        return serviceRegistryTable;
    }

    public String getConfigTable() {
        return configTable;
    }


    public boolean isLocal() {
        return apiTestProperties.getEnvironment().equalsIgnoreCase("local");
    }



    public boolean isTheServiceUp(String serviceUrl) {
        int numOfRequiredPings;
        long endTimeMillis = System.currentTimeMillis() + pingTimeout;
        PingApi pingApi = new PingApi();
        serviceUrl += "/internal/admin/ping";
        pingApi.setBaseUrl(serviceUrl, "internal");
        int numOfSuccessfulPings = 0;
        if (pingRequired == "" || pingRequired == null) {
            numOfRequiredPings = 5;
        } else {
            numOfRequiredPings = Integer.parseInt(pingRequired);
        }


        while (numOfSuccessfulPings < numOfRequiredPings && System.currentTimeMillis() < endTimeMillis) {
            log.info("Trying to ping " + serviceUrl + "...");
            try {
                pingApi.sendRequestToService("GET", "JSONObject");
                if (pingApi.getStatusCode() == 200) {
                    numOfSuccessfulPings++;
                    sleepFor(500);
                } else {
                    sleepFor(5000);
                }
            } catch (ResourceAccessException e) {
                log.error(e.toString());
                sleepFor(5000);
            }
        }

        return numOfRequiredPings == numOfSuccessfulPings;
    }

    private void sleepFor(long milliseconds) {
        try {
            Thread.sleep(milliseconds);
        } catch (InterruptedException e1) {
            e1.printStackTrace();
        }
    }

}
