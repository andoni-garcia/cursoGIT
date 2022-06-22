<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../product/product-toolbar-macro.ftl">
<#include "_ssi-detail-macro.ftl">
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl">

<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/standard-stocked-items/ssi-product.component.js"/>"></script>
</@hst.headContribution>

<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage"/>
<div class="row">
    <div class="col-lg-12 p-2">
        <div id="${componentId}">
            <#assign index = 0>
            <#list ssiProducts.getContent() as ssiProduct>
                <@SsiDetailTemplate ssiProduct=ssiProduct product=product index = index/>
                <#assign index += 1>
            </#list>
        </div>
    </div>
</div>
<div class="hidden" data-swiftype-index='false'>
    <input type="hidden" id="numTotalElements" value="${ssiProducts.getNumTotalElements()}">
    <input type="hidden" id="currentPage" value="${ssiProducts.getCurrentPage()}">
    <input type="hidden" id="numElements" value="${ssiProducts.getNumElements()}">
    <input type="hidden" id="totalPages" value="${ssiProducts.getTotalPages()}">
</div>
