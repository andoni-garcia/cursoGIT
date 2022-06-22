<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="ssiLink" siteMapItemRefId="ssi"/>
<#compress>

<@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@hst.link var="search" siteMapItemRefId="search"/>

<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.orderByPartNumber" var="labelOrderByPartNumber"/>
<@fmt.message key="eshop.orderByDescription" var="labelOrderByDescription"/>
<@fmt.message key="eshop.orderByFamily" var="labelOrderByFamily"/>
<@fmt.message key="eshop.orderBySerie" var="labelOrderBySerie"/>

<@fmt.message key="eshop.mssg.datatableInfoMessage" var="labelMssgDatatableInfoMessage"/>
<@fmt.message key="eshop.mssg.recordsPerPage" var="labelMssgRecordsPerPage"/>
<@fmt.message key="eshop.mssg.noProductsAvailable" var="labelMssgNoProductsAvailable"/>
<@fmt.message key="eshop.mssg.orderByVarLbl" var="labelMssgOrderByVarLbl"/>
<@fmt.message key="eshop.mssg.partNumberLbl" var="labelMssgPartnumberLbl"/>
<@fmt.message key="eshop.mssg.customerPartNumberLbl" var="labelMssgCustomerPartnumberLbl"/>
<@fmt.message key="eshop.mssg.productDescriptionLbl" var="labelMssgProductDescriptionLbl"/>
<@fmt.message key="eshop.mssg.descriptionLbl" var="labelMssgDescriptionLbl"/>
<@fmt.message key="eshop.mssg.mustSelectElement" var="labelMssgMustSelectElement"/>
<@fmt.message key="eshop.mssg.sureDeleteElements" var="labelMssgSureDeleteElements"/>
<@fmt.message key="eshop.mssg.oneOrMoreCanNotBeAdded" var="labelMssgOneOrMoreCanNotBeAdded"/>
<@fmt.message key="eshop.mssg.noneCanBeAdded" var="labelMssgNoneCanBeAdded"/>
<@fmt.message key="eshop.mssg.canNotExportExcel" var="labelMssgCanNotExportExcel"/>
<@fmt.message key="eshop.mssg.canNotExportExcelAllProducts" var="labelMssgCanNotExportExcelAllProducts"/>
<@fmt.message key="eshop.mssg.canNotCreatePDF" var="labelMssgCanNotCreatePDF"/>
<@fmt.message key="eshop.mssg.canNotCreatePDFAllProducts" var="labelMssgCanNotCreatePDFAllProducts"/>
<@fmt.message key="eshop.mssg.processCanTakeSeveralMinutes" var="labelMssgProcessCanTakeServeralMinutes"/>
<@fmt.message key="eshop.mssg.moreProductsThanPDFLimit" var="labelMssgMoreProductsThanPDFLimit"/>
<@fmt.message key="eshop.mssg.otherImportProcessLaunched" var="labelMssgOtherImportProcessLaunched"/>
<@fmt.message key="eshop.all" var="labelAll"/>
<@fmt.message key="favourites.toFavouritesSuccess" var="labelToFavouritesSuccess"/>
<@fmt.message key="favourites.toFavouritesError" var="labelToFavouritesError"/>
</#compress>

