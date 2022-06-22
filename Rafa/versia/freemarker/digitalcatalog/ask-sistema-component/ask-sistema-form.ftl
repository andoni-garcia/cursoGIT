<#ftl encoding="UTF-8">

<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<#assign componentId = .now?long?c>

<div id="${componentId}" class="row asksistemaform">
    <@hst.include ref="form"/>
    <@hst.include ref="asksistemaform"/>
</div>
