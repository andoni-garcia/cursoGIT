<#ftl encoding="UTF-8">

<div class="eforms-field form-group form-row">

    <div class="form-group smc-select col-md-12">

        <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>
        <p><select name="${field.formRelativeUniqueName}" class="${field.styleClass!} ${field.extraCssClass!}" ${field.mandatory?then('required', '')} >
            <#list field.options as option>
                <option value="${option.value!?html}" <#if option.selected>selected="selected"</#if>>${option.text!?html}</option>
            </#list>
        </select></p>
        <div class="smc-dummy-placeholder">${field.hint!?html}</div>
    </div>

</div>
