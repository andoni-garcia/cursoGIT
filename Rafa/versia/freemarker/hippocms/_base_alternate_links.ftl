<#list siblingPages?keys as locale>
    <#assign localeReplaced = locale />
    <@hst.link var="linkHippo" link=siblingPages[locale]/>
    <#assign linkUrl = linkHippo />
    <#if linkHippo?starts_with("http") == false>
        <#assign linkUrl = "https://www.smc.eu" + linkHippo?replace("/site","") />
    </#if>
    <link rel="alternate" hreflang="${localeReplaced?replace("_","-")}" href="${linkUrl}"/>
</#list>
<#if linkHippo?contains("30124") == true>
    <#include "_base_canonical_link.ftl" />
</#if>