<#ftl encoding="UTF-8">
<#include "../../../include/imports.ftl">
<#include "../../catalog-macros.ftl">
<#include "swiftype-search-engine.ftl">
<#include "../general-search/general-search-engine.ftl">
<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>
<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/swiftype-search/swiftype-search.component.css"/>" type="text/css"/>
</@hst.headContribution>
<div class="loading-container-search-text-js"></div>
<!-- /* RACA-0 */-->
<div class="main-header__search d-none d-xl-block d-xxl-block d-lg-block">
    <span class="fade-icon">
        <span class="fade-icon__icon icon-search"></span>
    </span>
</div>
<!-- /* RACA-0 */-->
<div class="main-header__searchtext search-bar-input-container d-xxl-block">
    <input type="text" id="search_bar_text_input"  class="typeahead"  autocomplete="off" placeholder="<@fmt.message key="searchbar.input.placeholder"/>">
</div>
<@hst.headContribution category="htmlHead">
<link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/spinner.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <#include "../../_spinner.ftl">
</@hst.headContribution>

<script id="swiftypeSearchComponent" data-locale="${.locale}">
/*
$('#main-header__search').click(function(e) {
    $('main-navigation-list__view').css('opacity', '0');
    $('main-navigation-list__view').css('pointer-events', 'auto');
    e.preventDefault();
    e.stopPropagation();
});

$(window).click(function() {
    $('main-navigation-list__view').css('opacity', '1');
    $('main-navigation-list__view').css('pointer-events', 'auto');
});

*/
let navbar= document.getElementById("main-navigation-list__view");
let search= document.getElementById("search_bar_text_input");

search.addEventListener('input',function(e){
    if(document.getElementById("search_bar_text_input").value){
        document.getElementById("main-navigation-list__view").style.opacity = 0;
        document.getElementById("main-navigation-list__view").style.pointerEvents = "none";
    } else {
        document.getElementById("main-navigation-list__view").style.opacity = 1;
        document.getElementById("main-navigation-list__view").style.pointerEvents = "auto";
    }
    e.preventDefault();
    e.stopPropagation();
});

window.onclick = function() {
    console.log(document.getElementById("search_bar_text_input").value);
    document.getElementById("main-navigation-list__view").style.opacity = 1;
    document.getElementById("main-navigation-list__view").style.pointerEvents = "auto";

}


    $(function () {

        var conf = {
            input: '.search-query',
            inPageButton: '.search-inpage__submit',
            showSuggestsClass: 'has-suggest',
            inpageActiveClass: 'active',
            hasSearchClass: 'has-search',
            headerFadeIcon: '.main-header__search .fade-icon',
            headerSearchInput: '.main-header__searchtext input[type="text"]',
            isMenu:true,
            headerWrapper:'.main-header__search',
            headerSearchText: '.main-header__searchtext',
            searchQuery: '.search-query'
        };
        SearchModule.init(conf);
        var $thisSwiftypeComponent = document.getElementById("swiftypeSearchComponent");
        var locale = $thisSwiftypeComponent.dataset.locale;
        var locales = locale.split("_");
        var language = locales[0];
        var country = locales[1];
        var $input = $("#search_bar_text_input");

        window.smc = window.smc || {};
        var generalSearchConfig = {
            messages: {
                ssiDisclaimer: "<@fmt.message key="search.searchbar.ssiDisclaimer"/>"
            }
        };
        var SwiftypeEngine = window.smc.SwiftypeEngine;
        var SearchLog =  window.smc.SearchLog;
        var GeneralSearch = window.smc.GeneralSearch;
        var swiftypeEngine = new SwiftypeEngine(locale);
        var searchLog = new SearchLog();
        var generalSearch = new GeneralSearch(generalSearchConfig);
        for (var engine in swiftypeEngine.getEngines()) {
            generalSearch.addEngine(engine, swiftypeEngine);
        }

        var typeaheadConfig ={
            followLinkOnEnter: true,
            changeInputOnSelect: true
        };

        //user is "finished typing," do something
        function doneTyping () {

            if($input.val().length >2){
                swiftypeEngine.getAutoComplete($input.val().trim(),
                        $input,
                        searchLog,
                        generalSearch,
                        typeaheadConfig,
                        '.loading-container-search-text-js',
                        language,
                        country);
            }
        }

        function doSearch(e, term) {
            if (e) e.preventDefault();

            generalSearch.redirect(term.trim());
        }

        $(document).on('smc.generalsearch.dosearch', doSearch);

        swiftypeEngine.init()
            .then(function () {
                var doneTypingInterval = 300;
                var typingTimer;
                $input.keyup(function (e) {
                    var isEnterKey = e.keyCode === 13;
                    var isArrowKey = e.keyCode === 38 || e.keyCode === 40;

                    if (!(isEnterKey || isArrowKey)) {
                        clearTimeout(typingTimer);
                        typingTimer = setTimeout(doneTyping, doneTypingInterval);

                    } else if (isEnterKey) {
                        $(document).trigger('smc.generalsearch.dosearch', [$input.val()]);
                    }
                });
                $input.on('keydown', function (e) {
                    clearTimeout(typingTimer);
                });
            });
    });
</script>