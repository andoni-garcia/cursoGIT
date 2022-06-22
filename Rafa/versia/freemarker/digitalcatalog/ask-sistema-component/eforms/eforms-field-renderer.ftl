<#ftl encoding="UTF-8">

<#assign core=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<#assign fmt=JspTaglibs ["http://java.sun.com/jsp/jstl/fmt"] >
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >

<@hst.setBundle basename="forms"/>

<#macro renderField field>
    <#if field.type == 'textfield' || field.type == 'textarea'>
        <#--Override the renderer to put "*" char in the placeholder-->
        <#include "./types/${field.type}.ftl">
    <#else>
        <#--Use the default field renderer-->
        <#include "../../../eforms/types/${field.type}.ftl">
    </#if>
</#macro>
