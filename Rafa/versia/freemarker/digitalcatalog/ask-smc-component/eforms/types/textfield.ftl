<#ftl encoding="UTF-8">

<div class="eforms-field form-group">

    <#if field.label?has_content>
        <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>
    </#if>
    <#assign fieldValue>${(field.value?? && field.value?has_content)?then(field.value,field.initialValue!)}</#assign>
    <div class="form-group__inputWrapper ${(field.label?has_content)?then('','form-group col-xs-12')}">
        <input type="${(field.validationRuleId?? && field.validationRuleId=='email')?then('email','text')}" name="${field.formRelativeUniqueName}" class="${field.styleClass!} ${field.extraCssClass!} form-control" value="${fieldValue}"
             <#if (field.length > 0)>size="${field.length}"</#if> <#if (field.maxLength > 0)>maxlength="${field.maxLength?long?c}"</#if> <#if (field.minLength > 0)>minlength="${field.minLength}"</#if>
               placeholder="${field.hint!?html} ${field.requiredMarker!?html}"  ${field.mandatory?then('required', '')} />

        <div class="invalid-feedback">
            <#if field.validationRuleId??>
                <@fmt.message key="field.notvalid.${field.validationRuleId}"/>
            <#else>
                <@fmt.message key="field.notvalid"/>
            </#if>
        </div>
    </div>

</div>