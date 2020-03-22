package com.experian.test.utils;

import au.com.bytecode.opencsv.CSVWriter;
import com.experian.test.data.entities.customer.*;
import com.experian.test.utils.file.csv.CsvFileReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.io.FileWriter;
import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@Component
@Scope("cucumber-glue")
public class CustomerUtil {

    private Customer customer;

    private static final Logger log = (Logger) LoggerFactory.getLogger(CustomerUtil.class);

    public void importCustomerCSVFile(String customerCSVFileName) {
        log.info("Getting a customer from the csv file...");
        customer = null;

        List<String[]> csvData = CsvFileReader.readCsv(customerCSVFileName);
        String[] line = csvData.get(0);
        log.info("Customer CSV data: ");
        for (String dataItem: line) {
            log.info(dataItem);
        }
        buildCustomer(line);
        csvData.remove(0);
        writeUpdatedCSVFile(customerCSVFileName, csvData);
    }

    private void writeUpdatedCSVFile(String csvFileName, List<String[]> csvData) {
        CSVWriter writer = null;

        try {
            writer = new CSVWriter(new FileWriter(csvFileName), ',', CSVWriter.NO_QUOTE_CHARACTER);
            writer.writeAll(csvData);
        } catch (final IOException e) {
            log.error(String.format("Failed to write output to CSV file %s : %s", csvFileName, e.getMessage()));
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (final IOException e) {
                    // Do nothing
                }
            }
        }
    }

    private void buildCustomer(String[] data) {
        log.info("Building internal <Customer> data entity and fill it with parsed data.");
        createIDaaSCustomer(data[2], data[3], data[0], "", "1975-02-01", "MothersMaidenName",
                "active", "", "80fd8c3c-1c7c-42da-9d37-8ee52dfe88ce", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME), "", Boolean.TRUE);
        customer.setCustomerId(data[1]);
    }

    public Customer getCustomer() {
        return customer;
    }

    public CustomerUtil createBasicCustomer() {
        String firstName = RandomUtils.randomAlphaString(8);
        String lastName = RandomUtils.randomAlphaString(8);
        String email = RandomUtils.randomAlphaString(10) + "@experiancs.com";
        String dobYear = Integer.toString(RandomUtils.randomInt(1900, 1997));
        String dobMonth = org.apache.commons.lang3.StringUtils.leftPad(Integer.toString(RandomUtils.randomInt(01, 12)), 2, "0");
        String dobDay = org.apache.commons.lang3.StringUtils.leftPad(Integer.toString(RandomUtils.randomInt(01, 28)), 2, "0");
        String dob = dobYear + "-" + dobMonth + "-" + dobDay;
        String idpRefId = "automation-" + RandomUtils.randomAlphaString(10);
        String mothersMaidenName = RandomUtils.randomAlphaString(8);

        customer = new Customer();
        customer.setCustomerId(UUID.randomUUID().toString());
        customer.setTitle("Mr");
        customer.setFirstName(firstName);
        customer.setMiddleName(null);
        customer.setLastName(lastName);
        customer.setEmailAddress(email);
        customer.setDateOfBirth(dobYear + "-" + dobMonth + "-" + dobDay);
        customer.setMothersMaidenName(mothersMaidenName);
        customer.setStatus("Active");
        customer.setIdpRefId(idpRefId);
        customer.setTenantId("80fd8c3c-1c7c-42da-9d37-8ee52dfe88ce");
        customer.setIsDateOfBirthVerified(false);
        customer.setIsEmailVerified(false);
        customer.setIsFirstNameVerified(true);
        customer.setIsLastNameVerified(true);
        customer.setIsMiddlenameVerified(false);
        customer.setVersionNumber(0);

        IDaasInformation iDaasInformation = new IDaasInformation();
        iDaasInformation.setAuthenticatedDate(LocalDateTime.now());
        iDaasInformation.setAuthenticationLevel("verified");
        iDaasInformation.setProviderName("iDaas");
        customer.setIDaaSInformation(iDaasInformation);

        return this;
    }

    public CustomerUtil createIDaaSCustomer(String firstName, String lastName, String middleName, String email, String dateOfBirth, String mothersMaidenName,
                                            String status, String iDpRefId, String tenantId, String authenticatedDate, String signUpMotivation, Boolean marketingOptIn) {
        customer = new Customer();
        customer.setCustomerId(UUID.randomUUID().toString());
        customer.setTitle("Mr");
        customer.setFirstName(firstName);
        customer.setMiddleName(middleName);
        customer.setLastName(lastName);
        customer.setEmailAddress(email);
        customer.setDateOfBirth(dateOfBirth);
        customer.setMothersMaidenName(mothersMaidenName);
        customer.setStatus(status);
        customer.setIdpRefId(iDpRefId);
        customer.setTenantId(tenantId);

        IDaasInformation iDaasInformation = new IDaasInformation();
        iDaasInformation.setAuthenticatedDate(LocalDateTime.parse(authenticatedDate));
        iDaasInformation.setAuthenticationLevel("verified");
        iDaasInformation.setProviderName("iDaas");
        customer.setIDaaSInformation(iDaasInformation);

        addAddress(AddressType.CURRENT, null, "Sir John Peace Building", null,
                "Experian Way", "NOTTINGHAM", "Some District", "Nottinghamshire", null,
                "NG80 1ZZ", true, false, false, "2008-01-01", null);

        addPhoneNumber(PhoneType.MOBILE, false, "07777777777");

        for (SignUpMotivation motivation: SignUpMotivation.values()) {
            if (motivation.getMotivationReason().equals(signUpMotivation))
                customer.setSignUpMotivation(motivation);
        }
        customer.setMarketingOptIn(marketingOptIn);

        customer.setHasAbroadAddress(Boolean.FALSE);
        customer.setHasPreviousAddress(Boolean.FALSE);

        return this;
    }

    public CustomerUtil createIDaaSCustomer() {
        createBasicCustomer();

        addAddress(AddressType.CURRENT, null, "Sir John Peace Building", null,
                "Experian Way", "NOTTINGHAM", "Some District", "Nottinghamshire", null,
                "NG80 1ZZ", true, false, false, "2008-01-01", null);

        addPhoneNumber(PhoneType.MOBILE, false, "07777777777");

        customer.setSignUpMotivation(SignUpMotivation.randomMotivation());
        Random random = new Random();
        customer.setMarketingOptIn(random.nextBoolean());

        customer.setHasAbroadAddress(Boolean.FALSE);
        customer.setHasPreviousAddress(Boolean.FALSE);

        return this;
    }

    public CustomerUtil addAddress(AddressType addressType, String houseNumber, String houseName, String flat, String street, String townCity,
                                   String district, String county, String country, String postCode, boolean isVerified,
                                   boolean enteredManually, boolean isAbroad, String fromDate, String toDate) {
        CustomerAddress address = new CustomerAddress();
        address.setAddressType(addressType);
        address.setFlat(flat);
        address.setHouseNumber(houseNumber);
        address.setHouseName(houseName);
        address.setStreetAddress(street);
        address.setTownCityName(townCity);
        address.setDistrict(district);
        address.setCounty(county);
        address.setCountry(country);
        address.setPostCode(postCode);
        address.setIsVerified(isVerified);
        address.setEnteredManually(enteredManually);
        address.setIsAbroad(isAbroad);
        address.setFromDate(fromDate);
        address.setToDate(toDate);
        customer.addAddress(address);

        return this;
    }

    public CustomerUtil addPhoneNumber(PhoneType phoneType, boolean isVerified, String number) {
        CustomerPhone phone = new CustomerPhone();
        phone.setPhoneType(phoneType);
        phone.setIsVerified(isVerified);
        phone.setNumber(number);
        customer.addPhone(phone);

        return this;
    }

    public CustomerUtil addTermsAndPrivacyPolicyDates() {
        customer.setTermsAndConditionsDate(Instant.now());
        customer.setPrivacyPolicyDate(Instant.now());
        return this;
    }

    public CustomerUtil addPreviousAddresses() {
        CustomerAddress prevAddress1 = new CustomerAddress();
        prevAddress1.setAddressType(AddressType.PREVIOUS);
        prevAddress1.setHouseNumber("71");
        prevAddress1.setHouseName(null);
        prevAddress1.setStreetAddress("Lee Lane");
        prevAddress1.setTownCityName("BOLTON");
        prevAddress1.setDistrict("District 2");
        prevAddress1.setCounty("Lancashire");
        prevAddress1.setCountry(null);
        prevAddress1.setPostCode("BL6 7AU");
        prevAddress1.setIsVerified(true);
        prevAddress1.setEnteredManually(false);
        prevAddress1.setFromDate("2007-01-01");
        prevAddress1.setToDate("2008-01-01");
        customer.addAddress(prevAddress1);

        CustomerAddress prevAddress2 = new CustomerAddress();
        prevAddress2.setAddressType(AddressType.PREVIOUS);
        prevAddress2.setHouseNumber(null);
        prevAddress2.setHouseName("Overseas Votes");
        prevAddress2.setStreetAddress("Arnot Hill Park");
        prevAddress2.setTownCityName("NOTTINGHAM");
        prevAddress2.setDistrict("District 3");
        prevAddress2.setCounty("Nottinghamshire");
        prevAddress2.setCountry(null);
        prevAddress2.setPostCode("NG5 0ZZ");
        prevAddress2.setIsVerified(true);
        prevAddress2.setEnteredManually(false);
        prevAddress2.setFromDate("2006-05-01");
        prevAddress2.setToDate("2007-01-01");
        customer.addAddress(prevAddress2);

        CustomerAddress prevAddress3 = new CustomerAddress();
        prevAddress3.setAddressType(AddressType.PREVIOUS);
        prevAddress3.setHouseNumber("100");
        prevAddress3.setHouseName("Test House Name");
        prevAddress3.setStreetAddress("Pyke Close");
        prevAddress3.setTownCityName("WOKINGHAM");
        prevAddress3.setDistrict("District 4");
        prevAddress3.setCounty("Berkshire");
        prevAddress3.setCountry(null);
        prevAddress3.setPostCode("RG40 1SZ");
        prevAddress3.setIsVerified(true);
        prevAddress3.setEnteredManually(false);
        prevAddress3.setFromDate("2000-10-01");
        prevAddress3.setToDate("2006-05-01");
        customer.addAddress(prevAddress3);

        customer.setHasPreviousAddress(Boolean.TRUE);
        return this;
    }

    public CustomerUtil addAbroadAddress() {
        CustomerAddress prevAddress1 = new CustomerAddress();
        prevAddress1.setAddressType(AddressType.PREVIOUS);
        prevAddress1.setIsAbroad(true);
        prevAddress1.setFromDate("2005-12-01");
        prevAddress1.setToDate("2008-01-01");
        customer.addAddress(prevAddress1);

        customer.setHasAbroadAddress(Boolean.TRUE);
        customer.setHasPreviousAddress(Boolean.TRUE);
        return this;
    }

    public CustomerUtil addNameAliases() {
        CustomerNameAlias aliasFirstName = new CustomerNameAlias();
        aliasFirstName.setNameType(NameType.FIRSTNAME_ALIAS);
        aliasFirstName.setAliasName("PrevFirstName");
        aliasFirstName.setIsVerified(true);
        aliasFirstName.setFromDate(customer.getDateOfBirth());
        aliasFirstName.setToDate("2017-01-26");
        customer.addName(aliasFirstName);

        CustomerNameAlias aliasMiddleName = new CustomerNameAlias();
        aliasMiddleName.setNameType(NameType.MIDDLENAME_ALIAS);
        aliasMiddleName.setAliasName("PrevMiddleName");
        aliasMiddleName.setIsVerified(true);
        aliasMiddleName.setFromDate(customer.getDateOfBirth());
        aliasMiddleName.setToDate("2017-01-26");
        customer.addName(aliasMiddleName);

        CustomerNameAlias aliasLastName = new CustomerNameAlias();
        aliasLastName.setNameType(NameType.LASTNAME_ALIAS);
        aliasLastName.setAliasName("PrevLastName");
        aliasLastName.setIsVerified(true);
        aliasLastName.setFromDate(customer.getDateOfBirth());
        aliasLastName.setToDate("2017-01-26");
        customer.addName(aliasLastName);
        return this;
    }

    public Customer createEmptyIDaaSCustomer(){
        customer = new Customer();
        return customer;
    }

}