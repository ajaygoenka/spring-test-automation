package com.experian.test.data.entities.customer;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class Customer {

    private String title;
    private String firstName;
    private String middleName;
    private String lastName;
    private String emailAddress;
    private String customerDateOfBirth;
    private String mothersMaidenName;
    private String customerId;
    private String status;
    private String tenantId;
    private String idpRefId;
    private String gender;

    private SignUpMotivation signUpMotivation;
    private FinancialDetails financialDetails;
    private ArrayList<CustomerNameAlias> nameList = new ArrayList<CustomerNameAlias>();
    private ArrayList<CustomerAddress> addressesList = new ArrayList<CustomerAddress>();
    private ArrayList<CustomerPhone> phoneList = new ArrayList<CustomerPhone>();
    private IDaasInformation idaasInformation;
    private LocalDateTime updatedDate;

    private Boolean isFirstnameVerified;
    private Boolean isLastnameVerified;
    private Boolean isEmailVerified;
    private Boolean isMiddlenameVerified;
    private Boolean isDOBVerified;

    private Boolean marketingOptIn;

    private Boolean hasPreviousAddress;
    private Boolean hasAbroadAddress;

    private int versionNumber;

    private Instant termsAndConditionsDate;
    private Instant privacyPolicyDate;

    private String offerId;
    private String billingPaymentAuthorizationId;

    public Customer() {
        setUpdatedDate();
    }

    public void setUpdatedDate() {
        updatedDate = LocalDateTime.now();
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String email) {
        this.emailAddress = email;
    }

    public String getDateOfBirth() {
        return customerDateOfBirth;
    }

    public void setDateOfBirth(String customerDateOfBirth) {
        this.customerDateOfBirth = customerDateOfBirth;
    }

    public String getMothersMaidenName() {
        return mothersMaidenName;
    }

    public void setMothersMaidenName(String mothersMaidenName) {
        this.mothersMaidenName = mothersMaidenName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public ArrayList<CustomerNameAlias> getNames() {
        return nameList;
    }

    public void setNames(ArrayList<CustomerNameAlias> nameList) {
        this.nameList = nameList;
    }

    public void addName(CustomerNameAlias name) {
        this.nameList.add(name);
    }

    public ArrayList<CustomerAddress> getAddresses() {
        return addressesList;
    }

    public void setAddresses(ArrayList<CustomerAddress> addressesList) {
        this.addressesList = addressesList;
    }

    public void addAddress(CustomerAddress address) {
        this.addressesList.add(address);
    }

    public ArrayList<CustomerPhone> getPhoneList() {
        return phoneList;
    }

    public void setPhoneList(ArrayList<CustomerPhone> phoneList) {
        this.phoneList = phoneList;
    }

    public void addPhone(CustomerPhone phone) {
        this.phoneList.add(phone);
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public SignUpMotivation getSignUpMotivation() {
        return signUpMotivation;
    }

    public void setSignUpMotivation(SignUpMotivation signUpMotivation) {
        this.signUpMotivation = signUpMotivation;
    }

    public FinancialDetails getFinancialDetails() {
        return financialDetails;
    }

    public void setFinancialDetails(FinancialDetails financialDetails) {
        this.financialDetails = financialDetails;
    }

    public IDaasInformation getIDaaSInformation() {
        return idaasInformation;
    }

    public void setIDaaSInformation(IDaasInformation idaasInformation) {
        this.idaasInformation = idaasInformation;
    }

    public String getIdpRefId() {
        return idpRefId;
    }

    public void setIdpRefId(String idpRefId) {
        this.idpRefId = idpRefId;
    }

    public String getTenantId() {
        return tenantId;
    }

    public void setTenantId(String tenantId) {
        this.tenantId = tenantId;
    }

    public Boolean getIsFirstNameVerified() {
        return isFirstnameVerified;
    }

    public void setIsFirstNameVerified(Boolean isFirstnameVerified) {
        this.isFirstnameVerified = isFirstnameVerified;
    }

    public Boolean getIsLastNameVerified() {
        return isLastnameVerified;
    }

    public void setIsLastNameVerified(Boolean isLastnameVerified) {
        this.isLastnameVerified = isLastnameVerified;
    }

    public Boolean getIsEmailVerified() {
        return isEmailVerified;
    }

    public void setIsEmailVerified(Boolean isEmailVerified) {
        this.isEmailVerified = isEmailVerified;
    }

    public Boolean getIsDateOfBirthVerified() {
        return isDOBVerified;
    }

    public void setIsDateOfBirthVerified(Boolean isDOBVerified) {
        this.isDOBVerified = isDOBVerified;
    }

    public Boolean getIsMiddleNameVerified() {
        return isMiddlenameVerified;
    }

    public void setIsMiddlenameVerified(Boolean isMiddlenameVerified) {
        this.isMiddlenameVerified = isMiddlenameVerified;
    }

    public Boolean getMarketingOptIn() {
        return marketingOptIn;
    }

    public void setMarketingOptIn(Boolean marketingOptIn) {
        this.marketingOptIn = marketingOptIn;
    }

    public void setHasAbroadAddress(Boolean hasAbroadAddress) {
        this.hasAbroadAddress = hasAbroadAddress;
    }

    public Boolean getHasAbroadAddress() {
        return hasAbroadAddress;
    }

    public void setHasPreviousAddress(Boolean hasPreviousAddress) {
        this.hasPreviousAddress = hasPreviousAddress;
    }

    public Boolean getHasPreviousAddress() {
        return hasPreviousAddress;
    }

    public void setVersionNumber(int versionNumber) {
        this.versionNumber = versionNumber;
    }

    public int getVersionNumber() {
        return versionNumber;
    }

    public void setTermsAndConditionsDate(Instant termsAndConditionsDate) {
        this.termsAndConditionsDate = termsAndConditionsDate;
    }

    public Instant getTermsAndConditionsDate() {
        return termsAndConditionsDate;
    }

    public void setPrivacyPolicyDate(Instant privacyPolicyDate) {
        this.privacyPolicyDate = privacyPolicyDate;
    }

    public Instant getPrivacyPolicyDate() {
        return privacyPolicyDate;
    }

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
    }

    public String getBillingPaymentAuthorizationId() {
        return billingPaymentAuthorizationId;
    }

    public void setBillingPaymentAuthorizationId(String billingPaymentAuthorizationId) {
        this.billingPaymentAuthorizationId = billingPaymentAuthorizationId;
    }

}