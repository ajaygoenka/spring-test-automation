package com.experian.test.data.entities.customer;

public enum AddressType {

    CURRENT ("C", "Current Address"),
    PREVIOUS ("P", "Previous Address" ),
    SUPPLEMENTAL ("S", "Supplemental Address" );

    private String addressType;
    private String addressTypeName;

    private AddressType(String addressType, String addressTypeName) {
        this.addressType = addressType;
    }

    public String getType() {
        return addressType;
    }

    public String getTypeName() {
        return addressType;
    }

    public static AddressType getByString(String value){
        return valueOf(value.toUpperCase());
    }
}
