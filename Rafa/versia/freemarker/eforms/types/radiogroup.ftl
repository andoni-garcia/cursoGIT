<#ftl encoding="UTF-8">

<@hst.setBundle basename="forms"/>

<div class="eforms-field smc-checkbox-list">

    <div class="text-02">${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></div>

    <#list field.fields as radio>
      <label class="smc-radio">
          <input type="radio" name="${field.formRelativeUniqueName}" class="${radio.styleClass!}" value="${radio.value!?html}"
               <#if radio.checked>checked="true"</#if>  ${field.mandatory?then('required', '')} />
          <span class="smc-radio__label">${radio.label!?html}</span>
      </label>
    </#list>
    <#if field.allowOther>
         <label class="smc-radio">
          <input type="radio" name="${field.formRelativeUniqueName}" class="${field.styleClass!}" value="${field.renderOtherValue!?html}"
          <#if field.otherValue>checked="true"</#if> />

          <span class="smc-radio__label"><@fmt.message key="forms.label.other" />:
          <input type="text" value="<#if field.otherValue>${field.value!}</#if>" name="${field.otherFieldName!}" class="textfield-other"
                 <#if (field.length > 0)>size="${field.length}"</#if> <#if (field.maxLength > 0)>maxlength="${field.maxLength?long?c}"</#if> />
            </span>
         </label>
    </#if>

    <div class="eforms-hint text-02">${field.hint!?html}</div>
</div>