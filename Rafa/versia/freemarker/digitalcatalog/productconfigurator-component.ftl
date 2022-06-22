<#if !(isSeriesPage?? && isSeriesPage == true)  >
    <#include "product-page/_product-page-scripts.ftl">
</#if>

<#--<@hst.include ref="product-toolbar-category-page" />-->
<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories,CylinderConfigurator,RefreshData,DigitalCatalog"/>
<#if pagetitle?? >
    <#assign titleBaseText><@fmt.message key="title.template" /></#assign>
    <title>${titleBaseText?replace("{product_name}", pagetitle)}</title>
</#if>

<#include "product-page/_swiftype_metas.ftl">

<script type="text/javascript">
    var ssi_columns = [];

    <#if ssi_columns?? >
        ssi_columns = "${ssi_columns}".split(",");
    </#if>
    var serie_config_values = [];

    <#if serie_config_values?? >
        serie_config_values = JSON.parse('${serie_config_values}');
    </#if>

    // var serie_config_values = JSON.parse('[]');
    var firstElement = true;
    var externalUrl = "";
    <#if externalUrl?? >
        externalUrl = "${externalUrl}";
    </#if>
</script>

<#if !(isSeriesPage?? && isSeriesPage=true) && (showRefreshData?? && showRefreshData == true) >
    <#assign refreshId = "${product.getNode().getId()?c}" >
    <#include "_refresh-data-banner.ftl">
</#if>
<div class="productconfigurator-component ${isStandalonePage?then('container-fluid is-standalone-page', 'container')} ${deviceInfo.deviceType?lower_case}"
     data-swiftype-index='true'>
    <div data-title="${product.getNode().getName()}"
         class="product-configuration-header-section ${deviceInfo.deviceType?lower_case}">
        <#if isSeriesPage?? && isSeriesPage == true>
        <#--            This block must be hidden-->
        <#else>
            <#if !isStandalonePage>
                <@osudio.dynamicBreadcrumb identifier="dc-bc" breadcrumb=breadcrumb />
                <h1 class="heading-03 color-blue"
                    data-swiftype-index='false'><@fmt.message key="standardstockeditems.productcataloge" /></h1>
                <#if product.getNode().getShortName()??>
                    <h2 class="heading-02" data-swiftype-index='true'>${product.getNode().getShortName()}</h2>
                <#else>
                    <h2 class="heading-02" data-swiftype-index='true'>${product.getNode().getName()}</h2>
                </#if>
            <#else>
                <div class="row hidden">
                    <div class="back-button back-button-js" onclick="window.history.go(-1);"></div>
                </div>
            </#if>

            <div class="row ${isStandalonePage?then('mt-10', '')}">
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
                    <div class="image"><@renderImage images=product.getNode().getImages() type='LARGE' /></div>
                    <div class="image-disclaimer very-small mt-3">
                        <span><@fmt.message key="productConfigurator.imagedisclaimer.line1"/></span><br/>
                        <span><@fmt.message key="productConfigurator.imagedisclaimer.line2"/></span>
                    </div>
                </div>
                <div class="col-lg-5 col-md-6 col-sm-6 col-xs-12 name-description name-description-desktop">
                    <div class="description">${product.getNode().getDescription()}</div>
                </div>
                <div id="related_information" class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
                    <@productToolbar id=("producttoolbar_" + product.getNode().getId()?long?c + "_header")
                    product=product.getNode() boxTitle="product.toolbar.materials" renderingMode="simple"
                    showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false
                    statisticsSource="PCP GENERAL" />

                    <br/>

                    <#if product.getNode().getVideo()?has_content && (product.getNode().getVideo()?ends_with(".mp4"))>
                        <video src="${product.getNode().getVideo()}" controls class="product-video"
                               smc-statistic-action="DOWNLOAD FILE" smc-statistic-data3="PRODUCT VIDEO"
                               smc-statistic-source="${statisticsSource}" smc-statistic-on="play">
                            <@fmt.message key="productConfigurator.browsernotcompatible.youcandownload"/> <a
                                    href="${videoURL}"><@fmt.message key="productConfigurator.browsernotcompatible.youcandownloadhere"/></a>
                        </video>
                    </#if>
                </div>
            </div>
        </#if>
    </div>
    <#if isSeriesPage?? && isSeriesPage == true>
        <div>
            <#include "product-page/product-serie-page-tabs.ftl">
        </div>
    <#else>
        <div>
            <#include "product-page/product-page-tabs.ftl">
        </div>
    </#if>
</div>
<script type="text/javascript"
        src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/cookie-consent.component.js" />"></script>

<script>
    $(document).ready(function () {
        var CookieConsentComponent = window.smc.CookieConsentComponent;
        var cookieConsentComponent = new CookieConsentComponent();
        cookieConsentComponent.init();

        var ProductPage = window.smc.ProductPage;
        var productPageController = new ProductPage({
            id: 'productPageComponentId',
            isStandalonePage: ${isStandalonePage?c},
            showOnlyFreeConfigurationTab: ${showOnlyFreeConfigurationTab?c},
            standardStockedItemsComponent: window.smc.standardStockedItemsComponent,
            productConfiguratorComponent: window.smc.productConfiguratorComponent,
            container: '#productConfiguratorContainer',
            device: '${deviceInfo.deviceType}',
            cookieConsentComponent: cookieConsentComponent
        });

        productPageController.init();
        window.smc.productPageController = productPageController;

        var GeneralSearchNavigation = window.smc.GeneralSearchNavigation;
        var generalNavigation = new GeneralSearchNavigation();

        var configGeneralSearch = {
            resultsContainer: 'productConfiguratorContainer',
            tabMenuContainer: 'tabSearchResult'
        };

        generalNavigation.init(configGeneralSearch);
    });
</script>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/js.cookie.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/relevance/addtocart_cookie.js"/>"></script>
</@hst.headContribution>
