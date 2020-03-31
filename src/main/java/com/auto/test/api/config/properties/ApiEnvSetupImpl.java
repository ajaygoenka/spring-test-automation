package com.auto.test.api.config.properties;

import javax.annotation.PostConstruct;

public abstract class ApiEnvSetupImpl {

    protected BaseEnvSetup baseEnvSetup;

    @PostConstruct
    public abstract void getInternalServiceURLs() throws Exception ;

    @PostConstruct
    public abstract void getDynamoDBTableNames() throws Exception;

    public BaseEnvSetup getBaseEnvSetup() {
        return baseEnvSetup;
    }

}
