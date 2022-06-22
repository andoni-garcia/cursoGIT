<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#include "toolbar/_feature-catalogues-detail-macro.ftl">
<#include "toolbar/_series-catalogues-detail-macro.ftl">
<#include "toolbar/_technical-documentation-detail-macro.ftl">
<#include "toolbar/_images-detail-macro.ftl">
<#include "toolbar/_multilingual-documents-detail-macro.ftl">

<@featureCatalogueTemplate />
<@technicalDocumentationTemplate />
<@imagesTemplate />
<@multilingualDocumentsTemplate />

<div class="hidden" data-swiftype-index='false'>
    <a id="showFeatureCataloguesLink" href="<@hst.resourceURL resourceId='showFeatureCatalogues'/>"></a>
    <a id="showSeriesCataloguesLink" href="<@hst.resourceURL resourceId='showSeriesCatalogues'/>"></a>
    <a id="showMultilingualDocumentsLink" href="<@hst.resourceURL resourceId='showMultilingualDocuments'/>"></a>
    <a id="showTechnicalDocumentationLink" href="<@hst.resourceURL resourceId='showTechnicalDocumentation'/>"></a>
    <a id="show3dPreviewLink" href="<@hst.resourceURL resourceId='show3dPreview'/>"></a>
    <a id="get3dPreviewLink" href="<@hst.resourceURL resourceId='get3dPreview'/>"></a>
    <a id="showCadDownloadLink" href="<@hst.resourceURL resourceId='showCadDownload'/>"></a>
    <a id="getDatasheetLink" href="<@hst.resourceURL resourceId='getDatasheet'/>"></a>
    <a id="getSalesDocumentLink" href="<@hst.resourceURL resourceId='getSalesDocument'/>"></a>
    <a id="downloadCadFileLink" href="<@hst.resourceURL resourceId='downloadCadFile'/>"></a>
    <a id="showAskSMCLink" href="<@hst.resourceURL resourceId='showAskSMC'/>"></a>
    <a id="showShareYourSuccessLink" href="<@hst.resourceURL resourceId='showShareYourSuccess'/>"></a>
    <a id="showVideoLink" href="<@hst.resourceURL resourceId='showVideo'/>"></a>
    <a id="showPressReleaseLink" href="<@hst.resourceURL resourceId='showPressRelease'/>"></a>
    <a id="getETechOnlineStatusLink" href="<@hst.resourceURL resourceId='getETechOnlineStatus'/>"></a>
    <a id="getCadenasOnlineStatusLink" href="<@hst.resourceURL resourceId='getCadenasOnlineStatus'/>"></a>
    <a id="askSMCFinalPageLink" href="<@hst.link siteMapItemRefId='asksmc'/>"></a>
    <a id="isDatasheetAvailableInCacheLink" href="<@hst.resourceURL resourceId='isDatasheetAvailableInCache'/>"></a>
    <a id="isCADAvailableInCacheLink" href="<@hst.resourceURL resourceId='isCADAvailableInCache'/>"></a>
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.productToolbar = smc.productToolbar || {};
    smc.productToolbar.urls = {
        showSeriesCatalogues: document.getElementById('showSeriesCataloguesLink').href,
        showFeatureCatalogues: document.getElementById('showFeatureCataloguesLink').href,
        showMultilingualDocuments: document.getElementById('showMultilingualDocumentsLink').href,
        showTechnicalDocumentation: document.getElementById('showTechnicalDocumentationLink').href,
        show3dPreview: document.getElementById('show3dPreviewLink').href,
        get3dPreview: document.getElementById('get3dPreviewLink').href,
        showCadDownload: document.getElementById('showCadDownloadLink').href,
        downloadCadFile: document.getElementById('downloadCadFileLink').href,
        getDatasheet: document.getElementById('getDatasheetLink').href,
        getSalesDocument: document.getElementById('getSalesDocumentLink').href,
        showAskSMC: document.getElementById('showAskSMCLink').href,
        showShareYourSuccess: document.getElementById('showShareYourSuccessLink').href,
        showVideo: document.getElementById('showVideoLink').href,
        showPressRelease: document.getElementById('showPressReleaseLink').href,
        askSMCFinalPageLink: document.getElementById('askSMCFinalPageLink').href,
        getETechOnlineStatus: document.getElementById('getETechOnlineStatusLink').href,
        getCadenasOnlineStatus: document.getElementById('getCadenasOnlineStatusLink').href,
        isDatasheetAvailableInCache: document.getElementById('isDatasheetAvailableInCacheLink').href,
        isCADAvailableInCache: document.getElementById('isCADAvailableInCacheLink').href
    };
</script>