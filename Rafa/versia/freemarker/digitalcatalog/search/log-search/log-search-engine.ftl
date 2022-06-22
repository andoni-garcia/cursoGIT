<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">


<@hst.headContribution category="htmlBodyEnd">
<script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/search-log/search-log.component.js"/>"></script>
</@hst.headContribution>


<script id="logSearchEngineScript" data-create-register-url="<@hst.resourceURL resourceId='createRegister'/>"
        data-add-action-url="<@hst.resourceURL resourceId='addAction'/>">
    $(function () {
        var $thisSearchEngine = document.getElementById("logSearchEngineScript");
        window.smc = window.smc || {};
        smc.logSearchComponent = smc.logSearchComponent || {};
        var logCreateUrl = $thisSearchEngine.dataset.createRegisterUrl;
        var addActionUrl = $thisSearchEngine.dataset.addActionUrl;

        smc.logSearchComponent.urls = {
            registerLog: logCreateUrl,
            addAction: addActionUrl
        };
    });
</script>
