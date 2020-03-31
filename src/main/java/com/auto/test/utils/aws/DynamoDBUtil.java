package com.auto.test.utils.aws;

import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.*;
import com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec;
import com.amazonaws.services.dynamodbv2.document.spec.GetItemSpec;
import com.amazonaws.services.dynamodbv2.document.spec.QuerySpec;
import com.amazonaws.services.dynamodbv2.document.spec.UpdateItemSpec;
import com.amazonaws.services.dynamodbv2.document.utils.ValueMap;
import com.amazonaws.services.dynamodbv2.model.ReturnValue;
import com.auto.test.session.ScenarioSession;
import com.auto.test.utils.file.FileUtils;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import cucumber.api.DataTable;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;
import java.util.regex.Pattern;

import static org.apache.commons.lang3.StringUtils.isNotEmpty;

public class DynamoDBUtil {


    @Value("${aws.dynamodb.endpoint:}")
    private String amazonDynamoDBEndpoint;

    @Value("${aws.dynamodb.region:}")
    private String amazonDynamoDBRegion;

    @Value("${protocol:}")
    private String protocol;

    private String serviceRegistryTable;
    private String configTable;

    private final Logger log = (Logger) LoggerFactory.getLogger(DynamoDBUtil.class);

    public void setServiceRegistryTable(String serviceRegistryTable) {
        this.serviceRegistryTable = serviceRegistryTable;
    }

    public void setConfigTable(String configTable) {
        this.configTable = configTable;
    }

    private DynamoDB getDynamoDBConnection() {
        AmazonDynamoDB client;

        if (isNotEmpty(amazonDynamoDBEndpoint) && isNotEmpty(amazonDynamoDBRegion)) {
            client = AmazonDynamoDBClientBuilder.standard().withEndpointConfiguration(
                    new AwsClientBuilder.EndpointConfiguration(amazonDynamoDBEndpoint, amazonDynamoDBRegion))
                    .build();
            log.info("Overriding DynamoDB endpoint with "+ amazonDynamoDBEndpoint + " and region with "+ amazonDynamoDBRegion);
        } else {
            client = AmazonDynamoDBClientBuilder.defaultClient();
            log.info("Using default DynamoDB endpoint and region");
        }

        return new DynamoDB(client);
    }

    public void deleteItem(String tableName, String primaryKey, String keyValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                .withPrimaryKey(new PrimaryKey(primaryKey, keyValue));

        log.info("Attempting delete for " +primaryKey+ " = " + keyValue + " from table " +tableName+" ...");
        table.deleteItem(deleteItemSpec);
        log.info("DeleteItem succeeded");
    }

    public void deleteItem(String tableName, String primaryPartitionKey, String primaryPartitionKeyValue , String primarySortKey , String primarySortKeyValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                .withPrimaryKey(primaryPartitionKey, primaryPartitionKeyValue,primarySortKey, primarySortKeyValue);

        log.info("Attempting delete for " +primaryPartitionKey+ " = " + primaryPartitionKeyValue + "and "+primarySortKey+ " = " + primarySortKeyValue + " from table " +tableName+" ...");
        table.deleteItem(deleteItemSpec);
        log.info("DeleteItem succeeded");
    }

    public void updateItem(String tableName, String primaryPartitionKey, String primaryPartitionKeyValue , String primarySortKey , String primarySortKeyValue , String primaryDateKey ,String primaryDateKeyValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        UpdateItemSpec updateItemSpec = new UpdateItemSpec()
                .withPrimaryKey(primaryPartitionKey, primaryPartitionKeyValue,primarySortKey, primarySortKeyValue)
                .withUpdateExpression("set "+primaryDateKey+" = :"+primaryDateKey)
                .withValueMap(new ValueMap()
                        .withString(":"+primaryDateKey,primaryDateKeyValue))
                ;
        log.info("Attempting update for " +primaryPartitionKey+ " = " + primaryPartitionKeyValue + "and "+primarySortKey+ " = " + primarySortKeyValue + "and "+primaryDateKey+ " = " + primaryDateKeyValue + " from table " +tableName+" ...");
        UpdateItemOutcome outcome = table.updateItem(updateItemSpec);
        log.info("UpdateItem succeeded");
    }

