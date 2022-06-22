<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<#--SEO METADATA ELEMENTS-->
<#assign pageTitleFinal = "${pagetitle}" />

<@hst.headContribution category="swiftypeMeta">
    <#if product.getNode().getSeoMetaTitle()?has_content >
        <#assign pageTitleFinal = "${product.getNode().getSeoMetaTitle()}" />
    </#if>
    <meta name="title" content="${pageTitleFinal}" />
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
    <#if product.getNode().getSerie()?has_content >
        <#assign descriptionBaseText><@fmt.message key="category.seo.description.template" /></#assign>
        <meta name="description" content="${descriptionBaseText?replace("{productName}", pageTitleFinal)}" />
    <#elseif product.getNode().getSeoMetaDescription()?has_content >
        <meta name="description" content="${product.getNode().getSeoMetaDescription()}" />
    </#if>
</@hst.headContribution>
<#--END SEO METADATA ELEMENTS-->

<@hst.headContribution category="swiftypeMeta">
<meta name="language" content="${lang}" />
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
<meta name="country" content="${country}" />
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
<meta name="product_series" content="${product.getNode().getSerie()}" />
</@hst.headContribution>

<@hst.headContribution category="swiftypeMeta">
<meta name="product_keywords" content="${product.getNode().getKeywords()}" />
</@hst.headContribution>

<#if product.getNode().isIsPrimary() == false>
    <@hst.headContribution category="swiftypeMeta">
        <meta name="robots" content="noindex" />
    </@hst.headContribution>
</#if>

<div class="hidden">
    ${product.getNode().getDescription()?replace('<', '&lt;')?replace('>', '&gt;')}
</div>


