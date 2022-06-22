<@security.authentication property="principal.selectedErp" var="selectedErp" />
<#if series>
        <div id="${componentId}"
             class="add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case}"
             data-swiftype-index='false'>
<#else>
    <div id="${componentId}"
         class="add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case} d-flex justify-content-end"
         data-swiftype-index='false'>
        </#if>
        <#--    <div id="${componentId}"-->
        <#--         class="add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case} d-flex justify-content-end"-->
        <#--         data-swiftype-index='false'>-->
        <div class="basket-actions-container">
            <div class="quantity-container ${(showQuantityBox && showAddToBasketBtn)?then('', 'hidden')}">
                <label class="item quantity-lbl"><@fmt.message key="addToCartBar.quantity" /></label>
                <div class="item quantity-box">
                    <input type="tel" name="quantity" min="1" max="999" step="1"
                           maxlength="3"
                           class="quantity-box-input quantity-box-input-js"/>
                </div>
            </div>

            <#if renderingMode == "series" || renderingMode ==  "cylinder-series" >
                <div class="spares-accesory-item__actions">
                    <#if isAuthenticated >
                        <#if renderingMode == "cylinder-series">
                            <#if isAuthenticated && apiPermission?? && apiPermission.isCreateSimpleSpecial() >
                                <button href="" class="btn btn-primary add-to-basket-btn show-cylinder-wizard-btn-js"
                                        data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="cylinderConfigurator.createSimpleSpecial"/>">
                                    <i class="icon-barcode"></i>
                                </button>
                            </#if>
                        <#else>
                            <button href="" class="btn btn-primary add-to-basket-btn add-to-basket-btn-js"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtocard"/>">
                                <#if renderingMode == "series">
                                    <i class="icon-cart"></i>
                                <#else>
                                    <i class="icon-barcode"></i>
                                </#if>
                            </button>
                        </#if>

                    <#else>
                        <#if renderingMode == "cylinder-series" && isAuthenticated && apiPermission?? && apiPermission.isCreateSimpleSpecial()>
                            <button href="" class="btn btn-primary add-to-basket-btn show-cylinder-wizard-btn-js"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="cylinderConfigurator.createSimpleSpecial"/>">
                                <i class="icon-barcode"></i>
                            </button>
                        <#else>
                            <button href="" class="btn btn-primary add-to-basket-btn add-to-basket-btn-js"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtoproductselection" />">
                                <#if renderingMode == "series">
                                    <i class="icon-list"></i>
                                <#else>
                                    <i class="icon-barcode"></i>
                                </#if>
                            </button>
                        </#if>

                    </#if>
                    <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites add-to-favourites-js"
                            data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtofavourites" />">
                        <i class="icon-star-full"></i>
                    </button>
                </div>
            <#else>
                <#if series>
                    <div class="buttons-container series-container">
                        <#if isAuthenticated>
                            <button class="btn btn-primary add-to-basket-btn add-to-basket-btn-js ${showAddToBasketBtn?then('', 'hidden')}"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtocard"/>"
                                    disabled>
                                <i class="icon-cart"></i>
                            </button>
                        <#else>
                            <button class="btn btn-primary update-product-basket-btn update-product-basket-btn-js hidden">
                                <@fmt.message key="addToCartBar.updateproductselection" />
                            </button>
                            <button class="btn btn-primary add-to-basket-btn add-to-basket-btn-js ${showAddToBasketBtn?then('', 'hidden')}"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtoproductselection" />"
                                    disabled>
                                <i class="icon-list"></i>
                            </button>
                        </#if>
                        <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites add-to-favourites-js ${showAddToFavoritesBtn?then('', 'hidden')}"
                                data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtofavourites" />"
                                disabled>
                            <i class="icon-star-full"></i>
                        </button>
                    </div>
                <#else>
                    <div class="buttons-container">
                        <#if isAuthenticated>
                            <button class="btn btn-primary add-to-basket-btn add-to-basket-btn-js ${showAddToBasketBtn?then('', 'hidden')}"
                                    disabled>
                                <@fmt.message key="addToCartBar.addtocard" />
                            </button>
                        <#else>
                            <button class="btn btn-primary update-product-basket-btn update-product-basket-btn-js hidden">
                                <@fmt.message key="addToCartBar.updateproductselection" />
                            </button>
                            <button class="btn btn-primary add-to-basket-btn add-to-basket-btn-js ${showAddToBasketBtn?then('', 'hidden')}"
                                    disabled>
                                <@fmt.message key="addToCartBar.addtoproductselection" />
                            </button>
                        </#if>
                        <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites add-to-favourites-js ${showAddToFavoritesBtn?then('', 'hidden')}"
                                disabled>
                            <@fmt.message key="addToCartBar.addtofavourites" />
                        </button>
                    </div>
                </#if>
            </#if>

        </div>
        <div class="erp-info-container">
            <div class="erp-info-data">
                <#if series>
                    <div class="row">
                        <div class="item first-item list-price product-prices hidden">
                            <label><@fmt.message key="addToCartBar.listprice" />:</label> <span
                                    class=" value"></span>
                        </div>
                        <div class="item second-item delivery-date product-dates hidden">
                            <label><@fmt.message key="addToCartBar.deliveryDate" />:</label> <span
                                    class=" value"></span>
                        </div>
                        <div class="item third-item country-of-origin product-other-info hidden">
                            <label><@fmt.message key="addToCartBar.countryoforigin" />:</label> <span
                                    class=" value"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item first-item unit-price product-prices hidden">
                            <label><@fmt.message key="addToCartBar.unitprice" />:</label> <span
                                    class=" value"></span>
                        </div>
                        <div class="item second-item best-achievable-date product-dates hidden">
                            <label><@fmt.message key="addToCartBar.bestAchievableDate" />:</label> <span
                                    class=" value"></span>
                        </div>
                        <div class="item third-item taric-code product-other-info hidden">
                            <label><@fmt.message key="addToCartBar.tariccode" />:</label> <span
                                    class=" value"></span>
                        </div>
                    </div>
                <#else>
                    <div class="item first-item list-price product-prices hidden">
                        <label class="item__label"><@fmt.message key="addToCartBar.listprice" />:</label> <span
                                class="item__value value"></span>
                    </div>
                    <div class="item first-item unit-price product-prices hidden">
                        <label class="item__label"><@fmt.message key="addToCartBar.unitprice" />:</label> <span
                                class="item__value value"></span>
                    </div>
                    <div class="item second-item delivery-date product-dates hidden">
                        <label class="item__label"><@fmt.message key="addToCartBar.deliveryDate" />:</label> <span
                                class="item__value value"></span>
                    </div>
                    <#if selectedErp!=DYNAMICS_ERP>
	                    <div class="item second-item best-achievable-date product-dates hidden">
	                        <label class="item__label"><@fmt.message key="addToCartBar.bestAchievableDate" />:</label> <span
	                                class="item__value value"></span>
	                    </div>
	                </#if>
                    <div class="item third-item country-of-origin product-other-info hidden">
                        <label class="item__label"><@fmt.message key="addToCartBar.countryoforigin" />:</label> <span
                                class="item__value value"></span>
                    </div>
                    <div class="item third-item taric-code product-other-info hidden">
                        <label class="item__label"><@fmt.message key="addToCartBar.tariccode" />:</label> <span
                                class="item__value value"></span>
                    </div>
                </#if>
            </div>
            <div class="erp-info-message mb-0 alert alert-info hidden fade">
                <!-- Loaded by JS -->
            </div>
            <div class="add-to-basket-bar-spinner loading-container">
                <#include "../../include/spinner.ftl">
            </div>
        </div>
    </div>