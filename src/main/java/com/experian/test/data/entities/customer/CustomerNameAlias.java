package com.experian.test.data.entities.customer;

public class CustomerNameAlias {

    private NameType nameType;
    private String aliasName;

    private String fromDate;
    private String toDate;

    private boolean isVerified;

    public NameType getNameType() {
        return nameType;
    }

    public void setNameType(NameType nameType) {
        this.nameType = nameType;
    }

    public String getAliasName() {
        return aliasName;
    }

    public void setAliasName(String aliasName) {
        this.aliasName = aliasName;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public boolean getIsVerified() {
        return isVerified;
    }
    public void setIsVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }
}

