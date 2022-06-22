<@hst.link var="basketUrl" siteMapItemRefId="basket"/>
<@hst.link var="search" siteMapItemRefId="search"/>
<@fmt.message key="eshop.notRegistered" var="notRegistered"/>
<div class="cart-selector text-01" data-swiftype-index="false">
    <div id="iconMoreInfoModal" class="layer-more-info hide"></div>
    <div class="cart__mega__left">
        <div class="smc-tabs pl-3 pr-3 pb-3">
            <span class="heading-04 p-0"><@fmt.message key="product.selection.title"/></span>
            <div class="smc-close-button" data-swiftype-index="false">×</div>
            <p class="m-0 p-0 mt-3"><@fmt.message key="basket.layer.description.top"/></p>
            <a class="btn btn-primary w-100 mt-3" href="${basketUrl}" ><@fmt.message key="eshop.goToDetails"/></a>
        </div>
        <div class="cart-selector__footer blue p-0 pt-3">
            <h2 class="heading-04"><@fmt.message key="eshop.smcPneumatics"/></h2>
            <p><@fmt.message key="basket.layer.description.bottom"/></p>
        </div>
    </div>
    <div class="cart__mega__right" style="min-width: 700px">
        <div class="cart-grid-header-block">
            <span class=""><@fmt.message key="eshop.partnumber"/></span>
        </div>
        <div class="cart-grid-list-block" >
            <ul id="basket-product-list">
                <!-- ko foreach: products -->
                <li data-bind="attr: {id: basketProductId}">
                    <div class="row m-0 grid_line">
                        <a class="text-muted col-9 pl-0 partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumber, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumber(), personalizedType())" target="_blank"></a>
                        <div class="col-3 align-right">
                            <a class="a-ko"><i class="fas fa-info-circle" data-bind="click: $root.getLayerMoreInfo.bind($data, $data)"></i></a>
                            <a class="a-ko" data-bind="attr: {'data-bind': ''}, click: $parent.deleteFromBasket.bind($data, basketProductId, 'BASKET LAYER')"><i class="fas fa-trash ml-2"></i></a>
                        </div>
                  </div>
                </li> 
                <!-- /ko -->
            </ul>
        </div>
        <div class="add-to-list-block mb-3 row">
           <#if scanVisible?? && scanVisible == "1">
            <div class="col-4 pr-0">
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
                    <div class="col-1 pr-0 bsk-scan__divider--vr"></div>
                </div>
            </div>
            <div class="col-4 pl-0 pr-0">
                <input id="bskly-add-partnumber" type="text" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumberLayer, valueUpdate: 'afterkeydown', submit: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" class="form-control float-left" placeholder="${partnumberPlaceholder}">
            </div>
            <div class="col-4">
                <button id="bskly-add-button" data-bind="attr: {'data-bind': ''}, click: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" class="btn btn-primary w-100 position-relative" type="button">
                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                    <@fmt.message key="eshop.addToBasket"/>
                </button>
            </div>
        </div>
          <#else>
        <div class="col-7 pr-0">
                <input id="bskly-add-partnumber" type="text" data-bind="attr: {'data-bind': ''}, value: boxInputPartnumberLayer, valueUpdate: 'afterkeydown', submit: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" class="form-control float-left" placeholder="${partnumberPlaceholder}">
            </div>
            <div class="col-5">
                <button id="bskly-add-button" data-bind="attr: {'data-bind': ''}, click: addToBasketSimpleSubmit.bind($data, 'BASKET LAYER')" class="btn btn-primary w-100 position-relative" type="button">
                    <smc-spinner-inside-element params="loading: addingItem(), isButton: true"></smc-spinner-inside-element>
                    <@fmt.message key="eshop.addToBasket"/>
                </button>
            </div>
        </div>
        </#if>
        
        
        <#if notRegistered?has_content && !notRegistered?contains('???')>
            <div class="cart-selector__footer p-0 pt-0">
                <h2 class="heading-04"></h2>
                <p>${notRegistered}</p>
            </div>
        </#if>
    </div>
</div>
