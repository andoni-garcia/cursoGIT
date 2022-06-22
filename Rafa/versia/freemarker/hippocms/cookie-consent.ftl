<#include "../include/imports.ftl">
<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/cookieconsent.min.css"/>" type="text/css"/>
<script src="<@hst.webfile  path="/freemarker/versia/js-menu/cookieconsent.min.js"/>"></script>
<script src="<@hst.webfile  path="/freemarker/versia/js-menu/custom-cookie-consent.js"/>"></script>

<#--<#if channelinfo.properties.privacyPolicyUrl?has_content>-->
<#--    <script async="async" src="https://consent.trustarc.com/notice?domain=smcusa.com&js=nj&c=teconsent&gtm=1&noticeType=bb&behavior=expressed&pn=0&cookieLink=${disclaimerPrivacyPolicyUrl}&privacypolicylink=${privacyPolicyUrl}" crossorigin = "">-->
<#--    </script>-->
<#--    <div id="consent_blackbar" ></div>-->
<#--</#if>-->
<#if hstRequest.getServerName()?contains("smc.eu")>
    <!-- El aviso de consentimiento de cookies de OneTrust comienza para smc.eu. -->
    <script type="text/javascript" src="https://cdn.cookielaw.org/consent/0409365a-4043-476d-a618-70435d80781f/OtAutoBlock.js" ></script>
    <script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js"  type="text/javascript" charset="UTF-8" data-domain-script="0409365a-4043-476d-a618-70435d80781f" ></script>
    <script type="text/javascript">
        function OptanonWrapper() { }
    </script>
    <!-- El aviso de consentimiento de cookies de OneTrust finaliza para smc.eu. -->
<#elseif hstRequest.getServerName()?contains("prd-hippo.smcaws.eu")>
    <!-- El aviso de consentimiento de cookies de OneTrust comienza para prd-hippo.smcaws.eu. -->
    <script type="text/javascript" src="https://cdn.cookielaw.org/consent/fe4e99e6-18bb-4faa-a26f-b1da095b8bcd/OtAutoBlock.js" ></script>
    <script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js" data-document-language="true" type="text/javascript" charset="UTF-8" data-domain-script="fe4e99e6-18bb-4faa-a26f-b1da095b8bcd" ></script>
    <script type="text/javascript">
        function OptanonWrapper() { }
    </script>
    <!-- El aviso de consentimiento de cookies de OneTrust finaliza para prd-hippo.smcaws.eu. -->
<#elseif hstRequest.getServerName()?contains("acc-hippo.smcaws.eu")>
<#--    SCRIPT DE PRUEBAS -->
    <!-- El aviso de consentimiento de cookies de OneTrust comienza para smc.eu. Versión de TST -->
    <script type="text/javascript" src="https://cdn.cookielaw.org/consent/0409365a-4043-476d-a618-70435d80781f-test/OtAutoBlock.js" ></script>
    <script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js" data-document-language="true" type="text/javascript" charset="UTF-8" data-domain-script="0409365a-4043-476d-a618-70435d80781f-test" ></script>
    <script type="text/javascript">
        function OptanonWrapper() { }
    </script>
    <!-- El aviso de consentimiento de cookies de OneTrust finaliza para smc.eu. -->
</#if>