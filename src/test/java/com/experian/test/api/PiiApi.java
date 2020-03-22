package com.experian.test.api;


import com.experian.test.api.api_objects.AbstractApiObject;
import com.experian.test.api.config.EnvSetup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

@Component
@Scope("cucumber-glue")
public class PiiApi extends AbstractApiObject {
    private static final Logger log = (Logger) LoggerFactory.getLogger(PiiApi.class);

    @Autowired
    private EnvSetup envSetup;


    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}")) {
            endpoint = endpoint.replace("{customerId}", scenarioSession.getData("customerId"));
            baseUrl = envSetup.getPiiUrl() + endpoint;
        }else {
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }
        API_VERSION_NUMBER = envSetup.getPiiApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);
    }

}
