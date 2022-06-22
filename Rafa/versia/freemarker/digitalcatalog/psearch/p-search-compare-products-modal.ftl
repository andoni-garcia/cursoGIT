<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage"/>

<#assign compareId = 'psearch-compare-products-' + .now?long?c>
<div class="modal fade compare-product-modal psearch-compare-product-modal" id="psearch_compareProductModal" tabindex="-1" role="dialog" aria-labelledby="psearch_compareProductModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered" role="document" >
        <div class="modal-content compare-table-products" id="${compareId}">
            <div class="modal-header">
                <h5 class="modal-title" id="psearch_compareProductModalTitle"><@fmt.message key="standardstockeditems.compare" /></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <#if deviceInfo.deviceType=='DESKTOP'>
                    <#assign comparisonClassNumber = compareProducts.getProductsData()?size>
                    <#if comparisonClassNumber == 2 >
                        <#assign colTitle = "col-7 col-sm-4 col-md-2">
                        <#assign colProduct = "col-7 col-sm-7 col-md-5">
                    <#elseif comparisonClassNumber == 3 >
                        <#assign colTitle = "col-7 col-sm-4 col-md-3">
                        <#assign colProduct = "col-7 col-sm-7 col-md-3">
                    <#else>
                        <#assign colTitle = "col-7 col-sm-4 col-md-2">
                        <#assign colProduct = "col-7 col-sm-7 col-md-3">
                    </#if>
                    <div id="psearch_compareProductModalBody_desktop" class="col-12">
                        <div class="row p-2">
                            <div class="${colTitle}"></div>
                            <#assign productCompare = compareProducts.getProductsData()[0].getData()>
                            <#list compareProducts.getProductsData() as product>
                                <div class="${colProduct} header p-2">
                                    <div class="p-2 key psearch-compare-product__image">
                                        <@renderImage images=product.getNode().getImages() type='MEDIUM' />
                                    </div>
                                    <div class="p-2 key psearch-compare-product__name">${product.getNode().getName()}</div>
                                    <div class="p-2 key psearch-compare-product__info">${product.getNode().getDescription()}</div>
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
                                <div class="${colTitle} p-2">
                                    <div class="p-2 key"> ${productData.getKey()}</div>
                                </div>
                                <#list compareProducts.getProductsData() as compareProduct>
                                    <div class="${colProduct} p-2">
                                        <div class="p-2 key">
                                            <#assign cellValue = "" >
                                            <#list compareProduct.getData() as productData>
                                                <#if currentKey == productData.getKey() >
                                                    <#list productData.getValues() as value>
                                                        ${value}<br>
                                                    </#list>
                                                    <#break>
                                                </#if>
                                            </#list>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </#list>
                    <div class="row p-2">
                        <div class="${colTitle} p-2"></div>
                    </div>
                <#else>
                    <div class="col-12 row">
                        <div class="col-12 p-0">
                            <#list compareProducts.getProductsData() as compareProduct>
                                <div class="header pt-3">
                                    <div class="p-2 key psearch-compare-product__image">
                                        <@renderImage images=compareProduct.getNode().getImages() type='MEDIUM' />
                                    </div>
                                    <div class="p-2 key psearch-compare-product__name">${compareProduct.getNode().getName()}</div>
                                    <div class="p-2 key psearch-compare-product__info">${compareProduct.getNode().getDescription()}</div>
                                </div>

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
                                            <div class="col-12 p-2 ${distinctKeyClass}"> <span class="key">${data.getKey()}</span>:<br>
                                                <#list data.getValues() as value>
                                                    ${value}<br>
                                                </#list></div>
                                        </div>
                                    </#list>
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
