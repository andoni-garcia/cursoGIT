<#ftl encoding="UTF-8">

<div class="eforms-field ${(field.label?has_content)?then('form-group','form-row')}">

    <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>

    <div class="form-group__inputWrapper ${(field.label?has_content)?then('','form-group col-xs-12')}">
        <textarea name="${field.formRelativeUniqueName}" class="${field.styleClass!} form-control"
              cols="${field.cols}" rows="${field.rows}"
                <#if (field.minLength > 0)>minlength="${field.minLength}"</#if> <#if (field.maxLength > 0)>maxlength="${field.maxLength?long?c}"</#if>
                placeholder="${field.hint!?html}" ${field.mandatory?then('required', '')} >${field.value!}</textarea>
    </div>

</div>