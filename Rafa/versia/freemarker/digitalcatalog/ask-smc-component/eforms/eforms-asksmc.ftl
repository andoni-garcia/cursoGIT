<#ftl encoding="UTF-8">

<#assign core=JspTaglibs ["http://java.sun.com/jsp/jstl/core"] >
<#assign fmt=JspTaglibs ["http://java.sun.com/jsp/jstl/fmt"] >
<#assign hst=JspTaglibs["http://www.hippoecm.org/jsp/hst/core"] >
<#import "./eforms-field-renderer.ftl" as fieldRenderer>

<@hst.defineObjects />

<div class="container-fluid">
  <#if form.title?has_content>
      <h1 class="heading-02">${form.title}</h1>
  </#if>

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





<#--
    //########################################################################
    //  Piece of javascript from Hippo default validations for conditional fields
    //########################################################################
-->
<script type="text/javascript">
$(document).ready(function() {

<#-- Write JSON of field condition infos -->
    var conditions = ${form.conditionsAsJsonString};
    var condFieldNames = {};

    if (conditions) {
        var items = [];
        if (conditions['fields']) {
        items = items.concat(conditions['fields']);
        }
        if (conditions['pages']) {
            items = items.concat(conditions['pages']);
        }
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var condFieldName = item['condname'];
            if (!condFieldNames[condFieldName]) {
            condFieldNames[condFieldName] = true;
            }
        }
    }

    for (var condFieldName in condFieldNames) {
        var condField = $('.eforms-field *[name="' + condFieldName + '"]');
        if (condField.length == 0) continue;
        var eventType = 'change';

        condField.bind(eventType, function() {
            if (conditions && conditions['fields']) {
                var fields = conditions['fields'];

                for (var i = 0; i < fields.length; i++) {
                    var field = fields[i];
                    var condFieldName = field['condname'];
                    if ($(this).attr('name') != condFieldName) continue;

                    var name = field['name'];
                    var targetField = $('.eforms-field *[name="' + name + '"]');
                    if (targetField.length == 0) {
                        targetField = $('.eforms-fieldgroup[name="' + name + '"]');
                    }
                    if (targetField.length == 0) {
                        targetField = $('.eforms-text[name="' + name + '"]');
                    }
                    if (targetField.length == 0) continue;

                    var targetContainer = targetField.parents('.eforms-field');
                    if (targetContainer.length == 0) {
                        targetContainer = targetField;
                    }

                    var type = field['condtype'];
                    var condFieldValue = field['condvalue'];
                    var condNegated = field['condnegated'];
                    var curSelectedValue = $(this).val();
                    if ($(this).is('input') && $(this).attr('type') == 'radio') {
                        curSelectedValue = $('.eforms-field *[name="' + condFieldName + '"]:radio:checked').val();
                    }

                    if (type == 'visibility') {
                        if ((!condNegated && condFieldValue == curSelectedValue)||(condNegated && condFieldValue != curSelectedValue)) {
                            targetContainer.show();
                        } else {
                            targetContainer.hide();
                        }
                    }
                }

                var pages = conditions['pages'];
                for (var i = 0; i < pages.length; i++) {
                    var page = pages[i];
                    var condFieldName = page['condname'];
                    if ($(this).attr('name') != condFieldName) continue;

                    var pageIndex = page['index'];
                    var targetPage = $('#page' + pageIndex);
                    var type = page['condtype'];
                    var condFieldValue = page['condvalue'];
                    var condNegated = page['condnegated'];
                    var curSelectedValue = $(this).val();
                    if ($(this).is('input') && $(this).attr('type') == 'radio') {
                        curSelectedValue = $('.eforms-field *[name="' + condFieldName + '"]:radio:checked').val();
                    }

                    if (type == 'visibility') {
                        if ((!condNegated && condFieldValue == curSelectedValue)||(condNegated && condFieldValue != curSelectedValue)) {
                        targetPage.addClass('conditionally-visible');
                        $('#pagesTab li:nth-child(' + (pageIndex + 1) + ')').addClass('conditionally-visible');
                        } else {
                        targetPage.removeClass('conditionally-visible');
                        $('#pagesTab li:nth-child(' + (pageIndex + 1) + ')').removeClass('conditionally-visible');
                        }
                        resetPagesVisible();
                    }
                }
            }
        });

        condField.trigger(eventType);
    }

    });
    </script>
