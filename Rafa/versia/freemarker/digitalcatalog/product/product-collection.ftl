<#include "../../include/imports.ftl">
<!--
product-colection.ftl
-->
<#import "product-renderer.ftl" as productRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Navigation" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<@osudio.renderComponent ajax=renderPlaceholder >
    <#if pageable?? && pageable.items?has_content>
        <div class="smc-main-container">
            <section class="container">
                <div class="row" data-event="dc-product-component-loaded">
                    <#assign sizePerRow = 12 / cparam.maxItemsRow?number>
                    <#list pageable.items as item>
                        <@productRenderer.renderItem item=item size=sizePerRow/>
                    </#list>
                </div>
            </section>
        </div>
    <#elseif editMode>
        <div>Click to edit Product Component</div>
    </#if>
</@osudio.renderComponent>


<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
</@hst.headContribution>