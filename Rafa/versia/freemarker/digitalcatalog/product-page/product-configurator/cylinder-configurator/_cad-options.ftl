<@hst.setBundle basename="CylinderConfigurator"/>
<div class="cad__format cad__format--2d">
    <div class="cad__format__header">
        <span>${title2DFormats}</span>
    </div>
    <ul class="list-unstyled cad__format__list">
        <#list cadOptions.getType2d() as format>
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
        <span>${title3DFormats}</span>
    </div>
    <ul class="list-unstyled cad__format__list">
        <#list cadOptions.getType3d() as format>
            <li class="cad__format__item">
                <label for="${format.getKey()}" class="smc-checkbox smc-radio">
                    <input id="${format.getKey()}" name = "sscw_cad_option" type="radio" class="smc-radio-input" value="${format.getKey()}"  data-label="${format.getValue()}">
                    <span class="smc-checkbox__label pl-5">${format.getValue()}</span>
                </label>
            </li>
        </#list>
    </ul>
</div>