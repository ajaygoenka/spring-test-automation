package com.experian.test.data.entities.customer;

public enum ResidentialStatus {

    Homeowner_With_Mortgage ("Homeowner - With a Mortgage"),
    Homeowner_Without_Mortgage ("Homeowner - Without a Mortgage" ),
    Private_Tenant ("Private Tenant" ),
    Council_Tenant ("Council Tenant"),
    Living_With_Parents("Living with Parents");

    private String residentialStatus;

    private ResidentialStatus(String residentialStatus) {
        this.residentialStatus = residentialStatus;
    }

    public String getResidentialStatus() {
        return residentialStatus;
    }

    public static ResidentialStatus getByString(String value){
        return valueOf(value.toUpperCase());
    }
}