<@security.authentication property="principal.selectedErp" var="selectedErp" />

<@security.authentication property="principal.hidenPrices" var="hidenPrices" />

<@fmt.message key="basket.available" var="labelAvailable"/>
<@fmt.message key="basket.partialAvailable" var="labelPartialAvailable"/>
<@fmt.message key="basket.notAvailable" var="labelNotAvailable"/>
<#assign pricesStyle="second-value mb-0 w-100">
<#if showListPrice && !showNetPrice>
    <#assign pricesStyle="value mb-1 w-100">
</#if>
<div class="row m-0 my-2 basket-product-box border border-secondary eshop-box-rounded">
    <div class="col-12 nopadding">
        <div class="row">
            <div class="col-lg-6 d-flex flex-column">
                <!-- Header-->
                <div class="basket-product-box-header row m-3">
                    <div class="col-12 nopadding">
                        <input class="select-favourite" data-bind="attr: {id: basketProductId}, checked: selected" type="checkbox">
                        <div class="position-relative div-for-spinner" data-bind="visible: (partnumberStatus() == $root.StateType.UPDATING || status() == $root.StateType.UPDATING) && $root.updating() == true">
                            <smc-spinner-inside-element params="loading: (partnumberStatus() == $root.StateType.UPDATING || status() == $root.StateType.UPDATING) && $root.updating() == true, isButton: true, backgroundColor: true"></smc-spinner-inside-element>
                        </div>
                        <a class="text-muted partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())" target="_blank"></a>
                        <span class="text-dark description" data-bind="text: name"></span>
                    </div>

                    <div class="col-12 mb-0 mb-lg-3 alert alert-warning" style="display:none" data-bind="visible: $parent.loadedViewModel && (quantityChanged() || partnumberCodeReplaced() || outOfStockWithFewPieces() )">
                        <label class="m-0">
                            <i class="fas fa-exclamation-triangle mr-2"></i>
                            <!-- ko if: quantityChanged() --><span data-bind="text: quantityChangedMessage"></span>.<!-- /ko -->
                            <#if selectedErp!=DYNAMICS_ERP>
                            	<!-- ko if: partnumberCodeReplaced() --><span data-bind="text: partnumberCodeReplacedMessage"></span>.<!-- /ko -->
                                <!-- ko if: outOfStock() --><@fmt.message key="basket.outOfStock"/>.<!-- /ko -->
                            <#else>
                                <!-- ko if: outOfStockWithFewPieces()--><span data-bind="text: outOfStockWithPiecesMessage"></span>.<!-- /ko -->
                            	<!-- ko if: partnumberCodeReplaced() && !morePiecesThanMaximunOffered() --><span data-bind="text: partnumberCodeReplacedMessage"></span>.<!-- /ko -->
                            	<!-- ko if: partnumberCodeReplaced() && !outOfStock() && morePiecesThanMaximunOffered()  --><span data-bind="text: moreThanMaximunOfferedMessage"></span>.<!-- /ko -->
                                
                             </#if>
                        </label>
                    </div>
                    <#if selectedErp!=DYNAMICS_ERP || selectedErp!=DYNAMICS_ERP>
                    <div class="col-12 mb-0 mb-lg-3 alert alert-warning" style="display:none" data-bind="visible: $parent.loadedViewModel && availability() === '2'">
                        <label class="m-0">
                            <i class="fas fa-exclamation-triangle mr-2"></i>
                            <span data-bind="text: sapOutOfStockMessage()"></span>
                        </label>
                    </div>
                    </#if>
                    
                     

                </div>

                <!-- Info medium-->
                <div class="row mb-3 ml-3 product-selection-item d-none d-lg-flex mt-auto">
                    <div class="col-md-4">
                        <!-- ko if: mediumImage()-->
                        <img data-bind="attr: {src: mediumImage()}">
                        <!-- /ko -->
                        <!-- ko if: !mediumImage() -->
                        <img src="${noImage}">
                        <!-- /ko -->
                    </div>
                    <div class="col-lg-8 eshop-option-tabs align-self-end p-0">
                        <!-- ko if: haveTechnicalInformation() || haveExtraTechnicalInformation() -->
                        <ul class="w-100">
                            <li class="heading-09 mt-3 mb-md-0 smc-tabs__head--active"><a class="collapsed" data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)" data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a></li>
                            <!-- ko if: personalizedType() == 'VC' || (productId() && productId() != '0')-->
                            <li class="heading-09 mt-3 mb-md-0  more-info-tab">
                                <a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partnumber(), $index(), personalizedType(), name())">
                                    <@fmt.message key="eshop.moreInfo"/>
                                </a>
                                <div class="spinner-inside more-info-tab-item ko-hide" data-bind="attr: {id: 'spinner' + $index()}">
                                    <div class="bounce"></div>
                                    <div class="bounce1"></div>
                                    <div class="bounce2"></div>
                                </div>
                                <div class="collapse more-info-tab-item" data-bind="attr: {id: 'moreInfo' + $index()}"></div>
                            </li>
                            <!-- /ko -->
                        </ul>
                        <!-- /ko -->
                    </div>
                </div>
            </div>
            <!-- Customer part number. sm-size -->
            <div class="col-12 d-sm-none d-block">
                <div class="col-md-5 mb-3">
                    <!-- CustPartNumber control only with logged users -->
                    <#if selectedErp==DYNAMICS_ERP>
                        <!-- ko if: haveCustomerPartNumber()  -->       
                        <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                        <input class="form-control w-100">     
                        <!-- /ko -->
                    <#else>
                    <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                    <input class="form-control w-100">  
                   </#if>
                </div>
            </div>
            <!-- Product details block -->
            <div class="col-lg-6 pl-lg-0 pl-3 basket-product-box-details">
                <div class="col-12">
                    <!-- Product detail head TODO: ERP improvement-->
                    <div class="row mb-3 details-head" data-bind="css: { 'multiline': lines().length > 1 }">
                        <!-- Customer part number. !sm-size -->
                        <#if selectedErp==DYNAMICS_ERP>
                        <!-- ko if: haveCustomerPartNumber()  -->       
                            <div class="col-4 d-none d-sm-block">
                                <label class=""><@fmt.message key="eshop.customerPartNumber"/></label>
                            </div>   
                        <!-- /ko -->
                        <!-- ko ifnot: haveCustomerPartNumber()  --> 
                             <div class="col-4 d-none d-sm-block">
                             </div>
                        <!-- /ko -->
                        <#else>
                        <div class="col-4 d-none d-sm-block">
                            <label class=""><@fmt.message key="eshop.customerPartNumber"/></label>
                        </div>
                        </#if>
                        <#if !hidenPrices>
                                <div class="col-sm-3 col-4">
                        <#else>
                        <div class="col-sm-3"></div>
                        <div class="col-sm-5 col-4">
                        </#if>
                        <label><@fmt.message key="eshop.quantity"/></label>
                         </div>
                        <#if !hidenPrices>
                        <div class="col-sm-2 col-4 pl-0 pr-0">
                            <#if showNetPrice>
                            <label class="w-100"><@fmt.message key="eshop.netPrice"/></label>
                            </#if>
                            <#if showListPrice>
                                <#if !showNetPrice>
                                <label class="w-100">
                                <#else>
                                <label class="second-value w-100 mb-0">
                                </#if>
                                <@fmt.message key="eshop.listPrice"/></label>
                            </#if>
                        </div>
                        <div class="col-sm-3 col-4 pl-0">
                            <label class="ml-3"><@fmt.message key="eshop.totalPrice"/></label>
                        </div>
                        </#if>
                    </div>
                </div>
                <div class="row m-0 product-details-grid">
                    <div class="col-12">
                        
                        <!-- Product detail list -->
                        <ul class="product-details-list m-0 p-0">
                            <li>
                                <div class="row justify-content-end">
                                    <!-- ko foreach: lines -->
                                    <div class="col-4 pr-sm-0 d-none d-sm-block">
                                             <!-- ko if: $index() == 0 -->
                                                 <!-- ko if: $parent.customerPartnumber() && $parent.customerPartnumber() != '' -->
                                                    <span data-bind="text: $parent.customerPartnumber()"></span>
                                                    <!-- /ko -->
                                            <!-- ko if: selectedErp!=DYNAMICS_ERP && (!($parent.customerPartnumber()) || $parent.customerPartnumber() == '') -->
                                                <input type="text" class="form-control float-left" data-bind="value: $parent.customerPartnumberInput, submit: $parent.updateCustomerPartnumber.bind($data), event: {blur: $parent.updateCustomerPartnumber.bind($data)}">
                                            <!-- /ko -->
                                    <!-- /ko -->
                                    </div>
                                    
                                    <#if !hidenPrices>
                                    <div class="col-sm-8" >
                                    <#else>
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-5">
                                    </#if>
                                        <div class="row">
                                            <!-- Quantity -->
                                            <#if !hidenPrices>
                                            <div class="col-4">
                                            <#else>
                                            <div class="col-5 pr-0">
                                            </#if>
                                                <input class="form-control float-left" type="text" maxlength="3" data-bind="value: quantity, attr: {disabled: basketProduct.status() == $root.StateType.UPDATING}, event: { 'keyup': checkQuantity }, numeric: 1">
                                            </div>
                                            <!-- Net/List price -->
                                            <#if !hidenPrices>
                                            <div class="col-4 pr-0">
                                            <#else>
                                            <div class="col-3 pr-0">
                                            </#if>
                                                <!-- ko if: $index() == 0 -->
                                                <#if showNetPrice>
                                                    <label class="value mb-1 w-100" data-bind="text: $parent.netPrice() + ' ' + $parent.currency()"></label>
                                                </#if>
                                                <#if showListPrice>
                                                <label class="${pricesStyle}" data-bind="text: $parent.listPrice()  + ' ' + $parent.currency()"></label>
                                                </#if>
                                                <!-- /ko -->
                                            </div>
                                            <!-- Total -->
                                            <div class="col-4 pl-0 pr-1">
                                                <#if showNetPrice>
                                                <label class="value mb-1 w-100" data-bind="text: totalNetPrice() + ' ' + $parent.currency()"></label>
                                                </#if>
                                                <#if showListPrice>
                                                <label class="${pricesStyle}" data-bind="text: totalListPrice() + ' ' + $parent.currency()"></label>
                                                </#if>
                                            </div>
                                            <div class="col-12 date-block last pb-2 mt-3">
                                                <!-- Fin última linea -->
                                                <div><label class="option-label"><#if selectedErp!=DYNAMICS_ERP><@fmt.message key="basket.deliveryDate"/><#else><@fmt.message key="basket.dynamics.deliveryDate"/></#if>: </label><label class="value mb-1" data-bind="text: deliveryDate()"></label></div>
                                                <div>
                                                    <#if selectedErp=="MOVEX" >
                                                    <label class="option-label mb-0"><@fmt.message key="eshop.bestArchievableDate"/>: </label><label class="value mb-0" data-bind="text: $parent.bestAchievableDeliveryDate()"></label>
                                                    <#elseif selectedErp=="SAP">
                                                    <label class="option-label mb-0"><@fmt.message key="basket.availability"/>: </label><label class="value mb-0 sap-dot-availability" data-bind="attr:{ title: checkSapAvailability($parent.availability())}, css: {'bg-error': $parent.availability() == '0', 'bg-success': $parent.availability() == '1', 'bg-warning': $parent.availability() == '2' }"></label>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /ko -->

                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Product details layer-->
        <div class="col-12 basket-product-box-info d-lg-none">
            <div class="row mb-md-3 ml-md-3 mr-md-3 product-selection-item">
                <div class="col-md-4">
                    <img data-bind="attr: {src: mediumImage()}">
                </div>
                <div class="col-md-8 eshop-option-tabs align-self-end">
                    <!-- ko if: haveTechnicalInformation() -->
                    <ul class="w-100">
                        <li class="heading-09 mb-3 mb-md-0 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)" data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a></li>
                        <!-- ko if: personalizedType() == 'VC' || (productId() && productId() != '0')-->
                        <li class="heading-09 mb-3 mb-md-0 more-info-tab">
                                <a class="collapsed more-info-tab-item" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partnumber(), $index(), personalizedType(), name())">
                                    <@fmt.message key="eshop.moreInfo"/>
                                </a>
                                <div class="spinner-inside more-info-tab-item ko-hide" data-bind="attr: {id: 'spinner' + $index()}">
                                    <div class="bounce"></div>
                                    <div class="bounce1"></div>
                                    <div class="bounce2"></div>
                                </div>
                        </li> 
                        <!-- /ko -->
                    </ul>
                    <!-- /ko -->
                </div>
            </div>
        </div>
        <div class="eshop-tab-line" style=""></div>
        <div class="eshop-tabs">
            <section class="container collapse more-info-mobile" data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>
            <section class="container collapse" data-bind="attr: {id: 'details' + basketProductId}">
                <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                    <div class="simple-collapse__bodyInner">
                        <div class="row">
                            <div class="col-12">
                                <!-- ko if: !details().detailsPart1 && !taricCode() && countryOfOrigin() -->
                                <div class="row col-12">
                                    <div class="col-12">
                                        <div class="alert alert-danger" role="alert">
                                            <@fmt.message key="eshop.detailsErrorMssg"/>
                                        </div>
                                    </div>
                                </div>
                                <!-- /ko -->
                                <!-- ko foreach: details().detailsPart1 -->
                                <div class="detail-row p-1">
                                    <span class="text-muted" data-bind="text: basketViewModel.splitString($data,':', 0, true)"></span>
                                    <span class="text-dark" data-bind="text: basketViewModel.splitString($data,':', 1, false)"></span>
                                </div>
                                <!-- /ko -->
                            
                                <!-- ko foreach: details().detailsPart2 -->
                                <div class="detail-row p-1">
                                    <span class="text-muted" data-bind="text: basketViewModel.splitString($data,':', 0, true)"></span>
                                    <span class="text-dark" data-bind="text: basketViewModel.splitString($data,':', 1, false)"></span>
                                </div>
                                <!-- /ko -->
                            <!-- ko if: taricCode() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.taricCode"/></span>
                                <span class="text-dark" data-bind="text: taricCode()"></span>
                            </div>
                            <!-- /ko -->
                            <!-- ko if: countryOfOrigin() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.countryOfOrigin"/></span>
                                <span class="text-dark" data-bind="text: countryOfOrigin()"></span>
                            </div>
                            <!-- /ko -->
                            <!-- ko if: eclass() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.eclass"/></span>
                                <span class="text-dark" data-bind="text: eclass()"></span>
                            </div>
                            <!-- /ko -->
                            <!-- ko if: eclassVersion() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.eclassVersion"/></span>
                                <span class="text-dark" data-bind="text: eclassVersion()"></span>
                            </div>
                            <!-- /ko -->
                            <!-- ko if: unspscNumber() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.unspscNumber"/></span>
                                <span class="text-dark" data-bind="text: unspscNumber()"></span>
                            </div>
                            <!-- /ko -->
                            <!-- ko if: unspscVersion() -->
                            <div class="detail-row p-1">
                                <span class="text-muted"><@fmt.message key="eshop.unspscVersion"/></span>
                                <span class="text-dark" data-bind="text: unspscVersion()"></span>
                            </div>
                            <!-- /ko -->
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>