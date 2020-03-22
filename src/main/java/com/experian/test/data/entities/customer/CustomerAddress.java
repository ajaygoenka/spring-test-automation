package com.experian.test.data.entities.customer;

public class CustomerAddress {

    private AddressType addressType;
    private String flat;
    private String houseName;
    private String houseNumber;
    private String streetAddress;
    private String townCityName;
    private String district;
    private String county;
    private String postCode;
    private String country;
    private String fromDate;
    private String toDate;
    private boolean isVerified;
    private boolean enteredManually;
    private boolean isAbroad;

    public AddressType getAddressType() {
        return addressType;
    }

    public void setAddressType(AddressType addressType) {
        this.addressType = addressType;
    }

    public String getFlat() {
        return flat;
    }

    public void setFlat(String flat) {
        this.flat = flat;
    }

    public String getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }

    public String getHouseName() {
        return houseName;
    }

    public void setHouseName(String houseName) {
        this.houseName = houseName;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public String getTownCityName() {
        return townCityName;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getDistrict() {
        return district;
    }

    public void setTownCityName(String townCityName) {
        this.townCityName = townCityName;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
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

    public boolean getEnteredManually() {
        return enteredManually;
    }

    public void setEnteredManually(boolean enteredManually) {this.enteredManually = enteredManually;}

    public boolean getIsAbroad() {return isAbroad;}

    public void setIsAbroad(boolean isAbroad) {this.isAbroad = isAbroad;}

    @Override
    public String toString() {
        return
                addressType + "\n " +
                houseNumber + "\n " +
                houseName + "\n " +
                streetAddress + "\n " +
                townCityName + "\n " + district + "\n " +
                county + "\n " +
                postCode;
    }

}

