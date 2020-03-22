package com.experian.test.api.config.properties;

import com.experian.test.api.api_objects.PingApi;
import com.experian.test.utils.StringUtils;
import com.experian.test.utils.aws.CloudFormationUtil;
import com.experian.test.utils.aws.DynamoDBUtil;
import com.github.tomakehurst.wiremock.WireMockServer;
import com.github.tomakehurst.wiremock.common.ConsoleNotifier;
import com.github.tomakehurst.wiremock.extension.responsetemplating.ResponseTemplateTransformer;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.ResourceAccessException;

import javax.annotation.PostConstruct;
import java.io.File;
import java.nio.charset.Charset;

import static com.github.tomakehurst.wiremock.core.WireMockConfiguration.options;

public class BaseEnvSetup {

    private static final Logger log = (Logger) LoggerFactory.getLogger(BaseEnvSetup.class);

    @Autowired
    private DynamoDBUtil dynamoDBUtil;

    @Autowired
    private CloudFormationUtil cloudFormationUtil;


    @Value("${external.api.base}")
    private String BaseUrl;

    @Value("${ping.timeout:180000}")
    private Integer pingTimeout;

    @Value("${ping.required:}")
    private String pingRequired;

    private ApiTestProperties apiTestProperties;
    private WireMockServer    wiremockServer;
    private String            serviceRegistryTable;
    private String            configTable;

    public BaseEnvSetup(ApiTestProperties apiTestProperties) {
        log.info("Initialising BaseEnvSetup class for tests...");
        this.apiTestProperties = apiTestProperties;
    }

    @PostConstruct
    private void setup() throws Exception {

        Runtime.getRuntime().addShutdownHook(CLOSE_THREAD);

        if (isLocal()) {
            log.info("Running tests against locally running service");
            serviceRegistryTable = apiTestProperties.getProperty("serviceregistry.table");
            configTable = apiTestProperties.getProperty("config.table");
            dynamoDBUtil.setServiceRegistryTable(serviceRegistryTable);
            dynamoDBUtil.setConfigTable(configTable);

            int port = 9999;
            if (StringUtils.isNotNullOrEmpty(System.getProperty("wiremock.port"))) {
                port = Integer.parseInt(System.getProperty("wiremock.port"));
            } else {
                System.setProperty("wiremock.port", Integer.toString(port));
            }

//            secureTokenUrl += ":" + port;
//            creditMatcherBaseUrl += ":" + port;
//            billingrateplansUrl += ":" + port;
//            experianHomeBaseUrl += ":" + port;
//            prodMoveBaseUrl += ":" + port;


            wiremockServer = new WireMockServer(
                    options()
                            .port(port)
                            .usingFilesUnderClasspath("wiremock")
                            .notifier(new ConsoleNotifier(false))
                            .extensions(new ResponseTemplateTransformer(true))
                            .enableBrowserProxying(true));
            wiremockServer.start();
            log.info("******* WIREMOCK SERVER STARTED ON PORT " + port + " *******");

        } else {
            log.info("Running tests against " + apiTestProperties.getEnvironment() + " environment");
            serviceRegistryTable = cloudFormationUtil.getPhysicalResourceName(System.getenv("NETWORK_STACK"), "ServiceRegistry");
            configTable = cloudFormationUtil.getPhysicalResourceName(System.getenv("NETWORK_STACK"), "ConfigTable");
            dynamoDBUtil.setServiceRegistryTable(serviceRegistryTable);
            dynamoDBUtil.setConfigTable(configTable);

            if (StringUtils.isNotNull(System.getProperty("jumpbox"))) {
                //secureTokenUrl = "http://localhost:8886";
            } else {
                //secureTokenUrl = dynamoDBUtil.getServiceURL(ServiceName.SECURE_TOKEN, secureTokenApiVersion);
            }
           // billingrateplansUrl = dynamoDBUtil.getServiceURL(ServiceName.BILLINGRATEPLANS, billingrateplansApiVersion);
        }
    }

    public ApiTestProperties getApiTestProperties() {
        return apiTestProperties;
    }

    public DynamoDBUtil getDynmamoDBUtil() {
        return dynamoDBUtil;
    }

    public CloudFormationUtil getCloudFormationUtil() {
        return cloudFormationUtil;
    }


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

    private void globalAfterAllHook() {
        if (wiremockServer != null && wiremockServer.isRunning()) {
            wiremockServer.stop();
            wiremockServer.shutdownServer();
            log.info("******* WIREMOCK SERVER STOPPED *******");
        }
    }

    private final Thread CLOSE_THREAD = new Thread() {
        @Override
        public void run() {
            createConsolidatedReport();
            globalAfterAllHook();
        }
    };

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

    private void createConsolidatedReport() {
        log.info("creating consolidated test report.json");
        File[] listOfFiles = new File("target/cucumber-parallel").listFiles();

        try {
            for (int i = 0; i < listOfFiles.length; i++) {
                if (listOfFiles[i].isFile()) {
                    org.json.JSONArray json_arr1 = new org.json.JSONArray(org.apache.commons.io.FileUtils.readFileToString(listOfFiles[i], "utf-8"));
                    String featureName = json_arr1.getJSONObject(0).getString("uri");
                    File featureReport = new File("target/cucumber-parallel/" + featureName.replaceAll(".+/", "")
                            .replace(".feature", ".json"));
                    if (!featureReport.exists()) {
                        featureReport.createNewFile();
                        log.info(featureReport.getName() + " created successfully");
                        org.apache.commons.io.FileUtils.copyFile(listOfFiles[i], featureReport);
                    } else {
                        org.json.JSONArray jsonArr_src = new org.json.JSONArray(org.apache.commons.io.FileUtils.readFileToString(listOfFiles[i], "utf-8"));
                        JSONObject scenario_obj_src = jsonArr_src.getJSONObject(0).getJSONArray("elements").getJSONObject(0);
                        String temp_file = org.apache.commons.io.FileUtils.readFileToString(featureReport, Charset.forName("UTF-8"));
                        StringBuilder sb = new StringBuilder(temp_file);
                        sb.insert(38, scenario_obj_src.toString() + ",");
                        org.apache.commons.io.FileUtils.writeStringToFile(featureReport, sb.toString(), Charset.forName("UTF-8"));
                    }
                    if (listOfFiles[i].delete()) {
                        log.info(listOfFiles[i].getName() + " deleted successfully");
                    }
                }
            }
        } catch (Exception io) {
            io.printStackTrace();
        }
    }
}
