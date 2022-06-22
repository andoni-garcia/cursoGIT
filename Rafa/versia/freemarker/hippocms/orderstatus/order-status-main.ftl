<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="orderStatusLink" siteMapItemRefId="orderStatus"/>

<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />

<#-- Values -> 0: All, 1: List Price, 2: Net Price, 3: Hide  -->
<@security.authentication property="principal.priceColumns" var="principalPriceColumns" />
<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.mssg.datatableInfoMessage" var="labelMssgDatatableInfoMessage"/>
<@fmt.message key="eshop.mssg.recordsPerPage" var="labelMssgRecordsPerPage"/>
<@fmt.message key="eshop.mssg.noProductsAvailable" var="labelMssgNoProductsAvailable"/>
<@fmt.message key="eshop.mssg.orderByVarLbl" var="labelMssgOrderByVarLbl"/>
<@fmt.message key="eshop.status" var="labelStatus"/>
<@fmt.message key="myorders.orderDate" var="labelOrderDate"/>
<@fmt.message key="orderstatus.blocked" var="labelBlocked"/>
<@fmt.message key="orderstatus.underPreparation" var="labelUnderPreparation"/>
<@fmt.message key="orderstatus.delivered" var="labelDelivered"/>
<@fmt.message key="orderstatus.invoiced" var="labelInvoiced"/>
<@fmt.message key="orderstatus.canceled" var="labelCanceled"/>

<@fmt.message key="orderstatus.noOrderStatuses" var="labelNoOrderStatuses"/>
<@fmt.message key="orderstatus.fromBiggerThanTo" var="labelFromBiggerThanTo"/>
<@fmt.message key="orderstatus.lessThanToday" var="labelLessThanToday"/>
<@fmt.message key="orderstatus.onlyLastYear" var="labelOnlyLastYear"/>

<@fmt.message key="eshop.dateFormat" var="labelDateFormat"/>
<@fmt.message key="orderstatus.invalidFormat" var="labelInvalidFormat"/>
<#assign labelDateInvalidFormat="${labelDateFormat}: ${labelInvalidFormat}"/>


