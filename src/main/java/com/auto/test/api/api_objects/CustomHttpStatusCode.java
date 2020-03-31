package com.auto.test.api.api_objects;

public enum CustomHttpStatusCode {

    CANNOT_FULFILL (530, "Cannot Fulfill"),
    GENERIC_EXCEPTION (540, "Generic Exception"),
    VALIDATION_FAILED_1 (550, "Validation failed"),
    EXT_SERVICE_UNAVAILABLE (560, "External service unavailable"),
    EXT_VENDOR_NOT_RESPONDING (561, "External Vendor Not Responding"),
    VALIDATION_FAILED_2 (570, "Validation failed");

    private int statusCode;
    private String statusCodeDescription;

    private CustomHttpStatusCode(int statusCode, String statusCodeDescription) {
        this.statusCode = statusCode;
        this.statusCodeDescription = statusCodeDescription;
    }

    public String getStatusCodeDescription() {
        return statusCodeDescription;
    }

    public static CustomHttpStatusCode valueOf(int statusCode) {
        CustomHttpStatusCode[] statusCodeArray = values();
        int length = statusCodeArray.length;

        for (int i = 0; i < length; ++i) {
            CustomHttpStatusCode status = statusCodeArray[i];
            if(status.statusCode == statusCode) {
                return status;
            }
        }

        throw new IllegalArgumentException("No matching constant for [" + statusCode + "]");
    }
}
