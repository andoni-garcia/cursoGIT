<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../_selection-basket-favourites-bar-macro.ftl" />
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl"/>
<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage"/>

<#assign compareId = 'compare-ssi-products-' + .now?long?c>
<div class="modal fade compare-product-modal" id="${componentId}_compareProductModal" tabindex="-1" role="dialog"
     aria-labelledby="${componentId}_compareProductModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
        <div class="modal-content compare-table-products" id="${compareId}">
            <div class="modal-header">
                <h5 class="modal-title"
                    id="${componentId}_compareProductModalTitle"><@fmt.message key="standardstockeditems.compare" /></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <#assign renderingMode = "compare-products">
                <#if !idMap??>
                    <#assign productId = "${product.getId()?long?c}">
                    <div class="col-12 d-none d-lg-block">
                        <div class="row p-2">
                            <div class="col-3 pl-5">
                                <@renderImage images=product.getImages() type='MEDIUM' />
                            </div>
                            <div class="col-9 align-self-center">
                                ${product.getName()}
                            </div>
                        </div>
                    </div>
                    <div class="col-12 d-block d-lg-none">
                        <div class="row p-2">
                            <div class="col-12 pl-5">
                                <@renderImage images=product.getImages() type='MEDIUM' />
                            </div>
                        </div>
                    </div>
                    <div class="col-12 d-block d-lg-none">
                        <div class="row p-2">
                            <div class="col-12 align-self-center">
                                ${product.getName()}
                            </div>
                        </div>
                    </div>
                </#if>
                <#if deviceInfo.deviceType=='DESKTOP'>
                    <div class="col-12">
                        <div class="row p-2">
                            <#assign comparisonClassNumber = compareProducts.getPartNumbersData()?size>
                            <#if comparisonClassNumber == 2>
                                <#assign comparisonClassNumber = 4 >
                            </#if>
                            <div class="col-${comparisonClassNumber}"></div>
                            <#assign productCompare = compareProducts.getPartNumbersData()[0].getData()>
                            <#list compareProducts.getPartNumbersData() as product>
                                <div class="col-${comparisonClassNumber} header p-2">
                                    <div class="p-2 key">${product.getPartNumber()}</div>
                                </div>
                                <#if product.getData()?has_content>
                                    <#assign productCompare = product.getData()>
                                </#if>
                            </#list>
                        </div>
                    </div>
                    <#list productCompare as productData>
                        <#assign distinctKeyClass = "">
                        <#assign currentKey = productData.getKey()>
                        <#list compareProducts.getDistinctKeys() as distinctKey>
                            <#if currentKey == distinctKey >
                                <#assign distinctKeyClass = "header differentKey">
                                <#break>
                            </#if>
                        </#list>
                        <div class="col-12">
                            <div class="row p-2  ${distinctKeyClass}">
                                <div class="col-${comparisonClassNumber}  p-2">
                                    <div class="p-2 key"> ${productData.getKey()}</div>
                                </div>
                                <#list compareProducts.getPartNumbersData() as compareProduct>
                                    <div class="col-${comparisonClassNumber} p-2">
                                        <div class="p-2 key">
                                            <#assign cellValue = "" >
                                            <#list compareProduct.getData() as productData>
                                                <#if currentKey == productData.getKey() >
                                                    ${productData.getValue()}
                                                    <#break>
                                                </#if>
                                            </#list>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </#list>
                    <#if isAuthenticated && !isLightUser>
                        <div class="col-12">
                            <div class="row p-2">
                                <div class="col-${comparisonClassNumber}">
                                    <div class="item first-item list-price product-prices key">
                                        <label class="mb-0"><@fmt.message key="addToCartBar.listprice" /></label>
                                    </div>
                                    <div class="item first-item unit-price product-prices key">
                                        <label class="mb-0"><@fmt.message key="addToCartBar.unitprice" /></label>
                                    </div>
                                    <div class="item first-item delivery-date product-dates key">
                                        <label class="mb-0"><@fmt.message key="addToCartBar.deliveryDate" /></label>
                                    </div>
                                </div>
                                <#list compareProducts.getPartNumbersData() as compareProduct>
                                    <div id="check-prices-content-compare-${compareProduct.getPartNumber()?replace("/", "_")}"
                                         class="col-${comparisonClassNumber} check-prices-content check-prices-content-js  p-2">
                                        <div id="check-prices-data-compare-${compareProduct.getPartNumber()?replace("/", "_")}">
                                            <div class="row  p-2">
                                                <div class="item first-item list-price product-prices">
                                                    <span class="value key">-</span>
                                                </div>
                                                <div class="item first-item unit-price product-prices">
                                                    <span class="value key">-</span>
                                                </div>
                                                <div class="item first-item delivery-date product-dates">
                                                    <span class="value key">-</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="erp-info-message mb-0 alert alert-info hidden fade">
                                            <!-- Loaded by JS -->
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </#if>
                    <div class="row p-2">
                        <div class="col-${comparisonClassNumber} p-2"></div>
                    </div>
                    <div class="col-12">
                        <div class="row p-2">
                            <div class="col-${comparisonClassNumber} p-2"></div>
                            <#list compareProducts.getPartNumbersData() as compareProduct>
                                <#if idMap??>
                                    <#assign productId = "${idMap[compareProduct.getPartNumber()]}">
                                </#if>
                                <div class="col-${comparisonClassNumber} p-2">
                                    <#if isAuthenticated>
                                        <@addToBasketBar productId="${productId}" renderingMode="${renderingMode}" showQuantityBox=true showInfo=true showExtraInfo=false
                                        partNumber="${compareProduct.getPartNumber()}"
                                        productPricesContainer="#check-prices-content-compare-${compareProduct.getPartNumber()}"
                                        productPricesDataContainer="#check-prices-data-compare-${compareProduct.getPartNumber()}"
                                        isConfiguratorPage = false
                                        statisticsSource="COMPARE PRODUCTS" />
                                    <#else>
                                        <@addToBasketBar productId="${productId}" renderingMode="${renderingMode}" showQuantityBox=false showInfo=false showExtraInfo=false
                                        partNumber="${compareProduct.getPartNumber()}" isConfiguratorPage = false
                                        statisticsSource="COMPARE PRODUCTS" />
                                    </#if>
                                </div>
                            </#list>
                        </div>
                    </div>
                <#else>
                    <div class="col-12 row">
                        <div class="col-12 p-0">
                            <#list compareProducts.getPartNumbersData() as compareProduct>
                                <#if idMap??>
                                    <#assign product>${idMap[compareProduct.getPartNumber()]}</#assign>
                                    <#assign renderingMode = "compare-products-functionality">
                                </#if>
                                <div class="col-12 header pt-3">${compareProduct.getPartNumber()?replace("/", "_")}</div>
                                <div class="col-12 pt-3">
                                    <#list compareProduct.getData() as data>
                                        <#assign distinctKeyClass = "">
                                        <#list compareProducts.getDistinctKeys() as distinctKey>
                                            <#if data.getKey() == distinctKey >
                                                <#assign distinctKeyClass = "header differentKey">
                                                <#break>
                                            </#if>
                                        </#list>
                                        <div class="row p-2">
                                            <div class="col-12 p-2 ${distinctKeyClass}"><span
                                                        class="key">${data.getKey()}</span>: ${data.getValue()}</div>
                                        </div>
                                    </#list>
                                </div>
                                <#if isAuthenticated  && !isLightUser>
                                    <div class="col-${comparisonClassNumber}">
                                        <div class="row" style="flex-flow: column">
                                            <div class="item first-item list-price product-prices key">
                                                <label class="mb-0"><@fmt.message key="addToCartBar.listprice" /></label>
                                            </div>
                                            <div class="item first-item unit-price product-prices key">
                                                <label class="mb-0"><@fmt.message key="addToCartBar.unitprice" /></label>
                                            </div>
                                            <div class="item first-item delivery-date product-dates key">
                                                <label class="mb-0"><@fmt.message key="addToCartBar.deliveryDate" /></label>
                                            </div>

                                        </div>
                                    </div>
                                    <div id="check-prices-content-compare-${compareProduct.getPartNumber()?replace("/", "_")}"
                                         class="col-12 row check-prices-content check-prices-content-js">
                                        <div id="check-prices-data-compare-${compareProduct.getPartNumber()?replace("/", "_")}">
                                            <div class="row col-12">
                                                <div class="item first-item list-price product-prices">
                                                    <span class="value">-</span>
                                                </div>
                                                <div class="item first-item unit-price product-prices">
                                                    <span class="value">-</span>
                                                </div>
                                                <div class="item first-item delivery-date product-dates">
                                                    <span class="value">-</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="erp-info-message mb-0 alert alert-info hidden fade">
                                            <!-- Loaded by JS -->
                                        </div>
                                    </div>
                                </#if>
                                <div class="col-12 pt-3">
                                    <#if isAuthenticated>
                                        <@addToBasketBar productId="${productId}" renderingMode="${renderingMode}" showQuantityBox=true showInfo=true showExtraInfo=false
                                        partNumber="${compareProduct.getPartNumber()}"
                                        productPricesContainer="#check-prices-content-compare-${compareProduct.getPartNumber()}"
                                        productPricesDataContainer="#check-prices-data-compare-${compareProduct.getPartNumber()}"
                                        isConfiguratorPage = false
                                        statisticsSource="COMPARE PRODUCTS" />
                                    <#else>
                                        <@addToBasketBar productId="${productId}" renderingMode="${renderingMode}" showQuantityBox=false showInfo=false showExtraInfo=false
                                        partNumber="${compareProduct.getPartNumber()}" isConfiguratorPage = false
                                        statisticsSource="COMPARE PRODUCTS" />
                                    </#if>
                                </div>
                            </#list>

                        </div>
                    </div>
                    <div class="col-12 row"></div>
                </#if>
            </div>
        </div>
    </div>
</div>

<script>

    $(function () {

        window.smc.comparePartNumbersList = [];
        <#list compareProducts.getPartNumbersData() as product>
        window.smc.comparePartNumbersList.push(
            '${product.getPartNumber()}');
        </#list>

        var CompareProducts = window.smc.CompareProducts;
        var config = {
            id: '${compareId}',
            container: $('#${compareId}'),
            partNumbers: window.smc.comparePartNumbersList,
            <#--productId: '${product.getId()?long?c}' || '',-->
            defaultLanguage: '${lang}',
            basketViewModel: window.basketViewModel
        };
        window.smc.compareProductsComponent = new CompareProducts(config);
        window.smc.compareProductsComponent.init();
    })
</script>
