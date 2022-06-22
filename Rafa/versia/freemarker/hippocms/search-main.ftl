<#include "../include/imports.ftl">
<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>
<@hst.include ref="product-toolbar-search-page" />
<#include "../digitalcatalog/search/swiftype-search/swiftype-search-engine.ftl">

<#include "../include/imports.ftl">
<#include "../digitalcatalog/catalog-macros.ftl">
<#include "../digitalcatalog/product/product-toolbar-macro.ftl">
<#include "../digitalcatalog/addtobasketbar-component/addtobasketbar-component.ftl">

<@hst.setBundle basename="SearchPage,SearchBar,ProductToolbar"/>

<#-- @ftlvariable name="searchTerm" type="java.lang.String" -->
<#-- @ftlvariable name="deviceInfo" type="com.smc.hippocms.targeting.demo.data.DeviceTypeRequestData" -->
<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/search-page/search-page.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>
<#if isElasticPCSearchAvailable??>
    <input type="hidden" id="isElasticPCSearchAvailable" value="${isElasticPCSearchAvailable}"/>
<#else>
    <input type="hidden" id="isElasticPCSearchAvailable" value="false"/>
</#if>
<#if isElasticWCSearchAvailable??>
    <input type="hidden" id="isElasticWCSearchAvailable" value="${isElasticWCSearchAvailable}"/>
<#else>
    <input type="hidden" id="isElasticWCSearchAvailable" value="false"/>