<main id="contenedor" class="smc-main-container eshop">
        <div class="container mb-30">
            <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
        </div>
        <div class="container">
            <div class="cmseditlink">
            </div>
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="ssi.title"/></h2>
        </div>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                <!-- SSI products -->

                    <!-- ko foreach: families    -->
                <!-- /ko -->
                    <!-- Filters -->
                    <form onsubmit="return false;">
                        <div class="form-row">

                            <div class="form-group col-md-3">
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary dropdown-toggle w-100" type="button" data-toggle="dropdown" data-bind="text: filterFamily().name"><span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu w-100">
                                    <!-- ko foreach: families    -->
                                        <li><a class="a-ko" data-bind="text: name, click: $parent.getFamilies.bind($data, id, name)"></a></li>
                                    <!-- /ko -->
                                    </ul>
                                </div>
                            </div>

                            <div class="form-group col-md-3">
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary dropdown-toggle w-100" type="button" data-toggle="dropdown" data-bind="text: filterSubfamily().name"><span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu w-100">
                                    <!-- ko foreach: subfamilies    -->
                                        <li><a class="a-ko" data-bind="text: name, click: $parent.setSubfamilyFilter.bind($data, id, name)"></a></li>
                                    <!-- /ko -->
                                    </ul>
                                </div>
                            </div>

                            <div class="form-group col-md-3">
                                <input class="form-control w-100" data-bind="value:filterPartnumber, valueUpdate:'keyup'" id="searchInput" placeholder="<@fmt.message key="eshop.partnumber"/>" type="text">
                            </div>
                            <div class="form-group col-md-3">
                                <button type="button" class="btn btn-primary w-100" data-bind="click: filterProducts"><@fmt.message key="eshop.search"/></button>
                            </div>
                        </div>
                    </form>
                    <div class="form-row">
                        <div class="col-12">
                            <ul class="eshop pagination">
                                <li class="page-item disabled"><a class="page-link" href=" #"><@fmt.message key="eshop.display"/></a></li>
                                <li class="page-item"><a class="a-ko page-link active" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[0]), css: {active: datatable.iDisplayLength().value == 10}" style="border: none !important; border-radius: 5px;">10</a></li>
                                <li class="page-item"><a class="a-ko page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[1]), css: {active: datatable.iDisplayLength().value == 20}">20</a></li>
                                <li class="page-item"><a class="a-ko page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[2]), css: {active: datatable.iDisplayLength().value == 50}">50</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row align-self-end">
                        <span class="col-md-7 align-self-end"><ik-datatable-showing params="viewModel : ssiViewModel"></ik-datatable-showing></span>

                        <div class="col-md-5">
                            <div class="dropdown smc-select">
                                <select id="my-basket-products-order" data-bind="options: ssiOrders, optionsText: 'text', optionsValue: 'order', value: selectedOrder, event:{ change: filterProducts.bind($data)}">
                                </select>
                            </div>
                        </div>
                    </div>
                    <smc-spinner-inside-element params="loading: datatable.loading"></smc-spinner-inside-element>

                    <!-- SSI product box -->
                    <!-- ko foreach: elements    -->

                        <div class="row m-0 my-2 favourite-product-box border border-secondary eshop-box-rounded" data-bind="attr: {id: favouriteId}" id="favouriteId">
                        <div class="col-12 nopadding">
                            <div class="row m-3">
                                <div class="col-12 nopadding">
                                    <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                                    <a class="text-muted partnumber-href" data-bind="text: partNumber, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partNumber())" target="_blank"></a>
                                    <!-- ko if: $data.info() -->
                                    <span class="text-dark description" data-bind="text: $data.info().name"></span>
                                    <!-- /ko -->
                                    <!-- <span class="text-dark" data-bind="text: partnumber().description"></span> -->
                                </div>
                            </div>
                            <div class="row m-3 product-selection-item">
                                <div class="col-2">
                                    <!-- ko if: $data.info() && $data.info().mediumImage -->
                                        <img data-bind="attr: {src: $data.info().mediumImage}">
                                    <!-- /ko -->
                                    <!-- ko if: !$data.info() || !$data.info().mediumImage -->
                                        <img src="${noImage}">
                                    <!-- /ko -->
                                </div>
                                <div class="col-xl-10 align-self-end">
                                    <div class="row">
                                        <div class="col-md-5 p-0 pr-md-3 pl-xl-3">
                                        <!-- ko if: $data.info() -->

                                        <!-- ko if: $data.info().family || $data.info().subfamily -->
                                            <div class="text"> <@fmt.message key="ssi.family"/> </div>
                                        <!-- /ko -->

                                        <!-- ko if: $data.info().family -->
                                        <strong class="text-dark description" data-bind="text: $data.info().family.name"></strong>
                                        <!-- /ko -->
                                        <!-- ko if: $data.info().family && $data.info().subfamily -->
                                         -
                                        <!-- /ko -->
                                        <!-- ko if: $data.info().subfamily -->
                                        <strong class="text-dark description" data-bind="text: $data.info().subfamily.name"></strong>
                                        <!-- /ko -->
                                        <div class="text"> <@fmt.message key="ssi.serie"/> </div>
                                        <strong class="text-dark description" data-bind="text: $data.info().serie"></strong>
                                        <!-- /ko -->
                                        </div>
                                        <div class="col-md-7 p-0">
                                            <div class="row w-100 m-0">
                                                <div class="col-4 align-self-end text-left p-0">
                                            <#if isTechnicalUser || isAdvancedUser || isProfessionalUser >
                                                    <span class="text-dark heading-09"> <@fmt.message key="eshop.quantity"/> </span>
                                                    <input type="number" data-bind="value: $data.quantity" max="999" class="form-control" value="1">
                                            </#if>
                                                </div>
                                                <div class="col-8 align-self-end text-right pr-0">
                                                <#if isTechnicalUser || isAdvancedUser || isProfessionalUser >
                                                    <button type="button" data-bind="click: $parent.addToBasket.bind($data, $data)" class="btn btn-primary w-100"><@fmt.message key="eshop.addToBasket"/></button>
                                                <#else>
                                                    <button type="button" data-bind="click: $parent.addToBasket.bind($data, $data)" class="btn btn-primary w-100"><@fmt.message key="eshop.addToList"/></button>
                                                </#if>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                      <!-- ko if: $data.hasInformation() && !$data .isPersonalized()-->
                                    <div class="row">
                                        <div class="col-12 eshop-option-tabs align-self-end  p-0 pr-md-3 pl-xl-3">
                                            <ul class="eshop-tabs">
                                                <li class="heading-09 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-toggle="collapse" data-bind="attr: {href: '#details' + $index()}, click: $parent.getDetails.bind($data, $data)"><@fmt.message key="eshop.showDetails"/></a></li>
                                                <li class="heading-09 more-info-tab">
                                                    <a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partNumber(), $index())">
                                                        <@fmt.message key="eshop.moreInfo"/>
                                                    </a>
                                                    <div class="spinner-inside more-info-tab-item ko-hide" data-bind="attr: {id: 'spinner' + $index()}">
                                                        <div class="bounce"></div>
                                                        <div class="bounce1"></div>
                                                        <div class="bounce2"></div>
                                                    </div>
                                                    <div class="collapse more-info-tab-item" data-bind="attr: {id: 'moreInfo' + $index()}"></div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!-- /ko -->
                                </div>
                            </div>
                            <div class="eshop-tab-line" style=""></div>
                            <div class="eshop-tabs">
                                <section class="container collapse more-info-mobile" data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>
                                <section class="container collapse" data-bind="attr: {id: 'details' + $index()}">
                                    <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                                        <div class="simple-collapse__bodyInner">
                                             <div class="row">
                                             <!-- ko if: !$data.status() || $data.status() === 'UPDATING' -->
                                                <div class="col-12">
                                                    <div class="spinner-inside">
                                                        <div class="bounce"></div>
                                                        <div class="bounce1"></div>
                                                        <div class="bounce2"></div>
                                                    </div>
                                                </div>
                                            <!-- /ko -->
                                             <!-- ko if: $data.details() != null -->
                                                <div class="col-12">
                                                 <!-- ko foreach: details().detailsPart1 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: ssiViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: ssiViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->

                                                <!-- ko foreach: details().detailsPart2 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: ssiViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: ssiViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->
                                                </div>
                                            <!-- /ko -->
                                            <!-- ko if: $data.status() === 'ERROR' -->
                                            <div class="row col-12">
                                                <div class="col-12">
                                                    <div class="alert alert-danger" role="alert">
                                                        <@fmt.message key="eshop.detailsErrorMssg"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /ko -->
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                            <!-- /ko -->

                    <ik-datatable-empty params="viewModel : ssiViewModel"></ik-datatable-empty>
                    <ik-datatable-pager params="viewModel : ssiViewModel"></ik-datatable-pager>

                    <!-- Favourites options -->
                    <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                        <div class="row m-3 w-100">
                            <div class="col-12 nopadding">
                                <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, checked : 'allChecked', click: 'selectAll'}} --><!-- /ko -->
                                <span class="text-muted"><@fmt.message key="eshop.selected"/></span>
                            </div>
                        </div>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: addToBasketItems"><i class="fas fa-cart-plus"></i> <@fmt.message key="eshop.toBasket"/></a>
                        <a data-bind="click: addToFavouriteSelecteds.bind($data)" class="a-ko col-md-3 mb-3 heading-09"><i class="fas fa-share"></i> <@fmt.message key="eshop.toFavourites"/></a>
                        <a data-bind="click: exportFile.bind($data, 'xlsx')" class="a-ko col-md-3 mb-3 heading-09" style="color: '#90a4ae'"><i class="fas fa-file-excel"></i> <@fmt.message key="eshop.XLS"/></a>
                        <a data-bind="click: exportFile.bind($data, 'pdf')" class="a-ko col-md-3 mb-3 heading-09" style="color: '#90a4ae'"><i class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDF"/></a>
                    </div>


            </div>
        </div>
        </div>

        <div id="data-container"></div>
