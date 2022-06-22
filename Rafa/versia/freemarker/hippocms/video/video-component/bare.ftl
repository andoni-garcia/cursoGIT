<#include "../../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Video" -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsVideoComponentInfo"--%> -->
<#if document??>
<div class="container">
    <div class="video-component">
        <div class="video-component__content">
            <iframe src="https://www.youtube.com/embed/${document.videoID}" frameborder="0" allowfullscreen></iframe>
        </div>
    </div>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/video.png" />"> Click to edit Video
  </div>
</#if>
