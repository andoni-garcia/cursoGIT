<#ftl encoding="UTF-8">

<#assign core=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<#assign fmt=JspTaglibs ["http://java.sun.com/jsp/jstl/fmt"] >
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >

<@hst.setBundle basename="forms"/>

<#macro renderField field>
    <#include "./types/${field.type}.ftl">
</#macro>
