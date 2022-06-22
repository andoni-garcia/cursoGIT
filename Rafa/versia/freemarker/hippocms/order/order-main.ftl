<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />
<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@security.authentication property="principal.showNetPrice" var="showNetPrice" />
<@security.authentication property="principal.showListPrice" var="showListPrice" />

<@hst.link var="search" siteMapItemRefId="search"/>

<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.confirm" var="labelConfirm"/>
<@fmt.message key="eshop.close" var="labelClose"/>
<@fmt.message key="eshop.assign" var="labelAssign"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.errorModal.title" var="labelErrorModalTitle"/>
<@fmt.message key="eshop.serviceUnavailable" var="labelServiceUnavailable"/>
<@fmt.message key="order.confirmModal.title" var="labelConfirmModalTitle"/>
<@fmt.message key="order.confirmModal.message" var="labelConfirmModalMessage"/>
<@fmt.message key="order.invalidProductsModal.title" var="labelInvalidProductsModalTitle"/>
<@fmt.message key="order.invalidProductsModal.message" var="labelInvalidProductsModalMessage"/>
<@fmt.message key="order.invalidCustomerOrdernNumerModal.title" var="labelInvalidCustomerOrderNumberModalTitle"/>
<@fmt.message key="order.invalidCustomerOrdernNumerModal.message" var="labelInvalidCustomerOrdernNumerModalMessage"/>
<@fmt.message key="order.emptyCustomerOrdernNumerModal.message" var="labelEmptyCustomerOrdernNumerModalMessage"/>

<@fmt.message key="order.confirmationModal.message.confirmed1" var="labelConfirmationModalMessageConfirmed1"/>
<@fmt.message key="order.confirmationModal.message.confirmed2" var="labelConfirmationModalMessageConfirmed2"/>
<@fmt.message key="order.confirmationModal.message.confirmed3" var="labelConfirmationModalMessageConfirmed3"/>
<@fmt.message key="order.confirmationModal.message.confirmed4" var="labelConfirmationModalMessageConfirmed4"/>
<@fmt.message key="order.confirmationModal.message.confirmed5" var="labelConfirmationModalMessageConfirmed5"/>

<@fmt.message key="order.confirmationModalSap.message.confirmed1" var="labelSapConfirmationModalMessageConfirmed1"/>
<@fmt.message key="order.confirmationModalSap.message.confirmed2" var="labelSapConfirmationModalMessageConfirmed2"/>
<@fmt.message key="order.confirmationModalSap.message.confirmed3" var="labelSapConfirmationModalMessageConfirmed3"/>
<@fmt.message key="order.confirmationModalSap.message.confirmed4" var="labelSapConfirmationModalMessageConfirmed4"/>

<@fmt.message key="order.confirmationModal.message.confirmedBlocked1" var="labelConfirmationModalMessageConfirmedBlocked1"/>
<@fmt.message key="order.confirmationModal.message.confirmedBlocked2" var="labelConfirmationModalMessageConfirmedBlocked2"/>

<@fmt.message key="order.confirmationModal.message.haveErrors" var="labelConfirmationModalMessageHaveErrors"/>
<@fmt.message key="order.acceptAlert" var="acceptAlert"/>
<@fmt.message key="order.acceptTermsUrl" var="acceptTerms"/>

<@fmt.message key="basket.available" var="labelAvailable"/>
<@fmt.message key="basket.notAvailable" var="labelNotAvailable"/>


</#compress>

