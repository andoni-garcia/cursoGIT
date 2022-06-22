<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<#if isAuthenticated>
    <@security.authentication property="principal.selectedErp" var="selectedErp" />
</#if>

<#if series>
    <div id="${componentId}"
         class="${renderingMode} ${deviceInfo.deviceType?lower_case} idbl_hto__content__addtobasketbar"
         data-swiftype-index='false'>
        <#--    <div id="${componentId}"-->
        <#--         class="add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case} d-flex justify-content-end"-->
        <#--         data-swiftype-index='false'>-->

        <#if renderingMode == "configurator">
        <section class="idbl_hto__content__info add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case}">
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage" id ="idbl_hto__content__data_notStockClickHere_message">
                <div class="alert">
                    <@fmt.message key="productConfigurator.notOnStock_preLink"/>
                    <a href = "javascript:void(0);" class = "idbl_hto__content__data_stockMessage_compare" ><strong><@fmt.message key="productConfigurator.notOnStock_clickHere"/></strong></a>
                    <@fmt.message key="productConfigurator.notOnStock_postLink"/>
                    <a href = "javascript:void(0);" class = "idbl_hto__content__data_contact_smc" id = "idbl_hto__content__data_contact_smc" ><strong><@fmt.message key="productConfigurator.contactSmc"/></strong></a>
                    <@fmt.message key="productConfigurator.contactSmc_postLink"/>
                </div>
            </div>
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage" id ="idbl_hto__content__data_notStock_message">
                <div class="alert"><@fmt.message key="productConfigurator.notOnStock"/></div>
            </div>
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage item" id ="idbl_hto__content__data_inStock_message">
                <div class="alert">
                    <label class = "item__label"><@fmt.message key="productConfigurator.delivery"/>: </label>
                    <span class = "item__value value"><strong><@fmt.message key="productConfigurator.normallyOnStock"/></strong></span>
                </div>
            </div>
            <div class="erp-info-container">
                <div class="erp-info-data">
                        <div class="item first-item list-price product-prices hidden">
                            <label class="item__label"><@fmt.message key="addToCartBar.listprice" />:</label> <span
                                    class="item__value value"></span>
                        </div>
                        <div class="item second-item delivery-date product-dates hidden">
                            <label class="item__label"><@fmt.message key="addToCartBar.deliveryDate" />:</label> <span
                                    class="item__value value"></span>
                        </div>
<#--                        <div class="item third-item country-of-origin product-other-info hidden">-->
<#--                            <label><@fmt.message key="addToCartBar.countryoforigin" />:</label> <span-->
<#--                                    class=" value"></span>-->
<#--                        </div>-->
                        <div class="item first-item unit-price product-prices hidden">
                            <label class="item__label"><@fmt.message key="addToCartBar.unitprice" />:</label> <span
                                    class="item__value value"></span>
                        </div>
                        <div class="item second-item best-achievable-date product-dates hidden">
                            <label class="item__label"><@fmt.message key="addToCartBar.bestAchievableDate" />:</label> <span
                                    class="item__value value"></span>
                        </div>
