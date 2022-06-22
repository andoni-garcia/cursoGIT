
<@hst.link var="basketUrl" siteMapItemRefId="basket"/>
<@hst.link var="orderUrl" siteMapItemRefId="order"/>
<@hst.link var="orderStatusUrl" siteMapItemRefId="orderStatus"/>

<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@security.authentication property="principal.hidenPrices" var="hidenPrices" />

<#assign priceStyle="text-gray">
<#if showListPrice && !showNetPrice>
    <#assign priceStyle=""/>
</#if>
<div class="cart-selector logged text-01" data-swiftype-index="false">
    <div id="iconMoreInfoModal" class="layer-more-info hide"></div>
    <div class="cart__mega__left">
        <div class="smc-tabs pl-3 pr-3 pb-3">
            <span class="heading-04 p-0"><@fmt.message key="basket.title"/></span>
            <div class="smc-close-button" data-swiftype-index="false">×</div>
            <p class="m-0 p-0 mt-3"><@fmt.message key="basket.layer.description.top"/></p>
            <a href="${basketUrl}" class="btn btn-primary w-100 mt-3"><@fmt.message key="eshop.goToDetails"/></a>  
            <#if !isTechnicalUser && !isAdvancedUser && !isOciUser && !isSaparibaUser><a href="${orderUrl}" class="btn btn-primary w-100 mt-3" data-bind="click: goToOrderMenu"><@fmt.message key="eshop.goToOrder"/></a></#if>
            <#if principalShowOrderStatus?? && principalShowOrderStatus == "1"><a href="${orderStatusUrl}" class="btn btn-primary w-100 mt-3"><@fmt.message key="eshop.goToOrderStatus"/></a></#if>
        </div>
            <#if hide_contact_area?c == "false">
            <div class="cart-selector__footer blue p-0 pt-3">
                <h2 class="heading-04"><@fmt.message key="eshop.smcPneumatics"/></h2>
                <#if contactEmail?has_content && contactEmail != "do_not_display"><p><i class="far fa-envelope"></i> <a href="mailto:${contactEmail}"><span class="contact-info m-2">${contactEmail}</span></a></p></#if>
                <#if contactTelephone?has_content && contactTelephone != "do_not_display"><p><i class="fas fa-phone"></i> <a href="tel:${contactTelephone}"><span class="contact-info m-2">${contactTelephone}</span></a></p></#if>
            </div>
            </#if>
    </div>
    <div class="cart__mega__right eshop_cart">
        <div class="cart-grid-header-block">
            <div class="row m-0">
                <div class="col-4 pl-0">
                    <label class="header"><@fmt.message key="eshop.partnumber"/></label>
                    <label class="header"><i><@fmt.message key="eshop.customerPartNumber"/></i></label>
                </div>
                <div class="col-2">
                    <label class="header"><@fmt.message key="eshop.qty"/></label>
                </div>
                <#if !isTechnicalUser>
                <div class="col-2">
                    <label class="header"><#if selectedErp!=DYNAMICS_ERP><@fmt.message key="basket.deliveryDate"/><#else><@fmt.message key="basket.dynamics.deliveryDate"/></#if></label>
                </div>
                <#if selectedErp?? && selectedErp=="SAP">
                <div class="col-1">
                    <@fmt.message key="basket.availability.abbr"/>
                </div>
                <div class="col-2 align-right">
                <#else>
                <div class="col-3 align-right">
                </#if>
                    <#if showNetPrice>
                    <label class="header"><@fmt.message key="eshop.netPrice.abbr"/></label><br>
                    </#if>
                    <#if showListPrice>
                        <#if !showNetPrice>
                        <label class="header">
                        <#else>
                        <label>
                        </#if>
                        <i><@fmt.message key="eshop.listPrice"/></i></label>
                    </#if>
                </div>
                <#else>
                <div class="col-5"></div>
                </#if>
            </div>
        </div>
        <div class="cart-grid-list-block mb-0 position-relative">
            <smc-spinner-inside-element params="loading: !firstDataLoad()"></smc-spinner-inside-element>
            <ul id="basket-product-list">
                <!-- ko foreach: products -->

                    <!-- ko if: lines().length == 0 -->
                    <li class="position-relative">
                        <smc-spinner-inside-element params="loading: status() == $root.StateType.UPDATING"></smc-spinner-inside-element>

                            <div class="row m-0 grid_line" data-bind="css: { 'alert alert-danger mb-1 pr-1r': !valid() && status() != $root.StateType.UPDATING}">
                                <div class="col-4 pl-0">
                                    <div>
                                        <!-- ko if: status() !== 'UPDATING' && !valid() -->
                                            <i class="fa fa-exclamation-triangle" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="eshop.product.notAvailableWebshop"/>"></i>
                                        <!-- /ko -->
                                        <a class="partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())" target="_blank"></a>
                                    </div>
                                    <div><span data-bind="text: customerPartnumber()"></span></div>
                                </div>
                                <div class="col-2 p-0">
                                    <#if isTechnicalUser>
                                    <input class="form-control mt-2 mb-2" type="text" maxlength="3" data-bind="attr: {id: 'bskly-quantity-' + basketProductId + '-' + $index(), 'data-bind': '', numeric: 1, disabled: status() == 'UPDATING'}, value: quantity">
                                    </#if>
                                </div>
                                
                                <#if !isTechnicalUser>
                                <!-- ko if: valid() -->
                                <div class="col-2"></div>
                                <div class="col-3 align-right"></div>
                                <!-- /ko -->
                                <div class="pl-0" data-bind="css: {'col-1 align-left': valid(), 'col-6 align-right': !valid(), 'pr-0': status() != $root.StateType.UPDATING}">
                                <#else>
                                <div class="col-6 pl-0 align-right" data-bind="css: {'pr-0': !valid() && status() != $root.StateType.UPDATING}">
                                </#if>
                                    <a class="a-ko"><i class="fas fa-info-circle" data-bind="click: $root.getLayerMoreInfo.bind($data, $parent)"></i></a>
                                    <a class="a-ko" data-bind="attr: {id: 'bskly-delete-' + basketProductId, 'data-bind': ''}, click: $root.deleteFromBasket.bind($data, basketProductId, 'BASKET LAYER')"><i class="fas fa-trash ml-2"></i></a>
                                </div>
                            </div>

                    </li>
                    <!-- /ko -->

                    <!-- ko if: lines().length > 0 -->
                    <!-- ko foreach: lines --> 
                    <li class="position-relative">
                        <smc-spinner-inside-element params="loading: status() == $root.StateType.UPDATING"></smc-spinner-inside-element>
                        <div class="row m-0 grid_line" data-bind="css: {'pr-0 pl-0 alert alert-warning mb-1': $parent.quantityChanged() || $parent.partnumberCodeReplaced() || $parent.outOfStock() || (selectedErp!=DYNAMICS_ERP && $parent.availability() === '2')}">
                            <div class="col-4 pl-0">
                                <!-- ko if: $index() == 0 -->
                                <!-- ko if: $parent.status() !== 'UPDATING' && $parent.valid() -->
                                    <!-- ko if: $parent.showWarning() --><i class="fas fa-exclamation-triangle ml-3" data-bind="attr: {title: $parent.warningMessage()}"></i><!-- /ko -->
                                <!-- /ko -->
                                <a class="partnumber-href" data-bind="text: $parent.personalizedPartnumber() != null ? $parent.personalizedPartnumber() : $parent.partnumber, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, $parent.partnumber(), $parent.personalizedType()) " target="_blank"></a>
                                <div data-bind="css: {'ml-3': $parent.quantityChanged() || $parent.partnumberCodeReplaced() || $parent.outOfStock() || $parent.availability() === '2'}"><span data-bind="text: $parent.customerPartnumber()"></span></div>
                                <!-- /ko -->
                            </div>
                            <div class="col-2 p-0">
                                <input class="form-control mt-2 mb-2" type="text" maxlength="3" data-bind="attr: {id: 'bskly-quantity-' + $parent.basketProductId + '-' + $index(), 'data-bind': '', numeric: 1, disabled: $parent.status() == 'UPDATING'}, value: quantity">
                            </div>
                            <#if !isTechnicalUser>
                            <div class="col-2">
                                <span class="" data-bind="text: deliveryDate()"></span>
                            </div>
                            <#if selectedErp?? && selectedErp=="SAP">
                            <div class="col-1">
                            <label class="value mb-0 sap-dot-availability" data-bind="attr:{ title: checkSapAvailability($parent.availability())}, css: {'bg-error': $parent.availability() == '0', 'bg-success': $parent.availability() == '1', 'bg-warning': $parent.availability() == '2' }"></label>
                            </div>
                            <div class="col-2 align-right">
                            <#else>
                            <div class="col-3 align-right">
                            </#if>
                                <#if showNetPrice><span class="" data-bind="text: totalNetPrice() + ' ' + $parent.currency()"></span><br></#if>
                                <#if showListPrice><span class="${priceStyle}" data-bind="text: totalListPrice()  + ' ' + $parent.currency()"></span></#if>
                            </div>
                            <#else>
                            <div class="col-5"></div>
                            </#if>
                            <div class="col-1 pl-0 pr-0 align-left">
                                <!-- ko if: $index() == 0 -->
                                <a class="a-ko" data-bind="click: $root.getLayerMoreInfo.bind($data, $parent)"><i class="fas fa-info-circle"></i></a>
                                <a class="a-ko" data-bind="attr: {id: 'bskly-delete-' + $parent.basketProductId, 'data-bind': ''}, click: $root.deleteFromBasket.bind($data, $parent.basketProductId, 'BASKET LAYER')"><i class="fas fa-trash ml-2"></i></a>
                                <!-- /ko -->
                            </div>
                        </div>
                    </li>
                    <!-- /ko -->
                    <!-- /ko -->
                <!-- /ko -->
            </ul>
        </div>
        <!-- Total -->
        <div class="cart-grid__footer blue">
            <div class="total-blue-box">
                <div class="row">
                    <div class="col-6">
                        <#if !hidenPrices>
                        <#if showNetPrice><label><@fmt.message key="eshop.totalNetPrice"/></label><br></#if>
                        <#if showListPrice><label class="<#if showNetPrice>text-gray</#if>"><@fmt.message key="eshop.totalListPrice"/></label></#if>
                        </#if>
                    </div>
                    <div class="col-4 align-right">
                        <#if !hidenPrices>
                        <!-- ko if: totalListPrice() == 0 && totalNetPrice() == 0 -->
                        <label></label>-<br>
                        <label class="text-gray">-</label>
                        <!-- /ko -->
                        <!-- ko if: totalListPrice() != 0 || totalNetPrice() != 0 -->
                        <#if showNetPrice><label data-bind="text: totalNetPrice() + ' ' + currency()"></label><br></#if>
                        <#if showListPrice><label class="${listPriceStyle}" data-bind="text: totalListPrice() + ' ' + currency()"></label></#if>
                        <!-- /ko -->
                        </#if>
                    </div>

                    <div class="col-2 text-right delete-all-button">
                        <a id="bskly-deleteall" data-bind="click: deleteFromBasketAll.bind($data, 'BASKET LAYER')" class="a-kons text-white"><i class="fas fa-trash"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add to list block -->
        <div class="add-to-list-block mb-3 row">
        <#if scanVisible?? && scanVisible == "1">
            <div class="col-3 pr-0">
                <div class="row p-0 m-0">
                    <div class="col-10 pl-0 pr-0">
                        <button id="btn-scan" class="btn btn-primary w-100" type="button"
                        data-toggle="modal"
                        data-scan="bskly-add-partnumber"
                        data-target="#livestream_scanner"><img class="mr-2"
                                                                    src="<@hst.webfile path="/images/icon_barcode.svg"/>"
                                                                    width="25"/><@fmt.message key="scan.btn"/>
                        </button>
                    </div>
                    <div class="col-1 pr-0 bsk-scan__divider--vr">
                    </div>
                </div>
                
            </div>
            <div class="col-4 pl-0 pr-0">
                <input id="bskly-add-partnumber" type="text" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumberLayer, valueUpdate: 'afterkeydown', submit: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER'), jqAuto: { autoFocus: true }, jqAutoSource: listOfMatches, jqAutoQuery: getMatches, jqAutoValue: boxInputPartnumber(), jqAutoSourceLabel: 'value', jqAutoSourceInputValue: 'value', jqAutoSourceValue: 'value', jqContainerId: 'container-top-autocomplete'" class="form-control float-left" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true" placeholder="${partnumberPlaceholder}">
                <div id="container-top-autocomplete"></div>
            </div>
            <div class="col-2 pr-0">
                <input id="bskly-add-quantity" type="number" max="999" data-bind="attr: {'data-bind': ''}, value: boxInputQuantity, numeric: 1, submit: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER'), valueUpdate: 'afterkeydown'" class="form-control float-left" value="1">
            </div>
            <div class="col-3">
                <button id="bskly-add-button" data-bind="attr: {'data-bind': ''}, click: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER')" class="btn btn-primary w-100 position-relative" type="button">
                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                    <@fmt.message key="eshop.addToBasket"/>
                </button>
            </div>
        </div>
        <#else>
           <div class="col-6 pr-0">
                <input id="bskly-add-partnumber" type="text" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumberLayer, valueUpdate: 'afterkeydown', submit: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER'), jqAuto: { autoFocus: true }, jqAutoSource: listOfMatches, jqAutoQuery: getMatches, jqAutoValue: boxInputPartnumber(), jqAutoSourceLabel: 'value', jqAutoSourceInputValue: 'value', jqAutoSourceValue: 'value', jqContainerId: 'container-top-autocomplete'" class="form-control float-left" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true" placeholder="${partnumberPlaceholder}">
                <div id="container-top-autocomplete"></div>
            </div>
            <div class="col-2">
                <input id="bskly-add-quantity" type="number" max="999" data-bind="attr: {'data-bind': ''}, value: boxInputQuantity, numeric: 1, submit: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER'), valueUpdate: 'afterkeydown'" class="form-control float-left" value="1">
            </div>
            <div class="col-4">
                <button id="bskly-add-button" data-bind="attr: {'data-bind': ''}, click: addToBasketSubmit.bind($data, boxInputPartnumberLayer(), PartnumberType.ANY, 'BASKET LAYER')" class="btn btn-primary w-100 position-relative" type="button">
                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                    <@fmt.message key="eshop.addToBasket"/>
                </button>
            </div>
        </div>
        </#if>
    </div>
</div>
