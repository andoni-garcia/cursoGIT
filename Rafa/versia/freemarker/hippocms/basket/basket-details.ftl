<@security.authentication property="principal.showNetPrice" var="showNetPrice" />
<@security.authentication property="principal.showListPrice" var="showListPrice" />
<@security.authentication property="principal.hidenPrices" var="hidenPrices" />

<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@hst.link var="orderLink" siteMapItemRefId="order"/>
<@fmt.message key="eshop.searchPlaceholder" var="searchPlaceHolder"/>
<@fmt.message key="basket.partnumberPlaceholder" var="partnumberPlaceholder"/>

<@fmt.message key="basket.alert.mssg1" var="alertMssg1"/>

<@hst.actionURL var="actionURL"/>

<@hst.headContribution category="htmlHead">
	<script>
		var actionUrl;
	</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
	<script type="text/javascript">
		$(document).ready(function(){	
			actionUrl = "${actionURL}";
            console.log(actionUrl)
    });
    </script>
</@hst.headContribution>

<main class="smc-main-container eshop">
            <div class="container mb-30">
                <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
            </div>
    <div class="container">
        <div class="cmseditlink">
        </div>
        <h2 class="heading-08 color-blue mt-20"><@fmt.message key="basket.title"/></h2>
        <strong><#if principalFullname??>${principalFullname}</#if></strong>
        <h1 class="heading-02 heading-main"><#if principalName??>${principalName}</#if></h1>
    </div>
    <div class="container">
        <#if isProfessionalUser||isAdvancedUser>
        <div class="row pl-3 pr-3">
            <div class="col-12 basket-line"></div>
            <div class="col-12 basket-steps-container d-flex">
                <div class="offset-md-1 col-xl-2 col-sm-4 col-5 basket-step selected">
                    <p>1 <@fmt.message key="basket.title"/></p>
                </div>
                <#if !isAdvancedUser>
                <div class="offset-1 col-xl-2 col-sm-4 col-5 basket-step">
                    <p>2 <@fmt.message key="order.title"/></p>
                </div>
                </#if>
            </div>
        </div>
        </#if>
        <#if showAlert == "1" && alertMssg1?has_content && !alertMssg1?contains('???')>
            <div class="alert alert-warning mb-5" role="alert">
                ${alertMssg1}<br/>
                <@fmt.message key="basket.alert.mssg2"/><br/>
                <@fmt.message key="basket.alert.mssg3"/>
            </div>
        </#if>
        <div class="row">
            <div class="col-12" id="new_box_container">
                <#include "./asksmc/asksmc.ftl">
                <#include "./basket-save.ftl">
                <#include "./basket-empty.ftl">

                <#if isSaparibaUser>
                <form id="sapariba-form" method="POST" action="">
                    <input id="cxml-urlencoded" name="cxml-urlencoded" type="hidden" value="">
                </form>
                </#if>

                <!-- Basket filters -->
                <div class="row mb-4">
                    <div class="col-md-9 mb-3">
                        <input class="form-control" id="bsk-search-filter" data-bind="value: filter, valueUpdate: 'afterkeydown'" placeholder="${searchPlaceHolder}" type="text">
                    </div>
                    <div class="col-md-3 pl-lg-0 mb-3">
                        <button type="button" class="btn btn-primary w-100" data-bind="click: clearFilter.bind($data)"><@fmt.message key="eshop.showAll"/></button>
                    </div>
                </div>
                
                <!-- Add to list -->
                <div class="row align-bottom">
                
                    <div class="col-lg-12">
                        <div class="row">
                        <#if scanVisible?? && scanVisible == "1">
                        <div class="col-12 col-xl-2 pr-xl-0 align-self-end text-left mb-3 pr-0">
                                <div class="row p-0 m-0">
                                    <div class="col-12 col-xl-10 pl-0 pr-xl-0">
                                        <button id="btn-scan"
                                                class="btn btn-primary w-100 livestream_scanner" type="button"
                                                data-toggle="modal"
                                                data-scan="bsk-partnumber-input1"
                                                data-target="#livestream_scanner"><img class="mr-2"
                                                                                        src="<@hst.webfile path="/images/icon_barcode.svg"/>"
                                                                                        width="25"/><@fmt.message key="scan.btn"/>
                                        </button>
                                    </div>
                                    <div class="col-12 col-xl-1 pr-xl-0 pl-0 bsk-scan__divider--vr pb-0 pt-3">
                                        <div class="w-100 bsk-scan__divider--h"></div>
                                    </div>
                                </div>
                            </div>
                                            

                        <#if selectedErp?? && (selectedErp=="MOVEX" || selectedErp==DYNAMICS_ERP)>
                            <div class="col-12 col-md-12 col-xl-3 pl-xl-0 pr-xl-0 mb-3">
                                <bs-modal-widget data-bind="visible: loadedViewModel" style="display:none"
                                                 params="options: customerPartnumberOptions">
                                    <div class="row">
                                        <div class="col-12">
                                            <span>Alias <span class="span-partnumber-code"
                                                              data-bind="text: $parent.createCustomerPartnumberCPN()"></span> assign to next partnumber</span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <span><@fmt.message key="eshop.partnumber"/>:</span>
                                            <input type="text"
                                                   data-bind="value: $parent.createCustomerPartnumberPN, valueUpdate: 'afterkeydown'">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <span data-bind="text: $parent.createCustomerPartnumberError()"></span>
                                        </div>
                                    </div>
                                </bs-modal-widget>
                                <div class="dropdown smc-select">
                                    <select id="bsk-partnumber-type1" data-bind="value: selectPartnumberType">
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.ANY"><@fmt.message key="basket.partnumberType.any"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.PARTNUMBER"><@fmt.message key="basket.partnumbertype.partnumber"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.CUSTOMER_PARTNUMBER"><@fmt.message key="basket.partnumberType.customerPartnumber"/></option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6 col-md-6 col-xl-3 pr-xl-0 mb-3">
                                <#else>
                                <div class="col-6 col-md-2 col-xl-2 pr-3 pr-0 mb-3">
                                    </#if>
                                    <!-- ko if: enabledAutocomplete() -->
                                    <input id="bsk-partnumber-input1" class="form-control"
                                           data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, valueUpdate: 'afterkeydown', submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), jqAuto: { autoFocus: true }, jqAutoSource: listOfMatches, jqAutoQuery: getMatches, jqAutoValue: boxInputPartnumber(), jqAutoSourceLabel: 'value', jqAutoSourceInputValue: 'value', jqAutoSourceValue: 'value'"
                                           placeholder="${partnumberPlaceholder}">
                                    <!-- /ko -->
                                    <!-- ko if: !enabledAutocomplete() -->
                                    <input id="bsk-partnumber-input1" class="form-control" style="display: none"
                                           data-bind="visible: loadedViewModel, attr: {'data-bind': ''}, value: boxInputPartnumber, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'"
                                           placeholder="${partnumberPlaceholder}">
                                    <!-- /ko -->
                                </div>
                                <div class="col-6 col-xl-1 pr-xl-0 align-self-end text-left mb-3">
                                    <input id="bsk-partnumber-input-qty-1" type="text" maxlength="3"
                                           data-bind="value: boxInputQuantity, numeric: 1, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'"
                                           class="form-control" value="1">
                                </div>
                                <div class="col-12 col-xl-3 align-self-end text-right mb-3">
                                    <button id="bsk-partnumber-addtobasket1" type="button"
                                            data-bind="click: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET')"
                                            class="btn btn-primary w-100 position-relative">
                                        <smc-spinner-inside-element
                                                params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                        <@fmt.message key="eshop.addToList"/>
                                    </button>
                                </div>
                            </div>
                        
                        <#else>
                            <#if selectedErp?? && (selectedErp=="MOVEX" || selectedErp==DYNAMICS_ERP)>
                            <div class="col-md-6 col-xl-4 pr-md-0 mb-3">

                                <bs-modal-widget data-bind="visible: loadedViewModel" style="display:none" params="options: customerPartnumberOptions">
                                    <div class="row">
                                        <div class="col-12">
                                            <span>Alias <span class="span-partnumber-code" data-bind="text: $parent.createCustomerPartnumberCPN()"></span> assign to next partnumber</span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <span><@fmt.message key="eshop.partnumber"/>:</span>
                                            <input type="text" data-bind="value: $parent.createCustomerPartnumberPN, valueUpdate: 'afterkeydown'">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <span data-bind="text: $parent.createCustomerPartnumberError()"></span>
                                        </div>
                                    </div>
                                </bs-modal-widget>
                                <div class="dropdown smc-select">
                                    <select id="bsk-partnumber-type1" data-bind="value: selectPartnumberType">
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.ANY"><@fmt.message key="basket.partnumberType.any"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.PARTNUMBER"><@fmt.message key="basket.partnumbertype.partnumber"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.CUSTOMER_PARTNUMBER"><@fmt.message key="basket.partnumberType.customerPartnumber"/></option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-3 pr-3 pr-xl-0 mb-3">
                            <#else>
                            <div class="col-md-6 col-xl-7 pr-3 pr-xl-0 mb-3">
                            </#if>
                                <!-- ko if: enabledAutocomplete() -->
                                <input id="bsk-partnumber-input1" class="form-control" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, valueUpdate: 'afterkeydown', submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), jqAuto: { autoFocus: true }, jqAutoSource: listOfMatches, jqAutoQuery: getMatches, jqAutoValue: boxInputPartnumber(), jqAutoSourceLabel: 'value', jqAutoSourceInputValue: 'value', jqAutoSourceValue: 'value'" placeholder="${partnumberPlaceholder}">
                                <!-- /ko -->
                                <!-- ko if: !enabledAutocomplete() -->
                                <input id="bsk-partnumber-input1" class="form-control" style="display: none" data-bind="visible: loadedViewModel, attr: {'data-bind': ''}, value: boxInputPartnumber, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'" placeholder="${partnumberPlaceholder}">
                                <!-- /ko -->
                            </div>
                            <div class="col-4 col-xl-1 align-self-end text-left pr-0 mb-3">
                                <input id="bsk-partnumber-input-qty-1" type="text" maxlength="3" data-bind="value: boxInputQuantity, numeric: 1, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'" class="form-control" value="1">
                            </div>
                            <div class="col-8 col-xl-4 align-self-end text-right mb-3">
                                <button id="bsk-partnumber-addtobasket1" type="button" data-bind="click: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET')" class="btn btn-primary w-100 position-relative">
                                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                    <@fmt.message key="eshop.addToList"/>
                                </button>
                            </div>
                        </div>
                        </#if>
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-6 col-md-6 col-xl-8 pr-md-0 mb-3 "></div>
                    <div class="col-6 col-md-6 col-xl-4 pr-15 mb-3 ">
                            <div class="dropdown smc-select">
                                <select id="bks-products-order" data-bind="options: basketProductOrderArr, optionsText: 'name', optionsValue: 'order', value: selectBasketOrder"></select>
                            </div>
                    </div>
                </div>
                <!-- Basket product box -->
                <!-- ko if: productsFilter().length > 0 -->
                    <@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>
                    
                    <div id="bsk-product-list" style="display: none;" data-bind="visible: loadedViewModel">    

                    <!-- ko foreach: productsFilter -->
                        
                        <!-- ko if: status() == $root.StateType.UPDATING || valid() == true -->
                            <#if isProfessionalUser || isAdvancedUser || isOciUser || isSaparibaUser>
                                <#include "./basket-details-product/professional-product.ftl">
                            <#else>
                                <#include "./basket-details-product/technical-product.ftl">
                            </#if>
                        <!-- /ko -->
                        <!-- ko if: status() != $root.StateType.UPDATING && valid() == false -->
                            <#include "./basket-details-product/product-unavailable.ftl">
                        <!-- /ko -->

                    <!-- /ko -->
                    </div>

                <!-- /ko -->
                
                <!-- ko if: productsFilter().length > 0 -->
                <!-- Add to list -->
                <div class="row align-top" style="display: none" data-bind="visible: loadedViewModel">
                    <div class="col-lg-7 col-xl-9 mt-3">
                        <!-- ko if: productsFilter().length > 2 -->
                        <div class="row">
                            <#if selectedErp?? && (selectedErp=="MOVEX" || selectedErp==DYNAMICS_ERP)>
                            <div class="col-md-6 col-xl-4 pr-md-0 mb-3">
                                <div class="dropdown smc-select">
                                    <select id="bsk-partnumber-type2" data-bind="value: selectPartnumberType">
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.ANY"><@fmt.message key="basket.partnumberType.any"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.PARTNUMBER"><@fmt.message key="basket.partnumbertype.partnumber"/></option>
                                        <option data-bind="attr: {'data-bind': ''}, value: PartnumberType.CUSTOMER_PARTNUMBER"><@fmt.message key="basket.partnumberType.customerPartnumber"/></option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-3 pr-3 pr-xl-0 mb-3">
                            <#else>
                            <div class="col-md-6 col-xl-7 pr-3 pr-xl-0 mb-3">
                            </#if>
                                <!-- ko if: enabledAutocomplete() -->
                                <input id="bsk-partnumber-input2" class="form-control" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown', jqAuto: { autoFocus: true }, jqAutoSource: listOfMatches, jqAutoQuery: getMatches, jqAutoValue: boxInputPartnumber(), jqAutoSourceLabel: 'value', jqAutoSourceInputValue: 'value', jqAutoSourceValue: 'value'" placeholder="${partnumberPlaceholder}">
                                <!-- /ko -->
                                <!-- ko if: !enabledAutocomplete() -->
                                <input id="bsk-partnumber-input2" class="form-control" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'" placeholder="${partnumberPlaceholder}">
                                <!-- /ko -->
                            </div>
                            <div class="col-4 col-xl-2 align-self-end text-left pr-0 mb-3">
                                <input id="bsk-partnumber-input-qty-2" type="text" maxlength="3" data-bind="value: boxInputQuantity, numeric: 1, submit: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET'), valueUpdate: 'afterkeydown'" class="form-control" value="1">
                            </div>
                            <div class="col-8 col-xl-3 align-self-end text-right mb-3">
                                <button id="bsk-partnumber-addtobasket2" type="button" data-bind="click: addToBasketSubmit.bind($data, boxInputPartnumber(), selectPartnumberType(), 'BASKET')" class="btn btn-primary w-100 position-relative">
                                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                    <@fmt.message key="eshop.addToList"/>
                                </button>
                            </div>
                        </div>
                        <!-- /ko -->
                    </div>

                    <#if !hidenPrices && (isProfessionalUser || isOciUser || isAdvancedUser || isSaparibaUser)>
                    <div class="offset-lg-1 col-lg-4 offset-xl-0 col-xl-3 mt-4 mt-lg-3 pl-0">
                        <div class="info-box">
                            <div class="info-box__head">
                                <h2 class="heading-07"><@fmt.message key="eshop.grandTotal"/></h2>
                            </div>
                            <div class="info-box__body text-01">
                                <!-- Total -->
                                <div class="basket-grand-total mb-3">
                                    <#if showNetPrice>
                                    <div class="d-flex justify-content-end"><label class="option-label"><@fmt.message key="eshop.netPrice"/> </label><label class="value" data-bind="text: totalNetPrice() + ' ' +  currency()"></label></div>
                                    </#if>
                                    <#if showListPrice>
                                    <#assign listStyle="">
                                    <#if showNetPrice>
                                    <#assign listStyle="second-">
                                    </#if>
                                    <div class="d-flex justify-content-end"><label class="option-label"><@fmt.message key="eshop.listPrice"/> </label><label class="${listStyle}value" data-bind="text: totalListPrice() + ' ' +  currency()"></label></div>
                                    </#if>
                                </div>
                                <#if isProfessionalUser>
                                <a class="a-kons btn btn-primary w-100" data-bind="click: goToOrder.bind($data, 'BASKET')"><@fmt.message key="eshop.next"/></a>
                                <#elseif isOciUser >
                                <a class="a-kons btn btn-primary w-100" data-bind="click: confirmOci"><@fmt.message key="eshop.confirmOci"/></a>
                                <#elseif isSaparibaUser >
                                <a class="a-kons btn btn-primary w-100" data-bind="click: confirmSapariba"><@fmt.message key="eshop.confirmOci"/></a>
                                </#if>
                            </div>
                        </div>
                    </div>
                    </#if>
                </div>
                <!-- /ko -->

                <!-- ko if: productsFilter().length == 0 -->
                <div class="row m-0 p-3 mt-5 mb-5 my-2 basket-product-box border border-secondary eshop-box-rounded position-relative">
                    <smc-spinner-inside-element params="loading: !firstDataLoad()">
                        <#include "../../../js/knockout/templates/smc-spinner-inside-element.html">
                    </smc-spinner-inside-element>
                    <div class="col-12" data-bind="visible: firstDataLoad()" style="display:none">
                    <@fmt.message key="basket.mssg.noProductsAvailableForOrder"/>
                    </div>
                </div>
                <!-- /ko -->

                <!-- Basket options -->
                <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                    <div class="row m-3 w-100">
                        <div class="col-12 nopadding">
                            <smc-select-all-check params="list: $root.productsFilter, field: 'selected'"><#include "../components/selectall-check.ftl"/></smc-select-all-check>
                        </div>

                        <div class="col-xl-3 col-md-6 pl-0">
                            <div class="mt-3"><a data-bind="click: deleteSelected.bind($data, 'BASKET')" class="a-ko heading-09"><i class="fas fa-trash"></i> <@fmt.message key="eshop.deleteProducts"/></a></div>
                            <div class="mt-3"><a onclick="importBasketViewModel.init()"  class="a-ko heading-09"><i class="fas fa-file-import"></i> <@fmt.message key="eshop.importFromFile"/></a></div>
                            <#if !isTechnicalUser>
                                <div class="mt-3"><a data-bind="click: showAskSmcModal.bind($data)" class="a-ko heading-09"><i class="fas fa-envelope"></i> <@fmt.message key="eshop.askSmc"/></a></div>
                            </#if>
                        </div>
                        <div class="col-xl-3 col-md-6 pl-0">
                            <div class="mt-3"><a data-bind="click: addToFavouriteSelecteds.bind($data)" class="a-ko heading-09"><i class="fas fa-share"></i> <@fmt.message key="eshop.toFavourites"/></a></div>
                            <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'xlsx', '')" class="a-ko heading-09"><i class="fas fa-file-excel"></i> <@fmt.message key="eshop.XLS"/></a></div>
                            <#if !isTechnicalUser>
                                <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'xlsx', 'pd')" class="a-ko heading-09"><i class="fas fa-file-excel"></i> <@fmt.message key="eshopPD.XLS"/></a></div>
                            </#if>
                        </div>
                        <div class="col-xl-3 col-md-6 pl-0">
                            <div class="mt-3"><a class="a-ko heading-09" data-bind="click: saveBasket.bind($data)"><i class="fas fa-save"></i> <@fmt.message key="eshop.save"/></a></div>
                            <div class="mt-3"><a class="a-ko heading-09" onclick="shareBasketViewModel.init()"><i class="fas fa-save"></i> <@fmt.message key="eshop.saveAndSend"/></a></div>
                        </div>
                        <div class="col-xl-3 col-md-6 p-0">
                            <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'pdf', '')" class="a-ko heading-09"><i class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDF"/></a></div>
                            <#if !isTechnicalUser>
                                <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'pdf', 'pd')" class="a-ko heading-09"><i class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDPDF"/></a></div>
                            </#if>
                            <#if isTechnicalUser>
                                <div class="mt-3"><a data-bind="click: showAskSmcModal.bind($data)" class="a-ko heading-09"><i class="fas fa-envelope"></i> <@fmt.message key="eshop.askSmc"/></a></div>
                            </#if>

                        </div>

                        <smc.eshop.download-cads params="partnumbers: getSelected()">
                            <@hst.include ref="eshop-download-cads"/>
                        </smc.eshop.download-cads>
                        
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>
