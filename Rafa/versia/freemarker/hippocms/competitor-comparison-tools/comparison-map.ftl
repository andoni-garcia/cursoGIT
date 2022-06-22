<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.setBundle basename="competitorTools,partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems,comparisonMap,ProductToolbar"/>
<main id="CMcontenedor">
    <#include "./cm/_comparison-map-filters.ftl">
    <div  class="smc-main-container">
        <div class="row">
            <div class="col-lg-12 text-right">
                <div class="d-inline-block">
                    <div class="d-inline-block align-middle">
                        <label class="switch">
                            <input id="rodEndOptionsSwitchToggle" type="checkbox" class="primary" data-bind="click:$root.handleToggleSMCUnique">
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <label for="rodEndOptionsSwitchToggle" class="switch-label ml-2">
                        <@fmt.message key="comparisonmap.toggle"/>
                    </label>
                </div>
                <button id="cm-btn-filter" class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-4"  data-toggle="modal" data-target="#_comparisonMapFilters">
                    <@fmt.message key="comparisonmap.filter"/>
                    <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                    <i class="fa fa-filter"></i>
                </button>
                <button id="cm-btn-download" class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 ml-4 d-none" disabled data-bind="click:getExportComparisonInformation">
                    <@fmt.message key="partnumberconverter.download"/>
                    <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                    <i class="fade-icon__icon icon-download"></i>
                </button>
            </div>
        </div>
        <!--- Search Results List -->
        <div class="ssi-component mt-sm-1 mt-5" id= ${ssiTabId}>
            <div class="col-lg-12 p-2" id="ssi-container">
                <div class="cct-register-spinner" id="cm-loading-container" style="display:none">
                    <div class="overlay-inside eshop-box-rounded"></div>
                    <div class="spinner-inside">
                        <div class="bounce"></div>
                        <div class="bounce1"></div>
                        <div class="bounce2"></div>
                    </div>
                </div>
                <div class="row d-none" id="cm-notificationError">
                    <div class="col-lg-12">
                        <div class="alert alert-danger mt-3 w-100" role="alert">
                            <i class="fas fa-exclamation-triangle mr-2"></i> <@fmt.message key="partnumberconvert.error"/>
                        </div>
                    </div>
                </div>
                <div class="row" id="cm-notResults" style="display:none">
                    <div class="col-lg-12 ssi-component pagination_showing no-results-js">
                        <span><@fmt.message key="list.notResult"/></span>
                    </div>
                 </div>
                <!-- ko if:ComparisonDataAll().length>0 -->
                <div class="row" id="cm-results">
                    <div id="spares_accessories" class="col-lg-12 spares-accessories-container mt-4">
                        <div class="row pagination_showing align-items-center">
                            <div class="col-md-6 mt-10 mt-lg-0  ">
                                <!--   --->
                                <@fmt.message key="search.searchresult.paging.showing"/>
                                <span class="js-search-init-page-number" data-bind="text:RegistryIndexFrom"></span>
                                <!--   --->
                                <@fmt.message key="search.searchresult.paging.to"/>
                                <span class="js-search-finish-page-number" data-bind="text:RegistryIndexTo"></span>
                                <!--   --->
                                <@fmt.message key="search.searchresult.paging.of"/>
                                <span class="js-search-total" data-bind="text:TotalResults"></span>
                                <!--   --->
                                <@fmt.message key="search.searchresult.paging.entries"/>
                            </div>
                            <div class="col-md-6  mt-10 mt-lg-0 d-none d-sm-block text-right">
                                <@fmt.message key="search.searchresult.paging.display"/>
                                <a data-section='product_catalogue' data-len="10" href="#" data-bind="attr:{class:RegistryPerPage()!='10'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">10</a> |
                                <a data-section='product_catalogue' data-len="20" href="#" data-bind="attr:{class:RegistryPerPage()!='20'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">20</a> |
                                <a data-section='product_catalogue' data-len="50" href="#" data-bind="attr:{class:RegistryPerPage()!='50'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">50</a> |
                                <a data-section='product_catalogue' data-len="100" href="#" data-bind="attr:{class:RegistryPerPage()!='100'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">100</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row d-block accordion spares-accessories-result-container" id="cm-spares-accessories-result-container">
                    <div class="col-lg-12 mt-5">
                        <div class="cct-table">
                            <div class="cct-thead">
                                <div class="row">
                                    <div class="col-12 col-md-1 pr-0">
                                        <div class="custom-control custom-checkbox text-left">
                                        	<input type="checkbox" class="form-check-input d-none" id="cm_select_all">
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-3 pl-lg-0">
                                        <strong><@fmt.message key="comparisonmap.smcseries"/></strong>
                                    </div>
                                    <div class="col-12 col-md-4"><strong><@fmt.message key="comparisonmap.competitorseries"/></strong></div>
                                    <div class="col-12 col-md-3 p-md-0 p-lg-0"><strong><@fmt.message key="comparisonmap.advantages"/></strong></div>
                                    <div class="col-12 col-md-1"></div>
                                    </div>
                            </div>
                            <div class="cct-tbody">
                                <!-- ko foreach:{data:ComparisonDataAll()} -->
                                <#include "./cm/_comparison-map-data.ftl">
                                <!-- /ko -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="d-flex justify-content-center pagination-container pagination-container-js col-12 mt-20 mt-xl-0 pt-xl-3 p-0 pl-0 pl-md-0">
                                <div class="paginationjs container row justify-content-center">
                                    <div class="paginationjs-pages row justify-content-md-center mt-10">
                                        <ul>
                                            <!-- ko if:RegistryIndex()==1 -->
                                            <li class="paginationjs-prev paginationjs-first  list-inline-item">
                                                <i class="icon-arrow-double-left"></i>
                                            </li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()>1 -->
                                            <li class="paginationjs-prev paginationjs-first  list-inline-item">
                                                <a href="#" data-bind="click:showFirstPage,clickBubble: false"><i class="icon-arrow-double-left"></i></a>
                                            </li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()>1 -->
                                            <li class="paginationjs-prev  list-inline-item"><a href="#" data-bind="click:showPreviousPage,clickBubble: false"><i class="icon-arrow-single-left" style="font-size: 14px;"></i></a></li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()==1 -->
                                            <li class="paginationjs-prev  list-inline-item"><i class="icon-arrow-single-left" style="font-size: 14px;"></i></li>
                                            <!-- /ko -->
                                            <!-- ko foreach:{data:NumbersTotalResults} -->
                                                <li class="paginationjs-page list-inline-item">
                                                    <a data-bind="attr:{class:$parent.RegistryIndex()==$data?'paginationjs-link active':'paginationjs-link'},click:$parent.showCurrentPage, clickBubble:false,text:$data,clickBubble: false" href="#"></a>
                                                </li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()<NumbersTotalResults().length -->
                                            <li class="paginationjs-next  list-inline-item"><a href="#" data-bind="click:showNextPage,clickBubble: false"><i class="icon-arrow-single-right" style="font-size: 14px;"></i></a></li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()==NumbersTotalResults().length -->
                                            <li class="paginationjs-next  list-inline-item">
                                                <i class="icon-arrow-single-right" style="font-size: 14px;"></i>
                                            </li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()<NumbersTotalResults().length -->
                                            <li class="paginationjs-last  list-inline-item">
                                                <a href="#" data-bind="click:showLastPage,clickBubble: false"><i class="icon-arrow-double-right"></i></a>
                                            </li>
                                            <!-- /ko -->
                                            <!-- ko if:RegistryIndex()==NumbersTotalResults().length -->
                                            <li class="paginationjs-last  list-inline-item">
                                                <i class="icon-arrow-double-right"></i>
                                            </li>
                                            <!-- /ko -->
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="compare-tab-js hidden"></div>
                <!-- /ko -->
            </div>
        </div>
        <!--- /Search Results List -->
    </div>
