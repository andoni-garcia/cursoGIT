<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->

<#-- NOT BEING USED FOR NOW - USING CAROUSEL WITH 1 ELEMENT TO REPRESENT HERO BANNER-->

<#if document??>
 <div <#if hideMobile == true>class="d-none d-sm-block"</#if>>
     <div class="cmseditlink">
           <@hst.manageContent hippobean=document/>
     </div>
     <section class="big-banner">
         <@hst.link var="img" hippobean=document.image/>
         <img src="${img}" title="${document.title}" alt="<@osudio.altTag document=document />"/>
         <div class="big-banner__text">
             <div class="container">
                <h1 class="heading-01"><#if document.title??>${document.title?html}</#if></h1>
                <#if primaryLink1??>
                    <#assign primaryLink1Target = ''>
                    <#if primaryLink1.openNewWindow == true>
                        <#assign primaryLink1Target = "target='_blank'">
                    </#if>
                    <div class="inline-buttons">
                        <a href="${primaryLink1.url?html}" class="btn btn-primary mr-10" ${primaryLink1Target}>${primaryLink1.caption?html}</a>
                    <#if primaryLink2??>
                        <#assign primaryLink2Target = ''>
                         <#if primaryLink2.openNewWindow == true>
                            <#assign primaryLink2Target = "target='_blank'">
                         </#if>
                         <a href="${primaryLink2.url?html}" class="btn btn-secondary d-none d-lg-block" ${primaryLink2Target}>${primaryLink2.caption?html}</a>
                     </#if>
                    </div>
                </#if>
             </div>
         </div>
     </section>
 </div>

<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Image
  </div>
</#if>
