package com.auto.test.api.config.spring;

import com.auto.test.api.config.properties.ApiTestProperties;
import com.auto.test.api.config.properties.BaseEnvSetup;
import org.springframework.context.annotation.*;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

@Configuration
@PropertySources({
        @PropertySource(value = {"classpath:properties/${environment}.properties"}),
        @PropertySource(value = {"classpath:properties/service.properties"})
})
@ComponentScan(basePackages = { "com.auto.test" })
public class ApiTestConfig {

    @Bean
    public ApiTestProperties properties() {
        return new ApiTestProperties();
    }


    @Bean
    public BaseEnvSetup baseEnvSetup() {
        return new BaseEnvSetup(properties());
    }


/*
    @Bean
    public DynamoDBUtil createDynamoDBUtil() {
        return new DynamoDBUtil();
    }

    @Bean
    public CloudFormationUtil createCloudFormationUtil() {
        return new CloudFormationUtil();
    }
*/

    @Bean
    public static PropertySourcesPlaceholderConfigurer propertyConfig() {
        return new PropertySourcesPlaceholderConfigurer();
    }
}
