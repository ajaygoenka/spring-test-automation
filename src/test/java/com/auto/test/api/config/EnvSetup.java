package com.auto.test.api.config;

import com.auto.test.api.config.properties.BaseEnvSetup;
import com.auto.test.api.config.properties.ApiEnvSetupImpl;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class EnvSetup extends ApiEnvSetupImpl {

    private static final Logger log = (Logger) LoggerFactory.getLogger(EnvSetup.class);


    @Value("${login.api.version}")
    private String loginApiVersion;

    @Value("${login.url:}")
    private String loginUrl;

//    private String customerLoginTable;


    @Autowired
    public EnvSetup(BaseEnvSetup baseEnvSetup) throws Exception {
        log.info("Initialising TestEnvSetup class for tests...");
        this.baseEnvSetup = baseEnvSetup;
    }

    public void getInternalServiceURLs() throws Exception {
        if (!baseEnvSetup.isLocal()) {
            log.info("Running getInternalServiceURLs");
           // loginUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("login",getLoginApiVersion());
            loginUrl="http://localhost:8080";
        }

    }

    public void getDynamoDBTableNames() throws Exception {
        log.info("Running getDynamoDBTableNames");
//        customerLoginTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("login", getLoginApiVersion(), "dynamo_tables.2.physicalid.0", "");

    }

}