<main id="order-container" class="smc-main-container eshop">
    <div class="mb-30 container">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div class="global-overlay" style="display: none" data-bind="visible: processingConfirmation()">
        <smc-spinner-inside-element params="loading: processingConfirmation()"></smc-spinner-inside-element>
    </div>

    <div class="container">
        <div class="cmseditlink">
        </div>
        <h2 class="heading-08 color-blue mt-20"><@fmt.message key="order.title"/></h2>
        <strong>${principalFullname}</strong>
        <h1 class="heading-02 heading-main">${principalName}</h1>
    </div>
    <br>

    <div class="container">
        <#if isProfessionalUser>
        <div class="row pl-3 pr-3">
            <div class="col-12 basket-line"></div>
            <div class="col-12 basket-steps-container d-flex">
                <div class="offset-md-1 col-xl-2 col-sm-4 col-5 basket-step">
                    <p>1 <@fmt.message key="basket.title"/></p>
                </div>
                <div class="offset-1 col-xl-2 col-sm-4 col-5 basket-step selected">
                    <p>2 <@fmt.message key="order.title"/></p>
                </div>
            </div>
        </div>
        </#if>

        <!-- Order info -->
        <#if selectedErp == "MOVEX">
            <#include "./order-addresses/movex.ftl">
        <#elseif selectedErp == DYNAMICS_ERP>
       		<#include "./order-addresses/dynamics.ftl">
        <#else>
            <#include "./order-addresses/sap.ftl">
        </#if>

        <div class="modal fade" id="modal-delivery-addresses" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><@fmt.message key="order.deliveryAddresses"/></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                    <!-- ko if: deliveryAddresses().length == 0 -->
                        <div class="mb-2 mt-2">
                            <@fmt.message key="order.noDeliveryAddresses"/>
                        </div>
                    <!-- /ko -->
                    <!-- ko if: deliveryAddresses().length > 0 -->
                    <!-- ko foreach: deliveryAddresses -->
                        <div class="mb-2">
                            <input type="radio" name="addressIdGroup" data-bind="checked: $root.selectedAddressId, value: addressId"/>
                            <label class="heading-09 mb-0" data-bind="text: customerName"></label><br>
                             <#if selectedErp == DYNAMICS_ERP>
                                <!-- ko foreach: deliveryAddress -->
                            <label class="mb-0 ml-4" data-bind="text: $data"></label><br>
                            <!-- /ko -->
                            <#else>
                            <!-- ko foreach: customerAddress -->
                            <label class="mb-0 ml-4" data-bind="text: $data"></label><br>
                            <!-- /ko -->
                            </#if>
                        </div>
                    <!-- /ko -->
                    <!-- /ko -->
                    </div>
                    <div class="modal-footer">
                        <!-- ko if: deliveryAddresses().length == 0 -->
                        <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal"><@fmt.message key="eshop.close"/></button>
                        <!-- /ko -->
                        <!-- ko if: deliveryAddresses().length > 0 -->
                        <button type="button" id="btn-return" class="btn btn-secondary" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                        <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal"><@fmt.message key="eshop.assign"/></button>
                        <!-- /ko -->
                    </div>
                </div>
            </div>
        </div>

        <!-- Order input -->
        <div class="row mt-3">
            <div class="col-md-4 mb-3">
                <label class="mb-0"><@fmt.message key="myorders.customerOrderNumber"/>:</label><br>
                <input class="form-control" data-bind="value: customerOrderNumberInput, valueUpdate: 'afterkeydown', disable: isCustomerOrderNumberChecking()">
            </div>

            <!-- ko if: selectedErp !== 'SAP' -->
            <div class="offset-md-4 col-md-4 mb-3" >
                <label class="mb-0"><#if selectedErp=="MOVEX"><@fmt.message key="order.applyToAllCrds"/><#elseif selectedErp==DYNAMICS_ERP> <@fmt.message key="order.applyToAllCrdsDynamics"/></#if></label><br>
                <input class="form-control" data-bind="datepicker:{minDate : 0, dateFormat: '${currentFormatDate}'}, value: requestDateForAll" type="text">
            </div>
            <!-- /ko -->

        </div>

        <div class="row">
            <div class="col-12" id="new_box_container">

                <!-- Basket product box -->
                <!-- ko if: orderProducts().length > 0 -->
                    <@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>

                    <div id="ord-product-list" style="display: none;" data-bind="visible: loadedViewModel">
                    <!-- ko foreach: orderProducts -->
                        <!-- ko if: (status() != $root.StateType.ERROR && valid() == true && prevStatus() != $root.StateType.ERROR) || (status() == $root.StateType.ERROR && !parent.erpUnaffordableRemovableProducts()) -->
                            <#include "./order-details-product/product.ftl">
                        <!-- /ko -->

                    <!-- /ko -->
                    </div>

                <!-- /ko -->

                <!-- ko if: orderProducts().length == 0 -->
                <div class="row m-0 p-3 mt-5 mb-5 my-2 basket-product-box border border-secondary eshop-box-rounded">
                    <div class="col-12 ">
                        <@fmt.message key="basket.mssg.noProductsAvailableForOrder"/>
                    </div>
                </div>
                <!-- /ko -->

                <div class="basket-steps-container"></div>
                    <div class="row align-top justify-space-between">
                        <div class="col">
                        <#if areTermsActivated?has_content && areTermsActivated != "NOT_SET">
                            <div class="info-box p-3 align-self-start mt-4 mt-lg-3 mb-3">
                                <input name="agreeDPP" type="checkbox" class="form-check-input ml-0" id="agreeTerms" data-bind="checked: acceptedTerms"/>
                                <label class="form-check-label" for="agreeTerms"><@fmt.message key="order.acceptMssg"/>*</label>
                                <#if areTermsActivated == "WITH_PDF">
                                <div class="col-12 order-terms-link">
                                    <a href="${acceptTerms}" target="_blank" >
                                        <@fmt.message key="users.readHere"/>
                                    </a>
                                </div>
                                <#else>
                                <div class="col-12 order-terms-link">
                                    <a class="a-ko" data-bind="click: openTerms.bind($data)">
                                        <@fmt.message key="users.readHere"/>
                                    </a>
                                </div>
                                <div class="col-12 p-0" data-bind="visible: showTermsText" style="display: none">
                                    <textarea disabled class="form-control input-disabled-wb unresizable-textarea textarea-addi-comments">${orderTerms}</textarea>
                                </div>
                                </#if>

                            </div>
                        </#if>
                        </div>
                        <div class="col-lg-4 col-xl-3 mt-4 mt-lg-3">
                            <div class="info-box">
                                <div class="info-box__head">
                                    <h2 class="heading-07"><@fmt.message key="eshop.grandTotal"/></h2>
                                </div>
                                <div class="info-box__body text-01">
                                    <!-- Total -->
                                    <div class="basket-grand-total mb-3">

                                        <#if orderCharges?has_content && orderCharges?number != 0>
                                            <div class="d-flex justify-content-end"><label class="option-label"><@fmt.message key="eshop.transportCharges"/> </label><label class="second-value" data-bind="text: orderCharges() + ' ' + currency()"></label></div>
                                            <br>
                                        </#if>

                                        <#if showNetPrice><div class="d-flex justify-content-end"><label class="option-label"><@fmt.message key="eshop.summaryNetPrice"/> </label><label class="value" data-bind="text: totalNetPrice() + ' ' + currency()"></label></div></#if>
                                        <#if showListPrice>
                                        <#assign listStyle="">
                                        <#if showNetPrice>
                                        <#assign listStyle="second-">
                                        </#if>
                                        <div class="d-flex justify-content-end"><label class="option-label"><@fmt.message key="eshop.listPrice"/> </label><label class="${listStyle}value" data-bind="text: totalListPrice() + ' ' + currency()"></label></div>
                                        </#if>
                                    </div>
                                    <a class="a-ko btn btn-secondary btn-secondary--blue-border w-100" data-bind="enable: !updating(), click: goToBasket"><@fmt.message key="eshop.back"/></a>
                                    <a id="confirmBtn" class="a-kons btn w-100 mt-3 position-relative" data-bind="click: confirmOrder.bind($data), css: acceptedTerms() && !updating() && !processingConfirmation() && !isCustomerOrderNumberChecking() ? 'btn-primary' : 'btn-desactivated'">
                                        <smc-spinner-inside-element params="loading: processingConfirmation() == true, isButton: true"></smc-spinner-inside-element>
                                        <@fmt.message key="eshop.confirm"/>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-order-confirmation" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><@fmt.message key="order.confirmModal.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <span class="modal-message"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btn-return" class="btn" data-dismiss="modal"><@fmt.message key="eshop.confirm"/></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modal-order-accept" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title"><@fmt.message key="order.confirmModal.title"/></h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <span class="modal-message"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" id="btn-return" class="btn btn-secondary" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                    <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal"><@fmt.message key="eshop.confirm"/></button>
                </div>
            </div>
        </div>
    </div>
