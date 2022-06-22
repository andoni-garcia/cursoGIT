<#ftl encoding="UTF-8">

<div class="form-row row">
    <div class="form-group">
        <input type="hidden" name="${field.formRelativeUniqueName}"/>
        <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>
        <table class="survey-table form-control">
            <thead>
                <tr><th></th>
              <#list field.options as option>
                <th>
                    ${option!?html}
                </th>
              </#list>
                </tr>
            </thead>
            <tbody>
                <#list field.optionsKeyValuePairs as pair>
                    <tr>
                        <td><label for='${pair.key.label!?html}'>${pair.key.label!?html}</label></td>
                    <#list pair.value as radio>
                      <td>
                          <label class="smc-radio">
                            <input type="radio" name="${radio.formRelativeUniqueName}" value="${radio.value!}"
                               <#if radio.checked>checked="true"</#if> class="${field.styleClass!}" ${field.mandatory?then('required', '')}/>
                             <span class="smc-radio__label"></span>
                          </label>
                      </td>
                    </#list>
                    </tr>
                </#list>
            </tbody>
        </table>
    <div class="eforms-hint text-02">${field.hint!?html}</div>
    </div>
</div>