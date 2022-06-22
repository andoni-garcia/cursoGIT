<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="essentials.global,EnhancedProducts,ProductToolbar"/>
<#include "../_enhanced-product-template-macro.ftl">

<@hst.include ref="product-toolbar-category-page" />

<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/enhanced-products/detail/enhanced-products-detail.component.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
</@hst.headContribution>

<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../../_spinner.ftl">
</@hst.headContribution>

<#assign enhancedProductDetailComponentId = "enhanced-products-detail_" + .now?long?c>

<div class="container">
    <div id="${enhancedProductDetailComponentId}" class="enhanced-products-detail-component ${deviceInfo.deviceType?lower_case}">
        <@osudio.dynamicBreadcrumb identifier="dc-bc" breadcrumb=breadcrumb />

        <h1 class="heading-03 color-blue"><@fmt.message key="enhancedproducts.title" /></h1>
        <h2 class="heading-02">${oldProduct.getNode().getSerie()} <@fmt.message key="enhancedproducts.series" /></h2>

        <div class="row mt-10">
            <div class="col-12 col-md-5 col-lg-4 col-xl-4">
                <div class="product-item product-item-js lister-row__item product-item-old"
                     id="${oldProduct.getNode().getId()?long?c}"
                     data-id="${oldProduct.getNode().getId()?long?c}"
                     data-href="${oldProduct.getUrl()}">
                    <div class="category-tile-wrapper category-tile--smallImage">
                        <div class="category-tile category-tile--has-footer category-tile--noExpand is-new-product">
                            <div class="category-tile__image">
                                <a href="${oldProduct.getUrl()}" class=""
                                   title="${oldProduct.getNode().getSerie()} <@fmt.message key="enhancedproducts.series" />">
                                <@renderImage images=oldProduct.getNode().getImages() type='MEDIUM' />
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <a href="${oldProduct.getUrl()}">
                                    <a href="${oldProduct.getUrl()}">
                                        <h2 class="heading-07 category-tile__title">${oldProduct.getNode().getSerie()} <@fmt.message key="enhancedproducts.series" /></h2>
                                    </a>
                                    <div class="category-tile__text__inner">
                                        <#list enhancedProductDataModel.getEnhancedProduct().getDiscontinuedModels() as value>
                                            <p>${value}</p>
                                        </#list>
                                    </div>
                                </a>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                            <div class="category-tile__footer text-01">
                                <@productToolbar product=oldProduct.getNode() boxTitle="product.toolbar.more_info" renderingMode="dropdown-category-item"
                                    showCadDownload=false showDataSheet=false showAskSMC=false
                                    statisticsSource="ENHANCED PRODUCTS" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-2 col-lg-1">
                <p class="enhanced-products-arrow"></p>
            </div>

            <div class="col-12 col-md-5 col-lg-4 col-xl-4">
                <div class="product-item product-item-js lister-row__item"
                     id="${newProduct.getNode().getId()?long?c}"
                     data-id="${newProduct.getNode().getId()?long?c}"
                     data-href="${newProduct.getUrl()}">
                    <div class="category-tile-wrapper category-tile--smallImage">
                        <div class="category-tile category-tile--has-footer category-tile--noExpand is-new-product">
                            <div class="category-tile__image">
                                <a href="${newProduct.getUrl()}" class=""
                                   title="${newProduct.getNode().getSerie()} <@fmt.message key="enhancedproducts.series" />">
                                    <@renderImage images=newProduct.getNode().getImages() type='MEDIUM' />
                                    <div class="is-new-product-tag">
                                        <span class="font-montserrat"><strong><@fmt.message key="enhancedproducts.newtag" /></strong></span>
                                        <div class="is-new-product-blank"></div>
                                    </div>
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <a href="${newProduct.getUrl()}">
                                    <a href="${newProduct.getUrl()}">
                                        <h2 class="heading-07 category-tile__title">${newProduct.getNode().getSerie()} <@fmt.message key="enhancedproducts.series" /></h2>
                                    </a>
                                    <div class="category-tile__text__inner">
                                        <#list enhancedProductDataModel.getEnhancedProduct().getReplacementModels() as value>
                                            <p>${value}</p>
                                        </#list>

                                        <p>${enhancedProductDataModel.getDate()}</p>
                                    </div>
                                </a>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                            <div class="category-tile__footer text-01">
                                <@productToolbar product=newProduct.getNode() boxTitle="product.toolbar.more_info" renderingMode="dropdown-category-item"
                                    showCadDownload=false showDataSheet=false showAskSMC=false
                                    statisticsSource="ENHANCED PRODUCTS" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-3 col-xl-3">
                <#if enhancedProductDataModel.getDocumentUrl()?has_content>
                    <a class="btn btn-primary w-100" href="${enhancedProductDataModel.getDocumentUrl()}" target="_blank"><@fmt.message key="enhancedproducts.detail.downloadswitchoverdocument" /></a>
                </#if>

                <@productToolbar id=("producttoolbar_" + newProduct.getNode().getId()?long?c + "_ask_our_experts")
                    cssClasses="btn btn-secondary btn-secondary--blue-border mt-10"
                    product=newProduct.getNode() boxTitle="" askSMCTitleKey="product.toolbar.askourexperts" renderingMode="plain"
                    showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false
                    showTechnicalDocumentation=false showFeaturesCatalogues=false
                    statisticsSource="ASK OUR EXPERTS" />
            </div>
        </div>

        <#if (enhancedProductDataModel.getEspecifications()?size > 0)>
            <div class="especifications-container mt-5">
                <div class="especifications-container-title heading-06"><@fmt.message key="enhancedproducts.detail.mountinginterchangeabilityandprecautions" /></div>

                <div class="especifications-list">
                    <#assign mounting = enhancedProductDataModel.getEspecifications()[0] />
                    <#assign precautions = enhancedProductDataModel.getEspecifications()[1] />

                    <#if mounting.getValue()??>
                        <div class="especifications-item">
                            <div class="especifications-item-key">
                                <div class="especifications-item-name mr-5"><@fmt.message key="enhancedproducts.detail.mountinginterchangeability" /></div>
                            </div>
                            <div class="especifications-item-value
                                    ${(mounting.getValue()?lower_case == "yes")?then('value-yes', '')}
                                    ${(mounting.getValue()?lower_case == "no")?then('value-no', '')}">
                                ${(mounting.getValue()?lower_case == "no" || mounting.getValue()?lower_case == "yes")?then('', mounting.getValue())}
                            </div>
                        </div>
                    </#if>
                    <#if precautions.getValue()??>
                        <div class="especifications-item">
                            <div class="especifications-item-key">
                                <div class="especifications-item-name mr-5"><@fmt.message key="enhancedproducts.detail.precautions" /></div>
                            </div>
                            <div class="especifications-item-value
                                    ${(precautions.getValue()?lower_case == "yes")?then('value-yes', '')}
                                    ${(precautions.getValue()?lower_case == "no")?then('value-no', '')}">
                                ${(precautions.getValue()?lower_case == "no" || precautions.getValue()?lower_case == "yes")?then('', precautions.getValue())}
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </#if>

    </div>
</div>


<script>
    $(function () {
        var smc = window.smc || {};
        smc.dc && smc.dc.updateBreadCrumbs($('.enhanced-products-detail-component'));
    });

    function reviewEnhancedProductsChannelLinks(){
        var currentLocation = window.location.href;
        var splittedLocation = currentLocation.split("/");
        if (splittedLocation.length > 3){
            var currentEnhancedPath = splittedLocation[splittedLocation.length - 3];
            $(".language-selector-item").each(function(){
                var currentHref = this.href;
                if (currentHref.endsWith("%7E") || currentHref.endsWith("~")){//encoded value for ~
                    currentHref +="enhanced-products";
                }
                if (currentHref !== undefined && currentHref.indexOf("//") > 1){
                    //must be at least two to check this. the first one is always https://
                    currentHref = currentHref.replace(currentEnhancedPath+"//","/");
                    this.href = currentHref;
                }
            });
        }
    }

    $(document).ready(function() {
        if ($(".enhanced-products-detail-component").length > 0){
            reviewEnhancedProductsChannelLinks();
        }
    });
</script>