<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<@hst.setBundle basename="AddToCartBar"/>
<div class="w-100 detail-table">
    <#list productDetails?chunk(10) as productchunk>
        <#list productchunk as techSpec>
            <div class="col-12 p-3 w-100 d-flex justify-content-between align-content-center attribute-list-row detail-register">
                <div class="attribute-name">${techSpec.getKey()}</div>
                <div class="attribute-value">${techSpec.getValue()}</div>
            </div>
        </#list>
    </#list>
    <div class="col-12 p-3 w-100 d-flex justify-content-between align-content-center attribute-list-row detail-register eclass-code hidden-important">
        <div class="attribute-name"><@fmt.message key="addToCartBar.eclassCode"/></div>
        <div class="attribute-value"></div>
    </div>
    <div class="col-12 p-3 w-100 d-flex justify-content-between align-content-center attribute-list-row detail-register  eclass-version hidden-important">
        <div class="attribute-name"><@fmt.message key="addToCartBar.eclassVersion"/></div>
        <div class="attribute-value"></div>
    </div>
    <div class="col-12 p-3 w-100 d-flex justify-content-between align-content-center attribute-list-row detail-register unspsc-number hidden-important">
        <div class="attribute-name"><@fmt.message key="addToCartBar.unspscNumber"/></div>
        <div class="attribute-value"></div>
    </div>
    <div class="col-12 p-3 w-100 d-flex justify-content-between align-content-center attribute-list-row detail-register unspsc-version hidden-important">
        <div class="attribute-name"><@fmt.message key="addToCartBar.unspscVersion"/></div>
        <div class="attribute-value"></div>
    </div>
</div>
