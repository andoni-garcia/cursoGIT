<#ftl encoding="UTF-8">

<#-- @ftlvariable name="form" type="com.onehippo.cms7.eforms.hst.model.Form" -->

<#if formIntro?has_content>
    <p class="content-p">${formIntro}</p>
</#if>

<#assign style="display:none;">
<#if eforms_error?? && (eforms_error?size > 0)>
    <#assign style="">
</#if>

<div id="feedbackPanel" class="nojs-error" style="${style}">
  <ul>
  <#if eforms_errors?? && (eforms_errors?size > 0)>
    <#list eforms_errors?keys as key>
      <li data-key="${key}" data-formcontrol="${eforms_errors[key].name}" >${eforms_errors[key].localizedMessage}</li>
    </#list>
  </#if>
  </ul>
</div>

<#if maxFormSubmissionsReached?has_content>

    <#if maxFormSubmissionsReachedText?has_content>
        <p>${maxFormSubmissionsReachedText}</p>
    <#else>
        <p>The maximum number of submission for this form has been reached</p>
    </#if>

<#else>

    <form class="form smc-form" action="<@hst.actionURL escapeXml=false />&${_csrf.parameterName}=${_csrf.token}" method="post" name="${form.name!}"
          <#if form.multipart>enctype="multipart/form-data"</#if> accept-charset="UTF-8">

        <#assign formPages = form.pages>

        <#if formPages?? && (formPages?size > 1)>

            <ul id="pagesTab" class="eforms-pagetab" style="display: none">
              <#list formPages as page>
                <#if page_index == 0>
                  <li class="conditionally-visible selected">${page.label}</li>
                <#else>
                  <li class="conditionally-visible">${page.label}</li>
                </#if>
              </#list>
            </ul>

        </#if>

        <#if formPages?? && (formPages?size > 0)>

            <#list formPages as page>

                <div id="page${page_index}" class="eforms-page conditionally-visible">

                    <#list page.fields as fieldItem>

                      <#if fieldItem.type == "fieldgroup">
                          <#assign groupCssClassName = "eforms-fieldgroup">
                          <#if fieldItem.oneline>
                              <#assign groupCssClassName = "eforms-fieldgroup oneline">
                          </#if>

                        <div name="${fieldItem.fieldNamePrefix!}" class="${groupCssClassName!}">
                          <#if fieldItem.label?has_content>
                            <p class="eforms-fieldgroupname heading-03 color-blue">${fieldItem.label}</p>
                          </#if>
                          <#list fieldItem.fields as fieldItemInGroup>
                              <@fieldRenderer.renderField field=fieldItemInGroup />
                          </#list>
                          <#if fieldItem.hint??>
                              <span class="eforms-hint">${fieldItem.hint}</span>
                          </#if>
                        </div>

                      <#else>
                          <@fieldRenderer.renderField field=fieldItem />
                      </#if>

                    </#list>

                </div>

            </#list>
        </#if>

        <div class="smc-buttons-list footer pr-3">
            <#list form.buttons as button>
                <#if button.type == "nextbutton">
                    <button type="submit" id="nextPageButton" name="nextPageButton" class="${button.styleClass!} btn btn-primary" style="display: none">
                        <#if button.value?has_content>${button.value}<#else>${button.name}</#if>
                    </button>
                <#elseif button.type == "previousbutton">
                    <input id="previousPageButton" type="button" name="previousPageButton" class="${button.styleClass!}" style="display: none"
                       value="<#if button.value?has_content>${button.value}<#else>${button.name}</#if>" />
                <#elseif button.type == "resetbutton">
                    <input type="reset" name="${button.formRelativeUniqueName}" class="${button.styleClass!}"
                           value="<#if button.value?has_content>${button.value}<#else>${button.name}</#if>" />
                <#elseif button.type == "submitbutton">
                    <button type="submit" name="${button.formRelativeUniqueName}" class="btn btn-primary ${button.styleClass!}">
                      <#if button.value?has_content>${button.value}<#else>${button.name}</#if>
                    </button>
                <#else>
                    <input type="button" name="${button.formRelativeUniqueName}" class="${button.styleClass!}"
                       value="<#if button.value?has_content>${button.value}<#else>${button.name}</#if>" />
                </#if>
            </#list>
        </div>

<#--        <#if _csrf??>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </#if>-->

    </form>

</#if>