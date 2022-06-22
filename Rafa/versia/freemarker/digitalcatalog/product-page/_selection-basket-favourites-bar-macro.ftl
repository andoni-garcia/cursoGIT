<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<#global selectionBasketFavouritesBarCounter = 0>

<#-- sparesAccessoriesComponentId: The ID of the SpareAccessoriesComponent to get the PartNumbers from when click "Add to basket" or "Add to favourites" buttons -->
<#-- relatedProducyComponentId: The ID of the SpareAccessoriesComponent to get the PartNumbers from when click "Add to basket" or "Add to favourites" buttons -->
<#macro selectionBasketFavouritesBar sparesAccessoriesComponentId='' relatedProducyComponentId='' ssiProductComponentId=''
selectAllCheckboxFeature=false statisticsSource='' seriesCheckBox=''seriesRelatedProductId='' sparesRelatedProductComponentId=''>
    <#global selectionBasketFavouritesBarCounter += 1>

    <#assign selectionBasketFavouritesBarComponentId = "selection_basket_favourites_bar_" + .now?long?c + "_" + selectionBasketFavouritesBarCounter?number?c >
    <#assign _statisticsSourceDefault = "${source}">
    <#assign _statisticsSource = (statisticsSource != "")?then(statisticsSource, _statisticsSourceDefault) >

    <#if seriesCheckBox == 'ssi'>
        <div id="${selectionBasketFavouritesBarComponentId}" class="selection-basket-favourites-bar-container">
            <label for="selectAll_${selectionBasketFavouritesBarComponentId}"
                   class="smc-checkbox select-all-products-checkbox-container">
                <input type="checkbox" id="selectAll_${selectionBasketFavouritesBarComponentId}"/>
                <span class="smc-checkbox__label"><strong><@fmt.message key="productConfigurator.models"/></strong></span>
            </label>
        </div>
    <#elseif seriesCheckBox == 'functionality'>
        <div id="${selectionBasketFavouritesBarComponentId}" class="selection-basket-favourites-bar-container">
            <label for="selectAll_${selectionBasketFavouritesBarComponentId}"
                   class="smc-checkbox select-all-products-checkbox-container">
                <input type="checkbox" id="selectAll_${selectionBasketFavouritesBarComponentId}"/>
                <span class="smc-checkbox__label"><strong><@fmt.message key= "productConfigurator.image" /></strong></span>
            </label>
        </div>
        <#assign seriesCheckBox="ssi">
    <#elseif seriesCheckBox == 'relatedProducts'>
        <div id="${selectionBasketFavouritesBarComponentId}" class="selection-basket-favourites-bar-container">
            <label for="selectAll_${selectionBasketFavouritesBarComponentId}"
                   class="smc-checkbox select-all-products-checkbox-container">
                <input type="checkbox" id="selectAll_${selectionBasketFavouritesBarComponentId}"/>
                <span class="smc-checkbox__label"><strong><@fmt.message key= "productConfigurator.image" /></strong></span>
            </label>
        </div>
    <#else>
        <div id="${selectionBasketFavouritesBarComponentId}" class="selection-basket-favourites-bar-container">
            <label for="selectAll_${selectionBasketFavouritesBarComponentId}"
                   class="smc-checkbox select-all-products-checkbox-container">
                <#if selectAllCheckboxFeature>
                    <input type="checkbox" id="selectAll_${selectionBasketFavouritesBarComponentId}"/>
                </#if>
                <span class="smc-checkbox__label"><@fmt.message key="addToCartBar.selectedto"/>:</span>
            </label>

            <button class="btn btn-primary add-to-basket-btn-js" disabled>
                <#if isAuthenticated>
                    <@fmt.message key="addToCartBar.addtocard" />
                <#else>
                    <@fmt.message key="addToCartBar.addtoproductselection" />
                </#if>
            </button>
            <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites-js"
                    disabled><@fmt.message key="addToCartBar.addtofavourites" /></button>
        </div>
    </#if>

    <script>
        window.smc = window.smc || {};

        $(function () {

            var selectionBasketFavouritesBar = new window.smc.SelectionBasketFavouritesBar({
                id: '${selectionBasketFavouritesBarComponentId}',
                container: $('#${selectionBasketFavouritesBarComponentId}'),
                selectionListComponentIds: ['${sparesAccessoriesComponentId}', '${relatedProducyComponentId}', '${ssiProductComponentId}'],
                basketViewModel: window.basketViewModel,
                statisticsSource: '${_statisticsSource}',
                ssiContainer: $('#ssi-container'),
                srpContainer: '${sparesRelatedProductComponentId}',
                seriesRelatedContainer: $('#related_products_${seriesRelatedProductId}'),
                selectAllCheckboxFeature: ${selectAllCheckboxFeature?c},
                checkBoxType: '${seriesCheckBox}'
            });

            selectionBasketFavouritesBar.init();
        });
    </script>
</#macro>
