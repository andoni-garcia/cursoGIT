<#include "../include/imports.ftl">

<#if isHomePage == true && channelinfo.properties.homeTitle?length gt 0>
    <title>${channelinfo.properties.homeTitle}</title>
<#elseif pagetitle??>
    <title>${pagetitle} <#if channelinfo.properties.titleSuffix?length gt 0>| ${channelinfo.properties.titleSuffix}</#if></title>
</#if>

<@hst.headContributions categoryIncludes="pageTitle" xhtml=true/>
