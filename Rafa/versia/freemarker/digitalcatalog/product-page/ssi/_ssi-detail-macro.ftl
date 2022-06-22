<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl">
<#macro SsiDetailTemplate ssiProduct product index id="">
    <#if ssiProduct.getInfo()?has_content>
        <#assign ssiComponentId = "productssi_" + ssiProduct.getPartNumber()?replace("/", "_")>
        <div class="row">
            <div class="product-catalogue-item" id="${ssiComponentId}">
                <header class="col-lg-12 p-2 header">
                    <label for="${ssiComponentId}_${index}" class="smc-checkbox">
                        <input id="${ssiComponentId}_${index}" type="checkbox" class="ssi-item-partnumber"
                               value="${ssiProduct.getPartNumber()}">
                        <span class="smc-checkbox__label">${ssiProduct.getPartNumber()}</span>
                    </label>
                    <span class="font-montserrat size-"><strong>|</strong></span> <span
                            class="title">${ssiProduct.getInfo().getName()}</span>
                </header>

                <section class="product-preview-container product-preview-container-js">
                    <div class="col-12 col-lg-7 col-xl-8 p-2 attribute-list">
                        <!-- Filled by Javascript -->
                    </div>

                    <#if isAuthenticated>
                        <div class="col-12 col-lg-5 col-xl-4">
                            <@addToBasketBar productId=product.getNode().getId()?long?c renderingMode="simple" showQuantityBox=true showInfo=true showExtraInfo=true
                            partNumber="${ssiProduct.getPartNumber()}" productPricesContainer="#check-prices-content-${ssiProduct.getPartNumber()}"
                            productPricesDataContainer="#check-prices-data-${ssiProduct.getPartNumber()}" isConfiguratorPage = false
                            statisticsSource="PCP SSI" />
                        </div>
                    <#else>
                        <div class="col-12 col-lg-5 col-xl-4">
                            <@addToBasketBar productId=product.getId()?long?c renderingMode="simple" showQuantityBox=false showInfo=false showExtraInfo=false
                            partNumber="${ssiProduct.getPartNumber()}" isConfiguratorPage = false
                            statisticsSource="PCP SSI" />
                        </div>
                    </#if>

                    <#include "../../../include/spinner.ftl">
                </section>
                <div class="col-lg-12">
                    <ul class="nav nav-tabs align-items-end ${deviceInfo.deviceType?lower_case}" role="tablist">
                        <li class="nav-item nav-item-12">
                            <a class="nav-link ssi-detail-tab ssi-detail-tab-js disabled"
                               id="ssi-detail-tab_${ssiProduct.getPartNumber()?replace("/", "_")}" disabled
                               data-partnumber="${ssiProduct.getPartNumber()}" data-toggle="tab"
                               href="#product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}"
                               role="tab" aria-controls="ssi-detail" aria-selected="false"
                               onclick="checkTabStatus(this);">
                                <@fmt.message key="standardstockeditems.productdetail" /> </a>
                        </li>
                        <li class="nav-item nav-item-16">
                            <a class="nav-link "
                               id="spares_related_products_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                               data-toggle="tab"
                               href="#spares_related_products_${ssiProduct.getPartNumber()?replace("/", "_")}" role="tab"
                               aria-controls="free_configuration" onclick="checkTabStatus(this);"
                               aria-selected="false"><@fmt.message key="standardstockeditems.sparesrelatedproducts" /> </a>
                        </li>
                        <li class="nav-item  nav-item-12">
                            <a class="nav-link " id="tools_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                               data-toggle="tab" href="#tools_${ssiProduct.getPartNumber()?replace("/", "_")}" role="tab"
                               aria-controls="free_configuration" onclick="checkTabStatus(this);" aria-selected="false">
                                <@fmt.message key="standardstockeditems.tools" />  </a>
                        </li>
                        <li class="nav-item invisible"></li>
                        <li class="nav-item invisible"></li>
                        <li class="nav-item invisible"></li>
                        <#if isAuthenticated && !isLightUser && !isTechnicalUser && !isInternalUser>
                            <li class="nav-item nav-item-50">
                                <a class="nav-link " id="check_prices_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                   data-toggle="tab" href="#check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                   role="tab" onclick="checkTabStatus(this);"
                                   aria-controls="free_configuration" aria-selected="false">
                                    <@fmt.message key="standardstockeditems.displayprices" /></a>

                            </li>
                        <#else>
                            <li class="nav-item invisible"></li>
                        </#if>
                    </ul>
                    <div class="tab-line tab-line-${ssiProduct.getPartNumber()?replace("/", "_")}-js"
                         style="display: none"></div>
                    <div class="tab-content">
                        <div class="tab-pane fade" id="product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}"
                             role="tabpanel" aria-labelledby="product_detail_tab">
                            <div class="tab-loading-container loading-container-js align-items-center"></div>
                            <div class="w-100 product-detail-content product-detail-content-js"></div>
                        </div>
                        <div class="tab-pane fade"
                             id="spares_related_products_${ssiProduct.getPartNumber()?replace("/", "_")}"
                             role="tabpanel" aria-labelledby="spares_related_products_tab">
                            <div class="tab-loading-container loading-container-js align-items-center"></div>
                            <div class="spare-related-content spare-related-content-js"></div>
                        </div>
                        <div class="tab-pane fade" id="tools_${ssiProduct.getPartNumber()?replace("/", "_")}"
                             role="tabpanel"
                             aria-labelledby="tools_tab">
                            <div class="pt-4 tool-content-js">
                                <@productToolbar id=("producttoolbar_" + ssiProduct.getPartNumber()?replace("/", "_") + "_desktop") product=product.getNode() boxTitle="" renderingMode="simple-tools"
                                showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=true
                                showCadDownload=true showVideo=false showDataSheet=false partNumber=ssiProduct.getPartNumber()
                                statisticsSource="PCP SSI" />
                            </div>
                        </div>
                        <#if isAuthenticated>
                            <div class="tab-pane fade" id="check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                 role="tabpanel"
                                 aria-labelledby="check_prices_tab">
                                <div id="check-prices-content-${ssiProduct.getPartNumber()?replace("/", "_")}"
                                     class="pt-4 check-prices-content check-prices-content-js">
                                    <div id="check-prices-data-${ssiProduct.getPartNumber()?replace("/", "_")}" class="check-prices-data">
                                        <div class="item first-item list-price product-prices hidden">
                                            <label><@fmt.message key="addToCartBar.listprice" />
                                                :</label> <span class="value">-</span>
                                        </div>
                                        <div class="item first-item unit-price product-prices hidden">
                                            <label><@fmt.message key="addToCartBar.unitprice" />
                                                :</label> <span class="value">-</span>
                                        </div>

                                        <div class="item second-item delivery-date product-dates hidden">
                                            <label><@fmt.message key="addToCartBar.deliveryDate" />
                                                :</label> <span class="value">-</span>
                                        </div>
                                        <div class="item second-item best-achievable-date product-dates hidden">
                                            <label><@fmt.message key="addToCartBar.bestAchievableDate" />
                                                :</label> <span class="value">-</span>
                                        </div>

                                        <div class="item third-item country-of-origin product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.countryoforigin" />
                                                :</label> <span class="value">-</span>
                                        </div>
                                        <div class="item third-item taric-code product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.tariccode" />
                                                :</label> <span class="value">-</span>
                                        </div>
                                        <div class="item third-item eclass-code product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.eclassCode" />
                                                :</label> <span class="value"></span>
                                        </div>
                                        <div class="item third-item eclass-version product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.eclassVersion" />
                                                :</label> <span class="value"></span>
                                        </div>
                                        <div class="item third-item unspsc-number product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.unspscNumber" />
                                                :</label> <span class="value"></span>
                                        </div>
                                        <div class="item third-item unspsc-version product-other-info hidden">
                                            <label><@fmt.message key="addToCartBar.unspscVersion" />
                                                :</label> <span class="value"></span>
                                        </div>

                                    </div>
                                    <div class="erp-info-message mb-0 alert alert-info hidden fade">
                                        <!-- Loaded by JS -->
                                    </div>
                                    <div class="add-to-basket-bar-spinner loading-container">
                                        <div class="cms-component component-render-placeholder add-to-basketbar-spinner-container">
                                            <div class="spinner">
                                                <div class="bounce1"></div>
                                                <div class="bounce2"></div>
                                                <div class="bounce3"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(function () {
                var SsiProduct = window.smc.SsiProduct;
                var config = {
                    id: '${ssiComponentId}',
                    container: $('#${ssiComponentId}'),
                    productId: '${ssiProduct.getInfo().getProductId()?long?c}',
                    partnumber: '${ssiProduct.getPartNumber()}' || '',
                    defaultLanguage: '${lang}'
                };

                var ssiProduct = new SsiProduct(config);
                ssiProduct.init();
            });

            function checkTabStatus(tab) {
                if ($(tab).hasClass("active")) {
                    setTimeout(function () {
                        $("#" + tab.id).removeClass("active");
                        // var tabElement = $(tab).attr("data-partnumber");
                        var tabElement = tab.href.substring(tab.href.toString().indexOf("#"));
                        $(tabElement).removeClass("active");
                        console.log("[checkTabStatus] class removed", tabElement);
                    }, 100);
                }
                $(tab).parent().siblings().each(function () {
                    var currentLi = $(this).children().get(0);
                    if (currentLi !== undefined) {
                        if (currentLi !== tab && $(currentLi).hasClass("active")) {
                            var currentRelatedContainer = $(currentLi).attr("href");
                            $(currentRelatedContainer).removeClass("d-flex");
                            $(currentRelatedContainer).addClass("fade");
                        }
                    }
                });
            }
        </script>
    </#if>
</#macro>