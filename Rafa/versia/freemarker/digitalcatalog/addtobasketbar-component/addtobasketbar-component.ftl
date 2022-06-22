<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#setting number_format="computer">

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/addtobasketbar/addtobasketbar.component.css"/>"
          type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/addtobasketbar-component/addtobasketbar.component.js"/>"></script>
</@hst.headContribution>

<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../_spinner.ftl">
</@hst.headContribution>

<a id="getErpInfoUrl" class="hidden" href="<@hst.resourceURL resourceId='getErpInfo'/>"></a>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.addToBasketBar = smc.addToBasketBar || {};
    smc.addToBasketBar.urls = {
        getErpInfo: document.getElementById('getErpInfoUrl').href
    };
</script>
<#global addToBasketBarCounter = 0>

<#macro addToBasketBar productId renderingMode="simple" showQuantityBox=false showAddToBasketBtn=true showAddToFavoritesBtn=true
showInfo=false showExtraInfo=false partNumber=""  series = false new_hto= false
productPricesContainer=".erp-info-container" productPricesDataContainer=".erp-info-data" isConfiguratorPage=true
statisticsSource="">

    <#global addToBasketBarCounter += 1>

    <#assign componentId = "addtobasketbar_" + .now?long?c + "_" + addToBasketBarCounter?number?c>
    <#assign _statisticsSourceDefault = "${source!''}">
    <#assign _statisticsSource = (statisticsSource != "")?then(statisticsSource, _statisticsSourceDefault) >

    <#include "addtobasketbar-component-idbl.ftl">

    <script>
        $(function () {
            var AddToBasketBar = window.smc.AddToBasketBar;

            var $productPriceContainer = $('${productPricesContainer?replace("/", "_")}', '#${componentId}');

            if ($productPriceContainer.length === 0) {
                $productPriceContainer = $('${productPricesContainer?replace("/", "_")}');
            }
            var config = {
                id: '${componentId}',
                productId: '${productId}',
                renderingMode: '${renderingMode}',
                partNumber: '${partNumber}' || '',
                defaultLanguage: '${lang}',
                container: $('#${componentId}'),
                $productPricesContainer: $productPriceContainer,
                $productPricesDataContainer: $('${productPricesDataContainer?replace("/", "_")}'),
                showQuantityBox: ${showQuantityBox?c},
                showAddToBasketBtn: ${showAddToBasketBtn?c},
                showAddToFavoritesBtn: ${showAddToFavoritesBtn?c},
                showInfo: ${showInfo?c},
                showExtraInfo: ${showExtraInfo?c},
                basketViewModel: window.basketViewModel,
                productConfiguratorComponent: window.smc.productConfiguratorComponent,
                isConfiguratorPage: ${isConfiguratorPage?c},
                isLightUser: ${isLightUser?c},
                statisticsSource: '${_statisticsSource}',
                <#--//canFetchPrices: ${(isAuthenticated && !isLightUser)},-->
                messages: {
                    couldntGetErpInfo: "<@fmt.message key="addToCartBar.prices.pleasecontactsmc" />",
                    completeConfigToViewPrices: "<@fmt.message key="addToCartBar.prices.completeconfig" />",
                    completeRodEndConfigToViewPrices: "<@fmt.message key="addToCartBar.prices.completerodendconfig" />"
                },
                BASKET_ERROR_CODES: window.BASKET_ERROR_CODES || BASKET_ERROR_CODES
            };

            config.isManualPartNumber = config.partNumber && config.partNumber !== '';

            var addToBasketBar = new AddToBasketBar(config);
            addToBasketBar.init();
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</#macro>