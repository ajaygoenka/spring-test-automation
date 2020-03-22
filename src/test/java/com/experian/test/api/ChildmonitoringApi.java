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

public class ChildmonitoringApi extends AbstractApiObject {
    private static final Logger log = (Logger) LoggerFactory.getLogger(ChildmonitoringApi.class);

    @Autowired
    private EnvSetup envSetup;

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}")  && endpoint.contains("{childSubscriptionId}")) {
            endpoint = endpoint.replace("{customerId}", (scenarioSession.getData("customerId")));
            endpoint = endpoint.replace("{childSubscriptionId}", scenarioSession.getData("childSubscriptionId"));
            baseUrl = envSetup.getChildMonitoringUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}")) {
            endpoint = endpoint.replace("{customerId}", scenarioSession.getData("customerId"));
            baseUrl = envSetup.getChildMonitoringUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{childSubscriptionId}")){
            endpoint = endpoint.replace("{childSubscriptionId}", scenarioSession.getData("childSubscriptionId"));
            baseUrl = envSetup.getChildMonitoringUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian")){
            baseUrl = envSetup.getChildMonitoringUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("external experian") && endpoint.contains("{childSubscriptionId}")) {
            endpoint = endpoint.replace("{childSubscriptionId}", scenarioSession.getData("childSubscriptionId"));
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }else {
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }

        API_VERSION_NUMBER = envSetup.getChildMonitoringApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);

    }


}
