package com.experian.test.api.config.spring;

import com.experian.test.api.config.properties.ApiTestProperties;
import com.experian.test.api.config.properties.BaseEnvSetup;
import com.experian.test.utils.aws.CloudFormationUtil;
import com.experian.test.utils.aws.DynamoDBUtil;
import org.springframework.context.annotation.*;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

@Configuration
@PropertySources({
        @PropertySource(value = {"classpath:properties/${environment}.properties"}),
        @PropertySource(value = {"classpath:properties/service.properties"}),
        @PropertySource(value = {"classpath:properties/${properties}.properties"} , ignoreResourceNotFound = true)
})
@ComponentScan(basePackages = { "com.experian.test" })
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
