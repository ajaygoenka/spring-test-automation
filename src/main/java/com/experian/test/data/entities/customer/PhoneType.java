package com.experian.test.data.entities.customer;

public enum PhoneType {

    HOME ("home"),
    MOBILE ( "mobile" ),
    WORK ( "work" );

    private String phoneType;

    private PhoneType(String phoneType) {
        this.phoneType = phoneType;
    }

    public String getType() {
        return phoneType;
    }

    public static PhoneType getByString(String value){
        return valueOf(value.toUpperCase());
    }
}
