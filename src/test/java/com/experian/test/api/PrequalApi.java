package com.experian.test.api;

import com.experian.test.api.api_objects.AbstractApiObject;
import com.experian.test.api.config.EnvSetup;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

@Component
@Scope("cucumber-glue")
public class PrequalApi extends AbstractApiObject {

    private static final Logger log = (Logger) LoggerFactory.getLogger(PrequalApi.class);

    @Autowired
    private EnvSetup envSetup;

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{marketingId}")){
            endpoint = endpoint.replace("{marketingId}", scenarioSession.getData("marketingId"));
            baseUrl = envSetup.getPrequalUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{customerId}")){
            endpoint = endpoint.replace("{customerId}", scenarioSession.getData("customerId"));
            baseUrl = envSetup.getPrequalUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian")){
            baseUrl = envSetup.getPrequalUrl() + "/internal" + endpoint;
        } else if(intOrExt.equalsIgnoreCase("external experian") && endpoint.contains("{marketingId}")){
            endpoint = endpoint.replace("{marketingId}", scenarioSession.getData("marketingId"));
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }else if(intOrExt.equalsIgnoreCase("external experian")){
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }

        API_VERSION_NUMBER = envSetup.getPrequalApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);

    }

    public void setJsonObject(String jsonStr){
        jsonObject = new JSONObject(jsonStr);
    }

    public void setJsonObject(JSONObject jsonStr){ jsonObject = jsonStr; }

}
