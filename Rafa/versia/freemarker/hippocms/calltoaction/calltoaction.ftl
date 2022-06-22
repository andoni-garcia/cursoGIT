<#include "../../include/imports.ftl">

<#if document??>
<div class="container" id="${document.getCanonicalHandleUUID()}">
    <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
    </div>
    <div class="info-box info-box--blue">
           <#if document.title??>
            <div class="info-box__head">
                <h2 class="heading-07">${document.title?html}</h2>
            </div>
        </#if>
        <div class="info-box__body text-01">
            <#if document.description??>
                <p>${document.description}</p>
            </#if>
            <div class="cta-box-list">
                <#if document.primaryLink?? && document.primaryLink.linkCaption?length gt 0>
                    <div class="cta-box">
                        <#assign primaryLink><@osudio.linkUrl link=document.primaryLink /></#assign>
                        <a href="${primaryLink}" target="_blank" class="btn btn-secondary mr-10" target="_blank"  <@osudio.openInNewTab primaryLink/>>${document.primaryLink.linkCaption?html}</a>
                    </div>
                </#if>
                <#if document.secondaryLink?? && document.secondaryLink.linkCaption?length gt 0>
                    <div class="cta-box">
                        <#assign secondaryLink><@osudio.linkUrl link=document.secondaryLink /></#assign>
                        <a href="${secondaryLink}" target="_blank" class="btn btn-tertiary" target="_blank" <@osudio.openInNewTab secondaryLink/>>${document.secondaryLink.linkCaption?html}</a>
                    </div>
                </#if>

                <#include "cta_logactions.ftl">

            </div>
        </div>
    </div>
</div>
<#elseif editMode??>
    <h2 class="not-configured">Click to configure Call To Action</h2>
</#if>
