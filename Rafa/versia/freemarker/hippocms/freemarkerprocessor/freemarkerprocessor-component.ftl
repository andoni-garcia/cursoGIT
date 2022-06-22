<#include "../../include/imports.ftl">

<#-- @ftlvariable name="document" type="com.smc.hippocms.beans.Banner" -->
<#if resourceBundleID??>
    <@hst.setBundle basename=resourceBundleID/>
</#if>

<#if html??>
<div class="container">
    <#assign inlineTemplate = html?interpret>
    <@inlineTemplate />
</div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/image.png" />"> Click to edit Freemarker Processor
  </div>
</#if>







