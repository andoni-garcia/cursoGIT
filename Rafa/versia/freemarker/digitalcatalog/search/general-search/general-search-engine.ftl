<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<@hst.setBundle basename="essentials.global,SearchPage,SearchBar"/>

<@hst.link var="searchUrl" siteMapItemRefId="search"/>
<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/general-search/general-search.component.js"/>"></script>
</@hst.headContribution>


<script id="generalSearchEngineScript" data-make-redirect-url="${searchUrl}" >
    $(function () {
        var $thisGeneralSearchEngine = document.getElementById("generalSearchEngineScript");
        window.smc = window.smc || {};
        smc.generalSearchEngine = smc.generalSearchEngine || {};
        var makeRedirect =  $thisGeneralSearchEngine.dataset.makeRedirectUrl;
        if(!smc.generalSearchEngine.hasOwnProperty('urls')){
            smc.generalSearchEngine.urls = {};
        }
        smc.generalSearchEngine.urls.makeRedirect= makeRedirect;

    });
</script>
