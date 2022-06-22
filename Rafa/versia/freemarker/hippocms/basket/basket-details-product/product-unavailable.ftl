<div class="row m-0 my-2 basket-product-box border border-secondary eshop-box-rounded">
    <div class="col-12 p-0">
        <div class="row m-3">
            <!-- Header-->
            <div class="col-12 p-0 basket-product-box-header">
                <input class="select-favourite" data-bind="attr: {id: basketProductId}, checked: selected" type="checkbox">
                <a class="text-muted partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())"></a>
                <span class="text-dark description" data-bind="text: name"></span>
            </div>
        </div>
        <!-- Info medium-->
        <div class="row ml-3 mr-3">
            <div class="col-6 p-0">
                <div class="row pb-3 product-selection-item d-none d-lg-flex mt-auto">
                    <div class="col-md-4">
                        <!-- ko if: mediumImage() -->
                        <img data-bind="attr: {src: mediumImage()}">
                        <!-- /ko -->
                        <!-- ko if: !mediumImage() -->
                        <img src="${noImage}">
                        <!-- /ko -->
                    </div>
                    <div class="col-lg-8 eshop-option-tabs align-self-end p-0">
                        <!-- ko if: haveTechnicalInformation() -->
                        <ul class="w-100">
                            <li class="heading-09 mt-3 mb-md-0 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-bind="attr: {href: '#details' + basketProductId},  click: $parent.getDetails.bind($data, partnumber, $data)" data-toggle="collapse"><@fmt.message key="eshop.showMoreDetails"/></a></li>
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
            <div class="col-lg-6 p-0 m-0 d-flex align-items-end flex-column">
                <!-- Product detail head -->
                <div class="row mt-auto p-0 pr-3 pl-lg-0 pl-3 message">
                    <div class="col-12 mb-0 mb-lg-3 alert alert-danger">
                        <label class="m-0"><@fmt.message key="eshop.product.notAvailableWebshop"/></label>
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
                        <li class="heading-09 mb-3 mb-md-0 smc-tabs__head--active"><a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#details' + basketProductId}"><@fmt.message key="eshop.showMoreDetails"/></a></li>
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

        <div class="eshop-tabs m-0 p-0">
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
                                <div  class="detail-row p-1">
                                    <span class="text-muted" data-bind="text: basketViewModel.splitString($data,':', 0, true)"></span>
                                    <span class="text-dark" data-bind="text: basketViewModel.splitString($data,':', 1, false)"></span>
                                </div  class="detail-row p-1">
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