</#if>
<input type="hidden" id="traceId" name="traceId" value="${traceId}"/>
<main>
    <section id ="search-section" class="container">
        <#if searchTerm??>
            <header><h2 class="heading-02"><@fmt.message key="search.searchbar.title.term"/></h2></header>
        <#else>
            <header><h2 class="heading-02"><@fmt.message key="search.searchbar.title.search"/></h2></header>
        </#if>

        <@hst.include ref="search-bar" >
            <div class="input-group search-bar-input-container">
                <input type="text" value="${searchTerm!''}" id="search_text_input" class="form-control typeahead" autocomplete="off" placeholder="<@fmt.message key="search.searchbar.input.placeholder"/>" aria-describedby="basic-addon">
                <span id='searchbutton' class="icon-search"></span>
            </div>
        </@hst.include>
        <@hst.include ref="content">
            <div id="searchResult">
                <p>
                    <span><@fmt.message key="search.searchresult.begin.text"/> </span>
                    <span id="searchResultText" class="search-query"></span>
                    <span><@fmt.message key="search.searchresult.middle.text"/> </span>
                    <span id="searchResultNumber" class="search-query"></span>
                    <span><@fmt.message key="search.searchresult.end.text"/></span>
                </p>
                <div id="hidding-content"></div>
            </div>
            <#if deviceInfo.deviceType=='DESKTOP'>
                <div id="searchResultsContainer" class="smc-tabs ${deviceInfo.deviceType?lower_case}">
                    <ul id="tabSearchResult" class="navbar-full nav border-bottom">
                        <li class="nav-item">
                            <a href="#product_catalogue" class="js-switftype-data js-predeterminated js-product-catalogue-link disabled" data-section="product_catalogue">
                                <!--  -->
                                <span><@fmt.message key="search.searchresult.product.catalogue"/></span>
                                <span id="productNumber" class="hidden"></span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#web_content" class="disabled js-switftype-data js-web-content-link" data-section="web_content">
                                <!-- -->
                                <span> <@fmt.message key="search.searchresult.product.webcontent"/></span>
                                <span id="webcontentNumber"  class="hidden"></span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#smc_equivalent" class="disabled hidden js-equivalent-data-link js-equivalent-data"  data-section="smc_equivalent">
                                <!--   --->
                                <span><@fmt.message key="search.searchresult.product.smcequivanlent"/></span>
                                <span id="smcequivanlentNumber"  class="hidden"></span>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content" id="content-products">
                        <div class="tab-pane fade" id="product_catalogue" role="tabpanel" aria-labelledby="pills-home-tab">
                            <div class="row pagination_showing hidden">
                                <div class="col-md-3">
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
                                <div class="offset-md-6 col-md-3">
                                     <@fmt.message key="search.searchresult.paging.display"/> <a  data-section='product_catalogue' class="active changelen" data-len="10" href="#">10</a> | <a data-section='product_catalogue'  class="changelen" data-len="20" href="#">20</a> | <a data-section='product_catalogue'  class="changelen" data-len="50" href="#">50</a> | <a data-section='product_catalogue'  class="changelen" data-len="100" href="#">100</a></a>
                                </div>
                            </div>
                            <div id="products-container" class="row">
                                <div class="content"></div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="web_content" role="tabpanel" aria-labelledby="pills-profile-tab">
                            <div class="row">
                                <div class="col-md-9 categories-button-container js-categories-button-container">
                                </div>
                                <div class="col-md-3 js-button-container">
                                    <button class="btn btn-primary categories-all js-categories-all" data-section="web_content"><i class="fa fa-plus"></i></button>
                                    <button class="btn btn-primary categories-reset js-categories-reset" data-section="web_content"> <@fmt.message key="search.searchresult.categories.reset"/></button>
                                </div>
                            </div>
                            <div class="row pagination_showing hidden">
                                <div class="col-md-3">
                                    <!--  --->
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
                                <div class="offset-md-6 col-md-3">
                                    <!--   --->
                                     <@fmt.message key="search.searchresult.paging.display"/> <a class="active changelen"  data-section='web_content'  data-len="10" href="#">10</a> | <a  class="changelen"  data-section='web_content'  data-len="20" href="#">20</a> | <a  class="changelen"  data-section='web_content'  data-len="50" href="#">50</a> | <a  class="changelen"  data-section='web_content'  data-len="100" href="#">100</a>
                                </div>
                            </div>
                            <div id="web-content-container" class="row">
                                <div class="content"></div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="smc_equivalent" role="tabpanel" aria-labelledby="pills-contact-tab">
                            <div id="smc-equivalent-container" class="row">
                                <div class="content">
                                    <#include "../include/spinner.ftl">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="main-page-spinner loading-container loading-container-js">
                        <#include "../include/spinner.ftl">
                    </div>
                </div>
            <#else>
                <div id="searchResultsContainer"  class="${deviceInfo.deviceType?lower_case}">
                    <div>
                        <div class="simple-collapse">
                            <a href="#product_catalogue" data-section="product_catalogue" class="js-accordion-mobile js-switftype-data js-product-catalogue-link disabled" data-target="#product_catalogue">
                                <!--  -->
                                <span><@fmt.message key="search.searchresult.product.catalogue"/></span>
                                <span id="productNumber"></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="product_catalogue" data-parent="#searchResultsContainer">
                            <div class="pagination_showing hidden" id="products-container">
                                <div class="col-11">
                                    <@fmt.message key="search.searchresult.paging.showing"/>
                                    <span class="js-search-init-page-number">?</span>
                                     <@fmt.message key="search.searchresult.paging.to"/>
                                    <span class="js-search-finish-page-number">?</span>
                                     <@fmt.message key="search.searchresult.paging.of"/>
                                    <span class="js-search-total">?</span>
                                     <@fmt.message key="search.searchresult.paging.entries"/>
                                </div>
                                <div class="content"></div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="simple-collapse">
                            <a href="#web_content" data-section="web_content" data-target="#web_content" class="js-switftype-data js-accordion-mobile js-web-content-link disabled">
                                <span><@fmt.message key="search.searchresult.product.webcontent"/></span>
                                <span id="webcontentNumber"></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="web_content" data-parent="#searchResultsContainer">
                            <div class="" id="web-content-container">
                                <div class="d-flex flex-column">
                                    <div class="d-flex  flex-row">
                                        <div class="col-10 categories-button-container js-categories-button-container"></div>
                                        <div class="d-flex align-items-end">  <button class="btn btn-primary categories-all js-categories-all" data-section="web_content"><i class="fa fa-plus"></i></button></div>
                                    </div>
                                    <div class="d-flex js-button-container">
                                        <div class="col-12"><button class="btn btn-primary categories-reset js-categories-reset" data-section="web_content"> <@fmt.message key="search.searchresult.categories.reset"/></button></div>
                                    </div>
                                </div>
                                <div class="row pagination_showing hidden">
                                    <div class="col-12">
                                        <@fmt.message key="search.searchresult.paging.showing"/>
                                        <span class="js-search-init-page-number">?</span>
                                        <@fmt.message key="search.searchresult.paging.to"/>
                                        <span class="js-search-finish-page-number">?</span>
                                        <@fmt.message key="search.searchresult.paging.of"/>
                                        <span class="js-search-total">?</span>
                                         <@fmt.message key="search.searchresult.paging.entries"/>
                                    </div>
                                </div>
                                <div class="content"></div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="simple-collapse">
                            <a href="#smc_equivalent" data-section="smc_equivalent" data-target="#smc_equivalent" class="js-equivalent-data js-equivalent-data-link js-accordion-mobile disabled hidden">
                                <!--   --->
                                <span><@fmt.message key="search.searchresult.product.smcequivanlent"/></span>
                                <span id="smcequivanlentNumber"></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse"  id="smc_equivalent" data-parent="#searchResultsContainer">
                            <div class="" id="smc-equivalent-container">
                                <div class="content">
                                    <#include "../include/spinner.ftl">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="main-page-spinner loading-container loading-container-js hidden">
                        <#include "../include/spinner.ftl">
                    </div>
                </div>
            </#if>
        </@hst.include>
    </section>
