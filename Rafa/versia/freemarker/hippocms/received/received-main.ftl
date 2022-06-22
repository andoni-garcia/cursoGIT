<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>
<@fmt.message key="eshop.save" var="labelSave"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>

<@fmt.message key="eshop.orderByDate" var="labelOrderByDate"/>
<@fmt.message key="eshop.orderBySender" var="labelOrderBySender"/>
<@fmt.message key="eshop.orderByDescription" var="labelOrderByDescription"/>


<@fmt.message key="received.acceptModalTitle" var="labelAcceptModalTitle"/>
<@fmt.message key="received.acceptOneModalMssg" var="labelAcceptOneModalMssg"/>
<@fmt.message key="received.acceptManyModalMssg" var="labelAcceptManyModalMssg"/>
<@fmt.message key="received.deleteEmptyMessage" var="labelDeleteEmptyMessage"/>
<@fmt.message key="received.acceptEmptyMessage" var="labelAcceptEmptyMessage"/>
<@fmt.message key="received.acceptSuccessMessage" var="labelAcceptSuccessMessage"/>
<@fmt.message key="received.acceptErrorMessage" var="labelAcceptErrorMessage"/>
<@fmt.message key="received.deleteSuccessMessage" var="labelDeleteSuccessMessage"/>
<@fmt.message key="received.deleteErrorMessage" var="labelDeleteErrorMessage"/>
<@fmt.message key="received.loadSuccessMessage" var="labelLoadSuccessMessage"/>
<@fmt.message key="received.loadErrorMessage" var="labelLoadErrorMessage"/>
<@fmt.message key="received.loadModalTitle" var="labelLoadModalTitle"/>
<@fmt.message key="received.loadModalMssg" var="labelLoadModalMssg"/>

</#compress>

<div class="container">
    <div class="mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="cmseditlink">
    </div>
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="received.title"/></h2>
    <strong>${principalFullname}</strong>
    <h1 class="heading-02 heading-main">${principalName}</h1>
</div>
<br>
<div class="container" id="contenedor">

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
        <span class="col-md-7 align-self-end"><ik-datatable-showing params="viewModel : receivedViewModel"></ik-datatable-showing></span>

           <div class="col-md-5">
                <div class="dropdown smc-select">
                    <select id="received-order" data-bind="options: orderTypes, optionsText: 'text', optionsValue: 'order',  value: selectedOrder, event:{ change: filterReceived.bind($data)}">
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
                            <th scope="col"><@fmt.message key="received.description"/></th>
                            <th scope="col"><@fmt.message key="received.sender"/></th>
                            <th scope="col"><@fmt.message key="received.date"/></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                    <!-- ko foreach: elements -->
                        <tr>
                            <td>
                            <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                            </td>
                            <td data-bind="text: $data.description"></td>
                            <td data-bind="text: $data.sender"></td>
                            <td data-bind="text: $data.orderDate"></td>
                            <td class="align-right">
                                <!-- ko if: hasComments -->
                                <div class="text-nowrap" data-bind="click: $parent.toggleDetails" style="display: inline">
                                            <a class="status-details"><@fmt.message key="received.comments"/></a>
                                            <span class="icon-angle-right" data-bind="css: {'icon-angle-right': !showDetails(), 'icon-angle-down': showDetails}"></span>
                                </div>
                                <!-- /ko -->
                                <i class="fas fa-save ml-3 pointer" data-bind="click: $root.acceptReceived.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="received.saveTooltip"/>"></i>
                                <i class="fas fa-shopping-cart ml-3 pointer" data-bind="click: $parent.loadReceived.bind($data, $data)" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="received.saveLoadTooltip"/>"></i>
                                <!--<i class="fas fa-share-square ml-3 pointer" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="myBaskets.shareTooltip"/>"></i>-->
                            </td>
                        </tr>
                        <tr data-bind="visible: showDetails">
                            <td colspan="5">
                                <span class="p-5" data-bind="text: $data.comments"> </span>
                            </td>
                        </tr>
                    <!-- /ko -->
                    </tbody>
                </table>
            </div>

            <div class="form-row">
                <div class="col-12">
                    <ul class="eshop pagination">
                       <ik-datatable-empty params="viewModel : receivedViewModel"></ik-datatable-empty>
                       <ik-datatable-pager params="viewModel : receivedViewModel"></ik-datatable-pager>
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
                        <a href="#" class="heading-09" data-bind="click: deleteReceiveds.bind($data)"><i class="fas fa-trash"></i> <@fmt.message key="received.deleteBaskets"/></a>
                    </div>
                    <div class="col-md-4">
                        <a href="#" class="heading-09" data-bind="click: acceptReceiveds.bind($data)"><i class="fas fa-save"></i> <@fmt.message key="received.saveReceiveds"/></a>
                    </div>

                </div>

            </div>
        </div>
    </div>



