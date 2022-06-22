<#include "../include/imports.ftl">

<#-- @ftlvariable name="document" type="org.hippoecm.hst.content.beans.standard.HippoGalleryImageSetBean" -->
<@hst.manageContent hippobean=document/>
<#if document??>
  <div class="container">
    <@hst.link var="img" hippobean=document.original/>
    <img src="${img}" title="${document.fileName?html}" alt="${document.fileName?html}" class="img-fluid"/>
  </div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Image
  </div>
</#if>

