<#include "../../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>
<div <#if hideMobile == true>class="d-none d-sm-block"</#if>>
  <div class="parallax-banner  <#if !isLeftPosition>parallax-banner--textRight</#if>">
      <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
      </div>
      <div class="parallax-banner__img">
          <@hst.link var="img" hippobean=document.image.extralarge/>
          <#if document.bannerLink??>
              <#assign link><@osudio.linkUrl link=document.bannerLink /></#assign>
              <a href="${link}" <@osudio.openInNewTab link/>>
                  <div class="parallax-window" data-parallax="scroll" data-image-src="${img}"></div>
              </a>
          <#else>
              <div class="parallax-window" data-parallax="scroll" data-image-src="${img}"></div>
          </#if>
      </div>
      <#if document.title?length gt 0 || document.content.content?length gt 0>
        <div class="container">
          <div class="parallax-banner__text">
              <div class="parallax-banner__text__body heading-04 smc-text-italic heading-light">
                  <#if document.content??><@hst.html hippohtml=document.content/></#if>
              </div>
              <#if document.title??>
                  <div class="parallax-banner__text__footer">
                      ${document.title?html}
                  </div>
              </#if>
          </div>
        </div>
      </#if>
  </div>
</div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Banner
  </div>
</#if>





