package com.experian.test.api.config;

import com.experian.test.api.config.properties.ApiEnvSetupImpl;
import com.experian.test.api.config.properties.BaseEnvSetup;
import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class EnvSetup extends ApiEnvSetupImpl {

    private static final Logger log = (Logger) LoggerFactory.getLogger(EnvSetup.class);


    @Value("${personalloans.api.version}")
    private String personalloansApiVersion;

    @Value("${personalloans.url:}")
    private String personalloansUrl;

    @Value("${oauth.api.version}")
    private String oauthApiVersion;

    @Value("${oauth.url:}")
    private String oauthUrl;

    @Value("${customer.api.version}")
    private String customerApiVersion;

    @Value("${oauth.url:}")
    private String customerUrl;

    @Value("${offers.api.version}")
    private String offersApiVersion;

    @Value("${offers.url:}")
    private String offersUrl;

    @Value("${registration.api.version}")
    private String registrationApiVersion;

    @Value("${registration.url:}")
    private String registrationUrl;

    @Value("${prequal.api.version}")
    private String prequalApiVersion;

    @Value("${prequal.url:}")
    private String prequalUrl;

    @Value("${clickstream.api.version}")
    private String clickstreamApiVersion;

    @Value("${clickstream.url:}")
    private String clickstreamUrl;

    @Value("${report.api.version}")
    private String reportApiVersion;

    @Value("${report.url:}")
    private String reportUrl;

    @Value("${login.api.version}")
    private String loginApiVersion;

    @Value("${login.url:}")
    private String loginUrl;

    @Value("${profile.api.version}")
    private String profileApiVersion;

    @Value("${profile.url:}")
    private String profileUrl;

    @Value("${fulfillment.api.version}")
    private String fulfillmentApiVersion;

    @Value("${fulfillment.url:}")
    private String fulfillmentUrl;

    @Value("${enrollment2.api.version}")
    private String enrollment2ApiVersion;

    @Value("${enrollment2.url:}")
    private String enrollment2Url;

    @Value("${childMonitoring.api.version}")
    private String childMonitoringApiVersion;

    @Value("${childMonitoring.url:}")
    private String childMonitoringUrl;

    @Value("${dispute.api.version}")
    private String disputeApiVersion;

    @Value("${dispute.url:}")
    private String disputeUrl;

    @Value("${itp.api.version}")
    private String itpApiVersion;

    @Value("${itp.url:}")
    private String itpUrl;

    @Value("${pii.api.version}")
    private String piiApiVersion;

    @Value("${pii.url:}")
    private String piiUrl;

    @Value("${salesForce.api.version}")
    private String salesForceApiVersion;

    @Value("${salesForce.url:}")
    private String salesForceUrl;

    @Value("${crmoData.api.version}")
    private String crmoDataApiVersion;

    @Value("${crmoData.url:}")
    private String crmoDataUrl;

    @Value("${csidGateway.api.version}")
    private String csidGatewayApiVersion;

    @Value("${csidGateway.url:}")
    private String csidGatewayUrl;

    @Value("${csidOrchestrator.api.version}")
    private String csidOrchestratorApiVersion;

    @Value("${csidOrchestrator.url:}")
    private String csidOrchestratorUrl;

    @Value("${familyPlan.api.version}")
    private String familyPlanApiVersion;

    @Value("${familyPlan.url:}")
    private String familyPlanUrl;

    @Value("${bureauLock.api.version}")
    private String bureauLockApiVersion;

    @Value("${bureauLock.url:}")
    private String bureauLockUrl;

    @Value("${vaultgateway.api.version}")
    private String vaultgatewayApiVersion;

    @Value("${vaultgateway.url:}")
    private String vaultgatewayUrl;

    @Value("${securelogin.api.version}")
    private String secureloginApiVersion;

    @Value("${securelogin.url:}")
    private String secureloginUrl;

    @Value("${uiprofile.api.version}")
    private String uiprofileApiVersion;

    @Value("${uiprofile.url:}")
    private String uiprofileUrl;

    @Value("${leadcapture.api.version}")
    private String leadcaptureApiVersion;

    @Value("${leadcapture.url:}")
    private String leadcaptureUrl;

    @Value("${globalterms.api.version}")
    private String globaltermsApiVersion;

    @Value("${globalterms.url:}")
    private String globaltermsUrl;

    @Value("${financialactivity.api.version}")
    private String financialactivityApiVersion;

    @Value("${financialactivity.url:}")
    private String financialactivityUrl;

    @Value("${alerts.api.version}")
    private String alertsApiVersion;

    @Value("${alerts.url:}")
    private String alertsUrl;

    @Value("${wallet.api.version}")
    private String walletApiVersion;

    @Value("${wallet.url:}")
    private String walletUrl;

    @Value("${survey.api.version}")
    private String surveyApiVersion;

    @Value("${survey.url:}")
    private String surveyUrl;

    @Value("${memberpreference.api.version}")
    private String memberpreferenceApiVersion;

    @Value("${memberpreference.url:}")
    private String memberpreferenceUrl;

    @Value("${oauth2.api.version}")
    private String oauth2ApiVersion;

    @Value("${oauth2.url:}")
    private String oauth2Url;

    @Value("${boe.api.version}")
    private String boeApiVersion;

    @Value("${boe.url:}")
    private String boeUrl;

    private String customerprofileTable;
    private String subscriptionTable;
    private String subscriptionBenefitTable;
    private String enrollmentBenefitTable;
    private String enrollmentBenefitHistoryTable;
    private String customerLoginTable;
    private String creditReportsTable;
    private String bonusResourcesTable;
    private String scoresTable;
    private String subscriptionHistoryTable;
    private String subscriptionPaymentTable;
    private String vaultAccountTable;
    private String LoanOffersTable;
    private String CustomerLoanProfileTable;
    private String DarkwebMatchInfoRequestTable;



    @Autowired
    public EnvSetup(BaseEnvSetup baseEnvSetup) throws Exception {
        log.info("Initialising TestEnvSetup class for tests...");
        this.baseEnvSetup = baseEnvSetup;
    }

    public void getInternalServiceURLs() throws Exception {
        if (!baseEnvSetup.isLocal()) {
            log.info("Running getInternalServiceURLs");
            personalloansUrl = baseEnvSetup.getDynmamoDBUtil().getServiceURL("personalloans",getPersonalloansApiVersion());
            oauthUrl = baseEnvSetup.getDynmamoDBUtil().getServiceURL("oauth",getOauthApiVersion());
            customerUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("customer",getCustomerApiVersion());
            offersUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("offers",getOffersApiVersion());
            registrationUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("registration",getRegistrationApiVersion());
            prequalUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("prequal",getPrequalApiVersion());
            clickstreamUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("clickstream",getClickstreamApiVersion());
            reportUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("report",getReportApiVersion());
            loginUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("login",getLoginApiVersion());
            childMonitoringUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("childmonitoring",getChildMonitoringApiVersion());
            disputeUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("dispute",getDisputeApiVersion());
            itpUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("itp",getItpApiVersion());
            secureloginUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("securelogin",getSecureloginApiVersion());
            fulfillmentUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("fulfillment",getFulfillmentApiVersion());
            uiprofileUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("uiprofile",getUiprofileApiVersion());
            leadcaptureUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("leadcapture",getLeadcaptureApiVersion());
            disputeUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("dispute",getDisputeApiVersion());
            globaltermsUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("globalterms",getGlobaltermsApiVersion());
            profileUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("profile",getProfileApiVersion());
            financialactivityUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("financial-activity",getFinancialactivityApiVersion());
            alertsUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("alerts",getAlertsApiVersion());
            piiUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("pii",getPiiApiVersion());
            csidGatewayUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("csid-gateway",getCsidGatewayApiVersion());
            csidOrchestratorUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("csid-orchestrator",getCsidOrchestratorApiVersion());
            bureauLockUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("bureaulock",getBureauLockApiVersion());
            walletUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("wallet",getWalletApiVersion());
            salesForceUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("salesforce",getSalesForceApiVersion());
            memberpreferenceUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("memberpreference",getMemberpreferenceApiVersion());
            salesForceUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("salesforce",getSalesForceApiVersion());
            oauth2Url=baseEnvSetup.getDynmamoDBUtil().getServiceURL("oauth2",getOauth2ApiVersion());
            boeUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("boe",getBoeApiVersion());
            crmoDataUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("crmodata",getCrmoDataApiVersion());
            familyPlanUrl=baseEnvSetup.getDynmamoDBUtil().getServiceURL("familyplan",getFamilyPlanApiVersion());


        }

    }

    public void getDynamoDBTableNames() throws Exception {
        log.info("Running getDynamoDBTableNames");
        customerprofileTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("profile", getProfileApiVersion(), "dynamo_tables.2.physicalid.0", "");
        subscriptionTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("fulfillment", getFulfillmentApiVersion(), "dynamo_tables.1.physicalid.0", "");
        subscriptionHistoryTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("fulfillment", getFulfillmentApiVersion(), "dynamo_tables.4.physicalid.0", "");
        subscriptionBenefitTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("fulfillment", getFulfillmentApiVersion(), "dynamo_tables.5.physicalid.0", "");
        enrollmentBenefitTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("enrollment2", getEnrollment2ApiVersion(), "dynamo_tables.0.physicalid.0", "");
        enrollmentBenefitHistoryTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("enrollment2", getEnrollment2ApiVersion(), "dynamo_tables.2.physicalid.0", "");
        creditReportsTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("report", getReportApiVersion(), "dynamo_tables.0.physicalid.0", "");
        scoresTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("report",getReportApiVersion(),"dynamo_tables.1.physicalid.0","");
        bonusResourcesTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("report",getReportApiVersion(),"dynamo_tables.2.physicalid.0","");
        customerLoginTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("login", getLoginApiVersion(), "dynamo_tables.2.physicalid.0", "");
        subscriptionPaymentTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("vaultgateway",getVaultgatewayApiVersion(), "dynamo_tables.1.physicalid.0", "");
        vaultAccountTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("vaultgateway", getVaultgatewayApiVersion(), "dynamo_tables.0.physicalid.0", "");
        LoanOffersTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("personalloans", getPersonalloansApiVersion(), "dynamo_tables.1.physicalid.0", "");
        CustomerLoanProfileTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("personalloans", getPersonalloansApiVersion(), "dynamo_tables.0.physicalid.0", "");
        DarkwebMatchInfoRequestTable = baseEnvSetup.getDynmamoDBUtil().getConfigurationItems("csid-orchestrator", getCsidOrchestratorApiVersion(), "dynamo_tables.1.physicalid.0", "");

    }

}