</div>



<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>

<@hst.resourceURL var="receivedListUrl" resourceId="GET_RECEIVED_ELEMENTS"/>
<@hst.resourceURL var="receivedDelete" resourceId="DELETE_RECEIVED_ELEMENTS"/>
<@hst.resourceURL var="receivedLoad" resourceId="LOAD_RECEIVED_BASKET"/>
<@hst.resourceURL var="receivedAccept" resourceId="ACCEPT_RECEIVED_ELEMENTS"/>


<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;

    var receivedListUrl;
	var receivedDelete;
    var receivedLoad;
    var receivedAccept;


	var permissions = {};

	var RECEIVED_MESSAGES = {};

	var token;

	var receivedViewModel;

    var cancelBtn = '${labelCancel?js_string}';
    var updateBtn = '${labelUpdate?js_string}';
    var deleteBtn = '${labelDelete?js_string}';
    var saveBtn = '${labelSave?js_string}';
    var acceptBtn = '${labelAccept?js_string}';

    var orderByDate = '${labelOrderByDate?js_string}';
    var orderBySender = '${labelOrderBySender?js_string}';
    var orderByDescription = '${labelOrderByDescription?js_string}';

    var acceptModalTitle = '${labelAcceptModalTitle?js_string}';
    var acceptOneModalMssg = '${labelAcceptOneModalMssg?js_string}';
    var acceptManyModalMssg = '${labelAcceptManyModalMssg?js_string}';
    var deletEmptyMessage = '${labelDeleteEmptyMessage?js_string}';
    var acceptEmptyMessage = '${labelAcceptEmptyMessage?js_string}';
    var acceptSuccessMessage = '${labelAcceptSuccessMessage?js_string}';
    var acceptErrorMessage = '${labelAcceptErrorMessage?js_string}';
    var deleteSuccessMessage = '${labelDeleteSuccessMessage?js_string}';
    var deleteErrorMessage = '${labelDeleteErrorMessage?js_string}';
    var loadSuccessMessage = '${labelLoadSuccessMessage?js_string}';
    var loadErrorMessage = '${labelLoadErrorMessage?js_string}';
    var loadModalTitle = '${labelLoadModalTitle?js_string}';
    var loadModalMssg = '${labelLoadModalMssg?js_string}';

</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.withDatatable.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.checkbox.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/received/ReceivedViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/received/ReceivedRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
 <script type="text/javascript">


    (function(context, $){
        RECEIVED_MESSAGES = {
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

        receivedListUrl = '${receivedListUrl}';
        receivedDelete = '${receivedDelete}';
        receivedAccept = '${receivedAccept}';
        receivedLoad = '${receivedLoad}';


        token = '${_csrf.token}';

		//Knockout

		ko.di.register(RECEIVED_MESSAGES,"ReceivedMessages");

		receivedViewModel = new ReceivedViewModel();
        ko.applyBindings(receivedViewModel, document.getElementById("contenedor"));

	});
</script>
</@hst.headContribution>