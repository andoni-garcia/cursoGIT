<div class="hidden" data-swiftype-index='false'>
    <a id="showProductDetailLink" href="<@hst.resourceURL resourceId='showProductDetail'/>"></a>
    <a id="showProductDetailJSONLink" href="<@hst.resourceURL resourceId='showProductDetailJson'/>"></a>
    <a id="showSpareAndRelatedProductsLink" href="<@hst.resourceURL resourceId='showSpareAndRelatedProducts'/>"></a>
    <a id="hasSpareAndRelatedProducts" href="<@hst.resourceURL resourceId='hasSpareAndRelatedProducts'/>"></a>
    <#if isSeriesPage?? && isSeriesPage == true>
        <a id="showSsiLink" href="<@hst.resourceURL resourceId='ssiSeriesPageInfo'/>"></a>
    <#else>
        <a id="showSsiLink" href="<@hst.resourceURL resourceId='ssiInfo'/>"></a>
    </#if>
    <a id="showCompareProductLink" href="<@hst.resourceURL resourceId='showCompareProduct'/>"></a>
    <a id="getETechOnlineStatusSSILink" href="<@hst.resourceURL resourceId='getETechOnlineStatus'/>"></a>
    <a id="showTechSpecsLink" href="<@hst.resourceURL resourceId='showTechSpecs'/>"></a>
    <a id="showPutItToWorkLink" href="<@hst.resourceURL resourceId='showPutItToWorkLink'/>"></a>
    <a id="showSeriesSpareAndRelatedProductsLink" href="<@hst.resourceURL resourceId='showSeriesSpareAndRelatedProducts'/>"></a>
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.ssi = smc.ssi || {};
    smc.ssi.urls = {
        showProductDetail: document.getElementById('showProductDetailLink').href,
        hasSpareAndRelatedProducts: document.getElementById('hasSpareAndRelatedProducts').href,
        showSpareAndRelatedProducts: document.getElementById('showSpareAndRelatedProductsLink').href,
        showSsiInfo: document.getElementById('showSsiLink').href,
        showProductDetailJSON: document.getElementById('showProductDetailJSONLink').href,
        showCompareProduct: document.getElementById('showCompareProductLink').href,
        getETechOnlineStatus:  document.getElementById('getETechOnlineStatusSSILink').href,
        showTechSpecs: document.getElementById('showTechSpecsLink').href,
        showPutItToWork: document.getElementById('showPutItToWorkLink').href,
        showSeriesSpareAndRelatedProducts: document.getElementById('showSeriesSpareAndRelatedProductsLink').href,

    };
</script>