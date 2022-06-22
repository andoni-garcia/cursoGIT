<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<@hst.setBundle basename="essentials.global,ParametricSearch"/>

<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/psearch/psearch.component.css"/>" type="text/css"/>
</@hst.headContribution>

<div class="hidden" data-swiftype-index='false'>
    <a id="getPSearchForm" href="<@hst.resourceURL resourceId='getPSearchForm'/>"></a>
    <a id="getPSearchResult" href="<@hst.resourceURL resourceId='getPSearchResult'/>"></a>
</div>


<section class="smc-flyout smc-filters">
    <div class="smc-flyout-scrollable" id="smc-psearch" style="display: none;">
        <div class="filters-wrapper">
            <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter active">
                <div class="simple-collapse__head">
                    <h2 class="heading-04"><@fmt.message key="psearch.advancedsearch" /></h2>
                </div>
                <div class="simple-collapse__body">
                    <div class="simple-collapse__bodyInner">
                        <ul class="filters-categories">
                            <div id="searchParamsBox">
                                <div class="psearch-searching-container"></div>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
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
        smc.psearch.functions.config(smc.psearch);
        $(document).trigger('psearch.config.loaded');
    })
</script>

<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/psearch-component.js"/>"></script>
</@hst.headContribution>