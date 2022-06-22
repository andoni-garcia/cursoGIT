<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.setBundle basename="eshop"/>
<@hst.link var="search" siteMapItemRefId="search"/>

<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>
<@fmt.message key="eshop.save" var="labelSave"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="mybaskets.editErrorMssg" var="labelEditErrorMssg"/>
<@fmt.message key="mybaskets.editSuccessMssg" var="labelEditSuccessMssg"/>
<@fmt.message key="mybaskets.deleteErrorMssg" var="labelDeleteErrorMssg"/>
<@fmt.message key="mybaskets.deleteSuccessMssg" var="labelDeleteSuccessMssg"/>
<@fmt.message key="mybaskets.successLoadBasket" var="labelSuccessLoadBasket"/>
<@fmt.message key="mybaskets.errorLoadBasket" var="labelErrorLoadBasket"/>
<@fmt.message key="mybaskets.errorLoadEmptyBasket" var="labelErrorLoadEmptyBasket"/>
<@fmt.message key="eshop.orderByDate" var="labelOrderByDate"/>
<@fmt.message key="eshop.orderByComments" var="labelOrderByComments"/>
<@fmt.message key="eshop.orderByDescription" var="labelOrderByDescription"/>
<@fmt.message key="mybaskets.loadBasketMssg" var="labelLoadBasketMssg"/>
<@fmt.message key="mybaskets.loadBasketTitle" var="labelLoadBasketTitle"/>
<@fmt.message key="mybaskets.deleteTitle" var="labelDeleteTitle"/>
<@fmt.message key="mybaskets.deleteEmptyMessage" var="labelDeleteEmptyMessage"/>
<@fmt.message key="mybaskets.deleteMessage" var="labelDeleteMessage"/>
<@fmt.message key="mybaskets.hideEmptyMssg" var="labelHideEmptyMssg"/>
<@fmt.message key="mybaskets.hideEmptyTitle" var="labelHideEmptyTitle"/>
<@fmt.message key="mybaskets.hideErrorMssg" var="labelHideErrorMssg"/>
<@fmt.message key="mybaskets.hideSuccess" var="labelHideSuccess"/>
<@fmt.message key="mybaskets.showAllTitle" var="labelShowAllTitle"/>
<@fmt.message key="mybaskets.showAllMssg" var="labelShowAllMssg"/>
<@fmt.message key="mybaskets.showAllSuccess" var="labelShowAllSuccess"/>

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
</#compress>
<div class="container">
    <div class="mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="cmseditlink">
    </div>
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="mybaskets.title"/></h2>
    <strong>${principalFullname}</strong>
    <h1 class="heading-02 heading-main">${principalName}</h1>
