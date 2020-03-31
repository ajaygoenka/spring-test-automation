package com.auto.test.utils.aws;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import com.amazonaws.services.sqs.model.GetQueueAttributesRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Copyright © 2016, Experian Ltd. All rights reserved.
 */

@Component
public class SQSUtil {

    private final Logger log = (Logger) LoggerFactory.getLogger(SQSUtil.class);

    private AmazonSQS getSQSConnection() {
        return AmazonSQSClientBuilder.defaultClient();
    }

    public int countOfObjects(String queueUrl) throws Exception {
        AmazonSQS sqsClient = getSQSConnection();
        int messagesCount = 0;
        try {
            GetQueueAttributesRequest request = new GetQueueAttributesRequest();
            request = request.withAttributeNames("ApproximateNumberOfMessages").withQueueUrl(queueUrl);

            Map<String, String> attrs = sqsClient.getQueueAttributes(request).getAttributes();

            messagesCount = Integer.parseInt(attrs.get("ApproximateNumberOfMessages"));
        }catch (AmazonServiceException ase){
            log.error("Error Message:    " + ase.getMessage());
        }
        return messagesCount;
    }
}
