<#include "../../../include/imports.ftl">
<#include "../../../digitalcatalog/product-page/ssi/ssi-page-component.ftl">
<#setting number_format="computer">
<#assign ssiTabId = "pc_" + .now?long?c >
<#--<#assign source = "functionality" >-->
<@hst.setBundle basename="SearchPage,ProductToolbar,AddToCartBar,eshop,ProductConfigurator,CylinderConfigurator, StandardStockedItems, ETools"/>

<#--<div class="smc-tabs__head">-->
<#--    <ul class="nav w-100" role="tablist">-->
<#--        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0">-->
<#--            <a class="active"-->
<#--               data-toggle="tab"-->
<#--               role="tab"-->
<#--               aria-selected="true"><@fmt.message key="functionality.itemsbestadaptstoyou"/></a>-->
<#--        </li>-->
<#--    </ul>-->
<#--</div>-->
<main id="psfFuntionalitycontenedor" class="psfFuntionalitycontenedor">

<div class="tab-content dc-navigation-page">
    <div class="col-lg-12 p-2 ssi-component" id="ssi-container">

        <div class="row">
            <div class="col-lg-12 p-0 ssi-component pagination_showing hidden no-results-js">
                <span><@fmt.message key="product.toolbar.noresults"/></span>
            </div>
        </div>
        <div class="row">
            <div id="spares_accessories" class="col-lg-12 p-0 spares-accessories-container mt-4">
                <div class="row align-items-center" style="display: none;">
                    <div class="col-md-4 mt-10 mt-lg-0 text-center text-md-left">
                        <!--   --->
                        <@fmt.message key="search.searchresult.paging.showing"/>
                        <span class="js-search-init-page-number">?</span>
                        <!--   --->
                        <@fmt.message key="search.searchresult.paging.to"/>
                        <span class="js-search-finish-page-number">?</span>
                        <!--   --->
                        <@fmt.message key="search.searchresult.paging.of"/>
                        <span class="js-search-total">?</span>
                        <!--   --->
                        <@fmt.message key="search.searchresult.paging.entries"/>
                    </div>
                    <div class="col-md-4 text-center mt-10 mt-lg-0 d-none d-sm-block">
                        <@fmt.message key="search.searchresult.paging.display"/>
                        <a data-section='product_catalogue' class="active changelen" data-len="10" href="#">10</a> |
                        <a data-section='product_catalogue' class="changelen" data-len="20" href="#">20</a> |
                        <a data-section='product_catalogue' class="changelen" data-len="50" href="#">50</a> |
                        <a data-section='product_catalogue' class="changelen" data-len="100" href="#">100</a>
                    </div>
                    <div class="col-md-4 mt-10 mt-lg-0 pl-md-0">
                        <div class="compare align-right justify-content-center d-flex justify-content-md-end">
                            <button class="btn btn-primary disabled compare-product-button mt-10 mt-sm-0" disabled>
                                <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                <span id="btn-compare-text"><@fmt.message key="standardstockeditems.compare"/> (max. 3) <#--TODO i18n-->
                                                        <span class="rounded-circle compare-number compare-number-js hidden">3</span>
                                                    </span>
                            </button>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div class="row mt-4 mb-2 d-none d-lg-flex spares-accessories__header">
            <div class="col-3 col-lg-2 sub-title"
                 id="referenceLbl" style="text-align: center">Components</div>
<#--            <@fmt.message key="etools.components"/>-->
            <div class="col-3 col-lg-3 sub-title"
                 id="descriptionLbl"><@fmt.message key="productConfigurator.description"/></div>
            <div class="col-3 col-lg-1 sub-title"
                 id="descriptionLbl">Quantity</div>
<#--            <@fmt.message key="etools.quantity"/>-->
            <div class="col-3 col-lg-1 sub-title"
                 id="descriptionLbl">Position</div>
<#--            <@fmt.message key="etools.position"/>-->
            <div class="col-3 col-lg-1 sub-title"
                 id="detailsLbl"><@fmt.message key="productConfigurator.details"/></div>
        </div>
        <div class="row d-block accordion spares-accessories-result-container"
             id="spares-accessories-result-container">
            <div id="ssi-content">
            </div>
        </div>

        <div class="ssi-empty-results row" data-swiftype-index='false'>
            <div class="col align-self-center text-center p-5"><@fmt.message key="standardstockeditems.emptyresponse"/></div>
        </div>
        <div class="row" style="display: none;">
            <div class="col-lg-12">
                <div class="row">
                    <div class="d-flex justify-content-center pagination-container pagination-container-js col-12 mt-20 mt-xl-0 pt-xl-3 p-0 pl-0 pl-md-0"></div>
                </div>
            </div>
        </div>

        <div class="compare-tab-js hidden"></div>
    </div>
    <script id="StandardStockedItemsInit">
        $(function () {
            var StandardStockedItems = window.smc.StandardStockedItems;
            var config = {
                id: '${ssiTabId}',
                container: $('#ssi-container'),
                component: $('.ssi-component'),
                pageNumber: 1,
                pageSize: 10,
                defaultLanguage: '${lang}',
                isEtools: true,
                etech: {
                    Init: window.Init,
                    oDomains: window.oDomains,
                    oStateMessages: window.oStateMessages
                },
                isEtechEnabled: true
            };
            window.smc.standardStockedItemsComponent = new StandardStockedItems(config);
        });
    </script>
</div>
    </main>
<style>
    .spare-accessory-item__label.detailsLabel {
        justify-content: center;
    }
</style>