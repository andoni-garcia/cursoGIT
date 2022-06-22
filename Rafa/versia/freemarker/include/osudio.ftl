<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >

<#-- @ftlvariable name="link" type="com.smc.hippocms.beans.GenericLink" -->

<#-- Renders the URL of a Generic Link (external link is leading)-->
<#macro linkUrl link>
    <#compress>
        <#if link.externalLink?has_content >
            <#if link.externalLink?starts_with("http") || link.externalLink?starts_with("#")>
                ${link.externalLink}
            <#else>
                ${channelPrefix}${link.externalLink}
            </#if>

        <#elseif link.internalLink??>
            <@hst.link hippobean=link.internalLink/>
        </#if>
    </#compress>
</#macro>

<#macro linkCaption additionalContent>
    <#compress>
        <#if additionalContent.linkCaption?? && additionalContent.linkCaption?has_content >
            ${additionalContent.linkCaption}
        <#else>
            <#if additionalContent.externalLink?has_content >
                ${additionalContent.externalLink}
            <#elseif additionalContent.internalLink??>
                ${additionalContent.internalLink}
            </#if>
        </#if>
    </#compress>
</#macro>

<#-- Render the URL of the menu item (internal link is leading) -->
<#macro linkHstMenu link>
    <#compress>
        <#if link.hstLink??>
            <@hst.link link=link.hstLink/>
        <#elseif link.externalLink?has_content>
            <#if link.externalLink?starts_with("http") || link.externalLink?starts_with("#") || link.externalLink?starts_with("mailto:")>
                ${link.externalLink}
            <#else>
                ${channelPrefix}${link.externalLink}
            </#if>
        </#if>
    </#compress>
</#macro>

<!-- Open in a new tab if the URL is not in the same domain as the current host or if it's a PDF -->
<#macro openInNewTab url>
    <#compress>
        <#if (url?has_content && !url?contains(hstRequest.serverName) && url?starts_with("http")) || url?ends_with(".pdf")>
            target="_blank"
        </#if>
    </#compress>
</#macro>



<#macro altTag document><#if document.alt?? && document.alt?length gt 0>${document.alt}><#else>${document.title}</#if></#macro>
<#macro linkHstFooterMenu link>
    <#if link.hstLink??>
        <a href="<@hst.link link=link.hstLink/>">${link.name?html}</a>
    <#elseif link.externalLink?has_content>
        <#if link.externalLink?starts_with("http") || link.externalLink?starts_with("#")>
            <a href="${link.externalLink}" <@openInNewTab "${link.externalLink}"/>>${link.name?html}</a>
        <#else>
            <a href="${channelPrefix}${link.externalLink}" <@openInNewTab "${channelPrefix}${link.externalLink}"/>>${link.name?html}</a>
        </#if>
    <#else>
        ${link.name?html}
    </#if>
</#macro>

<#-- Renders a component by AJAX if "ajax" is true -->
<#macro renderComponent ajax>
    <@hst.componentRenderingURL var="renderUrl" />

    <#if ajax >
        <div class="cms-component component-render-placeholder" data-url="${renderUrl}&ajax=true" >
            <div class="spinner">
                <div class="bounce1"></div>
                <div class="bounce2"></div>
                <div class="bounce3"></div>
            </div>
        </div>
    <#else>
        <#nested>
    </#if>

    <@hst.headContribution category="htmlBodyEnd">
	    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/cms/ajax-load.js"/>"></script>
    </@hst.headContribution>
    <@hst.headContribution category="htmlHead">
	    <link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
    </@hst.headContribution>

</#macro>

<#macro dynamicBreadcrumb identifier breadcrumb>
    <#assign isWebContentBreadcrumb = identifier == "regular-bc">

    <#if breadcrumb?? && breadcrumb.items??>
        <ol class="breadcrumbs ${identifier}" data-swiftype-index='false'>
            <#list breadcrumb.items as item>
                <#if item.link?? && item?has_next>
                    <@hst.link var="link" link=item.link/>
                    <li class="${(item?index > 0)?then('hidden', '')}"><a href="${link}">${item.title?html}</a></li>
                    <#if item?index == 1>
                        <li><a class="open-breadcrumbs-link open-breadcrumbs-link-js" href="javascript:void(0);">...</a></li>
                    </#if>
                <#else>
                    <li>${item.title?html}</li>
                </#if>
            </#list>
        </ol>
    </#if>

    <#if breadcrumb?? && breadcrumb.items??>
        <div class="swiftype-category hidden">
            <#if (breadcrumb.items?size > 2)>
                <#list breadcrumb.items as item>
                    <#if item?index == 2 && item.title?html != "_any_~nav"  && item.title?html != "_any_~cfg" >
                        <span data-swiftype-name='swiftype_page_submenu' data-swiftype-type='string'>${item.title?html}</span>
                    </#if>
                </#list>
            <#else>
                <span data-swiftype-name='swiftype_page_submenu' data-swiftype-type='string'></span>
            </#if>
        </div>
    </#if>
</#macro>

<#-- Macro to handle the behavior on the resources:
 - If the resource is a PDF, open it always in a new window
 - If the resource is a file from the resource bundle, download in the same window
 - For all other resources / links, follow the usual open in a new tab behavior -->
<#macro handleFileOpening downloadableFileExtensions link title>
    <#assign isKnownFile = false />
    <#compress>
        <#if link?? && link?ends_with(".pdf")>
            target="_blank"
            <#assign isKnownFile = true />
        <#else>
            <#list downloadableFileExtensions as extension>
                <#if link?? && link?ends_with("." + extension)>
                    download="${title}"
                    <#assign isKnownFile = true />
                    <#break>
                </#if>
            </#list>
        </#if>

        <#if !isKnownFile>
            <@openInNewTab link/>
        </#if>
    </#compress>
</#macro>