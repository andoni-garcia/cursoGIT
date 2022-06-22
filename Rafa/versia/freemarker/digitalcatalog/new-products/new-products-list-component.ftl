<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="NewProducts,SearchPage,SearchBar,ParametricSearch"/>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var smc = window.smc || {};
        smc.newproducts = smc.newproducts || {};
        smc.newproducts.messages = {
            "psearch.from": "<@fmt.message key="psearch.from" />",
            "psearch.to": "<@fmt.message key="psearch.to" />",
            "psearch.reset": "<@fmt.message key="psearch.reset" />",
            "psearch.search": "<@fmt.message key="psearch.search" />",
            "newproducts.seriesindex": "<@fmt.message key="newproducts.seriesindex" />",
            "newproducts.date": "<@fmt.message key="newproducts.date" />",
            "newproducts.family": "<@fmt.message key="newproducts.family" />",
            "newproducts.industry": "<@fmt.message key="newproducts.industry" />",
            "newproducts.selectoption": "<@fmt.message key="newproducts.selectoption" />",
            "newproducts.quarterly": "<@fmt.message key="newproducts.quarterly" />",
            "newproducts.yearly": "<@fmt.message key="newproducts.yearly" />",
            "newproducts.selectdate": "<@fmt.message key="newproducts.selectdate" />",
            "newproducts.selectperiod": "<@fmt.message key="newproducts.selectperiod" />",
            "newproducts.selectquarter": "<@fmt.message key="newproducts.selectquarter" />",
            "newproducts.firstquarter": "<@fmt.message key="newproducts.firstquarter" />",
            "newproducts.secondquarter": "<@fmt.message key="newproducts.secondquarter" />",
            "newproducts.thirdquarter": "<@fmt.message key="newproducts.thirdquarter" />",
            "newproducts.fourthquarter": "<@fmt.message key="newproducts.fourthquarter" />",
            "newproducts.showall": "<@fmt.message key="newproducts.showall" />",
            "newproducts.restart": "<@fmt.message key="newproducts.restart" />"
        };
    </script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var formJson = '${formJson}';
        <#--var isSeriesIndex = ${isSeriesIndex};-->
        var smc = window.smc || {};
        smc.psearch = smc.psearch || {};
        smc.psearchurls = smc.psearchurls || {};
        smc.psearchurls = {
            getPSearchForm: document.getElementById('getPSearchForm').href,
            getPSearchResult: document.getElementById('getPSearchResult').href
        };

        smc.psearch.psearchLanguage = '${lang}';
        smc.psearch.messages = {
            "psearch.noresultsfound": "<@fmt.message key="psearch.noresultsfound" />",
            "psearch.from": "<@fmt.message key="psearch.from" />",
            "psearch.to": "<@fmt.message key="psearch.to" />",
            "psearch.reset": "<@fmt.message key="psearch.reset" />",
            "psearch.search": "<@fmt.message key="psearch.search" />",
            "psearch.chooseanoption": "<@fmt.message key="psearch.chooseanoption" />"
        };

        $(function () {
            // smc.psearch.functions.config(smc.psearch);
            // $(document).trigger('psearch.config.loaded');
        })
    </script>
</@hst.headContribution>

<#--<@hst.headContribution category="htmlHead">-->
<#--    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/psearch/psearch.component.css"/>" type="text/css"/>-->
<#--</@hst.headContribution>-->

<div class="hidden" data-swiftype-index='false'>
    <a id="getPSearchForm" href="<@hst.resourceURL resourceId='getPSearchForm'/>"></a>
    <a id="getPSearchResult" href="<@hst.resourceURL resourceId='getPSearchResult'/>"></a>
</div>

<div class="new-products-list-component container desktop" data-swiftype-index="true" id="new_products_catalogue">

    <#include "new-products-list-content.ftl">

</div>


<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/new-products-list-component.js"/>"></script>
</@hst.headContribution>