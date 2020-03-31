package com.auto.test.utils.aws;

import com.amazonaws.AmazonClientException;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

@Component
public class S3Util {

    private final Logger log = (Logger) LoggerFactory.getLogger(S3Util.class);

    private AmazonS3 getS3Connection() {
        return AmazonS3ClientBuilder.defaultClient();
    }

    public void uploadObject(String bucketName , String folder ,String  filename) throws Exception {
        AmazonS3 s3client = getS3Connection();
        String filepath ;
        try {
            if (System.getProperty("user.dir").contains("auto"))
                filepath = System.getProperty("user.dir")+"/src/main/resources/json_objects"+filename;
            else
                filepath = System.getProperty("user.dir")+"/auto/src/main/resources/json_objects"+filename;
            System.out.println("Uploading a new object to S3 from a file\n");
            File file = new File(filepath);

                s3client.putObject((new PutObjectRequest(
                        bucketName, folder, file)).withSSEAwsKeyManagementParams(new SSEAwsKeyManagementParams()));

        } catch (AmazonServiceException ase) {
            log.error("Caught an AmazonServiceException, which " +
                    "means your request made it " +
                    "to Amazon S3, but was rejected with an error response" +
                    " for some reason.");
            log.error("Error Message:    " + ase.getMessage());
            log.error("HTTP Status Code: " + ase.getStatusCode());
            log.error("AWS Error Code:   " + ase.getErrorCode());
            log.error("Error Type:       " + ase.getErrorType());
            log.error("Request ID:       " + ase.getRequestId());
        } catch (AmazonClientException ace) {
            log.error("Caught an AmazonClientException, which " +
                    "means the client encountered " +
                    "an internal error while trying to " +
                    "communicate with S3, " +
                    "such as not being able to access the network.");
            log.error("Error Message: " + ace.getMessage());
        }
    }

    public boolean isFilePresent(String bucketName,String folder,String filename) throws Exception {
        AmazonS3 s3client = getS3Connection();
        ListObjectsV2Result result = null ;

        try {
                result = s3client.listObjectsV2(bucketName,folder);


            for (S3ObjectSummary objectSummary : result.getObjectSummaries()) {
                if(objectSummary.getKey().equals(folder+"/"+filename)){
                    log.info("File Name:    "+objectSummary.getKey());
                    return true;
                }
                    }
           return false;
        } catch (AmazonServiceException ase) {
            log.error("Caught an AmazonServiceException, which " +
                    "means your request made it " +
                    "to Amazon S3, but was rejected with an error response" +
                    " for some reason.");
            log.error("Error Message:    " + ase.getMessage());
            log.error("HTTP Status Code: " + ase.getStatusCode());
            log.error("AWS Error Code:   " + ase.getErrorCode());
            log.error("Error Type:       " + ase.getErrorType());
            log.error("Request ID:       " + ase.getRequestId());
            return false;
        } catch (AmazonClientException ace) {
            log.error("Caught an AmazonClientException, which " +
                    "means the client encountered " +
                    "an internal error while trying to " +
                    "communicate with S3, " +
                    "such as not being able to access the network.");
            log.error("Error Message: " + ace.getMessage());
            return false;
        }
    }

    public void deleteObject(String bucketName ,String keyName) throws Exception {
        AmazonS3 s3client = getS3Connection();
        try {
                s3client.deleteObject(new DeleteObjectRequest(bucketName, keyName));

        } catch (AmazonServiceException ase) {
            log.error("Caught an AmazonServiceException.");
            log.error("Error Message:    " + ase.getMessage());
            log.error("HTTP Status Code: " + ase.getStatusCode());
            log.error("AWS Error Code:   " + ase.getErrorCode());
            log.error("Error Type:       " + ase.getErrorType());
            log.error("Request ID:       " + ase.getRequestId());
        } catch (AmazonClientException ace) {
            log.error("Caught an AmazonClientException.");
            log.error("Error Message: " + ace.getMessage());
        }
    }

    public int countOfObjects(String bucketName) throws Exception{
        AmazonS3 s3client = getS3Connection();
        int count = 0;
        try {
            count = s3client.listObjectsV2(bucketName).getObjectSummaries().size();
        } catch (AmazonClientException ace) {
            log.error("Error Message: " + ace.getMessage());
        }
        return count;
    }

    public boolean stringExistenceInFile(String word, String filename, String bucket){
        AmazonS3 s3client = getS3Connection();
        try {
            S3Object result = s3client.getObject(bucket, filename);
            BufferedReader reader = new BufferedReader(new InputStreamReader(result.getObjectContent()));
            String line;
            while((line = reader.readLine()) != null) {
                if(line.contains(word))
                    return true;
            }
        } catch (IOException ioe){
            ioe.printStackTrace();
        } catch (AmazonServiceException ase) {
            log.error("Error Message:    " + ase.getMessage());
        } catch (AmazonClientException ace) {
            log.error("Error Message: " + ace.getMessage());
        }
        return false;
    }

    //s3 server side encryption - pass the KMS Key ID (which can be located via AWS KMS console for the associated service under test)
    public void uploadObject(String bucketName, String folder, String filename, String kmsKeyId) throws Exception {
        AmazonS3 s3client = getS3Connection();
        String filepath ;
        try {
            if (System.getProperty("user.dir").contains("auto")) {
                filepath = System.getProperty("user.dir") + "/src/main/resources/json_objects" + filename;
            }
            else {
                filepath = System.getProperty("user.dir") + "/auto/src/main/resources/json_objects" + filename;
            }
            log.info("Uploading a new object to S3 from a file, using KMS key ID: " + kmsKeyId);
            File file = new File(filepath);
            s3client.putObject((new PutObjectRequest(
                    bucketName, folder, file)).withSSEAwsKeyManagementParams(new SSEAwsKeyManagementParams(kmsKeyId)));
        } catch (AmazonServiceException ase) {
            log.error("Caught an AmazonServiceException, which " +
                    "means your request made it " +
                    "to Amazon S3, but was rejected with an error response" +
                    " for some reason.");
            log.error("Error Message:    " + ase.getMessage());
            log.error("HTTP Status Code: " + ase.getStatusCode());
            log.error("AWS Error Code:   " + ase.getErrorCode());
            log.error("Error Type:       " + ase.getErrorType());
            log.error("Request ID:       " + ase.getRequestId());
        } catch (AmazonClientException ace) {
            log.error("Caught an AmazonClientException, which " +
                    "means the client encountered " +
                    "an internal error while trying to " +
                    "communicate with S3, " +
                    "such as not being able to access the network.");
            log.error("Error Message: " + ace.getMessage());
        }
    }


}
