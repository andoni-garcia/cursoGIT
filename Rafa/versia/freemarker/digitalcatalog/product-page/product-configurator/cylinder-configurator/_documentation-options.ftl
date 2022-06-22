<@hst.setBundle basename="CylinderConfigurator"/>
<ul class="list-unstyled pl-4">
    <#list documentationOptions as documentationOption>
        <#if documentationOption.getCadFormats()?has_content && documentationOption.getCadFormats()?size != 0>
            <li>
                <label for="cad" class="smc-checkbox">
                    <input id="cad" type="checkbox" class="" value="true">
                    <span class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.cadFile"/></span>
                </label>
                <p class="pl-4 mt-3 cad__formats_label hidden"><@fmt.message key="cylinderConfigurator.selectCADFormat"/>:</p>
                <div class="cad__formats hidden" id = "cad__formats__container" >
                    <div class="cad__format cad__format--2d">
                        <div class="cad__format__header">
                            <span><@fmt.message key="cylinderConfigurator.2DFormats"/></span>
                        </div>
                        <ul class="list-unstyled cad__format__list">
                            <#list documentationOption.getCadFormats().getType2d() as format>
                                <li class="cad__format__item">
                                    <label for="${format.getKey()}_view" class="smc-checkbox smc-radio">
                                        <input id="${format.getKey()}_view"  name = "sscw_cad_option" type="radio" class="smc-radio-input" value="${format.getKey()}"  data-label="${format.getValue()}">
                                        <span class="smc-checkbox__label pl-5">${format.getValue()}</span>
                                    </label>
                                </li>
                            </#list>
                        </ul>
                    </div>
                    <div class="cad__format cad__format--3d">
                        <div class="cad__format__header">
                            <span><@fmt.message key="cylinderConfigurator.3DFormats"/></span>
                        </div>
                        <ul class="list-unstyled cad__format__list">
                            <#list documentationOption.getCadFormats().getType3d() as format>
                                <li class="cad__format__item">
                                    <label for="${format.getKey()}" class="smc-checkbox smc-radio">
                                        <input id="${format.getKey()}" name = "sscw_cad_option" type="radio" class="smc-radio-input" value="${format.getKey()}"  data-label="${format.getValue()}">
                                        <span class="smc-checkbox__label pl-5">${format.getValue()}</span>
                                    </label>
                                </li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </li>
        <#else>
            <li>
                <#if documentationOption.getItems()?has_content && documentationOption.getItems()?size != 0>
                    <label for="${documentationOption.getKey()}" class="smc-checkbox">
                        <input id="${documentationOption.getKey()}" type="checkbox" class="documentation-option-checkbox" value="true">
                        <span class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.${documentationOption.getKey()}"/></span>
                    </label>
                        <p class="mt-3 sscw_summary_fields_include_list_sub sscw_summary_${documentationOption.getKey()}_list_sub" ><@fmt.message key="cylinderConfigurator.selectsFieldsToInclude"/>:</p>
                        <ul class="list-unstyled pl-4 mb-3 sscw_summary_fields_include_list_sub sscw_summary_${documentationOption.getKey()}_list_sub" id="sscw_summary_fields_include_list_${documentationOption.getKey()}">
                            <#list documentationOption.getItems() as item>
                                <li>
                                    <label for="${item.getKey()}" class="smc-checkbox">
                                        <input id="${item.getKey()}" type="checkbox"  class="documentation-option-checkbox">
                                        <span class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.${item.getKey()}"/></span>
                                    </label>
                                </li>
                            </#list>
                        </ul>
                <#else>
                    <label for="${documentationOption.getKey()}" class="smc-checkbox">
                        <input id="${documentationOption.getKey()}" type="checkbox" class="documentation-option-checkbox documentation-option-checkbox-list" value="true">
                        <span class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.${documentationOption.getKey()}"/></span>
                    </label>
                </#if>
            </li>
        </#if>

    </#list>
</ul>