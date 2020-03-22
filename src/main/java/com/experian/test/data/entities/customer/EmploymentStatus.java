package com.experian.test.data.entities.customer;

public enum EmploymentStatus {

    Full_Time ("Full time"),
    Part_Time ("Part time" ),
    Self_Employed ("Self Employed" ),
    Homemaker ("Homemaker"),
    Student("Student"),
    Unemployed ("Unemployed"),
    Retired("Retired");

    private String employmentStatus;

    private EmploymentStatus(String employmentStatus) {
        this.employmentStatus = employmentStatus;
    }

    public String getEmploymentStatus() {
        return employmentStatus;
    }

    public static EmploymentStatus getByString(String value){
        return valueOf(value.toUpperCase());
    }
}