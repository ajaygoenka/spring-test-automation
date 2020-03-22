package com.experian.test.data.entities.customer;

public class FinancialDetails {

    private EmploymentStatus employmentStatus;
    private ResidentialStatus residentialStatus;
    private int annualIncome;
    private String currentAccountProvider;

    public void setEmploymentStatus(EmploymentStatus employmentStatus) {
        this.employmentStatus = employmentStatus;
    }
    public EmploymentStatus getEmploymentStatus() {
        return employmentStatus;
    }

    public void setResidentialStatus(ResidentialStatus residentialStatus) {
        this.residentialStatus = residentialStatus;
    }
    public ResidentialStatus getResidentialStatus() {
        return residentialStatus;
    }

    public void setAnnualIncome(int annualIncome) {
        this.annualIncome = annualIncome;
    }
    public int getAnnualIncome() {
        return annualIncome;
    }

    public void setCurrentAccountProvider(String currentAccountProvider) {
        this.currentAccountProvider = currentAccountProvider;
    }
    public String getCurrentAccountProvider() {
        return currentAccountProvider;
    }
}
