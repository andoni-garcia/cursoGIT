<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<@hst.setBundle basename="essentials.global,ProductToolbar"/>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-toolbar/product-toolbar.component.css"/>"
          type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-toolbar/product-toolbar.component.js"/>"></script>
</@hst.headContribution>

<#include "toolbar/product-toolbar-box-macro.ftl">

<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../_spinner.ftl">
</@hst.headContribution>

<script>
    $(function () {
        window.smc = window.smc || {};
        window.smc.languages = {
            en: "<@fmt.message key="language.english"/>",
            de: "<@fmt.message key="language.german"/>",
            fr: "<@fmt.message key="language.french"/>",
            es: "<@fmt.message key="language.spanish"/>",
            it: "<@fmt.message key="language.italian"/>",
            ru: "<@fmt.message key="language.russian"/>",
            pl: "<@fmt.message key="language.polish"/>",
            cz: "<@fmt.message key="language.czech"/>"
        };
    });
</script>


<#macro productToolbar product boxTitle renderingMode id="" cssClasses="" sticky=false
showFeaturesCatalogues=true
showTechnicalDocumentation=true
show3dPreview=true
showCadDownload=true
cadDownloadURL=""
showAskSMC=true
showDataSheet=true
showVideo=true
partNumber=""
rodEndConf=""
askSMCTitleKey="product.toolbar.askSMC"
inConfigurationPage=false
inValveConfiguratorPage=false
statisticsSource=""
renderingOrigin = ""

<#-- New Products Functions-->
showPressRelease=false
showInstallationManuals=false
showOperationManuals=false
showCECertificates=false
switchoverDocumentURL=""
showTechnicalPresentationJP=false
technicalPresentationJPURL=""
showSalesDocument=false
showFlyer = false
flyerURL =""
showEnrichData = false
enrichDataURL=""
showImages=false
imageChURL=""
imageClURL=""
imageBwURL=""
showReducedCatalogue=false
showPressReleaseDocument=false
showSwitchoverDocument=false
showNewProductPreview=false
showShareYourSuccess=false
areWeInNewProducts=false
areWeInNewProductsDetails=false
areWeInCylinderConfigurator=false
additionalContent=""

<#-- Series Functions-->
relatedProductId=""
isSeries=false
showSeriesCatalogues=false
nodeId = ""

<#-- Modal details Functions-->
comesFromModalDetails=false
>

    <#if product != "">
        <#assign defaultId = "producttoolbar_" + product.getId()?long?c>
    </#if>
    <#assign componentId = (id != "")?then(id, defaultId)>

<#--Set for retrocompatibility for "box-hover"-->
    <#assign renderMode = (renderingMode == 'box-hover')?then('dropdown-plain', renderingMode) >

    <#assign _statisticsSourceDefault = "${source!''}">
    <#assign _statisticsSource = (statisticsSource != "")?then(statisticsSource, _statisticsSourceDefault) >

    <div id="${componentId}" class="product-toolbar-component product-toolbar-component-${renderMode}
            ${deviceInfo.deviceType?lower_case} ${sticky?then('sticky theiaStickySidebar', '')} ${cssClasses}">
        <@productToolbarBox product=product boxTitle=boxTitle renderingMode=renderMode
        showFeaturesCatalogues=showFeaturesCatalogues
        showTechnicalDocumentation=showTechnicalDocumentation
        show3dPreview=show3dPreview
        showCadDownload=showCadDownload
        cadDownloadURL=cadDownloadURL
        showAskSMC=showAskSMC
        showDataSheet=showDataSheet
        showVideo=showVideo
        askSMCTitleKey=askSMCTitleKey
        statisticsSource=_statisticsSource
        showPressRelease=showPressRelease
        showInstallationManuals=showInstallationManuals
        showOperationManuals=showOperationManuals
        showCECertificates=showCECertificates
        switchoverDocumentURL=switchoverDocumentURL
        showTechnicalPresentationJP=showTechnicalPresentationJP
        technicalPresentationJPURL=technicalPresentationJPURL
        showSalesDocument=showSalesDocument
        showFlyer=showFlyer
        flyerURL=flyerURL
        showEnrichData=showEnrichData
        enrichDataURL=enrichDataURL
        showImages=showImages
        imageChURL=imageChURL
        imageClURL=imageClURL
        imageBwURL=imageBwURL
        showReducedCatalogue=showReducedCatalogue
        showPressReleaseDocument=showPressReleaseDocument
        showSwitchoverDocument=showSwitchoverDocument
        showNewProductPreview=showNewProductPreview
        showShareYourSuccess=showShareYourSuccess
        relatedProductId=relatedProductId
        comesFromModalDetails=comesFromModalDetails
        areWeInNewProducts=areWeInNewProducts
        areWeInNewProductsDetails=areWeInNewProductsDetails
        areWeInCylinderConfigurator=areWeInCylinderConfigurator
        additionalContent=additionalContent
        renderingOrigin=renderingOrigin
        isSeries=isSeries
        showSeriesCatalogues=showSeriesCatalogues
        />
    </div>
    <script>
        $(function () {
            var ProductToolbar = window.smc.ProductToolbar;
            var productId;
            if ('${relatedProductId}' !== "") {
                productId = '${relatedProductId}';
            } else {
                productId = '${product.getId()?long?c}';
            }


            var config = {
                id: '${componentId}',
                container: $('#${componentId}'),
                productId: productId,
                nodeId: '${nodeId}' || '',
                renderingMode: '${renderMode}',
                partNumber: '${partNumber}' || '',
                rodEndConf: '${rodEndConf}' || '',
                defaultLanguage: '${lang}',
                inConfigurationPage: ${inConfigurationPage?c},
                inValveConfiguratorPage: ${inValveConfiguratorPage?c},
                productConfiguratorComponent: window.smc.productConfiguratorComponent,
                statisticsSource: "${_statisticsSource}",
                messages: {
                    noPreview3DAvailable: "<@fmt.message key="product.toolbar.noPreview3DAvailable"/>",
                    noPreview3DFound: "<@fmt.message key="product.toolbar.noPreview3DFound"/>",
                    iframeBrowserNotCompatible: "<@fmt.message key="product.toolbar.iframeBrowserNotCompatible"/>",
                    functionalityNotAvailable: "<@fmt.message key="product.toolbar.functionalityNotAvailable"/>",
                    clickToView3DPreview: "<@fmt.message key="product.toolbar.clickToView3DPreview"/>"
                }
            };
            config.isManualPartNumber = config.partNumber && config.partNumber !== '';

            var pt = new ProductToolbar(config);
            pt.init();
        });
    </script>
</#macro>