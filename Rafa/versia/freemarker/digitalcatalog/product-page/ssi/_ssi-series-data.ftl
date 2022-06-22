<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../product/product-toolbar-macro.ftl">
<#include "_ssi-series-detail-macro.ftl">
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl">
<#setting number_format="computer">

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        if (ssi_columns === undefined || ssi_columns === "") {
            ssi_columns = "${ssi_columns}".split(",");
            var serie_config_values = '';
            if (${serie_config_values!""}) {
                serie_config_values = JSON.parse('${serie_config_values!""}');
            }
            firstElement = true;
        }
    </script>
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/standard-stocked-items/ssi-product.component.js"/>"></script>
</@hst.headContribution>

<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage"/>
<div>
    <div>
        <input type="hidden" id="ssi_columns_series" value="${ssi_columns}"/>
        <div id="${componentId!""}">
            <#assign index = 0>
            <#if isFunctionality??>
                <input type="hidden" id="functionalityDisabledFilters" value="${disabledFilterList}"/>
                <input type="hidden" id="functionalityRequiredFilters" value="${requiredFilterList}"/>
                <input type="hidden" id="functionalityColumns" value="${functionalityColumns}"/>
            <#elseif isEtoolsFrl??>
                <input type="hidden" id="etoolsColumns" value="${""}"/>
            </#if>
            <#list ssiProducts.getContent() as ssiProduct>
                <#if isFunctionality?? || isEtoolsFrl??>
                    <#assign product = ssiProduct.getProductData()>
                    <#assign hasAccessories = ssiProduct.getHasAccessories()>
                </#if>
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
