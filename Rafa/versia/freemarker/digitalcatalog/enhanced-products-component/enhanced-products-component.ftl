<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<@hst.setBundle basename="essentials.global,EnhancedProducts"/>
<#include "_enhanced-product-template-macro.ftl">

<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/enhanced-products/enhanced-products.component.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/enhanced-products/enhanced-products.component.js"/>"></script>
</@hst.headContribution>

<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../_spinner.ftl">
</@hst.headContribution>

<#assign enhancedProductComponentId = "enhanced-products_" + .now?long?c>

<div class="container">
    <div id="${enhancedProductComponentId}" class="enhanced-products-component ${deviceInfo.deviceType?lower_case}">

        <h1 class="heading-03 color-blue"><@fmt.message key="enhancedproducts.title" /></h1>
        <h2 class="heading-02"><@fmt.message key="enhancedproducts.subtitle" /></h2>

        <p class=""><@fmt.message key="enhancedproducts.explain" /></p>

        <div class="row mt-5 mt-md-4">
            <div class="col-12 input-group search-bar-input-container">
                <input id="filter" name="filter" type="text" class="form-control" autocomplete="off" placeholder="<@fmt.message key="enhancedproducts.filterPlaceholder" />" aria-describedby="basic-addon">
                <span id="searchbutton" class="icon-search"></span>
            </div>
        </div>

        <div class="row mt-5 mt-md-4">
            <#list products as enhancedProduct>
                <@enhancedProductTemplate product=enhancedProduct.getEnhancedProduct() url=enhancedProduct.getUrl()
                    cssClass="col-12 col-md-6 col-lg-4 col-xl-3 fade show" />
            </#list>

            <div class="empty-results row text-center m-auto p-5" data-swiftype-index='false'>
                <div class="col align-self-center"><@fmt.message key="standardstockeditems.noFilterResults"/></div>
            </div>
        </div>

    </div>
</div>


<script>
    $(function() {
        var smc = window.smc || {};
        smc.enhancedProducts = smc.enhancedProducts || {};

        var familiesList = {};
        <#list families as family>
            familiesList['${family.getId()?long?c}'] = { name: "${family.getName()}", series: [] };
        </#list>

        var seriesList = {};
        <#list series as serie>
            seriesList['${serie.getName()}'] = { name: "${serie.getName()}", familyId: '${serie.getFamilyId()?long?c}', active: false };
        </#list>

        var productList = {};
        <#list products as product>
            productList['${product.getEnhancedProduct().getId()?long?c}'] = {
                id: '${product.getEnhancedProduct().getId()?long?c}',
                name: "${product.getName()} <@fmt.message key='enhancedproducts.series' />",
                seriesName: "${product.getSeriesName()???then(product.getSeriesName(), 'no_serie')}",
                active: true
            };
        </#list>

        var EnhancedProducts = window.smc.EnhancedProducts;
        var config = {
            id: '${enhancedProductComponentId}',
            container: $('#${enhancedProductComponentId}'),
            familiesList: familiesList,
            seriesList: seriesList,
            productList: productList
        };
        var enhancedProducts = new EnhancedProducts(config);
        enhancedProducts.init();
    });
</script>

<script id="enhanced-product-template" type="text/template">
    <@enhancedProductTemplate />
</script>