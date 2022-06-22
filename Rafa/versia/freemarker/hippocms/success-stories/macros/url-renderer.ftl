<#include "../../../include/imports.ftl">

<#macro renderUrl name="" page="" pageSize="" sortField="" sortOrder="" query="">
    <@hst.renderURL var="${name}">
        <#if page?has_content>
            <@hst.param name="page" value="${page}"/>
        </#if>
        <#if pageSize?has_content>
            <@hst.param name="pageSize" value="${pageSize}"/>
        </#if>
        <#if sortField?has_content>
            <@hst.param name="sortField" value="${sortField}"/>
        </#if>
        <#if sortOrder?has_content>
            <@hst.param name="sortOrder" value="${sortOrder}"/>
        </#if>
        <#if query?has_content>
            <@hst.param name="query" value="${query}"/>
        </#if>
    </@hst.renderURL>
</#macro>
