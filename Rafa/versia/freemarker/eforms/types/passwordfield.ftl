<#ftl encoding="UTF-8">

<div class="eforms-field">
    <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>
    <input type="password" name="${field.formRelativeUniqueName}" class="${field.styleClass!} ${field.extraCssClass!}"
             <#if (field.length > 0)>size="${field.length}"</#if> <#if (field.maxLength > 0)>maxlength="${field.maxLength?long?c}"</#if> />
    <div class="eforms-hint text-02">${field.hint!?html}</div>
</div>