<#ftl encoding="UTF-8">

<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<@hst.setBundle basename="essentials.global,AskSMC"/>

<div class="row product ${product???then("", "empty-product")}">
    <#if product??>
        <div class="col-lg-4 col-md-4 col-sm-5 col-xs-12 image">
            <@renderImage images=product.getNode().getImages() type='MEDIUM' />
        </div>
        <div class="col-lg-8 col-md-8 col-sm-7 col-xs-12 description p-5">
            <div class="product-name">${product.getNode().getName()}</div>
            <#if partNumber?? && partNumber != "">
                <br/>
                <div class="part-number">
                    <span><@fmt.message key="asksmc.partnumber"/>: ${partNumber}</span>
                </div>
            </#if>
        </div>
    </#if>
</div>