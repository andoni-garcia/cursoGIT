<#include "../../../include/imports.ftl">

<#if document??>
<div class="container" id="${document.getCanonicalHandleUUID()}">
    <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
    </div>
    <div class="cta-box-list">
        <#if document.primaryLink?? && document.primaryLink.linkCaption?length gt 0>
            <div class="cta-box">
                <#assign primaryLink><@osudio.linkUrl link=document.primaryLink /></#assign>
                <a href="${primaryLink}" class="btn btn-secondary btn-secondary--blue-border" <@osudio.openInNewTab primaryLink/>>${document.primaryLink.linkCaption?html}</a>
            </div>
        </#if>
        <#if document.secondaryLink?? && document.secondaryLink.linkCaption?length gt 0>
            <div class="cta-box">
                <#assign secondaryLink><@osudio.linkUrl link=document.secondaryLink /></#assign>
                <a href="${secondaryLink}" class="btn btn-primary mr-10" <@osudio.openInNewTab secondaryLink/>>${document.secondaryLink.linkCaption?html}</a>
            </div>
        </#if>

        <#include "../cta_logactions.ftl">

    </div>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Call To Action</h2>
</#if>
