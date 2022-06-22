<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.setBundle basename="competitorTools,partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems,comparisonMap,ProductToolbar"/>
<main id="PNcontenedor">
    <div  class="smc-main-container">
        <div class="row">
            <div class="col-lg-12">
            <!--- Search Filter PartNumber -->
                <form onsubmit="return false;">
                    <div class="row">
                        <div class="col-12 col-lg-8 col-md-12 mb-3 mb-md-3 mb-sm-3">
                            <select id="selectPickerSuggested" data-dropup-auto="false" class="selectpicker w-100 cct-selectpicker" multiple data-live-search="true" maxOptions="10" title="<@fmt.message key="partnumberconverter.suggestedSearch.placeholder"/>"
                            data-bind="selectPicker:true,options:ResultSuggestedSearch,valueAllowUnset:true"
                            >
                            </select>
                        </div>
                    </div>
                </form>
            <!--- /Search Filter PartNumber -->
            <!--- Search PartNumber -->
                <form onsubmit="return false;">
                    <div class="row">
                        <div class="col-lg-8 mb-3 mb-md-3 mb-sm-3">
                            <textarea rows="4" cols="30" class="form-control w-100"  data-bind="value:CompetitorPartNumberRefList" style="white-space: pre-wrap;" id="partnumberconverterSearchInput" placeholder="<@fmt.message key="partnumberconverter.search.description"/>"></textarea>
                            <div class="alert alert-danger mt-3 w-100 d-none" role="alert" id="notificationPartnumberconverterCodes">
                                  <i class="fas fa-exclamation-triangle mr-2"></i> <@fmt.message key="partnumberconverter.warningCodes"/>
                            </div>
                            <div class="alert alert-danger mt-3 w-100 d-none" role="alert" id="notificationPartnumberconverterExcessCodes">
                                  <i class="fas fa-exclamation-triangle mr-2"></i> <@fmt.message key="partnumberconverter.warningExcessCodes"/>
                            </div>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-2 mb-sm-3">
                            <button id="btn_searchCompetitorPartNumberResults" type="button" class="btn btn-primary w-100" data-bind="click:searchCompetitorPartNumberResults">
                            <@fmt.message key="partnumberconverter.search"/>
                            <i class="ml-2 fa fa-search"></i>
                            </button>
                        </div>
                        <div class="col-sm-12 col-md-6 col-lg-2">
                            <button id="btn_clearCompetitorPartNumberSearch" type="button" class="btn btn-outline-primary w-100" data-bind="click:clearCompetitorPartNumberSearch">
                            <@fmt.message key="partnumberconverter.clear"/>
                             <i class="ml-2 fa fa-times"></i>
                            </button>
                        </div>
                    </div>
                </form>
                <!--- /Search PartNumber -->
            </div>
        </div>
    </div>
    <!--- Search Results List -->
    <div class="ssi-component mt-sm-1 mt-5" id= ${ssiTabId}>
        <div class="col-lg-12 p-2" id="ssi-container">
            <div class="cct-register-spinner" id="pnc-loading-container" style="display:none">
                <div class="overlay-inside eshop-box-rounded"></div>
                <div class="spinner-inside">
                    <div class="bounce"></div>
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                </div>
            </div>
            <!--<div id="pnc-loading-container" style="display:none">
                <div class="col-lg-12">
                    <div class="add-to-basket-bar-spinner loading-container">
                        <#include "../../include/spinner.ftl">
                    </div>
                </div>
            </div>-->
            <div class="row d-none" id="notificationError">
                <div class="col-lg-12">
                    <div class="alert alert-danger mt-3 w-100" role="alert">
                        <i class="fas fa-exclamation-triangle mr-2"></i> <@fmt.message key="partnumberconvert.error"/>
                    </div>
                </div>
            </div>
            <div class="row" id="pn-notResults" style="display:none">
                <div class="col-lg-12 ssi-component pagination_showing no-results-js">
                    <span><@fmt.message key="list.notResult"/></span>
                </div>
            </div>
            <!-- ko if:CompetitorPartNumberResults()!=null -->
            <!-- ko if:CompetitorPartNumberResults().length> 0 -->
            <div class="row" id="pn-results">
                <div id="spares_accessories" class="col-lg-12 spares-accessories-container mt-4">
                    <div class="row pagination_showing align-items-center">
                        <div class="col-md-12 text-center mt-10 mt-lg-0 d-none d-sm-block">
                            <@fmt.message key="search.searchresult.paging.display"/>
                            <a data-section='product_catalogue' data-len="10" href="#" data-bind="attr:{class:RegistryPerPage()!='10'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">10</a> |
                            <a data-section='product_catalogue' data-len="20" href="#" data-bind="attr:{class:RegistryPerPage()!='20'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">20</a> |
                            <a data-section='product_catalogue' data-len="50" href="#" data-bind="attr:{class:RegistryPerPage()!='50'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">50</a> |
                            <a data-section='product_catalogue' data-len="100" href="#" data-bind="attr:{class:RegistryPerPage()!='100'?'changelen':'changelen active'},click:updateRegistryPerPage,clickBubble: false">100</a>
                        </div>
                        <div class="col-md-6 mt-10 mt-lg-0 text-center text-md-left">
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
                        <div class="col-md-6 mt-10 mt-lg-0 pl-md-0">
                            <div class="compare align-right justify-content-center d-flex justify-content-md-end">
                                <button id="btn_partnumberconverterExpand" class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 " disabled data-bind="click:handleExpandItems">
                                    <@fmt.message key="partnumberconverter.expand"/>
                                    <i id="iconExpand" class="fade-icon__icon icon-plus icon-expand"></i>
                                </button>
                                <button id="btn_partnumberconverterDownload" class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 ml-4" disabled data-bind="click:getCompetitorPartNumberResultsExcell">
                                <@fmt.message key="partnumberconverter.download"/>
                                <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                                <i class="fade-icon__icon icon-download"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row d-block accordion spares-accessories-result-container" id="pn-spares-accessories-result-container">
                <div class="col-lg-12 mt-5">
                    <div class="cct-table">
                        <div class="cct-thead">
                            <div class="row">
                            <div class="col-12 col-md-1 pr-0">
                                <div class="custom-control custom-checkbox text-left">
                                <input type="checkbox" class="form-check-input" id="select_all">
                                </div>
                            </div>
                            <div class="col-12 col-md-3 pl-lg-0">
                                <strong><@fmt.message key="partnumberconverter.competitorPN"/></strong>
                            </div>
                            <div class="col-12 col-md-3"><strong><@fmt.message key="partnumberconverter.SMCPN"/></strong></div>
                            <div class="col-12 col-md-3"><strong><@fmt.message key="partnumberconverter.SMCPNsales"/></strong></div>
                            <div class="col-12 col-md-2"></div>
                            </div>
                        </div>
                        <div class="cct-tbody" data-bind="template: { name: 'partNumberConverterDataTemplate', foreach:CompetitorPartNumberResults}"></div>
                        <script id="partNumberConverterDataTemplate" type="text/html">
                            <#include "./pnc/_part-number-converter-data.ftl">
                        </script>
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
            <!-- /ko -->
        </div>
    </div>
    <!--- /Search Results List -->
</main>
<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.include ref="part-number-converter"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="competitorAllResultsUrl" resourceId="GET_SMC_COMPETITORS_DATA_ALL"/>
<@hst.resourceURL var="suggestedPartNumbers" resourceId="GET_SUGGESTED_PART_NUMBERS"/>
<@hst.resourceURL var="competitorAllResultsExcellUrl" resourceId="EXPORT_PART_NUMBER"/>
<@hst.resourceURL var="logActionUrl" resourceId="LOG_ACTION"/>
<@hst.headContribution category="scripts">
    <script type="text/javascript">
        (function(window){
            window.renderUrl = "${componentRenderingURL}";
            window.resourceUrl = "${serveResourceURL}";
            window.actionUrl = "${actionURL}";
            window.competitorAllResultsUrl = '${competitorAllResultsUrl}';
            window.suggestedPartNumbers='${suggestedPartNumbers}'
            window.competitorAllResultsExcellUrl='${competitorAllResultsExcellUrl}';
            window.logActionUrl = "${logActionUrl}";
        }(window));
    </script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/comparisonCompetitorTools/partNumberConverter/PartNumberConverterUtils.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/comparisonCompetitorTools/partNumberConverter/PartNumberConverterViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
