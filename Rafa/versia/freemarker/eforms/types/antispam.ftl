<#ftl encoding="UTF-8">

<#assign cssClass="eforms-field">
<#if field.extraCssClass?has_content>
    <#assign cssClass="eforms-field ${field.extraCssClass}">
</#if>

<#if field.honeyPot>

    <div class="${cssClass}" <#if !field.extraCssClass?has_content>style="display:none"</#if>>
        <label>${field.label?html}<span class="eforms-req">${field.requiredMarker?html}</span></label>
        <input type="text" name="${field.formRelativeUniqueName}" class="${field.styleClass} ${field.extraCssClass!}" value="${field.value!}"/>
    </div>

<#elseif field.slider>

    <div class="${cssClass}">
        <div id="slider"></div>
        <input type="hidden" id="sliderInput" name="${field.formRelativeUniqueName}" value=""/>
        <div id="notSlided" style="display:block">
            <p>Slide to be able to submit</p>
        </div>
        <div id="slided" style="display:none">
            <p>You may submit the form</p>
        </div>
    </div>

<#else>
    ${field.antiSpamType}
</#if>