</main>

<script id="searchMainScript" data-device="${deviceInfo.deviceType}"  data-locale="${.locale}" data-smc-logo="<@hst.webfile path="/images/assets/swiftype_default_image.jpg"/>">
    $(function () {
        let oldRearchResultResponseText = "${searchResultResponseJsonString?json_string!""}";
        let oldRearchResultResponse;
        if (oldRearchResultResponseText) {
            oldRearchResultResponse = JSON.parse(oldRearchResultResponseText);
        }
        else {
            oldRearchResultResponse = '';
        }
        let productsPageName = '${productsPageName!""}';
        let productsJsonString = '${productsJsonString?json_string!""}';
        let productsJson;
        if (productsJsonString) {
            productsJson = JSON.parse(productsJsonString);
        }
        else {
            productsJson = [];
        }
        var $input = $('#search_text_input');
        $input.val($input.val().replace("[pl]","+"));
        var $button =  $('#searchbutton');
        var GeneralSearch = window.smc.GeneralSearch;
        var SwiftypeEngine = window.smc.SwiftypeEngine;
        var GeneralSearchNavigation = window.smc.GeneralSearchNavigation;
        var generalSearchNavigation = new GeneralSearchNavigation();

        var $thisSearchMainScriptComponent = document.getElementById("searchMainScript");
        var smcLogo = $thisSearchMainScriptComponent.dataset.smcLogo;
        var device = $thisSearchMainScriptComponent.dataset.device;
        var locale = $thisSearchMainScriptComponent.dataset.locale;
        var locales = locale.split("_");
        var language = locales[0];
        var country = locales[1];

        var swiftypeEngine = new SwiftypeEngine(locale);
        var generalSearch = new GeneralSearch();
        for (var engine in swiftypeEngine.getEngines()) {
            generalSearch.addEngine(engine, swiftypeEngine);
        }

        var paginator = {'product_catalogue': 10,'web_content':10,'smc_equivalent':10};
        var configSearch = {
            searchEquivalencesModule: new window.smc.SearchEquivalencesModule(),
            clickable: $button,
            focusable: $input,
            lang: language,
            country: country,
            searchResult:'searchResult',
            searchResultText:'searchResultText',
            searchResultNumber:'searchResultNumber',
            smcequivanlentNumber:'smcequivanlentNumber',
            webcontentNumber:'webcontentNumber',
            productNumber:'productNumber',
            resultsContainer: '#searchResultsContainer',
            tabMenuContainer: '#tabSearchResult',
            productTab:'#product_catalogue',
            smcEquivalentTab:'#smc_equivalent',
            webContentTab:'#web_content',
            paginationResultBar: '.pagination_showing',
            paginationjs: '.paginationjs',
            initNumber:'.js-search-init-page-number',
            finishPageNumber:'.js-search-finish-page-number',
            searchTotal:'.js-search-total',
            productsContainer:'products-container',
            productsContainerProducts:'product_catalogue .content',
            smcEquivalentContainer:'smc-equivalent-container',
            smcEquivalentContainerProducts:'smc-equivalent-container .content',
            webContentContainer:'web-content-container',
            webContentContainerProducts:'web_content .content',
            changeLen:'.changelen',
            pageSize:paginator,
            defaultShow:'js-predeterminated',
            enableLink:'.js-switftype-data',
            smcProductCatalogueTabLink: '.js-product-catalogue-link',
            smcWebContentTabLink: '.js-web-content-link',
            smcEquivalentLink: '.js-equivalent-data-link',
            mobileCssMenuItem:'.js-accordion-mobile',
            device:device,
            pagingIndex: ['product_catalogue','web_content'],
            emptyImageRoute:smcLogo,
            spinnerContainer:'.main-page-spinner',
            categorySelector:'js-category-filter',
            categories:[],
            enlageCategoriesButton:'.js-categories-all',
            resetButtonContainer:'.js-categories-reset',
            categoryContainer:'#web_content .js-categories-button-container',
            oldRearchResultResponse: oldRearchResultResponse,
            productsPageName: productsPageName,
            products: productsJson
        };

        generalSearch.init(configSearch,swiftypeEngine);

        var configSeneralSearch = {
            resultsContainer: 'searchResultsContainer',
            tabMenuContainer: 'tabSearchResult'
        };
        generalSearchNavigation.init(configSeneralSearch);
    });
