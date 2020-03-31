package com.auto.test.api.config.properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;

public class ApiTestProperties {

    /**
     * Used to retrieve properties and make them available to tests
     */
    @Autowired
    private Environment environment;

    public String getProperty(String input_prop){
        return environment.getProperty(input_prop);
    }

    public String getEnvironment() {
        return System.getProperty("environment");
    }
}