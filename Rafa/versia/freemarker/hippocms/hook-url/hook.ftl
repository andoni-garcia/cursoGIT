<#include "../../include/imports.ftl">

<@hst.actionURL var="actionUrl"/>

<div>
<span class="d-none">${actionUrl}</span>
</div>

<div style="margin-top: 3em;">
<ul>
<#list attributesList as attribute>
    <li>${attribute}</li>
</#list>
</ul>
</div>