<#include "../../../include/imports.ftl">

<#macro renderUrl name="" page="" pageSize="">
    <@hst.renderURL var="${name}">
        <#if page?has_content>
            <@hst.param name="page" value="${page}"/>
        </#if>
        <#if pageSize?has_content>
            <@hst.param name="pageSize" value="${pageSize}"/>
        </#if>
    </@hst.renderURL>
</#macro>
