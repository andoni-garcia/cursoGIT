<#compress>

    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />

    <@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
    <@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
    <@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
    <@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
    <@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
    <@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
    <@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>

</#compress>

<#if !isAuthenticated>
    <script type="text/javascript">
        $(document).ready(function () {
            secureUrl();
        });
    </script>
</#if>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        function secureUrl() {
            var baseUrl = window.location;
            var channelPrefix = smc.channelPrefix;
            var securedPart = '/secured-resource';
            var site = '/site';
            var localhost = 'localhost';
            var url;
            if (localhost === smc.host){
                url = new URL(baseUrl.origin + site + channelPrefix + securedPart);
            } else {
                url = new URL(baseUrl.origin + securedPart);
            }
            url.searchParams.set('resource', baseUrl.toString().replace(baseUrl.origin, ''));
            window.location = url;
            deferred.reject();
        }
    </script>
</@hst.headContribution>