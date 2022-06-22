<#compress>

<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>

<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>

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
          var url;
          if (window.location.hostname == "localhost"){
            url = new URL(baseUrl.origin + "/site" + channelPrefix + securedPart);
          } else {
             url = new URL(baseUrl.origin + channelPrefix + securedPart);
          }
          url.searchParams.set('resource', baseUrl.toString().replace(baseUrl.origin, ''));
          window.location = url;
          deferred.reject();
        }
    </script>
</@hst.headContribution>