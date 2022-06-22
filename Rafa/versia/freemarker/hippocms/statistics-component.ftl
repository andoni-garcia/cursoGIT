<#ftl encoding="UTF-8">
<#include "../include/imports.ftl">

<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/components/statistics.component.js"/>"></script>
</@hst.headContribution>


<div class="hidden" data-swiftype-index='false'>
    <a id="logActionLink" href="<@hst.resourceURL resourceId='logAction'/>"></a>
</div>
<script>
    var smc =  window.smc || {};
    smc.statistics = smc.statistics || {};
    smc.statistics.urls = {
        logAction: document.getElementById('logActionLink').href
    };
</script>
