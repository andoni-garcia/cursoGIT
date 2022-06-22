<#ftl encoding="UTF-8">

<div class="eforms-field smc-checkbox-list smc-checkboxes${field.mandatory?then('-required', '')}">

    <#if field.fields?size != 1>
        <div class="text-02">${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></div>
    </#if>

    <#list field.fields as checkbox>
        <label class="smc-checkbox">
            <input type="checkbox" name="${checkbox.formRelativeUniqueName}" class="${checkbox.styleClass!}" value="${checkbox.value!?html}"
                 <#if checkbox.checked>checked="true"</#if> ${field.mandatory?then('required', '')} />
            <span class="smc-checkbox__label">
                    ${checkbox.label}
            </span>
        </label>
    </#list>

    <#if field.allowOther>
        <label class="smc-checkbox">
            <input type="checkbox" name="${field.formRelativeUniqueName}" class="${field.styleClass!}" value="${field.renderOtherValue!}"
                <#if field.otherValue>checked="true"</#if> />
            <span class="smc-checkbox__label"><@fmt.message key="forms.label.other" />:</span>
        </label>
        <span>
          <input type="text" value="<#if field.otherValue>${field.value!}</#if>" name="${field.otherFieldName!}" class="textfield-other"
                 <#if (field.length > 0)>size="${field.length}"</#if> <#if (field.maxLength > 0)>maxlength="${field.maxLength?long?c}"</#if> />
        </span>
    </#if>
    <div class="eforms-hint text-02">${field.hint!?html}</div>
</div>