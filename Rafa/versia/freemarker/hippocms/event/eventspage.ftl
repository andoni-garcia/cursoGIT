<#include "../../include/imports.ftl">

<#import "./event-renderer.ftl" as eventRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Event" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<@hst.setBundle basename="component.newslist"/>
<#if pageable?? && pageable.items?has_content>
    <div class="container">
            <div class="events-section">
                <div class="row">
                    <#list pageable.items as item>
                        <@eventRenderer.renderItem item=item size=4/>
                    </#list>
                </div>
            </div>
    </div>
<#elseif editMode>
    <div>Click to edit Events collection</div>
<#else>
    <div class="container">
        <div class="row">
            <h2><@fmt.message key="empty.events.message" /></h2>
        </div>
    </div>
</#if>

