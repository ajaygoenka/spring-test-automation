package com.auto.test.api;

import com.auto.test.api.api_objects.AbstractApiObject;
import com.auto.test.api.config.EnvSetup;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

@Component
@Scope("cucumber-glue")
public class LoginApi extends AbstractApiObject {
    private static final Logger log = (Logger) LoggerFactory.getLogger(LoginApi.class);

    @Autowired
    private EnvSetup envSetup;

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        if (intOrExt.equalsIgnoreCase("internal auto") && endpoint.contains("{userName}")){
            endpoint = endpoint.replace("{userName}", scenarioSession.getData("userName"));
            baseUrl = envSetup.getLoginUrl() + "/internal" + endpoint;
        }else if (intOrExt.equalsIgnoreCase("internal auto")){
            baseUrl = envSetup.getLoginUrl() + "/internal" + endpoint;
        } else if(intOrExt.equalsIgnoreCase("external auto")){
            baseUrl = envSetup.getBaseEnvSetup().getBaseUrl() + endpoint;
        }

        API_VERSION_NUMBER = envSetup.getLoginApiVersion();
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);

    }

    public void setJsonObject(String jsonStr){
        jsonObject = new JSONObject(jsonStr);
    }

    public void setJsonObject(JSONObject jsonStr){ jsonObject = jsonStr; }

}
