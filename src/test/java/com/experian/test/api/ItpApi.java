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

public class ItpApi extends AbstractApiObject {
    private static final Logger log = (Logger) LoggerFactory.getLogger(ItpApi.class);

    @Autowired
    private EnvSetup envSetup;

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("external experian") && endpoint.contains("{subscriptionId}") && endpoint.contains("{alertId}") && endpoint.contains("{childSubId}")) {
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            endpoint = endpoint.replace("{alertId}", scenarioSession.getData("alertId"));
            endpoint = endpoint.replace("{childSubId}", scenarioSession.getData("childSubId"));
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        } else if (intOrExt.equalsIgnoreCase("external experian") && endpoint.contains("{subscriptionId}") && endpoint.contains("{alertId}")) {
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            endpoint = endpoint.replace("{alertId}", scenarioSession.getData("alertId"));
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        } else if (intOrExt.equalsIgnoreCase("external experian") && endpoint.contains("{subscriptionId}")) {
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{alertId}") && endpoint.contains("{parentId}") && endpoint.contains("{childId}")) {
            endpoint = endpoint.replace("{alertId}", scenarioSession.getData("alertId"));
            endpoint = endpoint.replace("{parentId}", scenarioSession.getData("parentId"));
            endpoint = endpoint.replace("{childId}", scenarioSession.getData("childId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}") && endpoint.contains("{alertId}") && endpoint.contains("{parentId}") && endpoint.contains("{childId}")) {
            endpoint = endpoint.replace("{customerId}", scenarioSession.getData("customerId"));
            endpoint = endpoint.replace("{alertId}", scenarioSession.getData("alertId"));
            endpoint = endpoint.replace("{parentId}", scenarioSession.getData("parentId"));
            endpoint = endpoint.replace("{childId}", scenarioSession.getData("childId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        } else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}") && endpoint.contains("{subscriptionId}") && endpoint.contains("{childId}")) {
            endpoint = endpoint.replace("{customerId}", scenarioSession.getData("customerId"));
            endpoint = endpoint.replace("{childId}", scenarioSession.getData("childId"));
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{subscriptionId}") && endpoint.contains("{alertId}")) {
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            endpoint = endpoint.replace("{alertId}", scenarioSession.getData("alertId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{subscriptionId}") ) {
            endpoint = endpoint.replace("{subscriptionId}", scenarioSession.getData("subscriptionId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{childId}") ) {
            endpoint = endpoint.replace("{childId}", scenarioSession.getData("childId"));
            baseUrl = envSetup.getItpUrl() + endpoint;
        }else {
            baseUrl = envSetup.getItpUrl() + endpoint;
        }
        API_VERSION_NUMBER = envSetup.getItpApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);
    }


}
