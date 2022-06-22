<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl">
<@hst.setBundle basename="SearchPage,ProductToolbar,AddToCartBar,eshop,ProductConfigurator,StandardStockedItems"/>
<#macro SsiDetailTemplate ssiProduct product index id="">
    <#if ssiProduct.getInfo()?has_content>
        <#assign ssiComponentId = "productssi_" + ssiProduct.getPartNumber()?replace("/", "_")>

        <div class="product-catalogue-item spare-accessory-item spare-accessory-item--${ssiComponentId}_${index} mb-10 mb-md-0"
        id="${ssiComponentId}">

        <#if isFunctionality?? && isFunctionality>
            <#assign statisticsSource = "NbF">
        <#else>
            <#assign statisticsSource = "PCP SSI">
        </#if>

    <#if isFunctionality?? && isFunctionality>
        <div class="col-12 col-lg-1 spare-accessory-item__label modelLabel" data-field-title="Image">
            <label for="${ssiComponentId}_${index}" class="smc-checkbox">
                <input id="${ssiComponentId}_${index}" type="checkbox"
                       class="ssi-item-partnumber spare-accessory-item-partnumber"
                       value="${ssiProduct.getPartNumber()};${ssiProduct.getPartNumberId()};${ssiProduct.getInfo().getProductId()?long?c}">
                <span class="smc-checkbox__label image">
                            <#if ssiProduct.getImageUrl()??>
                                <img src="${ssiProduct.getImageUrl()}"/>
                            </#if>
                                </span>
            </label>
        </div>

        <div class="col-12 col-lg-2 text-center ssi-product__field" data-field-title="PartNumber">
            <a href="${digCatalogUrl}/${product.getNode().getSlug()}~${ssiProduct.getInfo().getProductId()?long?c}~cfg?partNumber=${ssiProduct.getPartNumber()}"
               target="_blank">
                <span>${ssiProduct.getPartNumber()}</span>
            </a>
        </div>

        <div class="col-12 col-lg-2 ssi-product__field" data-field-title="Description">
            <span>${ssiProduct.getDescription()}</span>
        </div>
    <#--        <#assign dataList = ssiProduct.getData() />-->
    <#list ssiProduct.getData()[0..1] as data>
        <div class="col-12 col-lg ssi-product__field" data-field-title="${data.getKey()}">
            <span>${data.getValue()}</span>
        </div>
    </#list>
        <div class="col-12 col-lg-1 spare-accessory-item__label detailsLabel" data-field-title="Details"
             id="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}_toggle">
            <#elseif isEtoolsFrl?? && isEtoolsFrl>
            <div class="col-12 col-lg-2 text-center ssi-product__field" data-field-title="PartNumber">
            <a href="${digCatalogUrl}/${product.getNode().getSlug()}~${ssiProduct.getInfo().getProductId()?long?c}~cfg?partNumber=${ssiProduct.getPartNumber()}"
               target="_blank">
                <span>${ssiProduct.getPartNumber()}</span>
            </a>
        </div>

            <div class="col-12 col-lg-3 ssi-product__field" data-field-title="Description">
                <span>${ssiProduct.getPartNumber()}</span>
            </div>

            <div class="col-12 col-lg-1 ssi-product__field" data-field-title="Quantity">
                <span>1</span>
            </div>

            <div class="col-12 col-lg-1 ssi-product__field" data-field-title="Position">
                <span>x</span>
            </div>
        <div class="col-12 col-lg-1 spare-accessory-item__label detailsLabel" data-field-title="Details"
             id="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}_toggle">
            <#else>
            <div class="col-12 col-lg-3 spare-accessory-item__label modelLabel" data-field-title="Model">
                <label for="${ssiComponentId}_${index}" class="smc-checkbox">
                    <input id="${ssiComponentId}_${index}" type="checkbox"
                           class="ssi-item-partnumber spare-accessory-item-partnumber"
                           value="${ssiProduct.getPartNumber()}">
                    <span class="smc-checkbox__label">${ssiProduct.getPartNumber()} </span>
                </label>
            </div>

            <section class="col-12 col-lg-4 product-preview-container product-preview-container-js">
                <div class="attribute-list w-100">
                    <!-- Filled by Javascript -->
                </div>
                <#include "../../../include/spinner.ftl">
            </section>
            <div class="col-12 col-lg-2 spare-accessory-item__label detailsLabel" data-field-title="Details"
                 id="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}_toggle">
                </#if>
                <span class="spare-accessory-item__toggler" data-toggle="collapse"
                      data-target="#collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}" role="button"
                      aria-expanded="false"
                      aria-controls="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}">
                    <i class="fa fa-plus"></i>
                </span>
            </div>
            <div class="col-12 spare-accessory-item__collapsed_details">
                <div id="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}" class="collapse"
                     aria-labelledby="collapsedDetails_${ssiProduct.getPartNumber()?replace("/", "_")}_toggle"
                     data-parent="#spares-accessories-result-container">
                    <div class="accordion" id="${ssiProduct.getPartNumber()?replace("/", "_")}__accordion">
                        <div class="accordion__item accordion__item__tools">
                            <div class="accordion__item__header">
                                <h3 id="tools_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                    class="heading-06 color-blue mb-0 collapsed accordion__item__toggler preview-unloaded-js"
                                    data-toggle="collapse"
                                    data-target="#accesories_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                    aria-expanded="false"
                                    aria-controls="accesories_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse">
                                    <span><@fmt.message key="product.toolbar.documentationandcad"/></span>
                                    <i class="fa fa-plus"></i>
                                </h3>
                            </div>
                            <div id="accesories_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                 class="collapse accordion__item__body"
                                 aria-labelledby="accesories_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                 data-parent="#${ssiProduct.getPartNumber()?replace("/", "_")}__accordion">
                                <div id="tools_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                     role="tabpanel"
                                     aria-labelledby="tools_tab">
                                    <div class="tool-content-js row ml-4 ml-lg-0">
                                        <div class="col-lg-8 list-items filters-wrapper put-it-to-work-wrapper">
                                            <#assign putItToWorkViewType = "active no-arrow">
                                            <#assign putItToWorkProduct = product>
                                            <#if ssiProduct.getPutItToWork()??>
                                                <#assign putItToWork = ssiProduct.getPutItToWork()>
                                            </#if>
                                            <#include "../product-put_it_to_work.ftl">
                                        </div>
                                        <div class="col-lg-4 sticky-sidebar">
                                            <@productToolbar id=("producttoolbar_" + ssiProduct.getPartNumber()?replace("/", "_") + "_desktop")
                                            product=product.getNode() boxTitle="" renderingMode="3d-preview"
                                            showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false
                                            showAskSMC=false showVideo=false partNumber=ssiProduct.getPartNumber()
                                            statisticsSource=statisticsSource />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="accordion__item accordion__item__documentation">
                            <div class="accordion__item__header">
                                <h3 id="ssi-detail-tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                    class="heading-06 color-blue mb-0 collapsed accordion__item__toggler"
                                    data-toggle="collapse"
                                    data-target="#product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                    aria-expanded="false"
                                    aria-controls="product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse">
                                    <span><@fmt.message key="productConfigurator.technicalspecifications"/></span>
                                    <i class="fa fa-plus"></i>
                                </h3>
                            </div>

                            <div id="product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                 class="collapse accordion__item__body"
                                 aria-labelledby="product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                 data-parent="#${ssiProduct.getPartNumber()?replace("/", "_")}__accordion">
                                <div id="product_detail_${ssiProduct.getPartNumber()?replace("/", "_")}">
                                    <div class="tab-loading-container loading-container-js align-items-center"></div>
                                    <div class="w-100 product-detail-content product-detail-content-js"></div>
                                </div>
                            </div>
                        </div>
                        <#if !(isFunctionality?? || isEtoolsFrl??) || (hasAccessories?? && hasAccessories)>
                            <div class="accordion__item accordion__item__spares">
                                <div class="accordion__item__header">
                                    <h3 id="spares_related_products_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                        class="heading-06 color-blue mb-0 collapsed accordion__item__toggler"
                                        data-toggle="collapse"
                                        data-target="#specifications_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                        aria-expanded="false"
                                        aria-controls="specifications_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse">
                                        <span><@fmt.message key="standardstockeditems.sparesrelatedproducts"/></span>
                                        <i class="fa fa-plus"></i>
                                    </h3>
                                </div>
                                <div id="specifications_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                     class="collapse accordion__item__body"
                                     aria-labelledby="specifications_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                     data-parent="#${ssiProduct.getPartNumber()?replace("/", "_")}__accordion">
                                    <div id="spares_related_products_${ssiProduct.getPartNumber()?replace("/", "_")}">
                                        <div class="tab-loading-container loading-container-js align-items-center"></div>
                                        <div class="spare-related-content spares-accessories spare-related-content-js"></div>
                                    </div>
                                </div>
                            </div>
                        </#if>
                        <#if isAuthenticated && !isLightUser && !isTechnicalUser && !isInternalUser>
                            <div class="accordion__item accordion__item__check_prices">
                                <div class="accordion__item__header">
                                    <h3 id="check_prices_tab_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                        class="heading-06 color-blue mb-0 collapsed accordion__item__toggler"
                                        data-toggle="collapse"
                                        data-target="#check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                        aria-expanded="false"
                                        aria-controls="check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse">
                                        <span><@fmt.message key="standardstockeditems.displayprices"/></span>
                                        <i class="fa fa-plus"></i>
                                    </h3>
                                </div>
                                <div id="check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}_collapse"
                                     class="collapse accordion__item__body"
                                     aria-labelledby="check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                     data-parent="#${ssiProduct.getPartNumber()?replace("/", "_")}__accordion">
                                    <div id="check_prices_${ssiProduct.getPartNumber()?replace("/", "_")}"
                                         role="tabpanel"
                                         aria-labelledby="check_prices_tab">
                                        <div class="tab-loading-container loading-container-js align-items-center"></div>
                                        <div id="check-prices-content-${ssiProduct.getPartNumber()?replace("/", "_")}"
                                             class="pt-4 check-prices-content check-prices-content-js">
                                            <div id="check-prices-data-${ssiProduct.getPartNumber()?replace("/", "_")}"
                                                 class="check-prices-data">
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
                                                <#include "../../../include/spinner.ftl">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
            <#if !isEtoolsFrl?? || !isEtoolsFrl>
            <div class="col-12 col-lg-3 spare-accessory-item__label actionsLabel"
                 data-field-title="Actions">
                <#if isAuthenticated>
                    <div class="col-12">
                        <@addToBasketBar productId=product.getNode().getId()?long?c renderingMode="series" showQuantityBox=true showInfo=true showExtraInfo=true
                        partNumber="${ssiProduct.getPartNumber()}" productPricesContainer='#check-prices-content-${ssiProduct.getPartNumber()?replace("/", "_")}'
                        productPricesDataContainer='#check-prices-data-${ssiProduct.getPartNumber()?replace("/", "_")}' isConfiguratorPage = false series=true
                        statisticsSource=statisticsSource />
                    </div>
                <#else>
                    <div class="col-12">
                        <@addToBasketBar productId=product.getId()?long?c renderingMode="series" showQuantityBox=false showInfo=false showExtraInfo=false
                        partNumber="${ssiProduct.getPartNumber()}" isConfiguratorPage = false series=true
                        statisticsSource=statisticsSource />
                    </div>
                </#if>
            </div>
            </#if>
        </div>
        <script>
            $(function () {
                var SsiProduct = window.smc.SsiProduct;
                var config = {
                    id: '${ssiComponentId}',
                    container: $('#${ssiComponentId}'),
                    productId: '${ssiProduct.getInfo().getProductId()?long?c}',
                    partnumber: '${ssiProduct.getPartNumber()}' || '',
                    partnumberId: '${ssiProduct.getPartNumberId()}' || '',
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
                $(tab).siblings().each(function () {
                    if (this !== tab && $(this).hasClass("active")) {
                        $(this).removeClass("active");
                    }
                });
            }
        </script>
        <script type="text/template" id="attributeListItemTemplate">
            <div class="spare-accessory-item__label" data-field-title="{{attributeKey}}">
                <div class="text-center">{{attributeValue}}</div>
            </div>
        </script>
    </#if>
</#macro>