</main>

<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="ssiServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="ssiFamiliesListUrl" resourceId="GET_FAMILIES"/>
<@hst.resourceURL var="ssiDetailsUrl" resourceId="GET_DETAILS"/>
<@hst.resourceURL var="ssiExportUrl" resourceId="EXPORT_SSI"/>

<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;

    var ssiServerListUrl;
	var ssiFamiliesListUrl;
    var ssiDetailsUrl;
    var moreInfoLink;
    var ssiExportUrl;

	var permissions = {};

	var SSI_CONFIGURATION_VARIABLES = {};
	var SSI_MESSAGES = {};

	var token;

	var ssiViewModel;

    var orderByPartNumber = '${labelOrderByPartNumber?js_string}';
    var orderByDescription = '${labelOrderByDescription?js_string}';
    var orderByFamily = '${labelOrderByFamily?js_string}';
    var orderBySerie = '${labelOrderBySerie?js_string}';

</script>

</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/libs/underscore-min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/ssi-functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.withDatatable.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.datatables.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.checkbox.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/SsiViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/SsiRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
 <script type="text/javascript">

 (function($){
	//	SSI_CONFIGURATION_VARIABLES['MODE'] = 'folder';
		SSI_CONFIGURATION_VARIABLES['SSI_URL'] = '${ssiServerListUrl}';
	})(jQuery);

    (function(context, $){
        SSI_MESSAGES = {
           "datatableInfoMessage" : '${labelMssgDatatableInfoMessage?js_string}',
            "recordsPerPage" : '${labelMssgRecordsPerPage?js_string}',
            "noProductsAvailable" : '${labelMssgNoProductsAvailable?js_string}',
            "orderByVarLbl" : '${labelMssgOrderByVarLbl?js_string}',
            "partNumberLbl" : '${labelMssgPartnumberLbl?js_string}',
            "customerPartNumberLbl" : '${labelMssgCustomerPartnumberLbl?js_string}',
            "productDescriptionLbl" : '${labelMssgProductDescriptionLbl?js_string}',
            "descriptionLbl" : '${labelMssgDescriptionLbl?js_string}',
            "mustSelectElement" : '${labelMssgMustSelectElement?js_string}',
            "sureDeleteElements" : '${labelMssgSureDeleteElements?js_string}',
            "oneOrMoreCanNotBeAdded" : '${labelMssgOneOrMoreCanNotBeAdded?js_string}',
            "noneCanBeAdded" : '${labelMssgNoneCanBeAdded?js_string}',
            "canNotExportExcel" : '${labelMssgCanNotExportExcel?js_string}',
            "canNotExportExcelAllProducts" : '${labelMssgCanNotExportExcelAllProducts?js_string}',
            "canNotCreatePDF" : '${labelMssgCanNotCreatePDF?js_string}',
            "canNotCreatePDFAllProducts" : '${labelMssgCanNotCreatePDFAllProducts?js_string}',
            "processCanTakeSeveralMinutes" : '${labelMssgProcessCanTakeServeralMinutes?js_string}',
            "moreProductsThanPDFLimit" : '${labelMssgMoreProductsThanPDFLimit?js_string}',
            "otherImportProcessLaunched" : '${labelMssgOtherImportProcessLaunched?js_string}',
            "allFamilies": '${labelAll?js_string}',
            "favouritesSuccess": '${labelToFavouritesSuccess?js_string}',
            "favouritesError": '${labelToFavouritesError?js_string}'
        };

	})(window, jQuery);

	$(document).ready(function() {
        var searchInput = document.getElementById('searchInput');
		renderUrl = "${componentRenderingURL}";
		resourceUrl = "${serveResourceURL}";
		refreshTechnicalInfo = "${updating}";
		actionUrl = "${actionURL}";

        token = '${_csrf.token}';

		//Knockout
		ssiServerListUrl = '${ssiServerListUrl}';
		ssiFamiliesListUrl = '${ssiFamiliesListUrl}';
        ssiDetailsUrl = '${ssiDetailsUrl}';
        ssiExportUrl = '${ssiExportUrl}';

		ko.di.register(SSI_CONFIGURATION_VARIABLES,"SsiConfigurationVariables");

		ko.di.register(SSI_MESSAGES,"SsiMessages");

		ko.di.register(permissions,"Permissions");

		ssiViewModel = new SsiViewModel();
        ko.applyBindings(ssiViewModel, document.getElementById("contenedor"));

        searchInput.onkeyup = function(e){
            if(e.keyCode === 13){
                ssiViewModel.filterProducts();
            }
        }
	});
</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/ssi-functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>