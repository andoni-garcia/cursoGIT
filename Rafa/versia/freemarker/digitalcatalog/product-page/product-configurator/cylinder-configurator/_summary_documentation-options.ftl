<@hst.setBundle basename="CylinderConfigurator"/>

<#list documentationOptions as documentationOption>
    <#if documentationOption.getCadFormats()?has_content && documentationOption.getCadFormats()?size != 0>

    <#else>
        <#if documentationOption?index == 0>
            <div class="d-md-flex justify-content-between align-items-center">
                <div class="sscw__summary_confirmation__content__title  sscw_summary_${documentationOption.getKey()}_container">
                    <span class="sscw_summary_${documentationOption.getKey()}_container"><@fmt.message key="cylinderConfigurator.${documentationOption.getKey()}"/></span>
                </div>
<#--                <div class="mb-3 mb-md-0 sscw__summary_confirmation__content__actions hidden" id ="sscw__summary_confirmation__content__actions" >-->
<#--                    <div class="sscw__loading_spinner"></div>-->
<#--                    <button type="button" id="btn-submit-download-sscw-zip" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.downloadZip"/></button>-->
<#--                    <div class="loading-container loading-container-js"></div>-->
<#--                </div>-->
            </div>
        <#elseif documentationOption.getItems()?has_content && documentationOption.getItems()?size != 0>
            <div class="sscw__summary_confirmation__content__title hidden sscw_summary_${documentationOption.getKey()}_container sscw__summary_confirmation__content__parent">
                <@fmt.message key="cylinderConfigurator.${documentationOption.getKey()}"/>
            </div>
            <ul class="pl-4 list-unstyled  sscw__summary_confirmation__content__${documentationOption.getKey()}_child_list">
                <#list documentationOption.getItems() as item>
                    <li id="configuration_summary_${item.getKey()}_summary" class="hidden sscw_summary_${item.getKey()}_container" ><@fmt.message key="cylinderConfigurator.${item.getKey()}"/></li>
                </#list>
            </ul>
        <#else>
            <div class="sscw__summary_confirmation__content__title hidden sscw_summary_${documentationOption.getKey()}_container">
                <@fmt.message key="cylinderConfigurator.${documentationOption.getKey()}"/>
            </div>
        </#if>
    </#if>
</#list>
