<#include "../../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#if document??>
 <div <#if hideMobile == true>class="d-none d-sm-block"</#if>>
    <section class="about-smc">
        <div class="cmseditlink">
               <@hst.manageContent hippobean=document/>
        </div>
        <div class="container about-smc__text">
            <#if document.title??><h2 class="about-smc__title heading-08">${document.title?html}</h2></#if>
            <div class="about-smc__body smc-text-italic text-04">
                <#if document.content??>
                    <@hst.html hippohtml=document.content/>
                </#if>
            </div>
            <#if document.cta1?? && document.cta1.linkCaption?length gt 0>
                <div class="smc-show-all">
                    <#assign link><@osudio.linkUrl link=document.cta1 /></#assign>
                    <a href="${link}" <@osudio.openInNewTab link/>>${document.cta1.linkCaption?html}</a>
                </div>
            </#if>
        </div>
        <div class="about-smc__image">
            <@hst.link var="img" hippobean=document.image.extralarge/>
            <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
        </div>
    </section>
 </div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Banner
  </div>
</#if>


