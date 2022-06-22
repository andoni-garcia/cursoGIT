<#include "../../include/imports.ftl">
<#include "./_functionality-scripts.ftl">
<#include "../../digitalcatalog/product-page/ssi/ssi-page-component.ftl">
<#include "../../digitalcatalog/product-page/_selection-basket-favourites-bar-macro.ftl" />
<#setting number_format="computer">
<#assign ssiTabId = "pc_" + .now?long?c >
<#assign source = "functionality" >
<@hst.setBundle basename="SearchPage,ProductToolbar,AddToCartBar,eshop,ProductConfigurator,CylinderConfigurator, StandardStockedItems, Functionality"/>

<div class="smc-tabs__head">
    <ul class="nav w-100" role="tablist">
        <li class="nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0">
            <a class="active"
               data-toggle="tab"
               role="tab"
               aria-selected="true"><span class="psf-steps mr-3">3</span><@fmt.message key="functionality.itemsbestadaptstoyou"/></a>
        </li>
    </ul>
</div>
<div class="tab-content dc-navigation-page">
    <div class="col-lg-12 p-2 ssi-component" id="ssi-container">
        <div class="row">
            <div class="col-lg-12 p-0 ssi-component pagination_showing hidden no-results-js">
                <span><@fmt.message key="product.toolbar.noresults"/></span>
            </div>
        </div>
        <div class="row">
            <div id="spares_accessories" class="col-lg-12 p-0 spares-accessories-container mt-4">
                <div class="row pagination_showing align-items-center">
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
            <div class="col-3 col-lg-1 sub-title" id="imageLbl">
                <label for="selectAll_id" class="smc-checkbox">
                    <@selectionBasketFavouritesBar ssiProductComponentId='${ssiTabId}' selectAllCheckboxFeature=true statisticsSource="NbF" seriesCheckBox="functionality" />
                </label>
            </div>
            <div class="col-3 col-lg-2 sub-title"
                 id="referenceLbl"><@fmt.message key="productConfigurator.models"/></div>
            <div class="col-3 col-lg-2 sub-title"
                 id="descriptionLbl"><@fmt.message key="productConfigurator.description"/></div>
            <div class="col-3 col-lg sub-title"
                 id="navColumn0"></div>
            <div class="col-3 col-lg sub-title"
                 id="navColumn1"></div>
            <div class="col-3 col-lg-1 sub-title"
                 id="detailsLbl"><@fmt.message key="productConfigurator.details"/></div>
            <div class="col-3 col-lg-3 sub-title" id="actionsLbl"></div>
        </div>
        <div class="row d-block accordion spares-accessories-result-container"
             id="spares-accessories-result-container">
            <div id="ssi-content">
            </div>
        </div>

        <div class="ssi-empty-results row" data-swiftype-index='false'>
            <div class="col align-self-center text-center p-5"><@fmt.message key="standardstockeditems.emptyresponse"/></div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="row">
                    <div class="d-flex justify-content-center pagination-container pagination-container-js col-12 mt-20 mt-xl-0 pt-xl-3 p-0 pl-0 pl-md-0"></div>
                </div>
                <div class="row">
                    <div class="d-flex ssi-footer col-12  p-0"><@selectionBasketFavouritesBar ssiProductComponentId='${ssiTabId}' selectAllCheckboxFeature=!(isSeriesPage?? && isSeriesPage) statisticsSource="NbF" /></div>
                </div>
            </div>
        </div>

        <div class="compare-tab-js hidden"></div>
    </div>
    <script id="StandardStockedItemsInit">
        $(function () {
            <#--var allPartNumbers = [];-->
            <#--<#list ssiProductsPartNumbers as partNumber>-->
            <#--allPartNumbers.push({-->
            <#--    part_number: '${partNumber}'-->
            <#--});-->
            <#--</#list>-->
            // window.smc.ssiAllPartNumbers = allPartNumbers;

            var currentURL = new URL(window.location.href);
            var urlSearchData = currentURL.searchParams.get("searchData");
            var searchData;
            if (urlSearchData) {
                let base64SearchData = urlSearchData.replaceAll('-','+' ).replaceAll('_', '/').replaceAll('.', '=');
                searchData = JSON.parse(atob(base64SearchData));
            }

            var StandardStockedItems = window.smc.StandardStockedItems;
            var config = {
                id: '${ssiTabId}',
                container: $('#ssi-container'),
                component: $('.ssi-component'),
                ssiCheckboxClass: 'ssi-item-partnumber',
                <#--productId: '${product.getNode().getId()?long?c}',-->
                pageNumber: searchData ? searchData.page : 1,
                pageSize: searchData ? searchData.size : 10,
                defaultLanguage: '${lang}',
                isFunctionality: true,
                categoryId: '${categoryId}',
                etech: {
                    Init: window.Init,
                    oDomains: window.oDomains,
                    oStateMessages: window.oStateMessages
                },
                isEtechEnabled: ${ isEtechEnabled???then(isEtechEnabled?c, false) }
            };
            window.smc.standardStockedItemsComponent = new StandardStockedItems(config);
        })
    </script>

    <div id="compare_hto_wrapper" style="display: none;">
        <div class="idbl_hto_wrapper idbl_hto_wrapper--compare" id="idbl_hto_wrapper--compare">
            <div class="idbl_hto  idbl_hto--light container">
                <header class="idbl_hto__header"></header>
                <div class="idbl_hto__content">
                    <section class="idbl_hto__content__data">
                    </section>
                    <section class="idbl_hto__content__partnumber">
                        <div class="idbl_hto__partnumber__actions">
                            <a id="compareCopyToClipBoard_btn" class="btn btn-secondary btn-secondary--blue-border"
                               href="#" data-toggle="tooltip" data-placement="bottom" title=""
                               data-original-title="Copy to clipboard">
                                <div class="icon-container-hto">
                                    <i class="icon-copy"></i>
                                </div>
                            </a>
                        </div>
                        <!-- ToDo: código del cpn_partnumber en data-partnumber-code -->
                        <div class="idbl_hto__partnumber__code_wrapper idbl_hto__partnumber__code_wrapper--overflow idbl_hto__partnumber__code_wrapper--status-complete"
                             data-partnumber-code="">
                            <span class="idbl_hto__partnumber__code_status"></span>

                            <div class="idbl_hto__partnumber__code config">
                                <div class="config">
                                    <div id="cpn_partnumber--compare" class="cpn_partnumber status-complete">
                                        <span id="compare_partnumber" class="partnumber_constant_chain"></span>
                                    </div>
                                    <div class="config-state" align="center"><span
                                                class="part-number-state part-number-state-ok"></span></div>
                                </div>
                            </div>

                        </div>
                    </section>


                    <div class="configurator desktop idbl_hto__content__addtobasketbar" data-swiftype-index="false">
                        <section class="idbl_hto__content__info add-to-basket-bar-component configurator desktop">
                            <div class="col-lg-12 idbl_hto__content__data_stockMessage"
                                 id="idbl_hto__content__data_comparing_with_message">
                                <div class="alert"><@fmt.message key="productConfigurator.selectToCompare"/></div>
                            </div>
                        </section>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>