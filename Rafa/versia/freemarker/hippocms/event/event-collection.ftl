<#include "../../include/imports.ftl">

<#import "./event-renderer.ftl" as eventRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Event" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<#if pageable?? && pageable.items?has_content>
<div class="container">
    <div class="events-section">
        <div class="row">
            <#assign sizePerRow = 12 / cparam.maxItemsRow?number>
            <#list pageable.items as item>
                <@eventRenderer.renderItem item=item size=sizePerRow/>
            </#list>
        </div>
    </div>
</div>
<#elseif editMode>
  <div>Click to edit Events collection</div>
</#if>