package com.experian.test.utils;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.lang.Integer.parseInt;

@Component
public class JSONUtils {

    private static final Logger log = (Logger) LoggerFactory.getLogger(JSONUtils.class);
    private static final Pattern NODE_LIST_ARRAY_PATTERN = Pattern.compile("(.*?)\\[(\\d+)\\]");

    private String lastNode;
    private String parentNode;

    public boolean isNodePresent(JSONObject jsonObject, String node_name) throws JSONException {
        JSONObject json_obj = getCorrectJsonObject(jsonObject, node_name);
        return json_obj.has(lastNode);
    }

    public boolean isValueCorrect(JSONObject jsonObject, String node_name, String node_value) throws JSONException {
        JSONObject json_obj = getCorrectJsonObject(jsonObject, node_name);
        if (json_obj.has(lastNode)) {
            log.debug("lastNode value: "+json_obj.get(lastNode));
            return json_obj.get(lastNode).toString().equals(node_value);
        }
        return false;
    }

    public String getNodeValue(JSONObject jsonObject, String node_name) throws JSONException {
        JSONObject json_obj = getCorrectJsonObject(jsonObject, node_name);
        return json_obj.get(lastNode).toString();
    }

    public JSONObject modifyJSONAttributes(JSONObject json_to_send, String attribute_name, String new_value) {
        JSONObject modified_json;
        String[] strArray;
        if (attribute_name.contains(".")) { // check if node_name has a child node or not
            modified_json = getCorrectJsonObject(json_to_send, attribute_name);
            if (new_value != null && new_value.equalsIgnoreCase("deleting"))
                modified_json.remove(lastNode);
            else if (new_value == null)
                modified_json.put(lastNode, JSONObject.NULL);
            else
                modified_json.put(lastNode, new_value);
        } else {
            modified_json = getCorrectJsonObject(json_to_send, attribute_name);
            if (new_value == null)
                modified_json.put(lastNode, JSONObject.NULL);
            else if (new_value != null && new_value.contains("--")) {
                strArray = new_value.split("--");
                modified_json.put(lastNode,strArray);
            }else
                modified_json.put(lastNode, new_value);
            json_to_send = modified_json;
        }

        log.debug("Modified JSON="+modified_json);
        log.debug("JSON To Send="+json_to_send);
        return json_to_send;
    }

    private List<String> getJsonNodesList(String node_name) {
        String[] node_list = node_name.split("\\.");
        return Arrays.asList(node_list);
    }

    private JSONObject getCorrectJsonObject(JSONObject jsonObj, String node_name) throws JSONException {
        lastNode = node_name;
        log.debug("lastNode start="+lastNode);
        if (node_name.contains(".")) { // check if node_name has a child node or not
            List<String> node_list = getJsonNodesList(node_name);
            lastNode = node_list.get(node_list.size() - 1);
            log.debug("lastNode="+lastNode);
            parentNode = node_list.get(0);
            for (int i = 0; i < node_list.size() - 1; i++) {
                String node = node_list.get(i);
                Matcher matcher = NODE_LIST_ARRAY_PATTERN.matcher(node);
                if(matcher.matches()) {
                    String arrayNode  = matcher.group(1);
                    int index = parseInt(matcher.group(2));
                    jsonObj = (JSONObject) jsonObj.getJSONArray(arrayNode).get(index);
                }
                else {
                    jsonObj = jsonObj.getJSONObject(node_list.get(i));
                }
            }
        }
        return jsonObj;
    }
}
