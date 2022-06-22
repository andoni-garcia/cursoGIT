<#include "../include/imports.ftl">

<#assign lang=hstRequest.locale.language/>

<div class="main-header__logo" data-swiftype-index='false'>
    <a href="<@hst.link siteMapItemRefId='root'/>">
        <#if siteLogoSmall??>
            <img class="d-lg-none" src="<@hst.link hippobean=siteLogoSmall.original />" alt="SMC" />
        </#if>
        <#if siteLogoBig??>
            <img class="d-none d-lg-block" src="<@hst.link hippobean=siteLogoBig.original />" alt="SMC">
        </#if>
    </a>
</div>