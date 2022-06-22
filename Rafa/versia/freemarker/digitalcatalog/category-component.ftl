<#include "../include/imports.ftl">
<#include "catalog-macros.ftl">
<#include "product/product-toolbar-macro.ftl">
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-catalog/product-catalog.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>

<#if  mustShowSeriesConfigurationPage?? && mustShowSeriesConfigurationPage == true>
    <@hst.headContribution category="htmlHead">
        <link rel="stylesheet"
              href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-page/product-configurator/product-configurator.component.css" fullyQualified=true />"
              type="text/css"/>
    </@hst.headContribution>
</#if>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var ssi_columns = "${ssi_columns}".split(",");
        var serie_config_values = '';
        if ('${serie_config_values}' !== '') {
            serie_config_values = JSON.parse('${serie_config_values}');
        }
        var firstElement = true;
        var externalUrl = "${externalUrl}";
    </script>
</@hst.headContribution>

<#if (isSeriesPage?? && isSeriesPage == true) >
    <#include "product-page/_product-page-scripts.ftl">
    <input type="hidden" id="isSeriesPage" value="true"/>
<#else>
    <input type="hidden" id="isSeriesPage" value="false"/>
</#if>

<@hst.setBundle basename="essentials.global,CylinderConfigurator,DigitalCatalog,ProductToolbar,ParametricSearch,MixedProducts,ProductConfigurator,StandardStockedItems,RefreshData"/>

<#if !(isSeriesPage?? && isSeriesPage == true && productId?? ) >
    <#include "_category_swiftype_metas.ftl">
</#if>

<@hst.include ref="product-toolbar-category-page" />
<#if (showRefreshData?? && showRefreshData == true) >
    <#assign refreshId = "${node.getId()?c}" >
    <#include "_refresh-data-banner.ftl">