</div>
<br>
<div class="container" id="contenedor">
    <div class="row">
        <div class="col-12">
            <!-- Order status filters -->
            <div class="row mb-4">
                <div class="col-lg-9 col-sm-8 mb-3">
                    <input class="form-control" id="searchInput" type="text" placeholder="<@fmt.message key="eshop.searchPlaceholder"/>" data-bind="value: filterSearch, valueUpdate: 'keyup'">
                </div>
                <div class="col-lg-3 col-sm-4 mb-3 align-self-end">
                    <button type="button" class="btn btn-primary w-100" data-bind="click: resetAndSearch"><@fmt.message key="eshop.showAll"/></button>
                </div>
            </div>
        </div>
    </div>

    <div class="form-row">
        <div class="col-12">
            <ul class="eshop pagination">
                <li class="page-item disabled"><a class="page-link" href=" #"><@fmt.message key="eshop.display"/></a></li>
                <li class="page-item"><a class="page-link active" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[0]), css: {active: datatable.iDisplayLength().value == 10}" href="#" style="border: none !important; border-radius: 5px;">10</a></li>
                <li class="page-item"><a class="page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[1]), css: {active: datatable.iDisplayLength().value == 20}" href=" #">20</a></li>
                <li class="page-item"><a class="page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[2]), css: {active: datatable.iDisplayLength().value == 50}" href=" #">50</a></li>
            </ul>
        </div>
    </div>
    <div class="row align-self-end">
        <span class="col-md-7 align-self-end"><ik-datatable-showing params="viewModel : myBasketsViewModel"></ik-datatable-showing></span>

            <div class="col-md-5">
                <div class="dropdown smc-select">
                    <select id="my-basket-products-order" data-bind="options: orderTypes, optionsText: 'text', optionsValue: 'order',  value: selectedOrder, event:{ change: filterBaskets.bind($data)}">
                    </select>
                </div>
            </div>
    </div>

    <div class="row mt-3">
        <div class="col-12">
            <!-- My baskets table -->
            <div class="table-responsive-lg">
                <smc-spinner-inside-element params="loading: datatable.loading"></smc-spinner-inside-element>

                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">
                                <input id="2156" class="select-favourite" type="checkbox" disabled>
                            </th>
                            <th scope="col"><@fmt.message key="mybaskets.date"/></th>
                            <th scope="col"><@fmt.message key="mybaskets.description"/></th>
                            <th scope="col"><@fmt.message key="mybaskets.comments"/></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <!-- ko foreach: elements -->
                        <tr>
                            <td>
                            <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                            </td>
                            <td data-bind="text: $data.orderDate"></td>
                            <td data-bind="text: $data.description"></td>
                            <td data-bind="text: $data.comments"></td>
                            <td class="align-right">
                                <div class="text-nowrap" data-bind="click: $parent.toggleDetails" style="display: inline">
                                            <a class="status-details"><@fmt.message key="eshop.details"/></a>
                                            <span class="icon-angle-right" data-bind="css: {'icon-angle-right': !showDetails(), 'icon-angle-down': showDetails}"></span>
                                </div>
                                <i class="fas fa-upload ml-3 pointer" data-bind="click: $parent.loadBasket.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="myBaskets.loadTooltip"/>"></i>
                                <i class="fas fa-share-square ml-3 pointer" data-bind="click: shareBasketViewModel.init.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="myBaskets.shareTooltip"/>"></i>
                                <i class="fas fa-edit ml-3 pointer" data-bind="click: $root.showEditModal.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="myBaskets.editTooltip"/>"></i>
                            </td>
                        </tr>
                        <tr data-bind="visible: showDetails">
                            <td colspan="5">
                            <!-- basket product lines -->
                                <div class="pl-5 pr-3">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col"><@fmt.message key="eshop.partnumber"/></th>
                                                <th scope="col"><@fmt.message key="eshop.productDescription"/></th>
                                                <th scope="col"><@fmt.message key="eshop.shortQty"/></th>
                                                <th scope="col" class="align-right"><@fmt.message key="eshop.listPrice"/></th>
                                                <th scope="col" class="align-right"><@fmt.message key="eshop.totalPrice"/></th>
                                                <th scope="col" class="align-right"><@fmt.message key="eshop.netPrice"/></th>
                                                <th scope="col" class="align-right"><@fmt.message key="eshop.totalPrice"/></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <!-- ko foreach: $data.products()    -->
                                            <tr>
                                                <td scope="col">
                                                    <a class="text-muted partnumber-href" data-bind="text: partnumberCode, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, $data.partnumberCode)" target="_blank"></a>
                                                </td>
                                                <td scope="col" data-bind="text: $data.name"></td>
                                                <td scope="col" data-bind="text: $data.quantity"></td>
                                                <td scope="col" data-bind="text: $data.listPrice+ ' ' + $data.currency" class="align-right"></td>
                                                <td scope="col" data-bind="text: $data.totalListPrice + ' ' + $data.currency" class="align-right"></td>
                                                <td scope="col" data-bind="text: $data.netPrice+ ' ' + $data.currency" class="align-right"></td>
                                                <td scope="col"  class="align-right">
                                                    <label data-bind="text: $data.totalNetPrice+ ' ' + $data.currency"></label>
                                                </td>
                                            </tr>
                                        <!-- /ko -->
                                        </tbody>
                                    </table>
                                </div>
                                <div class="pl-5">
                                <!-- Total -->
                                    <div class="cart-grid__footer">
                                        <div class="total-gray-box">
                                            <div class="row">
                                                <div class="col-6">
                                                    <label><@fmt.message key="eshop.totalNetPrice"/></label><br>
                                                    <label class="text-muted"><@fmt.message key="eshop.totalListPrice"/></label>
                                                </div>
                                                <div class="col-6 align-right">
                                                    <label data-bind="text:  $data.totalBasketNetPrice() + ' ' + $data.currency()"></label><br>
                                                    <label class="text-muted" data-bind="text: $data.totalBasketListPrice() + ' ' + $data.currency()"></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    <!-- /ko -->
                    </tbody>
                </table>
            </div>

            <div class="form-row">
                <div class="col-12">
                    <ul class="eshop pagination">
                        <ik-datatable-empty params="viewModel : myBasketsViewModel"></ik-datatable-empty>
                        <ik-datatable-pager params="viewModel : myBasketsViewModel"></ik-datatable-pager>
                    </ul>
                </div>
            </div>

            <!-- My basket options -->
            <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                <div class="row m-3 w-100">
                    <div class="col-12 nopadding">
                        <smc-select-all-check params="list: $root.elements, field: 'checked'"><#include "../components/selectall-check.ftl"/></smc-select-all-check>
                    </div>
                    <div class="col-md-4">
                        <a class="a-ko heading-09" data-bind="click: deleteMyBaskets.bind($data)"><i class="fas fa-trash"></i> <@fmt.message key="mybaskets.deleteBaskets"/></a>
                    </div>
                    <div class="col-md-4">
                        <a class="a-ko heading-09" data-bind="click: setHideMyBaskets.bind($data)"><i class="fas fa-eye-slash"></i> <@fmt.message key="mybaskets.hiddeBaskets"/></a>
                    </div>
                    <div class="col-md-4">
                        <a class="a-ko heading-09" data-bind="click: showAllMyBaskets.bind($data)"><i class="fas fa-eye"></i> <@fmt.message key="mybaskets.showBaskets"/></a>
                        <span class="heading-09" data-bind="text: hiddenCount">
                    </div>
                </div>

            </div>
        </div>
    </div>

