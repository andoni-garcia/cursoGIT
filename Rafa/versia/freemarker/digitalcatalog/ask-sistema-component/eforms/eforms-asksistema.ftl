<#ftl encoding="UTF-8">

<#assign core=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<#assign fmt=JspTaglibs ["http://java.sun.com/jsp/jstl/fmt"] >
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >
<#import "./eforms-field-renderer.ftl" as fieldRenderer>

<@hst.defineObjects />

<div class="container-fluid">
  <#if processDone!false && afterProcessSuccessText?has_content>
      <p class="content-p">${afterProcessSuccessText!}</p>
  <#else >
      <#include "./eforms-view.ftl">
  </#if>
</div>


<@hst.headContribution keyHint="formDatePicker">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/bootstrap-datepicker3.min.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/bootstrap-datepicker.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery-validate.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/forms/eforms.js"/>"></script>
</@hst.headContribution>