</script>

<script id="equivalentHeaderTemplate" type="text/template">
    <div class="d-none d-md-block alert alert-primary equivalent-header mt-4" role="alert">
        <div class="text-center">
            <strong><@fmt.message key="search.equivalences.oneAlternativeFound"/> "{{term}}"</strong>
        </div>
        <div class="text-center"><@fmt.message key="search.equivalences.pleaseCheck"/></div>
    </div>
</script>

<script id="partialMatchHeaderTemplate" type="text/template">
    <div class="d-none d-md-block alert alert-primary equivalent-header mt-4" role="alert">
        <div class="text-center">
            {{message}}
        </div>
    </div>
</script>

<script id="equivalentFooterTemplate" type="text/template">
    <div class='card equivalent-footer mt-4'>
        <div class='p-2'>
            <h5 class='card-title'><strong><@fmt.message key="search.equivalences.comparisonDetails"/></strong></h5>
            <div><@fmt.message key="search.equivalences.note"/></div>
            <div><@fmt.message key="search.equivalences.featuresTakenIntoAccount"/></div>
            <ul class='list-inline'>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresCylinder.title"/>:</strong> <@fmt.message key="search.equivalences.featuresCylinder"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresTubing.title"/>:</strong> <@fmt.message key="search.equivalences.featuresTubing"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresFittings.title"/>:</strong> <@fmt.message key="search.equivalences.featuresFittings"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresFRL.title"/>:</strong> <@fmt.message key="search.equivalences.featuresFRL"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresValves.title"/>:</strong> <@fmt.message key="search.equivalences.featuresValves"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresGauges.title"/>:</strong> <@fmt.message key="search.equivalences.featuresGauges"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresCouplers.title"/>:</strong> <@fmt.message key="search.equivalences.featuresCouplers"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresControllers.title"/>:</strong> <@fmt.message key="search.equivalences.featuresControllers"/></li>
                <li class='list-inline-item'><strong><@fmt.message key="search.equivalences.featuresProcessValves.title"/>:</strong> <@fmt.message key="search.equivalences.featuresProcessValves"/></li>
            </ul>
            <div><@fmt.message key="search.equivalences.disclaimer"/></div>
        </div>
    </div>
</script>

<script id="catelogueProductRow" type="text/template">
    <div class="d-flex">
        <div class="col-3">
            <a href="{{url}}" data-result-number="{{resultNumber}}" data-page-number="{{pageNumber}}" data-tab-name="{{tabName}}"><img src="{{imageUrl}}" alt="{{productName}}"></a>
        </div>
        <div class="col-9"><p><a href="{{url}}" data-result-number="{{resultNumber}}" data-page-number="{{pageNumber}}" data-tab-name="{{tabName}}">{{productName}}</a></p>
            <div class="js-substring">
                {{body}}
            </div>
        </div>
    </div>
</script>
