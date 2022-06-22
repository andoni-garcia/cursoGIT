<#include "../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Video" -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsVideoComponentInfo"--%> -->
<#if document??>
<div class="container">
  <div <#if document.description??>class="video-with-caption"</#if>>
    <#if document.title??>
      <h2 class="heading-04">${document.title?html}</h2>
    </#if>
    <div class="video-component">
        <div class="video-component__content">
            <iframe src="https://www.youtube.com/embed/${document.videoID}" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
    <#if document.description??>
        <div class="video-with-caption__caption">${document.description?html}</div>
    </#if>
  </div>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/video.png" />"> Click to edit Video
  </div>
</#if>