<main id="order-status-main" class="smc-main-container eshop">
    <div class="container mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="container">
        <div class="cmseditlink">
        </div>
        <h2 class="heading-08 color-blue mt-20"><@fmt.message key="eshop.orderStatus"/></h2>
        <strong>${principalFullname}</strong>
        <h1 class="heading-02 heading-main">${principalName}</h1>
    </div>
    <br>

    <div class="container">
        <div id="orderStatusTable">
            <div class="row">
                <div class="col-12">

                    <!-- Order status filters -->
                    <div class="row mb-4">
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.dateFrom"/></label>
                            <input class="form-control" id="inputDateFrom" type="text"
                                data-bind="datepicker:{maxDate : '+0D', dateFormat: '${currentFormatDate}'}, value: formDateFrom, submit: datatable.refresh">
                               <!-- data-bind="datepicker:{minDate : '-1Y', maxDate : '+0D', dateFormat: '${currentFormatDate}'}, value: formDateFrom, submit: datatable.refresh"> -->
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.dateTo"/></label>
                            <input class="form-control" id="inputDateTo" type="text"
                                data-bind="datepicker:{maxDate : '+0D', dateFormat: '${currentFormatDate}'}, value: formDateTo, submit: datatable.refresh">
                                <!-- data-bind="datepicker:{minDate : '-1Y', maxDate : '+0D', dateFormat: '${currentFormatDate}'}, value: formDateTo, submit: datatable.refresh"> -->
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.statusFrom"/></label>
                            <div class="dropdown smc-select">
                                <select  id="statusFrom" data-bind="value: datatable.filter.filterStatusFrom, submit: datatable.refresh">
                                    <option value="20"><@fmt.message key="order.underPreparation"/></option>
                                    <option value="60"><@fmt.message key="order.delivered"/></option>
                                    <option value="70"><@fmt.message key="order.invoiced"/></option>
                                    <option value="90"><@fmt.message key="order.cancelled"/></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.statusTo"/></label>
                            <div class="dropdown smc-select">
                                <select id="statusTo" data-bind="value: datatable.filter.filterStatusTo, submit: datatable.refresh">
                                    <option value="44"><@fmt.message key="order.underPreparation"/></option>
                                    <option value="66"><@fmt.message key="order.delivered"/></option>
                                    <option value="77"><@fmt.message key="order.invoiced"/></option>
                                    <option value="99"><@fmt.message key="order.cancelled"/></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.searchBy"/></label>
                            <div class="dropdown smc-select">
                                <select id="searchBy" data-bind="value: datatable.filter.filterSearchBy, submit: datatable.refresh">
                                    <option value="0"><@fmt.message key="eshop.partnumber"/></option>
                                    <option value="1"><@fmt.message key="myorders.customerOrderNumber"/></option>
                                    <option value="2"><@fmt.message key="myorders.smcOrderNumber"/></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3">
                            <label class="heading-09 mb-0"><@fmt.message key="eshop.value"/></label>
                            <input class="form-control" id="inputValue" type="text"
                                data-bind="value: datatable.filter.filterValue, valueUpdate: 'keyup', submit: datatable.refresh">
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3 align-self-end">
                            <button type="button" class="btn btn-primary w-100" data-bind="click: search()"><@fmt.message key="eshop.search"/></button>
                            <!-- <button type="button" class="btn btn-primary w-100" data-bind="click: datatable.resetPageAndRefresh"><@fmt.message key="eshop.search"/></button> -->
                        </div>
                        <div class="col-lg-3 col-sm-6 mb-3 align-self-end">
                            <button type="button" class="btn btn-primary w-100" data-bind="click: lastNDays.bind($data, 60)"><@fmt.message key="eshop.lastSixtyDays"/></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pagination size -->
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

            <!-- Datatables record selector component -->
            <div class="row align-self-end">
                <span class="col-md-7 align-self-end">
                    <ik-datatable-showing params="viewModel : orderStatusViewModel"></ik-datatable-showing>
                </span>
                <div class="col-md-5">
                    <div class="dropdown smc-select">
                        <ik-datatable-sorting params="viewModel: $data, clear: false">
                            <div class="ikSelectContainer ikLightSelect" data-bind="with: context">
                                <span><@fmt.message key="eshop.orderBy"/> </span>
                                <select data-bind="options: sorting.sortColumns , value: sorting.iSortCol, optionsText : 'displayText'">
                                        <option value="">▼ <@fmt.message key="myorders.orderDate"/></option>
                                        <option value="">▲ <@fmt.message key="myorders.orderDate"/></option>
                                        <option value="">▼ <@fmt.message key="eshop.status"/></option>
                                        <option value="">▲ <@fmt.message key="eshop.status"/></option>
                                </select>
                            </div>
                            <div data-bind="visible: clear" style="clear: both; display: none;"></div>
                        </ik-datatable-sorting>
                    </div>
                </div>
            </div>

            <!-- Datatable markup -->
            <div class="ikTable ikSimpleTable mt-3">


                <!-- Order status table -->
                <div class="table-responsive-lg position-relative">
                    <smc-spinner-inside-element params="loading: datatable.loading"></smc-spinner-inside-element>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">
                                    <div class="status_icon"></div>
                                </th>
                            	<#if selectedErp=DYNAMICS_ERP>
                            		<th scope="col"><@fmt.message key="eshop.status"/></th>
                            	</#if>
                                <th scope="col"><@fmt.message key="myorders.smcOrderNumber"/></th>
                                <th scope="col"><@fmt.message key="myorders.customerOrderNumber"/></th>
                                <th scope="col"><@fmt.message key="myorders.orderDate"/></th>
                                <#if selectedErp!=DYNAMICS_ERP>
                                    <th scope="col" class="table-crd"><@fmt.message key="order.customerRequestedDate"/></th>
                                    <th scope="col" class="table-crd"><@fmt.message key="order.confirmedDeliveryDate"/></th>
                                </#if>
                                    <th scope="col"></th>
                            </tr>
                        </thead>
                        <!-- ko if: datatable.initializating() -->
                        <tbody>
                            <tr>
                                <td class="datatable-loading-height"></td>
                            </tr>
                        </tbody>
                        <!-- /ko -->
                        <!-- ko if: !datatable.initializating() -->
                        <tbody style="display:none" data-bind="visible: !datatable.initializating()">
                        <!-- TODO: Convert in component -->

                             <!-- ko foreach: elements.paginated	 -->
                            <tr>
                                <th scope="row">
                                    <div class="status_icon status_22" data-bind="attr: {title: statusTitle}, css: 'status_' + status()"></div>
                                </th>
                            	<#if selectedErp=DYNAMICS_ERP>
                            		<td data-bind="text: statusTitleDesc"></td>
                            	</#if>
                                <td data-bind="text: orderNumber"></td>
                                <td data-bind="text: customerOrderNumber"></td>
                                <td data-bind="text: confirmedDate()"></td>
                                <#if selectedErp!=DYNAMICS_ERP>
                                    <td data-bind="text: customerDate()"></td>
                                    <td data-bind="text: confirmedDeliveryDate()"></td>
                                </#if>
                                <td>
                                    <div class="text-nowrap" data-bind="click: $parent.toggleDetails">
                                        <a class="status-details"><@fmt.message key="eshop.details"/></a>
                                        <span class="icon-angle-right" data-bind="css: {'icon-angle-right': !showDetails(), 'icon-angle-down': showDetails}"></span>
                                    </div>
                                </td>

                            </tr>

                            <!-- DETAILS -->
                            <tr data-bind="visible: showDetails" style="display: none;">
                                <#if selectedErp=DYNAMICS_ERP>
                                	<td colspan="8">
                               	<#else>
                               		<td colspan="7">
								</#if>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <!-- No elements -->
                                            <div class="ikNoElementsRow" data-bind="visible: items().length == 0" style="display: none;">
                                                <div>No elements available</div>
                                            </div>
                                            <table class="table" data-bind="visible: (items().length > 0)">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">
                                                            <div class="status_icon"></div>
                                                        </th>
                                                        <th scope="col"><@fmt.message key="eshop.partnumber"/></th>
                                                        <th scope="col"><@fmt.message key="eshop.productDescription"/></th>
                                                        <th scope="col" class="table-crd"><@fmt.message key="order.customerRequestedDate"/></th>
                                                        <th scope="col" class="table-crd"><@fmt.message key="order.confirmedDeliveryDate"/></th>
                                                        <th scope="col"><@fmt.message key="eshop.qty"/>.</th>
                                                        <#if principalPriceColumns == "0" || principalPriceColumns == "2">
                                                        <th scope="col"><@fmt.message key="eshop.netPrice"/></th>
                                                        <th scope="col"><@fmt.message key="eshop.totalPrice"/></th>
                                                        </#if>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- ko foreach: items	 -->
                                                    <tr>
                                                        <td>
                                                            <div class="status_icon status_22" data-bind="attr: {title: $root.getStatusTitle(status)}, css: 'status_' + status"></div>
                                                        </td>
                                                        <td data-bind="text: name" class="text-nowrap"></td>
                                                        <td><span data-bind="text: description, attr: {title: description}"></span></td>
                                                        <td data-bind="text: requestedDeliveryDate"></td>
                                                        <td data-bind="text: confirmedDeliveryDate"></td>
                                                        <td class="text-right" data-bind="text: quantity"></td>
                                                        <#if principalPriceColumns == "0" || principalPriceColumns == "2">
                                                        <td data-bind="text: netPrice"></td>
                                                        <td data-bind="text: total"></td>
                                                        </#if>
                                                    </tr>
                                                    <!-- /ko -->
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="cart-grid__footer">

                                        <div class="row orderstatus-endbox">

                                            <div class="col-6 col-md-5">

                                                <div class="total-gray-box float-none border-0">

                                                    <div data-bind="visible: (items().length > 0)">
                                                        <strong class="ikInfoBoxLabel"><@fmt.message key="order.deliveryMethod"/></strong>
                                                        <div>
                                                        <#if selectedErp?? && selectedErp=="MOVEX">
                                                            <!-- ko foreach: deliveries	 -->
                                                            <div class="ml-10">
                                                                <span data-bind="text: mody"></span> -
                                                                <!-- ko if: trackingUrl -->
                                                                    <a target="_blank" data-bind="text: dlix, attr: { href: trackingUrl }"></a>
                                                                <!-- /ko -->
                                                                <!-- ko ifnot: trackingUrl -->
                                                                    <span data-bind="text: dlix"></span>
                                                                <!-- /ko -->

                                                            </div>
                                                            <!-- /ko -->
                                                            <li data-bind="visible: deliveries().length == 0">-</li>
                                                         <#elseif selectedErp?? && selectedErp==DYNAMICS_ERP>
                                                         <!-- ko foreach: deliveries	 -->
                                                            <div class="ml-10">
                                                                <span data-bind="text: mody"></span>
                                                            </div>
                                                            <!-- /ko -->
                                                            <li data-bind="visible: deliveries().length == 0">-</li>
                                                         </#if>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="col-md-2"></div>

                                            <div class="col-6 col-md-5">

                                                <div class="orderstatus-totalbox">
                                                    <div class="row orderstatus-endbox-total">
                                                        <div class="col-md-6 text-right text-md-left">
                                                            <span class="ikInfoBoxLabel"><@fmt.message key="eshop.totalNetPrice"/></span>
                                                        </div>
                                                        <div class="col-md-6 text-right">
                                                            <span data-bind="html: formattedGrandTotal"></span>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>

                                    </div>

                                </td>

                            </tr>
                            <!-- /ko -->
                            <!-- END DETAILS -->

                        </tbody>
                        <!-- /ko -->
                    </table>
                </div>

            </div>

            <!-- Component to be shown when no elements meet criteria -->
            <ik-datatable-empty params="viewModel : $data" data-bind="visible: failure() == false">
                <div class="ikNoElementsRow" data-bind="with: context">
                    <div data-bind="html: datatable.noElementsMsg, visible: elements().length == 0 && !datatable.initializating()" style="display: none;"><@fmt.message key="eshop.mssg.noProductsAvalaible"/></div>
                    <div data-bind="visible: elements().length == 0 && datatable.initializating()" style="display: none;">&nbsp;</div>
                </div>
            </ik-datatable-empty>

            <div data-bind="visible: failure() == true">
                <@fmt.message key="eshop.mssg.contactSMC"/>
            </div>

            <!-- Datatable pager component -->
            <ik-datatable-pager params="viewModel : $data"></ik-datatable-pager>


        </div>

        <!-- Order status leyend -->
        <div class="row p-3 mt-3">

            <!-- CREATE ORDER STATUS REPORT ON PDF -->
            <div class="col-md-3 col-sm-6">
                <div class="status_icon status_33"></div>
                <div class="status_legend"><@fmt.message key="order.underPreparation"/></div>
            </div>

            <!-- CREATE ORDER STATUS REPORT ON PDF -->
            <div class="col-md-3 col-sm-6">
                <div class="status_icon status_66"></div>
                <div class="status_legend"><@fmt.message key="order.delivered"/></div>
            </div>

            <!-- CREATE ORDER STATUS REPORT ON PDF -->
            <div class="col-md-3 col-sm-6">
                <div class="status_icon status_77"></div>
                <div class="status_legend"><@fmt.message key="order.invoiced"/></div>
            </div>

            <!-- CREATE ORDER STATUS REPORT ON PDF -->
            <div class="col-md-3 col-sm-6">
                <div class="status_icon status_99"></div>
                <div class="status_legend"><@fmt.message key="order.cancelled"/></div>
            </div>
        </div>

        <!-- Basket options -->
        <!--
        -->
        <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
            <div class="row m-3 w-100">
                <div class="col-md-6 p-0">
                    <a data-bind="click: exportOrderStatus.bind($data, 'pdf'), css: {'link-disabled' : datatable.pages() == 0 || datatable.loading()}" class="a-ko heading-09 export-order-status link-disabled" disabled="disabled"><i class="fas fa-file-pdf"></i> <@fmt.message key="order.status.createReportPdf"/></a>
                </div>
                <div class="col-md-6 p-0">
                    <a data-bind="click: exportOrderStatus.bind($data, 'xlsx'), css: {'link-disabled' : datatable.pages() == 0 || datatable.loading()}" class="a-ko heading-09 export-order-status link-disabled" disabled="disabled"><i class="fas fa-file-excel"></i> <@fmt.message key="order.status.createReportXls"/></a>
                </div>
            </div>
        </div>

    </div>

