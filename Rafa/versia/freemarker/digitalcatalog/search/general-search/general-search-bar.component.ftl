<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "../swiftype-search/swiftype-search-engine.ftl">
<#include "general-search-engine.ftl">
<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>

<script id="generalSearchBarComponentScript" data-locale="${.locale}">
    $(function () {
        var $inputSearch = $("#search_text_input");
        $inputSearch.val($inputSearch.val().replace("[pl]","+"))
        var $thisSwiftypeComponent = document.getElementById("generalSearchBarComponentScript");

        window.smc = window.smc || {};
        var generalSearchConfig = {
            messages: {
                ssiDisclaimer: "<@fmt.message key="search.searchbar.ssiDisclaimer"/>"
            }
        };
        var locale = $thisSwiftypeComponent.dataset.locale;
        var locales = locale.split("_");
        var language = locales[0];
        var country = locales[1];

        var SwiftypeEngine = window.smc.SwiftypeEngine;
        var SearchLog =  window.smc.SearchLog;
        var GeneralSearch = window.smc.GeneralSearch;

        var swiftypeEngine = new SwiftypeEngine(locale);
        var searchLog = new SearchLog();
        var generalSearch = new GeneralSearch(generalSearchConfig);
        for (var engine in swiftypeEngine.getEngines()){
            generalSearch.addEngine(engine, swiftypeEngine);
        }

        var typeaheadConfig ={
            followLinkOnEnter: true,
            changeInputOnSelect: true
        };

        function doneTyping () {
            console.debug('[generalSearchBarComponentScript]', 'doneTyping');
            //console.log($input.attr("id"),$input.val());
            if($inputSearch.val().length >2){
                swiftypeEngine.getAutoComplete($inputSearch.val().trim(),
                        $inputSearch,
                        searchLog,
                        generalSearch,
                        typeaheadConfig,
                        '.loading-container-js',
                        language,
                        country
                );
            }
        }

        swiftypeEngine.init()
            .then(function () {
                var doneTypingInterval = 300;
                var typingTimer;
                $inputSearch.keyup(function (e) {
                    var isEnterKey = e.keyCode === 13;
                    var isArrowKey = e.keyCode === 38 || e.keyCode === 40;

                    if (!(isEnterKey || isArrowKey)) {
                        clearTimeout(typingTimer);
                        typingTimer = setTimeout(doneTyping, doneTypingInterval);
                    }
                });
                $inputSearch.on('keydown', function (e) {
                    clearTimeout(typingTimer);
                });
            });
    });
</script>