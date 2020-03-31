package com.auto.test.utils.aws;

import com.amazonaws.services.cloudformation.AmazonCloudFormation;
import com.amazonaws.services.cloudformation.AmazonCloudFormationAsyncClientBuilder;
import com.amazonaws.services.cloudformation.model.DescribeStackResourcesRequest;
import com.amazonaws.services.cloudformation.model.StackResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class CloudFormationUtil {

    private final Logger log = (Logger) LoggerFactory.getLogger(CloudFormationUtil.class);

    private AmazonCloudFormation getCFClient() {
        return AmazonCloudFormationAsyncClientBuilder.defaultClient();
    }

    public String getPhysicalResourceName(String stackName, String logicalName) throws Exception {
        AmazonCloudFormation cfClient = getCFClient();
        DescribeStackResourcesRequest stackResourceRequest = new DescribeStackResourcesRequest()
                .withStackName(stackName)
                    .withLogicalResourceId(logicalName);

        List<StackResource> resource = cfClient.describeStackResources(stackResourceRequest).getStackResources();
        if (resource.size() > 1)
            throw new Exception("Found more than 1 resource with Logical Name="+logicalName+ " in Stack "+stackName);

        String physicalResourceId = resource.get(0).getPhysicalResourceId();
        log.info("Found Physical Resource Name "+physicalResourceId+" from Logical Name="+logicalName+ " in Stack "+stackName);
        return physicalResourceId;
    }
}