</main>
<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="getCompetitorsDataCombo" resourceId="GET_COMPETITORS_DATA_COMBO"/>
<@hst.resourceURL var="getFamiliesDataCombo" resourceId="GET_FAMILIES_DATA_COMBO"/>
<@hst.resourceURL var="getSubFamiliesDataCombo" resourceId="GET_SUBFAMILIES_DATA_COMBO"/>
<@hst.resourceURL var="getSerieByCompetitorDataCombo" resourceId="GET_SERIE_BY_COMPETITOR_DATA_COMBO"/>
<@hst.resourceURL var="getComparisonDataAll" resourceId="GET_COMPARISON_DATA_ALL"/>
<@hst.resourceURL var="getBenefitsDataCombo" resourceId="GET_BENEFITS_DATA_COMBO"/>
<@hst.resourceURL var="getAdvantagesDataCombo" resourceId="GET_ADVANTAGES_DATA_COMBO"/>
<@hst.resourceURL var="getDisadvantagesDataCombo" resourceId="GET_DISADVANTAGES_DATA_COMBO"/>
<@hst.resourceURL var="getCompetitorsSeriesDataCombo" resourceId="GET_COMPETITORS_SERIES_DATA_COMBO"/>
<@hst.resourceURL var="getSmcSerieCombo" resourceId="GET_SMC_SERIE_COMBO"/>
<@hst.resourceURL var="exportComparisonInformation" resourceId="EXPORT_COMPARISON_INFORMATION"/>
<@hst.resourceURL var="getSuggestedPartNumbers" resourceId="GET_SUGGESTED_PART_NUMBERS"/>
<@hst.resourceURL var="getCombinedFilters" resourceId="GET_COMBINED_FILTERS"/>
<@hst.resourceURL var="logActionUrl" resourceId="LOG_ACTION"/>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/select/bootstrap-select.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script type="text/javascript">
        (function(window){
            window.getCompetitorsDataCombo = "${getCompetitorsDataCombo}";
            window.getFamiliesDataCombo = "${getFamiliesDataCombo}";
            window.actionUrl = "${actionURL}";
            window.getSubFamiliesDataCombo = '${getSubFamiliesDataCombo}';
            window.getSerieByCompetitorDataCombo='${getSerieByCompetitorDataCombo}';
            window.getComparisonDataAll='${getComparisonDataAll}';
            window.getBenefitsDataCombo='${getBenefitsDataCombo}';
            window.getAdvantagesDataCombo='${getAdvantagesDataCombo}';
            window.getDisadvantagesDataCombo='${getDisadvantagesDataCombo}';
            window.getCompetitorsSeriesDataCombo='${getCompetitorsSeriesDataCombo}';
            window.getSmcSerieCombo='${getSmcSerieCombo}';
            window.exportComparisonInformation='${exportComparisonInformation}';
            window.getSuggestedPartNumbers='${getSuggestedPartNumbers}';
            window.getCombinedFilters='${getCombinedFilters}';
            window.logActionUrl = "${logActionUrl}";
        }(window));
    </script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/comparisonCompetitorTools/comparisonMap/ComparisonMapViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>