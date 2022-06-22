<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>
<div class="container">
    <div <#if hideMobile == true>class="d-none d-sm-block"</#if>>
      <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
      </div>
          <#if document.title?? && document.title?has_content>
              <h2 class="heading-04">
                  ${document.title?html}
              </h2>
          </#if>
          <div class="image-with-caption mb-40">
              <@hst.link var="img" hippobean=document.image.inline/>
              <div class="js--LazyImageContainer image-shown">
                  <#if document.bannerLink??>
                      <#assign link><@osudio.linkUrl link=document.bannerLink /></#assign>
                      <a href="${link}" <@osudio.openInNewTab link/>>
                        <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
                      </a>
                  <#else>
                      <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
                  </#if>
              </div>
              <div class="media-caption text-01">
                  <#if document.content??><@hst.html hippohtml=document.content/></#if>
              </div>
          </div>
    </div>
</div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Banner
  </div>
</#if>







