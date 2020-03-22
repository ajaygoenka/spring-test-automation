package com.experian.test.data.entities.customer;

import java.time.LocalDateTime;

public class IDaasInformation {

    private LocalDateTime authenticatedDate;
    private String authenticationLevel;
    private String providerName;

    public LocalDateTime getAuthenticatedDate() {
        return authenticatedDate;
    }

    public void setAuthenticatedDate(LocalDateTime authenticatedDate) {
        this.authenticatedDate = authenticatedDate;
    }

    public String getAuthenticationLevel() {
        return authenticationLevel;
    }

    public void setAuthenticationLevel(String authenticationLevel) {
        this.authenticationLevel = authenticationLevel;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }
}
