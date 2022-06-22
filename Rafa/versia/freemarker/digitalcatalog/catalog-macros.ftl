
<#-- Render a single HTML image tag of the specified type -->
<#macro renderImage images type>
    <#list images as image>
        <#if image.getType() == type>
            <img src="${image.getUrl()}" alt="${image.getTitle()}" />
            <#break>
        </#if>
    </#list>
</#macro>

<#macro setImageUrl images type>
    <#list images as image>
        <#if image.getType() == type>
            <#assign imageUrl=image.getUrl()>
            <#break>
        </#if>
    </#list>
</#macro>