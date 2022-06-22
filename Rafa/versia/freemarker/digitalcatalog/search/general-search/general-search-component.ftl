<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#-- Templates -->
<@hst.headContribution category="htmlBodyEnd">
    <#include "../../_spinner.ftl">
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/general-search/equivalences.component.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/general-search/general-search.component.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/general-search/general-search-navigation.component.js"/>"></script>
</@hst.headContribution>

<a id="buildEquivalentResultRowUrl" class="hidden" href="<@hst.resourceURL resourceId='buildEquivalentResultRowUrl'/>"></a>
<a id="buildPartialMatchResultRowUrl" class="hidden" href="<@hst.resourceURL resourceId='buildPartialMatchResultRowUrl'/>"></a>
<a id="getProductCatalogueSearchResults" class="hidden" href="<@hst.resourceURL resourceId='getProductCatalogueSearchResults'/>"></a>
<a id="getWebContentSearchResults" class="hidden" href="<@hst.resourceURL resourceId='getWebContentSearchResults'/>"></a>

<script id="generalSearchComponentScript" data-get-data-results-url="<@hst.resourceURL resourceId='getDataResults'/>">
    $(function () {
        var $thisGeneralSearchEngine = document.getElementById("generalSearchComponentScript");
        window.smc = window.smc || {};
        smc.generalSearchEngine = smc.generalSearchEngine || {};
        var getDataResultsUrl = $thisGeneralSearchEngine.dataset.getDataResultsUrl;
        var n = getDataResultsUrl.indexOf("getDataResults")+"getDataResults".length;
        getDataResultsUrl =  getDataResultsUrl.substring(0,n);

        if(!smc.generalSearchEngine.hasOwnProperty('urls')){
            smc.generalSearchEngine.urls = {};
        }
        if(!smc.generalSearchEngine.hasOwnProperty('config')){
            smc.generalSearchEngine.config = {};
        }
        smc.generalSearchEngine.urls.getDataResults = getDataResultsUrl;
        smc.generalSearchEngine.urls.buildEquivalentResultRowUrl = document.getElementById('buildEquivalentResultRowUrl').href;
        smc.generalSearchEngine.urls.buildPartialMatchResultRowUrl = document.getElementById('buildPartialMatchResultRowUrl').href;
        smc.generalSearchEngine.urls.getProductCatalogueSearchResults = document.getElementById('getProductCatalogueSearchResults').href;
        smc.generalSearchEngine.urls.getWebContentSearchResults = document.getElementById('getWebContentSearchResults').href;
        smc.generalSearchEngine.config.isElasticPCSearchAvailable = $("#isElasticPCSearchAvailable").val();
        smc.generalSearchEngine.config.isElasticWCSearchAvailable = $("#isElasticWCSearchAvailable").val();
        <#--smc.generalSearchEngine.urls.buildEquivalentResultRowUrl = '<@hst.resourceURL resourceId='buildEquivalentResultRowUrl' fullyQualified=true/>';-->
    });
</script>