<#include "./my-baskets-edit.ftl">
<#include "./my-baskets-modal.ftl">
<#include "./my-baskets-empty.ftl">

</div>



<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="myBasketsServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="myBasketsListUrl" resourceId="GET_MY_BASKETS"/>
<@hst.resourceURL var="basketProductsListUrl" resourceId="GET_STORED_PRODUCTS"/>
<@hst.resourceURL var="mybasketUpdate" resourceId="UPDATE_MY_BASKET"/>
<@hst.resourceURL var="mybasketDelete" resourceId="DELETE_MY_BASKETS"/>
<@hst.resourceURL var="mybasketLoad" resourceId="LOAD_MY_BASKET"/>
<@hst.resourceURL var="mybasketsHide" resourceId="HIDE_MY_BASKETS"/>
<@hst.resourceURL var="mybasketShowAll" resourceId="SHOW_ALL_MY_BASKETS"/>
<@hst.resourceURL var="mybasketHiddenCount" resourceId="COUNT_HIDDEN_BASKETS"/>


<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;

    var myBasketsServerListUrl;
	var myBasketsListUrl;
    var basketProductsListUrl;
    var mybasketUpdate;
    var mybasketDelete;
    var mybasketLoad;
    var mybasketsHide;
    var mybasketShowAll;
    var mybasketHiddenCount;

	var permissions = {};

	var MY_BASKETS_MESSAGES = {};

	var token;

	var myBasketsViewModel;

    var cancelBtn = '${labelCancel?js_string}';
    var updateBtn = '${labelUpdate?js_string}';
    var deleteBtn = '${labelDelete?js_string}';
    var saveBtn = '${labelSave?js_string}';
    var acceptBtn = '${labelAccept?js_string}';

    var myBasketEditError = '${labelEditErrorMssg?js_string}';
    var myBasketEditSuccess = '${labelEditSuccessMssg?js_string}';
    var myBasketDeleteError = '${labelDeleteErrorMssg?js_string}';
    var myBasketDeleteSuccess = '${labelDeleteSuccessMssg?js_string}';
    var successLoadBasket = '${labelSuccessLoadBasket?js_string}';
    var errorLoadBasket = '${labelErrorLoadBasket?js_string}';
    var errorLoadEmptyBasket = '${labelErrorLoadEmptyBasket?js_string}';
    var orderByDate = '${labelOrderByDate?js_string}';
    var orderByComments = '${labelOrderByComments?js_string}';
    var orderByDescription = '${labelOrderByDescription?js_string}';
    var loadBasketMssg = '${labelLoadBasketMssg?js_string}';
    var loadBasketTitle = '${labelLoadBasketTitle?js_string}';
    var deleteTitle = '${labelDeleteTitle?js_string}';
    var deleteEmptyMssg = '${labelDeleteEmptyMessage?js_string}';
    var deleteMssg = '${labelDeleteMessage?js_string}';
    var hideEmptyMssg = '${labelHideEmptyMssg?js_string}';
    var hideEmptyTitle = '${labelHideEmptyTitle?js_string}';
    var hideErrorMssg = '${labelHideErrorMssg?js_string}';
    var hideSuccess = '${labelHideSuccess?js_string}';
    var showAllTitle = '${labelShowAllTitle?js_string}';
    var showAllMssg = '${labelShowAllMssg?js_string}';
    var showAllSuccess = '${labelShowAllSuccess?js_string}';

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
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/my-baskets/MyBasketsViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/my-baskets/MyBasketsRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
 <script type="text/javascript">

 (function($){
//		SSI_CONFIGURATION_VARIABLES['SSI_URL'] = '${ssiServerListUrl}';
	})(jQuery);

    (function(context, $){
        MY_BASKETS_MESSAGES = {
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
            "otherImportProcessLaunched" : '${labelMssgOtherImportProcessLaunched?js_string}'

        };

	})(window, jQuery);

	$(document).ready(function() {
		renderUrl = "${componentRenderingURL}";
		resourceUrl = "${serveResourceURL}";
		refreshTechnicalInfo = "${updating}";
		actionUrl = "${actionURL}";

        token = '${_csrf.token}';

		//Knockout
		myBasketsServerListUrl = '${myBasketsServerListUrl}';
		myBasketsListUrl = '${myBasketsListUrl}';
		basketProductsListUrl = '${basketProductsListUrl}';
        mybasketUpdate = '${mybasketUpdate}';
        mybasketDelete = '${mybasketDelete}';
        mybasketLoad = '${mybasketLoad}';
        mybasketsHide = '${mybasketsHide}';
        mybasketShowAll = '${mybasketShowAll}';
        mybasketHiddenCount = '${mybasketHiddenCount}';

		ko.di.register(MY_BASKETS_MESSAGES,"MyBasketsMessages");

		myBasketsViewModel = new MyBasketsViewModel();
        ko.applyBindings(myBasketsViewModel, document.getElementById("contenedor"));
        $('#searchInput').keyup(function(){
            myBasketsViewModel.filterBaskets();
        })
	});
</script>
</@hst.headContribution>