</main>

<@hst.resourceURL var="orderStatusServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="orderStatusExportToXlsxUrl" resourceId="EXPORT_ORDER_STATUS"/>

<@hst.headContribution category="htmlHead">
<script>

    var token;

    var orderStatusServerListUrl;
    var orderStatusExportToXlsxUrl;

    var ORDER_STATUS_MESSAGES;
    var ORDER_STATUS_CONFIGURATION_VARIABLES;
    var orderStatusViewModel;

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
<!-- <@hst.headContribution category="scripts"> -->
<!--    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.daterange.js"/>" type="text/javascript"></script> -->
<!-- </@hst.headContribution> -->
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Datepicker.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/order-status/OrderStatusViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/order-status/OrderStatusRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script type="text/javascript">

    token = '${_csrf.token}';

    orderStatusServerListUrl = '${orderStatusServerListUrl}';

    (function(context, $){

        ORDER_STATUS_CONFIGURATION_VARIABLES = {
            ORDER_STATUS_SORT_COL : 0,
            ORDER_STATUS_FILTER_VALUE : '',
            ORDER_STATUS_FILTER_DATE_FROM : '',
            ORDER_STATUS_FILTER_DATE_TO : '',
            ORDER_STATUS_FILTER_STATUS_FROM : '',
            ORDER_STATUS_FILTER_STATUS_TO : '',
            ORDER_STATUS_FILTER_SEARCH_BY : ''
        };

        ORDER_STATUS_MESSAGES = {
            "datatableInfoMessage" : '${labelMssgDatatableInfoMessage?js_string}',
            "recordsPerPage" : '${labelMssgRecordsPerPage?js_string}',
            "noProductsAvailable" : '${labelMssgNoProductsAvailable?js_string}',
            "orderByVarLbl" : '${labelMssgOrderByVarLbl?js_string}',
            "statusLbl" : "${labelStatus?js_string}",
            "orderDateLbl" : "${labelOrderDate?js_string}",
            "noOrderStatuses" : "${labelNoOrderStatuses?js_string}",
            "fromBiggerThanTo" : "${labelFromBiggerThanTo?js_string}",
            "lessThanToday" : "${labelLessThanToday?js_string}",
            "onlyLastYear" : "${labelOnlyLastYear?js_string}",
            "invalidFormat" : "${labelDateInvalidFormat?js_string}",
            statusTitles: [
                "${labelBlocked?js_string}",
                "${labelBlocked?js_string}",
                "${labelUnderPreparation?js_string}",
                "${labelUnderPreparation?js_string}",
                "${labelUnderPreparation?js_string}",
                "",
                "${labelDelivered?js_string}",
                "${labelInvoiced?js_string}",
                "",
                "${labelCanceled?js_string}"
            ]
        };

        orderStatusExportToXlsxUrl = '${orderStatusExportToXlsxUrl}';

        $(document).ready(function(){

            ko.di.register(ORDER_STATUS_MESSAGES,"OrderStatusMessages");
            ko.di.register(ORDER_STATUS_CONFIGURATION_VARIABLES, "OrderStatusConfigurationVariables");

            orderStatusViewModel = new OrderStatusViewModel();
            ko.applyBindings(orderStatusViewModel, document.getElementById("order-status-main"));

        });

    })(window, jQuery);

</script>
</@hst.headContribution>