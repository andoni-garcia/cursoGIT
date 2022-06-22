<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">

<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/swiftype-search/switftype.component.js"/>"></script>
</@hst.headContribution>


<script id="swiftypeEngineScript"
        data-engine-url="<@hst.resourceURL resourceId='getEngines'/>"
        data-ssiproducts-url="<@hst.resourceURL resourceId='getSsiProducts'/>"
        data-suggest-url="<@hst.resourceURL resourceId='getSuggest'/>"
        data-wc-suggest-url="<@hst.resourceURL resourceId='getWcSuggest'/>">
    $(function () {
        var $thisSwiftypeEngine = document.getElementById("swiftypeEngineScript");
        window.smc = window.smc || {};
        smc.swiftypeEngineComponent = smc.swiftypeEngineComponent || {};
        var getEnginesData =  $thisSwiftypeEngine.dataset.engineUrl;
        var getSsiproducts =  $thisSwiftypeEngine.dataset.ssiproductsUrl;
        var getSuggest =  $thisSwiftypeEngine.dataset.suggestUrl;
        var getWcSuggest =  $thisSwiftypeEngine.dataset.wcSuggestUrl;

        smc.swiftypeEngineComponent.urls = {
            getEnginesData: getEnginesData,
            getSsiProducts: getSsiproducts,
            getSuggest: getSuggest,
            getWcSuggest: getWcSuggest
        };
    });
</script>
