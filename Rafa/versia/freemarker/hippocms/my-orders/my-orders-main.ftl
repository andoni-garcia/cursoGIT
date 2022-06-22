<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="search" siteMapItemRefId="search"/>

<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>
<@fmt.message key="eshop.save" var="labelSave"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="myorders.deleteErrorMssg" var="labelDeleteErrorMssg"/>
<@fmt.message key="myorders.successDeleteOrder" var="labelSuccessDeleteOrder"/>
<@fmt.message key="myorders.errorLoadOrder" var="labelErrorLoadOrder"/>
<@fmt.message key="myorders.successLoadOrder" var="labelSuccessLoadOrder"/>
<@fmt.message key="myorders.errorLoadEmptyOrder" var="labelErrorLoadEmptyOrder"/>
<@fmt.message key="eshop.orderByDate" var="labelOrderByDate"/>
<@fmt.message key="eshop.orderBySmcOrderNumber" var="labelOrderBySmcOrderNumber"/>
<@fmt.message key="eshop.orderByCustomerOrderNumber" var="labelOrderByCustomerOrderNumber"/>
<@fmt.message key="myorders.deleteEmptyMessage" var="labelDeleteEmptyMessage"/>
<@fmt.message key="myorders.deleteTitle" var="labelDeleteTitle"/>
<@fmt.message key="myorders.hideEmptyMssg" var="labelHideEmptyMssg"/>
<@fmt.message key="myorders.hideEmptyTitle" var="labelHideEmptyTitle"/>
<@fmt.message key="myorders.deleteMssg" var="labelDeleteMssg"/>
<@fmt.message key="myorders.loadOrderTitle" var="labelLoadOrderTitle"/>
<@fmt.message key="myorders.loadOrderMssg" var="labelLoadOrderMssg"/>
<@fmt.message key="myorders.hideErrorMssg" var="labelHideErrorMssg"/>
<@fmt.message key="myorders.hideSuccessMssg" var="labelHideSuccessMssg"/>
<@fmt.message key="myorders.showAllTitle" var="labelShowAllTitle"/>
<@fmt.message key="myorders.showAllMssg" var="labelShowAllMssg"/>
<@fmt.message key="myorders.showAllSuccessMssg" var="labelShowAllSuccessMssg"/>

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

<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />
</#compress>

<div class="container">
    <div class="mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="cmseditlink">
    </div>
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="myorders.title"/></h2>
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
        <span class="col-md-7 align-self-end"><ik-datatable-showing params="viewModel : myOrdersViewModel"></ik-datatable-showing></span>

           <div class="col-md-5">
                <div class="dropdown smc-select">
                    <select id="my-orders-order" data-bind="options: orderTypes, optionsText: 'text', optionsValue: 'order',  value: selectedOrder, event:{ change: filterOrders.bind($data)}">
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
                            <th scope="col"><@fmt.message key="myorders.orderDate"/></th>
                            <th scope="col"><@fmt.message key="myorders.smcOrderNumber"/></th>
                            <th scope="col"><@fmt.message key="myorders.customerOrderNumber"/></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <!-- ko foreach: elements    -->
                        <!-- Basket header -->
                        <tr>
                            <td>
                            <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                            </td>
                            <td data-bind="text: $data.orderDate"></td>
                            <td data-bind="text: $data.smcOrderNumber"></td>
                            <td data-bind="text: $data.customerOrderNumber"></td>

                            <td class="align-right">
                                 <div class="text-nowrap" data-bind="click: $parent.toggleDetails" style="display: inline">
                                            <a class="status-details"><@fmt.message key="eshop.details"/></a>
                                            <span class="icon-angle-right" data-bind="css: {'icon-angle-right': !showDetails(), 'icon-angle-down': showDetails}"></span>
                                </div>
                                <i class="fas fa-upload ml-3 pointer" data-bind="click: $parent.loadOrder.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="myOrders.loadTooltip"/>"></i>
                            </td>
                        </tr>
                        <!-- Basket details -->
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
                                                <td>
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
                                                    <label data-bind="text: $data.totalOrderNetPrice() + ' ' +  $data.currency()"></label><br>
                                                    <label class="text-muted" data-bind="text: $data.totalOrderListPrice() + ' ' + $data.currency()"></label>
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
                       <ik-datatable-empty params="viewModel : myOrdersViewModel"></ik-datatable-empty>
                       <ik-datatable-pager params="viewModel : myOrdersViewModel"></ik-datatable-pager>
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
                        <a href="#" class="heading-09" data-bind="click: $root.deleteMyOrders.bind($data)"><i class="fas fa-trash"></i><@fmt.message key="myorders.deleteBtn"/></a>
                    </div>
                    <div class="col-md-4">
                        <a href="#" class="heading-09" data-bind="click: $root.setHideMyOrders.bind($data)"><i class="fas fa-eye-slash"></i> <@fmt.message key="myorders.hideBtn"/></a>
                    </div>
                    <div class="col-md-4">
                        <a href="#" class="heading-09" data-bind="click: $root.setAllVisible.bind($data)"><i class="fas fa-eye"></i> <@fmt.message key="myorders.showHiddenBtn"/></a>
                        <span class="heading-09" data-bind="text: hiddenCount">
                    </div>
                </div>

            </div>
        </div>
    </div>
    <#include "./my-orders-modal.ftl">
    <#include "./my-orders-empty.ftl">
