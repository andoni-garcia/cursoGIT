<#include "../../include/imports.ftl">

<#import "navigation-renderer.ftl" as navigationRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Navigation" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<#if pageable?? && pageable.items?has_content>
<section class="container category-tiles--related">
    <div class="row">
        <#assign sizePerRow = 12 / cparam.maxItemsRow?number>
        <#list pageable.items as item>
            <@navigationRenderer.renderItem item=item size=sizePerRow/>
        </#list>
    </div>
</section>
<#elseif editMode>
  <div>Click to edit Navigation Component</div>
</#if>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/category_tile.js"/>"></script>
</@hst.headContribution>