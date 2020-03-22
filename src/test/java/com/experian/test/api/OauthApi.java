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
public class OauthApi extends AbstractApiObject {

    private static final Logger log = (Logger) LoggerFactory.getLogger(OauthApi.class);

    @Autowired
    private EnvSetup envSetup;

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("internal experian") && endpoint.contains("{oauth}")){
            endpoint = endpoint.replace("{oauth}", scenarioSession.getData("oauth"));
            baseUrl = envSetup.getOauthUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal experian")){
            baseUrl = envSetup.getOauthUrl() + "/internal" + endpoint;
        } else if(intOrExt.equalsIgnoreCase("external experian")){
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }

        API_VERSION_NUMBER = envSetup.getOauthApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);

    }

    public void setJsonObject(String jsonStr){
        jsonObject = new JSONObject(jsonStr);
    }

    public void setJsonObject(JSONObject jsonStr){ jsonObject = jsonStr; }

}