</#if>
<div class="container dc-navigation-page">
    <div class="category-component" data-event="dc-component-loaded" data-title="${node.getName()}">
        <@osudio.dynamicBreadcrumb identifier="dc-bc" breadcrumb=breadcrumb />

        <div class="align-items-end" style="display: flex;">
            <div style="flex-grow: 1;">
                <#if isMixedProducts??>
                    <div class="heading-03 color-blue" data-swiftype-index='false'>${pagetitle}</div>
                <#else>
                    <div class="heading-03 color-blue" data-swiftype-index='false'>
                        <@fmt.message key="category.header.title" />
                    </div>
                </#if>
            </div>
        </div>
        <#if !(node.getType() == "SERIE" && (mustShowSeriesSummary?? && mustShowSeriesSummary == true)) >
            <#if node.getName()??>
                <h1 class="heading-02" data-swiftype-index='true'>${node.getName()}</h1>
            </#if>
        </#if>
        <#if node.getType() == "SERIE" >
            <#if mustShowSeriesSummary?? && mustShowSeriesSummary == true>
                <div class="row">
                    <div class="col-12 col-lg-8"
                         <#if !(productId?has_content)>data-swiftype-name="swiftype_product_info"
                         data-swiftype-type="text" data-swiftype-index="true"</#if>>
                        <#if node.getShortName()??>
                            <h2 class="heading-02" data-swiftype-index='true'>${node.getShortName()}</h2>
                        <#else>
                            <h2 class="heading-02" data-swiftype-index='true'>${node.getName()}</h2>
                        </#if>
                        <div class="col-12">
                            <div class="name-description name-description-desktop">
                                <h3 class="heading-04 description__title">${node.getSlogan()}</h3>
                                <div class="description">
                                    ${node.getBenefits()}
                                </div>
                            </div>
                            <div class="name-description name-description-desktop">
                                <h3 class="heading-04 description__title"><@fmt.message key="category.andmuchmore" /></h3>
                                <div class="description">
                                    ${node.getWebtexts()}
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-12 col-lg-4 product__related_information">
                        <div class="image large img-fluid"><@renderImage images=node.getImages() type='LARGE' /></div>
                        <div class="image-disclaimer very-small mt-3">
                            <label class="d-flex justify-content-center">
                                <@fmt.message key="productConfigurator.imagedisclaimer.line1"/><br>
                                <@fmt.message key="productConfigurator.imagedisclaimer.line2"/>
                            </label>
                        </div>
                        <div id="producttoolbar_related_information_header"
                             class="product-toolbar-component product-toolbar-component-simple desktop">
                            <div class="product-toolbar-item" data-swiftype-index="false">
                                <div class="product-toolbar-item__content product-toolbar-content-js">
                                    <h2 class="heading heading-07">
                                        <span><@fmt.message key="product.toolbar.relatedinformation"/></span>
                                    </h2>
                                    <div class="list-items filters-wrapper">
                                        <#if node.getCatalogues()?? && node.getCatalogues().getDocuments()?size != 0>
                                            <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                                                <div class="simple-collapse__head">
                                                    <h2 class="heading-06"><@fmt.message key="product.toolbar.documentation"/></h2>
                                                </div>
                                                <div class="simple-collapse__body">
                                                    <div class="simple-collapse__bodyInner">
                                                        <ul class="filters-categories__item__level2">
                                                            <li class="simple-collapse simple-collapse--filter-category">
                                                                <div class="simple-collapse__head">
                                                                    <@fmt.message key="product.toolbar.catalogue"/>
                                                                </div>
                                                                <div class="simple-collapse__body">
                                                                    <div class="simple-collapse__bodyInner">
                                                                        <@productToolbar id=("producttoolbar_catalogues_" + node.getId()?long?c + "_header")
                                                                        product=node boxTitle="product.toolbar.catalogue" renderingMode="simple"
                                                                        showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false isSeries=true showSeriesCatalogues=true
                                                                        nodeId = node.getId()?long?c statisticsSource="PCP GENERAL" />
                                                                    </div>
                                                                </div>
                                                            </li>
                                                            <#if node.getLeaflet()?? && node.getLeaflet()?has_content>
                                                                <li class="simple-collapse simple-collapse--filter-category">
                                                                    <a href="${node.getLeaflet()}" class=""
                                                                       target="_blank"><@fmt.message key="product.toolbar.leaflet"/></a>
                                                                </li>
                                                            </#if>
                                                            <#if ceCertificateUrl??>
                                                                <li class="simple-collapse simple-collapse--filter-category">
                                                                    <a href="${ceCertificateUrl}" class=""
                                                                       target="_blank"><@fmt.message key="product.toolbar.cecertificate"/></a>
                                                                </li>
                                                            </#if>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </#if>
                                        <#if engineeringTools?? && engineeringTools?size != 0>
                                            <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                                                <div class="simple-collapse__head">
                                                    <h2 class="heading-06"><@fmt.message key="product.toolbar.relatedengineeringtools"/></h2>
                                                </div>
                                                <div class="simple-collapse__body">
                                                    <div class="simple-collapse__bodyInner">
                                                        <ul class="filters-categories__item__level2 pt-1">
                                                            <#list engineeringTools as item>
                                                                <li>
                                                                    <a href="${item.getUrl()}"
                                                                       target="_blank"><@fmt.message key="product.toolbar.title." + item.getName() /></a>
                                                                </li>
                                                            </#list>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </#if>
                                        <#if node.getVideo()??>
                                            <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter active">
                                                <div class="simple-collapse__head">
                                                    <h2 class="heading-06"><@fmt.message key="product.toolbar.seeItInMotion"/></h2>
                                                </div>
                                                <div class="simple-collapse__body">
                                                    <div class="simple-collapse__bodyInner">
                                                        <video style="width: 100%;" src="${node.getVideo()}"
                                                               controls
                                                               class="product-video"
                                                               smc-statistic-action="DOWNLOAD FILE"
                                                               smc-statistic-data3="PRODUCT VIDEO"
                                                               smc-statistic-source="${statisticsSource}"
                                                               smc-statistic-on="play">
                                                            <@fmt.message key="productConfigurator.browsernotcompatible.youcandownload"/>
                                                            <a
                                                                    href="${node.getVideo()}"><@fmt.message key="productConfigurator.browsernotcompatible.youcandownloadhere"/></a>
                                                        </video>
                                                    </div>
                                                </div>
                                            </div>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            <#else>
                <div class="serie-heading row">
                    <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                        <div class="image medium"><@renderImage images=node.getImages() type='MEDIUM' /></div>
                    </div>
                    <div class="col-lg-5 col-md-6 col-sm-6 col-xs-12 mt-10 mt-sm-0 name-description name-description-desktop">
                        <div class="description">${node.getDescription()}</div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
                        <@productToolbar id=("producttoolbar_" + node.getId()?long?c + "_header")
                        product=node boxTitle="product.toolbar.materials" renderingMode="simple"
                        showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false />
                        <br/>
                    </div>
                </div>
            </#if>
        <#else>
            <#if node.getDescription()??>
                <h3 class="heading-0a">${node.getDescription()}</h3>
            </#if>
        </#if>
    </div>
    <#if node.getRelatedInformation()?? && node.getRelatedInformation()?size gt 0>
        <#include "fixed-area/fixed-area.ftl">
    </#if>
    <#if node.getType()?has_content && node.getType() == "SERIE" && mustShowSeriesConfigurationPage?? && mustShowSeriesConfigurationPage == true>
    <#--            <div class="col-lg-12 smc-filters-column smc-categories-sidebar">-->
    <#--                <div class="row" id="dc_products" data-attrset="${setForSeriesConfig}" data-childrentype="FOLDER"-->
    <#--                         data-underfolder="ACT_EU/NODE_133464" style="display: none">-->
    <#--                </div>-->
    <#--                <div class="row" id="dc_products" data-attrset="${setForSeriesConfig}" data-childrentype="${(node.getType() == "PRODUCT")?then("PRODUCT","FOLDER")}"-->
    <#--                         data-underfolder="${node.getLine()}/${node.getCode()}" style="display: none">-->
    <#--                </div>-->
    <#--                <@hst.include ref="p-search-category-page" />-->

    <#--            </div>-->
    <#if !isSingleChildrenNode>
        <section class="row productconfigurator__section">
            <aside class="fixed_flag flag_ask_our_experts">
                <ul class="list-items empty-list">
                    <li class="additional_element product-toolbar-item simple-fixed">
                        <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_sh_header")
                        product=node  boxTitle=""
                        showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                        showDataSheet=false showAskSMC=true showShareYourSuccess=false renderingMode="simple"
                        showSalesDocument=false/>
                    </li>
                </ul>
            </aside>

            <div class="col-12">
                <h2 class="productconfigurator__section__title"><@fmt.message key="productConfigurator.productSelection" /></h2>
                <div class="d-flex justify-content-between">
                    <p><@fmt.message key="productConfigurator.selectproductvariation" /></p>
                    <div class="d-flex justify-content-between">
                        <p class="reset-label"><@fmt.message key="productConfigurator.resetFilterButton"/></p>
                        <#if mustShowProductSelectionConfigurator && productSelectionIFrameSrc?has_content >
                            <button class="btn btn-secondary btn-secondary--blue-border btn-reset-filters"> <@fmt.message key="psearch.reset.filters"/></button>
                        <#else>
                            <button class="btn btn-secondary btn-secondary--blue-border btn-reset-filters"
                                    onclick="javascript:resetFilters();"> <@fmt.message key="psearch.reset.filters"/></button>
                        </#if>
                    </div>

                </div>
            </div>
            <div class="row" id="dc_products" data-attrset="${setForSeriesConfig}"
                 data-childrentype="${(node.getType() == "PRODUCT")?then("PRODUCT","FOLDER")}"
                 data-underfolder="${node.getLine()}/${node.getCode()}" style="display: none"></div>

            <#if mustShowProductSelectionConfigurator && productSelectionIFrameSrc?has_content >
                <#include "product-page/_product-selection-iframe-container.ftl">
            <#else>
                <div class="col-12 product_selection">
                    <#include "psearch/serie-search-component.ftl">
                </div>
            </#if>
        </section>
    </#if>

    <div class="pc__loading_spinner"></div>
    <div id="productconfigurator-component__ps_no_results_found" class="alert alert-info hidden">
        <@fmt.message key="productConfigurator.noResultsFoundWithThisConfiguration" />
    </div>
    <div id="productconfigurator-component__ps_no_unique_results_found" class="alert alert-info hidden">
        <@fmt.message key="productConfigurator.noUniqueResultsFoundWithThisConfiguration" />
    </div>
    <section id="productconfigurator-component__section">
        <#if productId??>
            <div class="row">
                <#include "productconfigurator-component.ftl">
            </div>
        </#if>
    </section>
    <#else>
    <div class="row mt-4 align-items-start">
        <div class="col-lg-3 smc-filters-column smc-categories-sidebar">
            <@hst.include ref="p-search-category-page" />

            <section class="smc-flyout smc-filters" id="smc-filters">
                <div class="smc-flyout-scrollable">
                    <div class="filters-wrapper">
                        <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter active">
                            <div class="simple-collapse__head">
                                <h2 class="heading-04"><@fmt.message key="category.left.menu.title" /></h2>
                            </div>
                            <div class="simple-collapse__body">
                                <div class="simple-collapse__bodyInner">
                                    <ul class="filters-categories">
                                        <#list families as family>
                                            <div class=" simple-collapse simple-collapse--filter-category">
                                                <div class="simple-collapse__head">
                                                    ${family.getName()}
                                                </div>
                                                <div class="simple-collapse__body">
                                                    <div class="simple-collapse__bodyInner">
                                                        <ul class="filters-categories__item__level2">
                                                            <#list family.getChildfamilies() as subfamily>
                                                                <li>
                                                                    <#if subfamily.getExternalUrl()?has_content>
                                                                        <a target="_blank" href="${subfamily.getExternalUrl()}">${subfamily.getName()}</a>
                                                                    <#else>
                                                                        <a href="${subfamily.getUrl()}">${subfamily.getName()}</a>
                                                                    </#if>
                                                                </li>
                                                            </#list>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </#list>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="col-lg-9 smc-filters-column digital-catalog-grid">
            <#if mustShowCompareProductsButton>
                <div id="psearch-compare-product-button" class="row" style="display: none;">
                    <div class="col-12">
                        <div class="compare alert alert-primary text-center">
                            <span class="color-blue"><@fmt.message key="psearch.comparealert"/></span>
                            <a class="psearch-compare-products-button" href="#">
                                <i class="loading-container loading-container-js"></i>
                                <strong id="btn-compare-text"> <@fmt.message key="psearch.compareclick"/></strong>
                            </a>
                        </div>
                    </div>
                </div>
            </#if>

            <div class="row" id="dc_products" data-attrset="${node.getAttrset()}"
                 data-childrentype="${(node.getType() == "PRODUCT")?then("PRODUCT","FOLDER")}"
                 data-underfolder="${node.getLine()}/${node.getCode()}">
                <#list node.getChildNodes() as childNode>
                <div class="lister-row__item col-md-6 col-xxl-4 dc_product" id="${childNode.getId()?long?c}"
                     data-href="${childNode.getUrl()}">
                    <div class="category-tile-wrapper category-tile--smallImage">
                        <#if childNode.getDescription()??>
                        <div class="category-tile category-tile--has-footer category-tile--noExpand ${(isNewProductTagActive && childNode.isIsNew())?then('is-new-product', '')}">
                            <#else>
                            <div class="category-tile category-tile--has-footer category-tile--noExpand ${(isNewProductTagActive && childNode.isIsNew())?then('is-new-product', '')} no-text">
                                </#if>
                                <div class="category-tile__image">
                                    <a href="${childNode.getUrl()}" class=" image-shown"
                                       title="${childNode.getName()}">
                                        <@renderImage images=childNode.getImages() type='MEDIUM' />
                                        <#if (isNewProductTagActive && childNode.isIsNew())>
                                            <div class="is-new-product-tag">
                                                <span class="font-montserrat"><strong><@fmt.message key="catalog.newtag" /></strong></span>
                                                <div class="is-new-product-blank"></div>
                                            </div>
                                        </#if>
                                        <span class="category-tile__image__mask"></span>
                                    </a>
                                </div>
                                <div class="category-tile__text text-01">
                                    <a href="${childNode.getUrl()}">
                                        <#if childNode.getName()??>
                                            <a href="${childNode.getUrl()}"><h2
                                                        class="heading-07 category-tile__title">${childNode.getName()}</h2>
                                            </a>
                                        </#if>
                                        <#if node.getViewType() != "IMAGE-ONLY">
                                            <div class="category-tile__text__inner">
                                                <#if childNode.getDescription()??>
                                                    <p>${childNode.getDescription()}</p>
                                                </#if>
                                            </div>
                                        </#if>
                                    </a>
                                    <div class="category-tile__text__accordion-trigger"></div>
                                </div>
                                <#if node.getViewType() != "IMAGE-ONLY">
                                    <div class="category-tile__footer text-01">
                                        <@productToolbar product=childNode boxTitle="product.toolbar.more_info" renderingMode="dropdown-category-item"
                                        showCadDownload=false showDataSheet=false showAskSMC=false showTechnicalDocumentation=false />
                                    </div>
                                </#if>
                            </div>
                            <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                        </div>
                    </div>
                    <#list childNode.getChildNodes() as subChildNode>
                    <div class="lister-row__item col-md-6 col-xxl-4 dc_product_children"
                         id="${subChildNode.getId()?long?c}" data-href="${subChildNode.getUrl()}">
                        <div class="category-tile-wrapper category-tile--smallImage">
                            <#if subChildNode.getDescription()??>
                            <div class="category-tile category-tile--has-footer category-tile--noExpand ${(isNewProductTagActive && subChildNode.isIsNew())?then('is-new-product', '')}">
                                <#else>
                                <div class="category-tile category-tile--has-footer category-tile--noExpand ${(isNewProductTagActive && subChildNode.isIsNew())?then('is-new-product', '')} no-text">
                                    </#if>


                                    <div class="category-tile__image">
                                        <a href="${subChildNode.getUrl()}" class="image-shown"
                                           title="${subChildNode.getName()}">
                                            <@renderImage images=subChildNode.getImages() type='MEDIUM' />
                                            <#if (isNewProductTagActive && subChildNode.isIsNew())>
                                                <div class="is-new-product-tag">
                                                    <span class="font-montserrat"><strong><@fmt.message key="catalog.newtag" /></strong></span>
                                                    <div class="is-new-product-blank"></div>
                                                </div>
                                            </#if>
                                            <span class="category-tile__image__mask"></span>
                                        </a>
                                    </div>
                                    <div class="category-tile__text text-01">
                                        <a href="${subChildNode.getUrl()}">
                                            <#if subChildNode.getName()??>
                                                <a href="${subChildNode.getUrl()}"><h2
                                                            class="heading-07 category-tile__title">${subChildNode.getName()}</h2>
                                                </a>
                                            </#if>
                                            <#if childNode.getViewType() != "IMAGE-ONLY">
                                                <div class="category-tile__text__inner">
                                                    <#if subChildNode.getDescription()??>
                                                        <p>${subChildNode.getDescription()}</p>
                                                    </#if>
                                                </div>
                                            </#if>
                                        </a>
                                        <div class="category-tile__text__accordion-trigger"></div>
                                    </div>
                                    <#if childNode.getViewType() != "IMAGE-ONLY">
                                        <div class="category-tile__footer text-01">
                                            <@productToolbar product=subChildNode boxTitle="product.toolbar.more_info" renderingMode="dropdown-category-item"
                                            showCadDownload=false showDataSheet=false showAskSMC=false showTechnicalDocumentation=false />
                                        </div>
                                    </#if>
                                </div>
                                <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                            </div>
                        </div>
                        </#list>
                        </#list>

                        <#if isMixedProducts?? && node.getChildNodes()?size == 0>
                            <p class="text-center m-auto"><@fmt.message key="mixedproducts.noresults"/></p>
                        </#if>
                    </div>
                    <div class="category-spinner-container">
                        <#include "../include/spinner.ftl">
                    </div>
                    <div class="psearch-no-results text-center mt-5">
                        <span class="w-100"><@fmt.message key="psearch.noresultsfound" /></span>
                    </div>
                </div>
            </div>
            </#if>
        </div>

        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript"
                    src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlHead">
            <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/libs/select2.min.css" fullyQualified=true />"
                  type="text/css"/>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript"
                    src="<@hst.webfile path="/freemarker/versia/js-menu/libs/select2.full.min.js" fullyQualified=true />"></script>
        </@hst.headContribution>
        <@hst.headContribution category="htmlBodyEnd">
            <script type="text/javascript"
                    src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/series-spares-related.module.js" fullyQualified=true />"></script>
        </@hst.headContribution>

        <#if !isMixedProducts?? && !mustShowSeriesConfigurationPage>
            <script>
                $(function () {
                    var smc = window.smc || {};
                    smc.dc && smc.dc.updateBreadCrumbs($('.category-component'));
                });
            </script>
        </#if>

        <div class="compare-tab-js hidden"></div>

        <div class="hidden" data-swiftype-index='false'>
            <a id="compareProductsLink" href="<@hst.resourceURL resourceId='compareProducts'/>"></a>
        </div>
        <script>
            var compareMaxElements = ${compareMaxElements};
            $(function () {
                function showCompareProducts(element, event, attributeSet, productIds, productId) {
                    if (event) event.preventDefault();

                    console.debug('[psearch-compare]', 'loadCompareProductData productIds=' + productIds);

                    var data = {
                        componentId: this.id,
                        productId: productId,
                        productIds: productIds,
                        attributeSet: attributeSet
                    };

                    initLoading($(element));

                    $.get(smc.dc.urls.compareProducts, data)
                        .then(function (response) {
                            var $compareTabJs = $('.compare-tab-js');
                            $compareTabJs.html(response);
                            $compareTabJs.removeClass('hidden');
                            $('#psearch_compareProductModal').modal('show');

                            endLoading($(element));

                        });
                }

                function initLoading($container) {
                    $container.addClass('disabled');
                    $('.loading-container-js', $container)
                        .addClass('loading-container')
                        .html(document.getElementById('spinner-template').innerHTML);
                }

                function endLoading($container) {
                    $('.loading-container-js', $container)
                        .removeClass('loading-container')
                        .html('');
                    $container.removeClass('disabled');
                }

                $('.psearch-compare-products-button').click(function (event) {
                    var attributeSet = $("#dc_products").data("attrset");
                    var productIds = [];
                    $(".lister-row__item:visible").each(function () {
                        productIds.push($(this).attr("id"))
                    });
                    var productId = "";

                    if (productIds.length > 1) {
                        showCompareProducts(this, event, attributeSet, productIds.join(","), productId);
                    }
                });
            });
        </script>
    </div>
<#--SEO METADATA ELEMENTS-->
    <#if node.getSeoH2Title()?has_content>
        <div id="category_metadata" class="category-metadata container">
            <div class="row mt-4 align-items-start">
                <div class ="col-lg-3 smc-filters-column"></div>
                <div class ="col-lg-9 smc-filters-column">
                    <div class="category_metadata-title">
                        <strong>${node.getSeoH2Title()}</strong>
                    </div>
                    <div class="category_metadata-content">
                        ${node.getSeoContent()}
                    </div>
                </div>
            </div>
        </div>
    </#if>
<#-- END SEO METADATA ELEMENTS-->
</div>