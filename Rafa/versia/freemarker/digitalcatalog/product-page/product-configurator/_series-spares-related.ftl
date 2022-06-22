<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../product/product-toolbar-macro.ftl">
<#if ( isAccessoryDetailsModalEnabled?? && isAccessoryDetailsModalEnabled == true)  >
    <#include "../../accessoriesModal-component/accessoriesModal-component-macro.ftl">
</#if>
<#assign sparesRelatedProductComponentId = "spares_related_products_" + partNumber>

<#assign showPagination = false>

<#include "../_selection-basket-favourites-bar-macro.ftl" />
<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories"/>
<#if accessoriesRelatedProducts?has_content>
    <div id="spares_related_products_${partNumber?replace("+", "_")?replace("/", "_")}">
        <#if accessoriesRelatedProducts?size != 0 && groups?size != 0>
            <ul id="accessories_${partNumber?replace("+", "_")?replace("/", "_")}_tabs" class="navbar-full nav border-bottom d-flex justify-content-center"
                role="tablist">
                <#list groups as group>
                    <li class="nav-item p-3">
                        <a class="nav-link group-filter" id="accessories_${partNumber?replace("+", "_")?replace("/", "_")}_${group?index}_tab"
                           href="#" role="tab" data-group="${group.getName()?replace(" ", "_")?replace(",", "")}"
                           aria-selected="false">
                            <figure class="nav_link_anchor image nav_link_anchor--accessories_${group.getName()?replace(" ", "_")?replace(",", "")}">
                                <img class="accessories-group" src="${group.getImageUrl()}" alt="">
                                <img class="accessories-group-active" src="${group.getImageActiveUrl()}" alt="">
                                <figcaption>
                                    ${group.getName()}
                                </figcaption>
                            </figure>
                        </a>
                    </li>
                </#list>
            </ul>

            <div class="tab-content related-products-result-container">
                <div classconfiguration-summary="tab-pane fade active show" id="accessories_${partNumber?replace("+", "_")?replace("/", "_")}"
                     role="tabpanel"
                     aria-labelledby="accessories_${partNumber?replace("+", "_")?replace("/", "_")}_1_tab">
                    <section class="accessories__tab__section accessories_${partNumber?replace("+", "_")?replace("/", "_")}__products">
                        <div class="row mt-4 mb-2 d-none d-lg-flex">
                            <div class="col-12 col-lg-10 row mx-0 px-0">
                                <div class="col-12 col-lg-2 sub-title label_header--image" id="imageLbl">
                                    <label for="accessories_${partNumber?replace("+", "_")?replace("/", "_")}__products_all" class="smc-checkbox">
                                        <#if !(mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries == true) >
                                            <@selectionBasketFavouritesBar sparesRelatedProductComponentId=sparesRelatedProductComponentId
                                            selectAllCheckboxFeature=true seriesCheckBox="relatedProducts" seriesRelatedProductId=("spares_related_products_"+ partNumber)
                                            statisticsSource="SPARE PARTS AND ACCESSORIES" />
                                        <#else>
                                            <span class="smc-checkbox__label"><strong><@fmt.message key= "productConfigurator.image"/></strong></span>
                                        </#if>
                                    </label>
                                </div>
                                <div class="col-12 col-lg-8 sub-title d-flex justify-content-center text-center label_header--description"
                                     id="descriptionLbl">
                                    <strong><@fmt.message key="standardstockeditems.productdescription"/></strong>
                                </div>
                                <div class="col-12 col-lg-2 sub-title d-flex justify-content-center label_header--group"
                                     id="groupLbl" style="display: none !important;">
                                    <strong><@fmt.message key="standardstockeditems.group"/></strong>
                                </div>
                                <div class="col-12 col-lg-2 sub-title d-flex justify-content-center text-center label_header--part_number"
                                     id="partNumberLbl">
                                    <strong><@fmt.message key="standardstockeditems.partnumber" /></strong></div>
                            </div>
                            <div class="col-12 col-lg-2 sub-title d-flex justify-content-center text-center label_header--additional_info"
                                 id="additionalInfoLbl">
                                <strong><@fmt.message key="standardstockeditems.additionalinformation"/></strong></div>
                        </div>
                        <div class="accessories-products-result-container"
                             id="accessories_${partNumber?replace("+", "_")?replace("/", "_")}_products-result-container">
                            <#list accessoriesRelatedProducts as product>
                                <div style="display: none"
                                     class="row spare-accessory-item series_accessory_${partNumber?replace("+", "_")?replace("/", "_")}_${product.getGroup()?replace(" ", "_")?replace(",", "")} mb-10 mb-md-0">
                                    <label for="accessory_${partNumber?replace("+", "_")?replace("/", "_")}_${product?index}"
                                           class="smc-checkbox col-12 col-lg-10 row mx-0 px-0">
                                        <div class="col-12 col-lg-2 spare-accessory-item__label imageLabel"
                                             data-field-title="<@fmt.message key= "productConfigurator.image"/>">
                                            <div>
                                                <#if !(mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries == true) >
                                                <input id="accessory_${partNumber?replace("+", "_")?replace("/", "_")}_${product?index}" type="checkbox"
                                                       class="series-related-product-partnumber"
                                                       value="${product.getPartNumber()}">
                                                <span class="smc-checkbox__label pl-5">
                                        <#else>
                                            <input id="accessory_${partNumber?replace("+", "_")?replace("/", "_")}_${product?index}" type="radio"
                                                   name="aareo__choosen_accesory"
                                                   class="aareo__choosen_accesory"
                                                   value="${product.getPartNumber()}">
                                            <span class="smc-checkbox__label py-2">
                                        </#if>
                                    <figure class="image pb-0">
                                        <img src="${product.getImageUrl()}"
                                             alt="">
                                    </figure>
                                        </span>
                                            </div>
                                        </div>
                                        <div class="col-12 col-lg-8 spare-accessory-item__label descriptionLabel"
                                             data-field-title="<@fmt.message key="standardstockeditems.productdescription"/>">
                                            <div>${product.getDescription()}</div>
                                        </div>
                                        <div class="col-12 col-lg-2 spare-accessory-item__label groupLabel"
                                             data-field-title="<@fmt.message key="standardstockeditems.group"/>"
                                             id="collapsedDetails_${partNumber?replace("+", "_")?replace("/", "_")}_${product?index}_toggle"
                                             style="display:none !important;">
                                            <span class="">${product.getGroup()}</span>
                                        </div>
                                        <div class="col-12 col-lg-2 spare-accessory-item__label partNumberLabel"
                                             data-field-title="<@fmt.message key="standardstockeditems.partnumber" />"
                                             id="collapsedDetails_${partNumber?replace("+", "_")?replace("/", "_")}_${product?index}_toggle">
                                            <span class="">${product.getPartNumber()}</span>
                                        </div>
                                    </label>
                                    <div class="col-12 col-lg-2 spare-accessory-item__label additionalInfoLabel"
                                         data-field-title="<@fmt.message key="standardstockeditems.additionalinformation"/>">
                                        <#if product.isHasCad() == true>
                                            <div class="spares-accesory-item__actions">
                                                <@productToolbar id=("producttoolbar_" + product.getPartNumber()?replace("/", "_") + "_desktop") relatedProductId=product.getProductid() boxTitle="" renderingMode="related-product-cad"
                                                showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false product=""
                                                showCadDownload=true showVideo=false showDataSheet=false partNumber=product.getPartNumber()
                                                statisticsSource="SPARE PARTS AND ACCESSORIES"/>
                                            </div>
                                        </#if>
                                        <#if ( isAccessoryDetailsModalEnabled?? && isAccessoryDetailsModalEnabled == true)  >
                                            <@accessoriesModal boxTitle=""+product.getPartNumber() renderMode="from-ssi-series" product=""
                                            id=("accesoriesModal_" + product.getPartNumber()?replace("+", "_")?replace("/", "_") + "_" + partNumber?replace("+", "_")?replace("/", "_") + "_" + product?index + "_ssi")
                                            accessoryPartNumber=""+product.getPartNumber() />
                                        </#if>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </section>
                </div>
            </div>
            <#if !(mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries == true) >
                <div class="col-lg-12 pt-5">
                    <@selectionBasketFavouritesBar sparesRelatedProductComponentId=sparesRelatedProductComponentId
                    selectAllCheckboxFeature=false statisticsSource="SPARE PARTS AND ACCESSORIES" />
                </div>
            </#if>

        </#if>


    </div>


    <script>
        window.smc = window.smc || {};
        window.smc.relatedProductList = [];
    </script>

    <script>
        $(function () {
            var relatedProduct = new window.smc.SeriesRelatedProducts({
                id: '${relatedProductComponentId}',
                container: $('.related-products-result-container'),
                relatedProductCheckboxClass: '.series-related-product-partnumber',
                containerId: $('#spares_related_products_${partNumber?replace("+", "_")?replace("/", "_")}'),
                seriesAccessoryClass: '.series_accessory_${partNumber?replace("+", "_")?replace("/", "_")}_'

            });
            relatedProduct.init();
            $('#accessories_${partNumber?replace("+", "_")?replace("/", "_")}_0_tab').trigger("click");
        });
    </script>
</#if>