<#include "../../include/imports.ftl">

<#assign c=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >

<#if socialMediaLinks?? && socialMediaLinks?has_content>
    <ul class="main-footer__socials">
        <#list socialMediaLinks as item>
            <li><a href="${item.url}" target="_blank"><img src="<@hst.link hippobean=item.icon />"></a></li>
        </#list>
    </ul>
</#if>