</main>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Datepicker.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/order/OrderRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/order/OrderDeliveryAddress.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/order/OrderUtils.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/order/OrderViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="htmlBodyEnd">
<script type="text/javascript">
    var orderViewModel;
    var orderDeliveryAddressesServerUrl = '<@hst.resourceURL resourceId="GET_DELIVERY_ADDRESSES"/>';
    var orderSetDeliveryAddressServerUrl = '<@hst.resourceURL resourceId="SET_DELIVERY_ADDRESS"/>';
    var orderCheckCustomerOrderNumberServerUrl = '<@hst.resourceURL resourceId="GET_CUSTOMER_ORDER_NUMBER"/>';
    var orderConfirmServerUrl = '<@hst.resourceURL resourceId="CONFIRM_ORDER"/>';

    var storeDeliveryAddress = <#if addressId??>'${addressId}'<#else>''</#if>;

    var checkAgree = document.getElementById('agreeTerms');
    var confirmBtn = document.getElementById('confirmBtn');
    var areTermsActivated;
    <#if !areTermsActivated?has_content || (areTermsActivated?has_content && areTermsActivated != "NOT_SET") >
        areTermsActivated = true;
    </#if>


    var ORDER_MESSAGES = {
        cancel : '${labelCancel?js_string}',
        confirm : '${labelConfirm?js_string}',
        close : '${labelClose?js_string}',
        assign : '${labelAssign?js_string}',
        accept : '${labelAccept?js_string}',

        modalServiceErrorTitle: '${labelErrorModalTitle?js_string}',

        serviceUnavailable: '${labelServiceUnavailable?js_string}',

        modalConfirmTitle: '${labelConfirmModalTitle?js_string}',
        modalSapConfirmTitle: '${labelSapConfirmModalTitle?js_string}',
        modalConfirmMessage: '${labelConfirmModalMessage?js_string}',

        modalInvalidProductsTitle: '${labelInvalidProductsModalTitle?js_string}',
        modalInvalidProductsMessage: '${labelInvalidProductsModalMessage?js_string}',

        modalInvalidCustomerOrderNumberTitle: '${labelInvalidCustomerOrderNumberModalTitle?js_string}',
        modalInvalidCustomerOrderNumberMessage: '${labelInvalidCustomerOrdernNumerModalMessage?js_string}',
        modalEmptyCustomerOrderNumberMessage: '${labelEmptyCustomerOrdernNumerModalMessage?js_string}',

        modalConfirmationMessageConfirmed1: '${labelConfirmationModalMessageConfirmed1?js_string}',
        modalConfirmationMessageConfirmed2: '${labelConfirmationModalMessageConfirmed2?js_string}',
        modalConfirmationMessageConfirmed3: '${labelConfirmationModalMessageConfirmed3?js_string}',
        modalConfirmationMessageConfirmed4: '${labelConfirmationModalMessageConfirmed4?js_string}',
        modalConfirmationMessageConfirmed5: '${labelConfirmationModalMessageConfirmed5?js_string}',

        modalSapConfirmationMessageConfirmed1: '${labelSapConfirmationModalMessageConfirmed1?js_string}',
        modalSapConfirmationMessageConfirmed2: '${labelSapConfirmationModalMessageConfirmed2?js_string}',
        modalSapConfirmationMessageConfirmed3: '${labelSapConfirmationModalMessageConfirmed3?js_string}',
        modalSapConfirmationMessageConfirmed4: '${labelSapConfirmationModalMessageConfirmed4?js_string}',

        modalConfirmationMessageConfirmedBlocked1: '${labelConfirmationModalMessageConfirmedBlocked1?js_string}',
        modalConfirmationMessageConfirmedBlocked2: '${labelConfirmationModalMessageConfirmedBlocked2?js_string}',

        modalConfirmationMessageHaveErrors: '${labelConfirmationModalMessageHaveErrors?js_string}',

        acceptAlert: '${acceptAlert?js_string}'
    };

    $(document).ready(function(){

        var orderBindDom = document.getElementById("order-container");
        orderViewModel = new OrderViewModel();
        ko.applyBindings(orderViewModel, orderBindDom);

    });


</script>
</@hst.headContribution>