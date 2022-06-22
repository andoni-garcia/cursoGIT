<div class="row m-0 my-2 basket-product-box border border-secondary eshop-box-rounded">
    <div class="col-12 nopadding">
        <smc-spinner-inside-element params="loading: status() == $root.StateType.UPDATING"></smc-spinner-inside-element>
        <div class="row">
            <div class="col-lg-6 d-flex flex-column">
                <!-- Header-->
                <div class="basket-product-box-header row m-3">
                    <div class="col-12 nopadding">
                        <input class="select-favourite" data-bind="attr: {id: basketProductId}, checked: selected" type="checkbox">
                        <a class="text-muted partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, toUpperCase, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())" target="_blank"></a>
                        <span class="text-dark description" data-bind="text: name"></span>
                    </div>

                    <div class="col-12 mb-0 mb-lg-3 alert alert-warning" style="display:none" data-bind="visible: $parent.loadedViewModel && (quantityChanged() || partnumberCodeReplaced())">
                        <label class="m-0">
                            <i class="fas fa-exclamation-triangle mr-2"></i>
                            <!-- ko if: quantityChanged() --><span data-bind="text: quantityChangedMessage"></span>.<!-- /ko -->
                            <!-- ko if: partnumberCodeReplaced() --><span data-bind="text: partnumberCodeReplacedMessage"></span>.<!-- /ko -->
                            <!-- ko if: outOfStock() --><@fmt.message key="basket.outOfStock"/>.<!-- /ko -->
                        </label>
                    </div>
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
                        <!-- ko if: productId() && productId() != '0' -->
                        <ul class="w-100">
                            <li class="heading-09 mt-3 mb-md-0 smc-tabs__head--active"><a class="collapsed" data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)" data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a></li>
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
                        </ul>
                        <!-- /ko -->
                    </div>
                </div>
            </div>
            <!-- Customer part number. sm-size -->
            <div class="col-12 d-sm-none d-block">
                <div class="col-md-5 mb-3">
                    <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                    <input class="form-control w-100">
                </div>
            </div>
            <!-- Product details block -->
            <div class="col-lg-6 pl-lg-0 pl-3 basket-product-box-details">
                <div class="col-12">
                    <!-- Product detail head -->
                    <div class="row mb-3 details-head">
                        <!-- Customer part number. !sm-size -->
                        <div class="col-4 d-none d-sm-block">
                            <label class=""><@fmt.message key="eshop.customerPartNumber"/></label>
                        </div>
                        <div class="col-sm-3">
                            <label><@fmt.message key="eshop.quantity"/></label>
                        </div>
                    </div>
                </div>
                <div class="row m-0 product-details-grid">
                    <div class="col-12">
                        <!-- Product detail list -->
                        <ul class="product-details-list m-0 p-0">
                            <li>
                                <div class="row justify-content-end">
                                    <div class="col-4 pr-sm-0 d-none d-sm-block">
                                        <!-- ko if: customerPartnumber() && customerPartnumber() != '' -->
                                        <span data-bind="text: customerPartnumber()"></span>
                                        <!-- /ko -->
                                        <!-- ko if: !(customerPartnumber()) || customerPartnumber() == '' -->
                                        <input type="text" class="form-control float-left" data-bind="value: customerPartnumberInput, submit: updateCustomerPartnumber.bind($data), event: {blur: updateCustomerPartnumber.bind($data)}">
                                        <!-- /ko -->
                                    </div>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <!-- Quantity -->
                                            <div class="col-4">
                                                <input class="form-control float-left" type="text" maxlength="3" data-bind="value: quantity, attr: {disabled: status() == $root.StateType.UPDATING}, numeric: 1">
                                            </div>
                                            <!-- Add to favourites button -->
                                            <div class="col-8 pl-sm-0">
                                                <button type="button" class="btn btn-primary w-100"><@fmt.message key="eshop.addToFavourites"/></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Product details layer-->
        <div class="col-12 basket-product-box-info d-lg-none">
            <div class="row m-md-3 product-selection-item">
                <div class="col-md-4">
                    <img src="${imageSrc}">
                </div>
                <div class="col-md-8 eshop-option-tabs align-self-end">
                    <!-- ko if: productId() && productId() != '0' -->
                    <ul class="w-100">
                        <li class="heading-09 mb-3 mb-md-0 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)" data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a></li>
                        <li class="heading-09 mt-3 mb-md-0  more-info-tab">
                                <a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partnumber(), $index(), personalizedType(), name())">
                                    <@fmt.message key="eshop.moreInfo"/>
                                </a>
                                <div class="spinner-inside more-info-tab-item ko-hide" data-bind="attr: {id: 'spinner' + $index()}">
                                    <div class="bounce"></div>
                                    <div class="bounce1"></div>
                                    <div class="bounce2"></div>
                                </div>
                            </li>   
                    </ul>
                    <!-- /ko -->
                </div>
            </div>
        </div>
        <div class="eshoptab-line" style=""></div>
        <div class="eshop-tabs">
            <section class="container collapse more-info-mobile" data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>
            <section class="container collapse" data-bind="attr: {id: 'details' + basketProductId}">
                <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                    <div class="simple-collapse__bodyInner">
                        <div class="row">
                            <div class="col-12">
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
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>