<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@fmt.message key="basket.available" var="labelAvailable"/>
<@fmt.message key="basket.notAvailable" var="labelNotAvailable"/>

<div class="row m-0 my-2 order-product-box border border-secondary eshop-box-rounded p-3 position-relative" >
    
    <smc-spinner-inside-element params="loading: status() == $root.StateType.UPDATING && prevStatus() != $root.StateType.ERROR"></smc-spinner-inside-element>

    <!-- ko if: lines().length == 0 -->
    <div class="col-lg-4 p-0 pb-sm-3">
        <a class="text-muted partnumber-href" data-bind="text: partnumber, toUpperCase, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber())" target="_blank"> </a>
        <br>
        <span class="text-dark description" data-bind="text: name"></span>
    </div>

    <div class="col-lg-8 p-0 m-0">
        <div class="row p-0 m-0">
            <div class="col-lg-1 col-sm-1 p-0 pt-3 pt-sm-0">
                <label class="option-label mb-0"><@fmt.message key="eshop.qty"/>: </label><br>
                <label class="value stronge mb-0" data-bind="text: $data.quantity()"></label>
            </div>
            <div class="col-lg-11 col-sm-11 p-0 pl-sm-3 pt-3 pt-lg-0 align-right order-delete-column">
                <div>
                    <a class="a-ko mr-2" data-bind="attr: {id: 'bskly-delete-' + $data.basketProductId, 'data-bind': ''}, click: parent.deleteFromBasket.bind($data, $data.basketProductId, 'ORDER')">
                        <i class="fas fa-trash ml-2"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <!-- ko if: lines().length > 0 -->
    <!-- ko foreach: lines -->
    <div class="col-lg-4 p-0 pb-sm-3">
        <!-- ko if: $index() == 0 -->
        <!-- <label class="reference mb-0" data-bind="text: $parent.partnumber, toUpperCase"></label><br> -->
        <a class="text-muted partnumber-href" data-bind="text: $parent.partnumber, toUpperCase, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, $parent.partnumber())" target="_blank"> </a>
        <br>
        <span class="text-dark description" data-bind="text: $parent.name"></span>
        <!-- /ko -->
    </div>

    <div class="col-lg-8 p-0 m-0" data-bind="css: (window.koDate.dateDaysDiffFormatted(customerRequestDate(),deliveryDate()) > 0 && selectedErp !== 'SAP') ? 'alert-warning p-2' : ''">

        <div class="row p-0 m-0">

            <div class="col-lg-1 col-sm-2 p-0 pt-3 pt-sm-0">
                <label class="option-label mb-0"><@fmt.message key="eshop.qty"/>: </label><br>
                <label class="value stronge mb-0" data-bind="text: $data.quantity()"></label>
            </div>
            <div class="col-lg-4  col-sm-5 p-0  pt-3 pt-sm-0">
                               
                <#if selectedErp?? && selectedErp=="MOVEX">
                <label class="option-label mb-0"><@fmt.message key="order.customerRequestedDate"/>: </label>
                <input class="form-control" data-bind="datepicker:{minDate : $parent.bestAchievableDeliveryDate(), dateFormat: '${currentFormatDate}'}, value: customerRequestDate" type="text">
                <#elseif selectedErp?? && selectedErp==DYNAMICS_ERP>
                <label class="option-label mb-0"><@fmt.message key="order.customerRequestedDate"/>: </label>
                <input class="form-control" data-bind="datepicker:{minDate : 0, dateFormat: '${currentFormatDate}'}, value: customerRequestDate" type="text">
                </#if>
                <div class="d-lg-block d-none">
                    <div class="row">
                        <div class="col-8">
                            <label class="option-label${selectedErp?? && selectedErp=='SAP'?string('mt-3','')} mb-0" ><#if selectedErp?? && selectedErp==DYNAMICS_ERP><@fmt.message key="order.dynamics.deliveryDate"/><#else><@fmt.message key="order.confirmedDeliveryDate"/></#if>: </label><br>
                            <!-- ko if: window.koDate.dateDaysDiffFormatted(customerRequestDate(),deliveryDate()) > 0 && selectedErp !== 'SAP' -->
                                <i class="fa fa-exclamation-triangle" aria-hidden="true" title="<@fmt.message key="order.warningDates"/>"></i>
                            <!-- /ko -->
                            <label class="value stronge mb-0 " data-bind="text: deliveryDate">fddf</label>
                        </div>
                        <#if selectedErp?? && selectedErp=="SAP">
                        <div class="col-4">
                            <label class="option-label mb-0" ><@fmt.message key="basket.availability"/>: </label><br>
                            <label class="value mb-0 sap-dot-availability" data-bind="attr:{ title: checkSapAvailability($parent.availability())}, css: {'bg-error': $parent.availability() == '0', 'bg-success': $parent.availability() == '1', 'bg-warning': $parent.availability() == '2' }"></label>
                        </div>
                        </#if>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-sm-5 d-lg-none p-0 pl-sm-3 pt-3 pt-sm-0">
                <div class="row">
                    <div class="col-8">
                        <label class="option-label mb-0"><@fmt.message key="order.confirmedDeliveryDate"/>: </label><br>
                        <!-- ko if: customerRequestDate() < deliveryDate() -->
                            <i class="fa fa-exclamation-triangle" aria-hidden="true" title="<@fmt.message key="order.warningDates"/>"></i>
                        <!-- /ko -->
                        <label class="value stronge mb-0" data-bind="text: deliveryDate"></label>
                    </div><
                    <#if selectedErp?? && selectedErp=="SAP">
                    <div class="col-4">
                        <label class="option-label mb-0" ><@fmt.message key="basket.availability"/>: </label><br>
                        <label class="value mb-0" data-bind="css: {'icon-invalid': !$parent.availability(), 'icon-valid': $parent.availability()}"></label>
                    </div>
                    </#if>
                </div>
            </div>
            <div class="col-lg-3 col-sm-4 pl-lg-3 p-0 pt-3 pt-lg-0 align-right">
                <#if showListPrice><label class="option-label mb-0"><@fmt.message key="eshop.listPrice"/>: </label><br>
                <label class="value stronge mb-3" data-bind="text: $parent.listPrice() + ' ' + $parent.currency()"></label></#if>
                <#if showNetPrice><div class="d-lg-block d-none">
                    <label class="option-label mb-0"><@fmt.message key="eshop.netPrice"/>: </label><br>
                    <label class="value stronge mb-0" data-bind="text: $parent.netPrice() + ' ' + $parent.currency()"></label>
                </div></#if>
            </div>
            <div class="col-sm-4 d-lg-none p-0 pt-sm-3 pt-lg-0 align-right">
                <#if showNetPrice><label class="option-label mb-0"><@fmt.message key="eshop.netPrice"/>: </label><br>
                <label class="value stronge mb-0" data-bind="text: $parent.netPrice() + ' ' + $parent.currency()"></label></#if>
            </div>
            <div class="col-lg-4 col-sm-4 p-0 pl-sm-3 pt-3 pt-lg-0 align-right order-delete-column">
                <div class="order-delete-column-totalprice">
                    <label class="option-label mb-0"><@fmt.message key="eshop.totalPrice"/>: </label><br>
                    <#if showListPrice && !showNetPrice>
                    <label class="value stronge mb-0" data-bind="text: totalListPrice() + ' ' + $parent.currency()"></label>
                    <#else>
                    <label class="value stronge mb-0" data-bind="text: totalNetPrice() + ' ' + $parent.currency()"></label>
                    </#if>

                </div>
                <div>
                    <a class="a-ko" data-bind="attr: {id: 'bskly-delete-' + $parent.basketProductId, 'data-bind': ''}, click: parentVm.deleteFromBasket.bind($data, $parent.basketProductId, 'ORDER')">
                        <i class="fas fa-trash ml-2"></i>
                    </a>
                </div>
            </div>

        </div>

    </div>
    <!-- /ko -->
    <!-- /ko -->
</div>

