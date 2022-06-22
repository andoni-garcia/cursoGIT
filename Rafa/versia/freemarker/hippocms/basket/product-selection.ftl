<@fmt.message key="basket.partnumberPlaceholder" var="partnumberPlaceholder"/>
<@fmt.message key="eshop.searchPlaceholder" var="searchPlaceHolder"/>

<main class="smc-main-container eshop">
    <div class="mb-30 container">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
    <div>
        <div>
            <div class="container">
                <div class="cmseditlink">
                </div>
                <h2 class="heading-08 color-blue mt-20"><@fmt.message key="product.selection.title"/></h2>
                <#if isAuthenticated>
                    <strong>${principalFullname}</strong>
                    <h1 class="heading-02 heading-main">${principalName}</h1>
                </#if>
            </div>
        </div>
    </div>
    <br>
    <div class="container">
        <div class="row">
            <div class="col-12" id="new_box_container">
                <!-- Basket filters -->
                <div class="form-row">
                    <div class="form-group col-md-9">
                        <input class="form-control w-100" id="bsk-search-filter"
                               data-bind="value: filter, valueUpdate: 'afterkeydown'" placeholder="${searchPlaceHolder}"
                               type="text">
                    </div>
                    <div class="form-group col-md-3">
                        <button type="button" class="btn btn-primary w-100"
                                data-bind="click: clearFilter.bind($data)"><@fmt.message key="eshop.showAll"/></button>
                    </div>
                </div>

                
                <#if scanVisible?? && scanVisible == "1">
                	<div class="row align-bottom mb-4">
                	<!-- Add to list -->
                    	<div class="col-lg-12">
                        	<div class="row">
                            
                            	<div class="col-12 col-xl-4 pl-3 pr-0 align-self-end text-right mb-3">
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
                            
                            	<div class="col-12 col-md-12 col-xl-5 pl-xl-0 pr-3 mb-3">
                                	<input id="bsk-partnumber-input1" class="form-control"
                                    	   data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, valueUpdate: 'afterkeydown', submit: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')"
                                       	placeholder="${partnumberPlaceholder}">
                            	</div>
                            	<div class="col-12 col-xl-3 pl-xl-0 align-self-end text-right mb-3">
                                	<button id="bsk-partnumber-addtobasket1" type="button"
                                    	    data-bind="attr: {'data-bind': ''}, click: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')"
                                        	class="btn btn-primary w-100 position-relative">
                                    	<smc-spinner-inside-element
                                        	    params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                    	<@fmt.message key="eshop.addToList"/>
                               	 </button>
                         	   </div>
                      	  </div>
                  	  </div>
               	 </div>
                <#else>
                	<div class="row align-bottom">
                		 <!-- Add to list -->
                    	<div class="col-lg-12">
                        	<div class="row">
                            	<div class="col-md-12 col-xl-7 pr-3 pr-xl-0 mb-3">
                                	<input id="bsk-partnumber-input1" class="form-control" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, valueUpdate: 'afterkeydown', submit: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" placeholder="${partnumberPlaceholder}">
                            	</div>
                            	<div class="col-12 col-xl-5 align-self-end text-right mb-3">
                                	<button id="bsk-partnumber-addtobasket1" type="button" data-bind="attr: {'data-bind': ''}, click: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" class="btn btn-primary w-100 position-relative">
                                    	<smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                    	<@fmt.message key="eshop.addToList"/>
                               	 </button>
                           	 </div>
                      	  </div>
                 	   </div>
               	 </div>
                </#if>

                <div class="row m-0">
                    <div class="offset-md-6 col-md-6 nopadding">
                        <div class="dropdown smc-select">
                            <select id="bks-products-order"
                                    data-bind="options: basketProductOrderArr, optionsText: 'name', optionsValue: 'order', value: selectBasketOrder"></select>
                        </div>
                    </div>
                </div>
                <!-- Basket product box -->
                <@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>

                <div id="bsk-product-list" style="display: none;" data-bind="visible: loadedViewModel">
                    <!-- ko if: productsFilter().length > 0 -->
                    <!-- ko foreach: productsFilter -->
                    <div class="row m-0 my-2 basket-product-box border border-secondary eshop-box-rounded">
                        <div class="col-12 nopadding">
                            <smc-spinner-inside-element
                                    params="loading: status() == $root.StateType.UPDATING"></smc-spinner-inside-element>
                            <div class="row m-3">
                                <div class="col-12 nopadding">
                                    <input class="select-favourite"
                                           data-bind="attr: {id: basketProductId}, checked: selected" type="checkbox">
                                    <a class="text-muted partnumber-href"
                                       data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, click: GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())"
                                       target="_blank"></a>
                                    <span class="text-dark description" data-bind="text: name"></span>
                                </div>
                            </div>
                            <div class="row m-3 product-selection-item">
                                <div class="col-md-2">
                                    <!-- ko if: mediumImage-->
                                    <img data-bind="attr: {src: mediumImage}">
                                    <!-- /ko -->
                                    <!-- ko ifnot: mediumImage -->
                                    <img src="${noImage}">
                                    <!-- /ko -->
                                </div>
                                <div class="col-lg-3 align-self-end nopadding">
                                    <!-- CustPartNumber control only with logged users -->
                                    <#if isAuthenticated>
                                        <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                                        <input class="form-control w-100"
                                               data-bind="value: customerPartnumber, event: { blur: updateLightCustomerPartnumber.bind($data)}">
                                    </#if>
                                </div>
                                <div class="col-lg-7 eshop-option-tabs prod-select-option-tabs align-self-end">
                                    <div class="row">
                                        <!-- ko if: productId -->
                                        <ul>
                                            <li class="heading-09 mt-3 smc-tabs__head--active"><a class="collapsed"
                                                                                                  data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)"
                                                                                                  data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a>
                                            </li>
                                            <li class="heading-09 prod-selection-tab more-info-tab">
                                                <a class="collapsed" data-toggle="collapse"
                                                   data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partnumber(), $index(), personalizedType(), name())">
                                                    <@fmt.message key="eshop.moreInfo"/>
                                                </a>
                                                <div class="spinner-inside  ko-hide"
                                                     data-bind="attr: {id: 'spinner' + $index()}">
                                                    <div class="bounce"></div>
                                                    <div class="bounce1"></div>
                                                    <div class="bounce2"></div>
                                                </div>
                                                <div class="collapse prod-selection more-info-tab-item"
                                                     data-bind="attr: {id: 'moreInfo' + $index()}"></div>
                                            </li>
                                        </ul>
                                        <!-- /ko -->
                                    </div>
                                </div>
                            </div>
                            <div class="eshop-tabs">
                                <section class="container collapse more-info-mobile"
                                         data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>
                                <section class="container collapse" data-bind="attr: {id: 'details' + basketProductId}">
                                    <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                                        <div class="simple-collapse__bodyInner">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <!-- ko if: !details().detailsPart1 -->
                                                    <div class="row col-12">
                                                        <div class="col-12">
                                                            <div class="alert alert-danger" role="alert">
                                                                <@fmt.message key="eshop.detailsErrorMssg"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- /ko -->
                                                    <!-- ko foreach: details().detailsPart1 -->
                                                    <div>
                                                        <span class="text-muted"
                                                              data-bind="text: basketViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark"
                                                              data-bind="text: basketViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                    <!-- /ko -->
                                                </div>
                                                <div class="col-md-6">
                                                    <!-- ko foreach: details().detailsPart2 -->
                                                    <div>
                                                        <span class="text-muted"
                                                              data-bind="text: basketViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark"
                                                              data-bind="text: basketViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                    <!-- /ko -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                    <!-- /ko -->
                    <!-- ko if: productsFilter().length == 0 -->
                    <div class="row m-0 p-3 mt-5 mb-5 my-2 basket-product-box border border-secondary eshop-box-rounded">
                        <smc-spinner-inside-element params="loading: !firstDataLoad()">
                            <#include "../../../js/knockout/templates/smc-spinner-inside-element.html">
                        </smc-spinner-inside-element>
                        <div class="col-12" data-bind="visible: firstDataLoad()" style="display:none">
                            <@fmt.message key="basket.mssg.noProductsAvailableForOrder"/>
                        </div>
                    </div>
                    <!-- /ko -->

                    <!-- ko if: productsFilter().length > 2 -->
                    <!-- Add to list -->
                    <div class="row align-bottom">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-md-12 col-xl-7 pr-3 pr-xl-0 mb-3">
                                    <input id="bsk-partnumber-input1" class="form-control"
                                           data-bind="attr: {'data-bind': ''}, value: boxInputPartnumber, valueUpdate: 'afterkeydown', submit: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')"
                                           placeholder="${partnumberPlaceholder}">
                                </div>
                                <div class="col-12 col-xl-5 align-self-end text-right mb-3">
                                    <button id="bsk-partnumber-addtobasket1" type="button"
                                            data-bind="attr: {'data-bind': ''}, click: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')"
                                            class="btn btn-primary w-100 position-relative">
                                        <smc-spinner-inside-element
                                                params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                                        <@fmt.message key="eshop.addToList"/>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->

                    <!-- Basket options -->
                    <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                        <div class="row m-3 w-100">
                            <div class="col-12 nopadding">
                                <smc-select-all-check
                                        params="list: $root.productsFilter, field: 'selected'"><#include "../components/selectall-check.ftl"/></smc-select-all-check>
                            </div>

                            <div class="col-xl-3 col-md-6 pl-0">
                                <div class="mt-3"><a data-bind="click: deleteSelected.bind($data, 'BASKET')"
                                                     class="a-ko heading-09"><i
                                                class="fas fa-trash"></i> <@fmt.message key="eshop.deleteProducts"/></a>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 pl-0">
                                <div class="mt-3"><a data-bind="click: addToFavouriteSelecteds.bind($data, 'BASKET')"
                                                     class="a-ko heading-09"><i
                                                class="fas fa-share"></i> <@fmt.message key="eshop.toFavourites"/></a>
                                </div>
                            </div>
                            <#if isLightUser || isInternal>
                                <div class="col-xl-3 col-md-6 pl-0">
                                    <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'xlsx', '')"
                                                         class="a-ko heading-09"><i
                                                    class="fas fa-file-excel"></i> <@fmt.message key="eshop.XLS"/></a>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6 p-0">
                                    <div class="mt-3"><a data-bind="click: exportBasket.bind($data, 'pdf', '')"
                                                         class="a-ko heading-09"><i
                                                    class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDF"/>
                                        </a></div>
                                </div>

                                <smc.eshop.download-cads params="partnumbers: getSelected()">
                                    <@hst.include ref="eshop-download-cads"/>
                                </smc.eshop.download-cads>
                                
                            </#if>
                        </div>

                    </div>

                </div>
            </div>
        </div>
</main>