</div>

<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="myOrdersServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="myOrderListUrl" resourceId="GET_STORED_ORDERS"/>
<@hst.resourceURL var="orderProductsListUrl" resourceId="GET_STORED_ORDER_PRODUCTS"/>
<@hst.resourceURL var="myorderDelete" resourceId="DELETE_STORED_ORDERS"/>
<@hst.resourceURL var="myorderLoad" resourceId="LOAD_STORED_ORDER"/>
<@hst.resourceURL var="myorderShowAll" resourceId="SHOW_ALL_STORED_ORDERS"/>
<@hst.resourceURL var="myorderHide" resourceId="HIDE_STORED_ORDERS"/>
<@hst.resourceURL var="myorderHiddenCount" resourceId="COUNT_HIDDEN_ORDERS"/>

<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;

    var myOrdersServerListUrl;
	var myOrderListUrl;
    var orderProductsListUrl;
    var myordersUpdate;
    var myorderDelete;
    var myorderLoad;
    var myorderShowAll;
    var myorderHide;
    var myorderHiddenCount;

	var permissions = {};

	var MY_ORDERS_MESSAGES = {};

	var token;

	var myOrdersViewModel;

    var cancelBtn = '${labelCancel?js_string}';
    var updateBtn = '${labelUpdate?js_string}';
    var deleteBtn = '${labelDelete?js_string}';
    var saveBtn = '${labelSave?js_string}';
    var acceptBtn = '${labelAccept?js_string}';

    var myOrderDeleteError = '${labelDeleteErrorMssg?js_string}';
    var successDeleteOrder = '${labelSuccessDeleteOrder?js_string}';
    var errorLoadOrder = '${labelErrorLoadOrder?js_string}';
    var successLoadOrder = '${labelSuccessLoadOrder?js_string}';

    var errorLoadEmptyOrder = '${labelErrorLoadEmptyOrder?js_string}';

    var orderByDate = '${labelOrderByDate?js_string}';
    var orderBySmcOrderNumber = '${labelOrderBySmcOrderNumber?js_string}';
    var orderByCustomerOrderNumber  = '${labelOrderByCustomerOrderNumber?js_string}';

    var deleteEmptyMssg = '${labelDeleteEmptyMessage?js_string}';
    var deleteEmptyTitle = '${labelDeleteTitle?js_string}';
    var hideEmptyMssg = '${labelHideEmptyMssg?js_string}';
    var hideEmptyTitle = '${labelHideEmptyTitle?js_string}';
    var deleteMssg = '${labelDeleteMssg?js_string}';
    var loadTitle = '${labelLoadOrderTitle?js_string}';
    var loadMssg = '${labelLoadOrderMssg?js_string}';
    var hideErrorMssg = '${labelHideErrorMssg?js_string}';
    var hideSuccessMssg = '${labelHideSuccessMssg?js_string}';
    var showAllTitle = '${labelShowAllTitle?js_string}';
    var showAllMssg = '${labelShowAllMssg?js_string}';
    var showAllSuccessMssg = '${labelShowAllSuccessMssg?js_string}';
</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/libs/underscore-min.js"/>" type="text/javascript"></script>
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
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/my-orders/MyOrdersViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/my-orders/MyOrdersRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
 <script type="text/javascript">


    (function(context, $){
        MY_ORDERS_MESSAGES = {
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
		myOrdersServerListUrl = '${myOrdersServerListUrl}';
		myOrderListUrl = '${myOrderListUrl}';
		orderProductsListUrl = '${orderProductsListUrl}';
        myorderDelete = '${myorderDelete}';
        myorderLoad = '${myorderLoad}';
        myorderShowAll = '${myorderShowAll}';
        myorderHide = '${myorderHide}';
        myorderHiddenCount = '${myorderHiddenCount}';

		ko.di.register(MY_ORDERS_MESSAGES,"MyOrdersMessages");

		myOrdersViewModel = new MyOrdersViewModel();
        ko.applyBindings(myOrdersViewModel, document.getElementById("contenedor"));
        $('#searchInput').keyup(function(){
            myOrdersViewModel.filterOrders();
        })
	});
</script>
</@hst.headContribution>