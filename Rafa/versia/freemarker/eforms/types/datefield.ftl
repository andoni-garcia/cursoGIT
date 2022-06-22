<#ftl encoding="UTF-8">

<div class="form-row">
    <div class="eforms-field form-group col-md-4">

        <label>${field.label!?html}<span class="eforms-req">${field.requiredMarker!?html}</span></label>

        <div class="smc-date-pick">
            <div class="form-group__inputWrapper">
                <input id="datepicker" data-provide="datepicker" name="${field.formRelativeUniqueName}" class="form-control smc-date-pick__datepicker ${field.styleClass!}"
                       value="${field.value!}"  data-date-format="${field.dateFormat!?replace('MM','mm')}" ${field.mandatory?then('required', '')} />
            </div>
        </div>

        <div class="eforms-hint text-02">${field.hint!?html}</div>
    </div>
</div>