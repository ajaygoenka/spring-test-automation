package com.experian.test.data.entities.customer;

public enum NameType {

    CURRENT_NAME (""),
    FIRSTNAME_ALIAS ("ForenameType"),
    MIDDLENAME_ALIAS ("MiddleNameType"),
    LASTNAME_ALIAS ("SurnameType");

    private String xmlAliasNameTag;

    private NameType(String xmlAliasNameTag) {
        this.xmlAliasNameTag = xmlAliasNameTag;
    }

    public String getXmlAliasNameTag() {
        return xmlAliasNameTag;
    }

    public static NameType getByString(String value){
        return valueOf(value.toUpperCase());
    }
}
