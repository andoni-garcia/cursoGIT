<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] /><#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../digitalcatalog/_spinner.ftl">
</@hst.headContribution>

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
<@security.authorize access="hasRole('ROLE_sapariba_user')" var="isSaparibaUser"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>

<@hst.headContribution category="htmlHead">
    <script	type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/url-polyfill.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
<script	type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/history-polyfill.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/component-manager.component.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap-components/bootstrap-notify.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/notify.component.js"/>"></script>
</@hst.headContribution>

<#-- Common variables -->
<#assign DYNAMICS_ERP = 'MSDYNAMICS'>

<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../digitalcatalog/_spinner.ftl">
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
<script>
    var smc = window.smc || {};
    smc.locale = '${.locale}';
    smc.host = '${host}';
    smc.channelPrefix = '${channelPrefix}';
    smc.language = smc.lang = '${lang}';
    smc.country = '${country}';
    smc.messages = {
        generalError: "<@fmt.message key="global.generalError" />"
    };
    <@security.authorize access="isAuthenticated()">
        smc.user = {
            name: '<@security.authentication property="principal.name" />',
            role: '<@security.authentication property="authorities[0]" />',
            email: '<@security.authentication property="principal.email" />',
            firstName: '<@security.authentication property="principal.firstName" />',
            lastName: '<@security.authentication property="principal.lastName" />'
        };
    </@security.authorize>
    var DYNAMICS_ERP = '${DYNAMICS_ERP}';
</script>
</@hst.headContribution>