<#--                        <div class="item third-item taric-code product-other-info hidden">-->
<#--                            <label><@fmt.message key="addToCartBar.tariccode" />:</label> <span-->
<#--                                    class=" value"></span>-->
<#--                        </div>-->
                </div>
                <div class="erp-info-message mb-0 alert hidden fade">
                    <!-- Loaded by JS -->
                </div>
                <div class="add-to-basket-bar-spinner loading-container">
                    <#include "../../include/spinner.ftl">
                </div>
            </div>
        </section>
        </#if>
        <section class="idbl_hto__content__actions idbl_hto__content__actions--buttons add-to-basket-bar-component  ${renderingMode} ${deviceInfo.deviceType?lower_case}" >
            <div class="basket-actions-container">
                <div class="quantity-container ${(showQuantityBox && showAddToBasketBtn)?then('', 'hidden')}">
                    <label class="item quantity-lbl"><@fmt.message key="addToCartBar.quantity" />:</label>
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
                                <#if apiPermission?? && apiPermission.isCreateSimpleSpecial() >
                                    <button href="" class="btn btn-primary add-to-basket-btn show-cylinder-wizard-btn-js"
                                            data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="cylinderConfigurator.createSimpleSpecial"/>"
                                            data-info-title="<@fmt.message key="cylinderConfigurator.createSimpleSpecial"/>"
                                            data-disabled-title="<@fmt.message key="cylinderConfigurator.cantCreateSimpleSpecial"/>">
                                        <i class="icon-barcode"></i>
                                    </button>
                                    <button class="btn btn-secondary btn-secondary--blue-border open-closed-configuration open-closed-configuration-js hidden" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<@fmt.message key="cylinderConfigurator.openClosedConfiguration"/>">
                                        <i class="icon-pencil"></i>
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
                            <button href="" class="btn btn-primary add-to-basket-btn add-to-basket-btn-js"
                                    data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtoproductselection" />">
                                <#if renderingMode == "series">
                                    <i class="icon-cart"></i>
                                <#else>
                                    <i class="icon-barcode"></i>
                                </#if>
                            </button>
                        </#if>
                        <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites add-to-favourites-js"
                                data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtofavourites" />">
                            <i class="icon-star-full"></i>
                        </button>
                    </div>
                <#else>
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
                                <i class="icon-cart"></i>
                            </button>
                        </#if>
                        <button class="btn btn-secondary btn-secondary--blue-border add-to-favourites add-to-favourites-js ${showAddToFavoritesBtn?then('', 'hidden')}"
                                data-toggle="tooltip" data-placement="bottom" title="<@fmt.message key="addToCartBar.addtofavourites" />"
                                disabled>
                            <i class="icon-star-full"></i>
                        </button>
                    </div>
                </#if>

            </div>
        </section>
    </div>
<#else>
    <div id="${componentId}" class= "idbl_hto__content__addtobasketbar" data-swiftype-index='false'>
        <#if renderingMode == "configurator">
            <section class="idbl_hto__content__info add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case}">
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage" id ="idbl_hto__content__data_notStockClickHere_message">
                <div class="alert">
                    <@fmt.message key="productConfigurator.notOnStock_preLink"/>
                    <a href = "javascript:void(0);" class = "idbl_hto__content__data_stockMessage_compare" ><strong><@fmt.message key="productConfigurator.notOnStock_clickHere"/></strong></a>
                    <@fmt.message key="productConfigurator.notOnStock_postLink"/>
                    <a href = "javascript:void(0);" class = "idbl_hto__content__data_contact_smc" id = "idbl_hto__content__data_contact_smc" ><strong><@fmt.message key="productConfigurator.contactSmc"/></strong></a>
                    <@fmt.message key="productConfigurator.contactSmc_postLink"/>
                </div>
            </div>
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage" id ="idbl_hto__content__data_notStock_message">
                <div class="alert"><@fmt.message key="productConfigurator.notOnStock"/></div>
            </div>
            <div class="col-lg-12 hidden idbl_hto__content__data_stockMessage item" id ="idbl_hto__content__data_inStock_message">
                <div class="alert">
                    <label class = "item__label"><@fmt.message key="productConfigurator.delivery"/>: </label>
                    <span class = "item__value value"><strong><@fmt.message key="productConfigurator.normallyOnStock"/></strong></span>
                </div>
            </div>
            <div class="erp-info-container">
                <div class="erp-info-data">
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
					<#else>
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
                <div class="erp-info-message mb-0 alert hidden fade">
                    <!-- Loaded by JS -->
                </div>
                <div class="add-to-basket-bar-spinner loading-container">
                    <#include "../../include/spinner.ftl">
                </div>
            </div>
        </section>
        </#if>
        <section class="idbl_hto__content__actions idbl_hto__content__actions--buttons add-to-basket-bar-component  ${renderingMode} ${deviceInfo.deviceType?lower_case}" >
            <div class="basket-actions-container">
                <div class="quantity-container ${(showQuantityBox && showAddToBasketBtn)?then('', 'hidden')}">
                    <label class="item quantity-lbl"><@fmt.message key="addToCartBar.quantity" />:</label>
                    <div class="item quantity-box">
                        <input type="tel" name="quantity" min="1" max="999" step="1"
                               maxlength="3"
                               class="quantity-box-input quantity-box-input-js"/>
                    </div>
                </div>
                <#if new_hto>
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
                                <i class="icon-cart"></i>
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

            </div>
        </section>
    </div>
<#--        <div id="${componentId}"-->
<#--        class="add-to-basket-bar-component ${renderingMode} ${deviceInfo.deviceType?lower_case} d-flex justify-content-end"-->
<#--        data-swiftype-index='false'>-->
<#--        </div>-->
</#if>