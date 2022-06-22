<#include "../../include/imports.ftl">

<#import "article-renderer.ftl" as articleRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Event" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<#if pageable?? && pageable.items?has_content>
<div class="container">
    <div class="our-services">
        <#list pageable.items as item>
            <@articleRenderer.renderItem item=item />
        </#list>
    </div>
</div>
<#elseif editMode>
  <div>Click to edit Articles collection</div>
</#if>