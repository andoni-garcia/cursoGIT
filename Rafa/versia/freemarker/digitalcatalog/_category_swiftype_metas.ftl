<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >
<#include "../include/imports.ftl">
<#include "catalog-macros.ftl">

<#assign pageTitleFinal = "${pagetitle}" />
<@hst.headContribution category="pageTitle">
    <#if node.getSeoMetaTitle()?has_content >
        <#assign pageTitleFinal = "${node.getSeoMetaTitle()}" />
    </#if>
    <#if node.getSerie()?has_content >
        <#assign titleBaseText><@fmt.message key="title.template" /></#assign>
        <title>${titleBaseText?replace("{product_name}", pageTitleFinal)}</title>
    <#else>
        <title>${pageTitleFinal} <#if channelinfo.properties.titleSuffix?length gt 0>| ${channelinfo.properties.titleSuffix}</#if></title>
    </#if>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <meta name="language" content="${lang}"/>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <#if node.getSerie()?has_content >
        <#assign descriptionBaseText><@fmt.message key="category.seo.description.template" /></#assign>
        <meta name="description" content="${descriptionBaseText?replace("{productName}", pageTitleFinal)}"/>
    <#elseif node.getSeoMetaDescription()?has_content>
        <meta name="description" content="${node.getSeoMetaDescription()}"/>
    </#if>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <meta name="title" content="${pageTitleFinal}"/>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <meta name="country" content="${country}"/>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <meta name="product_series" content="${node.getSerie()}"/>
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <meta name="product_keywords" content="${node.getKeywords()}"/>
</@hst.headContribution>

