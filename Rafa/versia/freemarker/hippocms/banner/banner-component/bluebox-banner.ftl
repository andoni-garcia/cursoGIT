<#include "../../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>
<div class="container">
    <div <#if hideMobile == true>class="d-none d-sm-block"</#if>>
        <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
        </div>
        <div class="text-image">
            <div class="text-image__image js--LazyImageContainer image-shown">
                <@hst.link var="img" hippobean=document.image.inline/>
                <#if document.bannerLink??>
                  <#assign link><@osudio.linkUrl link=document.bannerLink /></#assign>
                  <a href="${link}" <@osudio.openInNewTab link/>>
                      <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
                  </a>
                <#else>
                  <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
                </#if>
            </div>
            <div class="text-image__body heading-07 heading-light smc-text-italic">
                <#if document.content??><@hst.html hippohtml=document.content/></#if>
            </div>
            <#if document.title??>
                <div class="text-image__foot text-02 heading-light">
                    ${document.title?html}
                </div>
            </#if>
        </div>
    </div>
</div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Banner
  </div>
</#if>





