package com.experian.test.data.entities.customer;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public enum SignUpMotivation {

    Applying_For_Mortagage ( "ApplyingForMortgage", "Applying for a mortgage"),
    Applying_For_CreditCard ( "ApplyingForCreditCard", "Applying for a credit card" ),
    Applying_For_Loan ( "ApplyingForLoan", "Applying for a loan" ),
    Check_CreditScore ( "CreditScore", "Find out my credit score" ),
    Refused_Credit( "RefusedCredit", "I've been refused credit" );

    private String motivationReason;
    private String reasonText;

    private SignUpMotivation(String motivationReason, String reasonText) {
        this.motivationReason = motivationReason;
        this.reasonText = reasonText;
    }

    public String getMotivationReason() {
        return motivationReason;
    }

    public String getReasonText() {
        return reasonText;
    }

    public static SignUpMotivation getByString(String value){
        return valueOf(value);
    }


    private static final List<SignUpMotivation> VALUES = Collections.unmodifiableList(Arrays.asList(values()));
    private static final int SIZE = VALUES.size();
    private static final Random RANDOM = new Random();

    public static SignUpMotivation randomMotivation()  {
        return VALUES.get(RANDOM.nextInt(SIZE));
    }
}