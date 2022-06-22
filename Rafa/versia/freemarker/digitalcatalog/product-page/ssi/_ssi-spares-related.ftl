<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#assign sparesComponentId = "spares_accessories_" + partNumber>
<#assign relatedProductComponentId = "related_product_" + partNumber>
<#assign showPagination = false>

<#include "../_spares-accessories-macro.ftl" />
<#include "../_selection-basket-favourites-bar-macro.ftl" />
<#include "_product-related-macro.ftl">
<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories"/>
<#if sparesAccessories?has_content || relatedProducts?has_content >

    <div class="col-lg-12">
        <#if sparesAccessories?has_content>
            <div class="pt-4"><h3
                        class="sub-title"><@fmt.message key="standardstockeditems.sparesaccesories" /></h3></div>

            <div class="col-lg-12">
                <@spareAccessoryList componentId=sparesComponentId sparesAccessories=sparesAccessories showPagination=showPagination />
            </div>
        </#if>
        <#if relatedProducts?has_content>
            <div class="clearfix"></div>
            <div class="col-lg-12 pt-4"><h3
                        class="sub-title"><@fmt.message key="standardstockeditems.relatedproducts" /></h3></div>
            <div class="col-lg-12">
                <@productRelatedList componentId=relatedProductComponentId relatedProducts=relatedProducts/>
            </div>
        </#if>
        <div class="col-lg-12 pt-5">
            <@selectionBasketFavouritesBar sparesAccessoriesComponentId=sparesComponentId relatedProducyComponentId=relatedProductComponentId
            statisticsSource="SPARE PARTS AND ACCESSORIES" />
        </div>
    </div>
</#if>