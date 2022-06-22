<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<@hst.setBundle basename="SearchPage,SearchBar,ParametricSearch"/>

<div class="hidden" data-swiftype-index='false'>
    <a id="getPSearchForm" href="<@hst.resourceURL resourceId='getPSearchForm'/>"></a>
    <a id="getPSearchResult" href="<@hst.resourceURL resourceId='getPSearchResult'/>"></a>
</div>

<div class="coming-soon-list-component container desktop" data-swiftype-index="true" id="coming_soon_catalogue">
    <#include "coming-soon-list-content.ftl">
</div>


<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var formJson = "${formJson}";
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

        function checkTabStatus(tab){
            if ($(tab).hasClass("active")){
                setTimeout(function() {
                    $("#"+tab.id).removeClass("active");
                    var tabElement = tab.href.substring(tab.href.toString().indexOf("#"));
                    $(tabElement).removeClass("active");
                    console.log("[checkTabStatus] class removed", tabElement);
                }, 100);
            }
            $(tab).siblings().each(function(){
                if (this !== tab && $(this).hasClass("active")){
                    $(this).removeClass("active");
                    var liTab = $(this).attr("href");
                    if (liTab !== undefined ){
                        if (liTab.toString().indexOf("#") === 0 && liTab.toString().length > 1){
                            liTab = liTab.toString().substr(1);
                            $("#"+liTab).addClass("hidden");
                        }
                    }
                }
            });
        }
    </script>
</@hst.headContribution>