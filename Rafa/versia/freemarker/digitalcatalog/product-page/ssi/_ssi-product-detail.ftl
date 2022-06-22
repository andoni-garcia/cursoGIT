<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<@hst.setBundle basename="AddToCartBar"/>
<div class="detail-table">
    <#list productDetails?chunk(10) as productchunk>
        <#list productchunk as productDetail>
            <div class="detail-register">
                <div class="pl-2 pr-0 key-text">${productDetail.getKey()}</div>
                <div class="pl-1 key-text-value">${productDetail.getValue()}</div>
            </div>
        </#list>
    </#list>
    <div class="detail-register eclass-code" style="display: none">
        <div class="pl-2 pr-0 key-text"><@fmt.message key="addToCartBar.eclassCode"/></div>
        <div class="pl-1 key-text-value"></div>
    </div>
    <div class="detail-register eclass-version" style="display: none">
        <div class="pl-2 pr-0 key-text"><@fmt.message key="addToCartBar.eclassVersion"/></div>
        <div class="pl-1 key-text-value"></div>
    </div>
    <div class="detail-register unspsc-number" style="display: none">
        <div class="pl-2 pr-0 key-text"><@fmt.message key="addToCartBar.unspscNumber"/></div>
        <div class="pl-1 key-text-value"></div>
    </div>
    <div class="detail-register unspsc-version" style="display: none">
        <div class="pl-2 pr-0 key-text"><@fmt.message key="addToCartBar.unspscVersion"/></div>
        <div class="pl-1 key-text-value"></div>
    </div>
</div>