    public boolean deleteItemUsingQuery(String tableName, String primaryKey, String keyValue, String indexName, String colName) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);
        Index index = table.getIndex(indexName);

        log.info("Creating a query to look for " +primaryKey+ "=" +keyValue);

        QuerySpec querySpec = new QuerySpec().withKeyConditionExpression(primaryKey+" = :"+primaryKey)
                .withValueMap(new ValueMap()
                        .withString(":"+primaryKey,keyValue));

        ItemCollection<QueryOutcome> items = index.query(querySpec);
        Iterator<Item> iter = items.iterator();
        boolean found_results = iter.hasNext();
        log.info("Found items to delete: " + found_results);

        while (iter.hasNext()) {
            Item item = iter.next();
            log.info(item.toString());
            String colNameValue = item.get(colName).toString();
            log.info(colNameValue);

            DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                    .withPrimaryKey(new PrimaryKey(colName, colNameValue));

            log.info("Attempting delete for colName = " +colNameValue+ " ...");
            table.deleteItem(deleteItemSpec);
            log.info("DeleteItem succeeded");
        }

        if (!found_results)
            log.warn("Couldn't find any matching items in the table " + tableName + " for " +primaryKey+"=" +keyValue);

        return found_results;
    }

    public void insertItem(String tableName, String primaryKey, String primaryValue, String sortKey, String sortValue, String column, HashMap<String, Object> infoMap) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        try {
            log.info("Adding a new item...");
            PutItemOutcome outcome = table.putItem(new Item()
                    .withPrimaryKey(primaryKey, primaryValue, sortKey, sortValue)
                    .withMap(column, infoMap));

            log.info("PutItem succeeded:\n" + outcome.getPutItemResult());

        } catch (Exception e) {
            log.error("Unable to add item: " + primaryValue + " " + sortValue);
            log.error(e.getMessage());
        }
    }

    public void insertJSONintoDynamoTable(String tableName, String primaryKey, String primaryValue , String filename, DataTable dataTable , ScenarioSession scenarioSession) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        JsonParser parser = new JsonFactory().createParser(FileUtils.loadFile(filename));
        JsonNode rootNode = new ObjectMapper().readTree(parser);

        try {
            Item item = new Item().withPrimaryKey(primaryKey, primaryValue);
            log.info("\n");
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> result = mapper.convertValue(rootNode, Map.class);

            List<List<String>> rows = dataTable.raw();
            for (int i = 0; i < rows.size(); i++) {
                String attribute = rows.get(i).get(0);
                String value =     rows.get(i).get(1);

                while (!attribute.isEmpty()) {
                    if (value.isEmpty()) {
                        result.put(attribute,scenarioSession.getData(attribute));
                        break;
                    } else {
                        result.put(attribute,value);
                        break;
                    }
                }
            }

            for ( String key : result.keySet() ) {

                if (key.equalsIgnoreCase("version") || key.equalsIgnoreCase("versionNumber") || key.equalsIgnoreCase("frequency")) {
                    item.withInt(key,rootNode.path(key).asInt());
                    log.info(key + "->" + result.get(key).toString());

                } else if (!key.equalsIgnoreCase(primaryKey))
                    if(result.get(key).toString().contains("[{") && result.get(key).toString().contains("=") && result.get(key).toString().contains(", ")) {
                        item.withJSON(key, rootNode.path(key).toString());
                        log.info(key + "->" + result.get(key).toString());
                        // if "value" of attribute need to be added as "withJSON" then add the attribute in below if statement
                    } else if(key.equalsIgnoreCase("idpRefInfo") || key.equalsIgnoreCase("isCustomerDataVerified")|| key.equalsIgnoreCase("channel")|| key.equalsIgnoreCase("tags") || key.equalsIgnoreCase("descriptors") || key.equalsIgnoreCase("legalDocuments") || key.equalsIgnoreCase("placements")){
                        item.withJSON(key,rootNode.path(key).toString());
                        log.info(key + "->" + result.get(key).toString());
                    } else if(result.get(key).toString().equalsIgnoreCase("true") || result.get(key).toString().equalsIgnoreCase("false")) {
                        item.withBoolean(key,rootNode.path(key).asBoolean());
                        log.info(key + "->" + result.get(key).toString());
                    } else {
                        item.withString(key,result.get(key).toString());
                        log.info(key + "->" + result.get(key).toString());
                    }
            }

            table.putItem(item);
            System.out.println("\nPutItem succeeded into Table");

        } catch (Exception e) {
            log.error("Unable to add item: " + primaryValue);
            log.error(e.getMessage());
        }
    }

    public String getResultsFromTable(String tableName, String primaryKey, String primaryValue, String columnsSplitByComma) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        QuerySpec querySpec = new QuerySpec()
                .withProjectionExpression(columnsSplitByComma)
                .withKeyConditionExpression(primaryKey+" = :keyValue")
                .withValueMap(new ValueMap()
                        .withString(":keyValue", primaryValue));
        ItemCollection<QueryOutcome> items = table.query(querySpec);
        String resultsJSONString = "";

        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) {
            Item item = iter.next();
            log.info(item.toString());
            resultsJSONString = item.toJSON();
        }

        if (resultsJSONString.isEmpty())
            log.warn("Could not find any results for "+primaryKey+ " = " +primaryValue);

        return resultsJSONString;
    }

    public JSONObject getResultsFromTable(String tableName, String primaryKey, String primaryValue, String sortKey, String sortValue) throws Exception {
        Item itemResult = readItem(tableName, primaryKey, primaryValue, sortKey, sortValue);
        log.info(itemResult.toString());
        JSONObject resultsJSONString = new JSONObject(itemResult.toJSON());
        return resultsJSONString;
    }

    public JSONObject getResultsFromTable(String tableName, String primaryKey, String primaryValue) throws Exception {
        Item itemResult = readItem(tableName, primaryKey, primaryValue);
        log.info(itemResult.toString());
        JSONObject resultsJSONString = new JSONObject(itemResult.toJSON());
        return resultsJSONString;
    }

    public ArrayList<JSONObject> getAllResultsFromTable(String tableName, String primaryKey, String primaryValue, String columnsSplitByComma) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        QuerySpec querySpec = new QuerySpec()
                .withProjectionExpression(columnsSplitByComma)
                .withKeyConditionExpression(primaryKey+" = :keyValue")
                .withValueMap(new ValueMap()
                        .withString(":keyValue", primaryValue));
        ItemCollection<QueryOutcome> items = table.query(querySpec);

        ArrayList<JSONObject> jsonResults = new ArrayList<JSONObject>();
        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) {
            Item item = iter.next();
            log.info(item.toString());
            jsonResults.add(new JSONObject(item.toJSON()));
        }

        if (jsonResults.isEmpty())
            log.warn("Could not find any results for "+primaryKey+ " = " +primaryValue);

        return jsonResults;
    }

    public String getItem(String tableName, String primaryKey, String primaryValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        Item item = table.getItem(primaryKey, primaryValue);

        String resultsJSONString = item.toJSON();
        if (resultsJSONString.isEmpty())
            log.warn("Could not find any results for "+primaryKey+ " = " +primaryValue);

        return resultsJSONString;
    }

    public String getResultsFromTableUsingIndex(String tableName, String indexName, String primaryKey, String primaryValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();;
        Table table = dynamoDB.getTable(tableName);
        Index index = table.getIndex(indexName);

        QuerySpec querySpec = new QuerySpec().withKeyConditionExpression(primaryKey+" = :keyValue")
                .withValueMap(new ValueMap()
                        .withString(":keyValue", primaryValue));

        ItemCollection<QueryOutcome> items = index.query(querySpec);

        String resultsJSONString = "";

        Iterator<Item> iter = items.iterator();
        while (iter.hasNext()) {
            Item item = iter.next();
            log.info(item.toString());
            resultsJSONString = item.toJSON();
        }

        if (resultsJSONString.isEmpty())
            log.warn("Could not find any results for "+primaryKey+ " = " +primaryValue);

        return resultsJSONString;
    }

    public Item readItem(String tableName, String primaryKey, String primaryValue, String sortKey, String sortValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        GetItemSpec spec = new GetItemSpec()
                .withPrimaryKey(primaryKey, primaryValue, sortKey, sortValue);

        log.info("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        log.info("GetItem succeeded: " + outcome);
        return outcome;
    }

    public Item readItem(String tableName, String primaryKey, String primaryValue) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);

        GetItemSpec spec = new GetItemSpec()
                .withPrimaryKey(primaryKey, primaryValue);

        log.info("Attempting to read the item...");
        Item outcome = table.getItem(spec);
        log.info("GetItem succeeded: " + outcome);
        return outcome;
    }


    //Implemented to allow the hostname to be derived explicitly by the passed in service name string (rather than just enum)
    public String getServiceURL(String serviceName, String version) throws Exception {
        log.info(serviceRegistryTable+ " " + serviceName + " " + version );
        Item item = readItem(serviceRegistryTable, "service", serviceName, "version", version);
        if (item == null)
            throw new Exception("No records found in table " + serviceRegistryTable + " for service="
                    + serviceName + " and version=" + version);
        String url = item.get("url").toString();
        String port = item.get("port").toString();
        String status = item.get("status").toString();
        String apiversion = item.get("version").toString();
        log.info(url + " " + port + " " + status + " " + apiversion);
        return protocol + url;
    }

    public String getConfigurationItems(String serviceName, String version, String configurationName, String filter) throws Exception {
        Item item = this.readItem(configTable, "service", serviceName, "version", version);
        if(item == null) {
            throw new Exception("No records found in table " + configTable + " for service=" + serviceName + " and version=" + version);
        } else {


            String configString = item.get("config").toString();
            JSONObject configJSON = new JSONObject(configString);
            log.info(configJSON.toString());

            String[] splitArray = configurationName.split(Pattern.quote("."));
            if(splitArray.length == 0){
                splitArray =  new String []{configurationName};
            }

            String configItem = "";
            for(int i = 0; i<configJSON.names().length(); i++){

                if(configJSON.names().getString(i).equalsIgnoreCase(splitArray[0].toString())){
                    if(configJSON.get(configJSON.names().getString(i)).getClass().getName().contains("String")){
                        configItem =  configJSON.getString(configJSON.names().getString(i));
                    }else if(configJSON.get(configJSON.names().getString(i)).getClass().getName().contains("Boolean") || configJSON.get(configJSON.names().getString(i)).getClass().getName().contains("Integer")){
                        configItem =  configJSON.get(configJSON.names().getString(i)).toString();
                    }else if(configJSON.get(configJSON.names().getString(i)).getClass().getName().contains("JSONArray")){
                        JSONArray dynamoDBArray = configJSON.getJSONArray(configJSON.names().getString(i));
                        configItem = getdynamoDBArray(configJSON,dynamoDBArray ,filter,splitArray);
                    }else if(configJSON.get(configJSON.names().getString(i)).getClass().getName().contains("JSONObject")){
                        JSONObject dynamoDBObject = configJSON.getJSONObject(configJSON.names().getString(i));
                        if(splitArray.length > 2 ) {
                            configItem =  dynamoDBObject.getJSONObject(splitArray[1].toString()).get(splitArray[2].toString()).toString();
                        }else{
                            configItem =  dynamoDBObject.get(splitArray[1].toString()).toString();
                        }

                    }
                }

            }
            log.info("Table name=" + configItem);

            return configItem;
        }
    }

    public String getdynamoDBArray(JSONObject configJSON,JSONArray dynamoDBArray ,String filter, String[] splitArray) {
        String configItem = "";
        for (int j = 0; j < dynamoDBArray.length(); ++j) {
            JSONObject obj = dynamoDBArray.getJSONObject(j);
            if (!filter.equals("")) {
                String field = filter.substring(0, filter.indexOf(61));
                String value = filter.substring(filter.indexOf(61) + 1, filter.length());
                if (obj.getString(field).equals(value)) {
                    if(splitArray.length > 3){
                        configItem = obj.getJSONArray(splitArray[2]).get(Integer.parseInt(splitArray[3])).toString();
                        break;
                    }else{
                        configItem = obj.getJSONArray(splitArray[2]).toString();
                        break;
                    }
                }
            } else if (splitArray.length > 3) {
                configItem = configJSON.getJSONArray(splitArray[0]).getJSONObject(Integer.parseInt(splitArray[1])).getJSONArray(splitArray[2]).get(Integer.parseInt(splitArray[3])).toString();
            }else{
                configItem = configJSON.getJSONArray(splitArray[0]).getJSONObject(Integer.parseInt(splitArray[1])).get(splitArray[2]).toString();
            }
        }
        return configItem ;
    }

    public void queryItemAndDeleteFromTable(String tableName, String primaryKey, String primaryValue ,String primarySortKey ) throws Exception {
        DynamoDB dynamoDB = getDynamoDBConnection();
        Table table = dynamoDB.getTable(tableName);
        HashMap<String, String> nameMap = new HashMap<String, String>();
        nameMap.put("#"+primaryKey,primaryKey);
        HashMap<String, Object> valueMap = new HashMap<String, Object>();
        valueMap.put(":primaryValue", primaryValue);
        QuerySpec queryspec = new QuerySpec()
                .withKeyConditionExpression("#"+primaryKey+" = :primaryValue")
                .withNameMap(nameMap)
                .withValueMap(valueMap);
        ItemCollection<QueryOutcome> items = null;
        Iterator<Item> iterator = null;
        Item item = null;

        try {

            items = table.query(queryspec);
            iterator = items.iterator();

            while (iterator.hasNext()) {
                item = iterator.next();
                System.out.println(item.getString(primaryKey) + " : " + " : " + item.getString(primarySortKey));
                log.info("DATA FOUND with "+primaryKey.toUpperCase( )+" : " + item.getString(primaryKey) + primarySortKey.toUpperCase()+" : " + item.getString(primarySortKey)+"in table");
                DeleteItemSpec deleteItemSpec = new DeleteItemSpec()
                        .withPrimaryKey(primaryKey, primaryValue,primarySortKey,item.getString(primarySortKey));

                log.info("Attempting delete Subscription record with "+primaryKey.toUpperCase( )+" : " + item.getString(primaryKey) + primarySortKey.toUpperCase()+" : " + item.getString(primarySortKey)+"in table");
                DeleteItemOutcome deleteItemoutcome = table.deleteItem(deleteItemSpec);
                log.info("DeleteItem succeeded");

            }

        } catch (Exception e) {
            System.err.println("Unable to query");
            System.err.println(e.getMessage());
        }
    }

    public void updateWithpastProcessDt(String tableName, String primaryKey, String keyValue) throws Exception {
        try {
            DynamoDB dynamoDB = getDynamoDBConnection();
            Table table = dynamoDB.getTable(tableName);
            SimpleDateFormat SDF1 = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat SDF2=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'S'Z'");
            LocalDateTime dateBeforeDays = LocalDateTime.now().minusHours(24).plusMinutes(5);
            Date dates = Date.from(dateBeforeDays.toInstant(ZoneOffset.UTC));
            String date = SDF1.format(dates);
            String dateTime = SDF2.format(dates);

            UpdateItemSpec updateItemSpec = new UpdateItemSpec()
                    .withPrimaryKey(primaryKey,keyValue)
                    .withUpdateExpression("set processDate = :date, processDateTime = :dateTime")
                    .withValueMap(new ValueMap() .withString(":dateTime", dateTime) .withString(":date", date))
                    .withReturnValues(ReturnValue.UPDATED_NEW);

            log.info("Attempting update Subscription record with" + primaryKey + "=" + keyValue );
            UpdateItemOutcome  outcome = table.updateItem(updateItemSpec);
            log.info("UPDATE succeeded");

        } catch (Exception e) {
            log.warn("Couldn't find any matching items in the table " + tableName + " for" + primaryKey + "=" + keyValue );
            System.err.println(e.getMessage());
        }
    }
}