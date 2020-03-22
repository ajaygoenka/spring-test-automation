package com.experian.test.session;

public enum ScenarioKey {

    APPLICANT_ID    ("applicantID"),
    BROKER_PAYLOAD  ("brokerPayload"),
    CUSTOMER_ID     ("customerId"),
    SUBSCRIPTION_ID ("subscriptionId"),
    SESSION_ID      ("sessionId"),
    SECURE_TOKEN    ("secureToken"),
    ADDRESS_ID      ("addressId"),
    PROSPECT_ID     ("prospectId"),
    REPORT_ID       ("reportId"),
    CREATE_DATE     ("createDate"),
    SCORE_ID        ("scoreId"),
    DOCUMENT_ID     ("document_Id"),
    URI_ID          ("uriId"),
    ALERTS_ID       ("alertsId"),
    USER_ID         ("userId");

    private String scenarioKey;

    private ScenarioKey(String scenarioKey) {
        this.scenarioKey = scenarioKey;
    }

    public String getKey() {
        return scenarioKey;
    }

    public static ScenarioKey getByString(String value){
        return valueOf(value.toUpperCase());
    }
}
