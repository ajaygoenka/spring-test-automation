package com.experian.test.api.api_objects;

import org.apache.http.client.HttpClient;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

public class PingApi extends AbstractApiObject {

    private static final Logger log = (Logger) LoggerFactory.getLogger(PingApi.class);

    public PingApi() {
        // Set timeout to a lower value than the default
        int pingTimeout = 5000;
        restTemplate = new RestTemplate();
        HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
        HttpClient httpClient = HttpClients.custom().setSSLHostnameVerifier(new NoopHostnameVerifier()).build();
        requestFactory.setHttpClient(httpClient);
        requestFactory.setConnectTimeout(pingTimeout);
        requestFactory.setReadTimeout(pingTimeout);
        requestFactory.setConnectionRequestTimeout(pingTimeout);
        restTemplate.setRequestFactory(requestFactory);
        requestHeaders = new HttpHeaders();

    }

    @Override
    public void setBaseUrl(String endpoint, String intOrExt) {
        baseUrl = endpoint;
        builder = UriComponentsBuilder.fromHttpUrl(baseUrl);
    }
}
