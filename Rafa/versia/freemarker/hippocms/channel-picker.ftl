<#include "../include/imports.ftl">

<#assign currentLocale=hstRequest.requestContext.resolvedMount.mount.locale>
<@hst.link var="menuLanguage" path="binaries/content/gallery/smc_global/headicons/menu-web-language.svg"/>

<li class="d-xxl-none d-xl-none d-lg-none showInput"><a href="#"> <span class="icon-search"></span></a></li>
<div class="search-input">
    <input type="text" id="search_bar_text_input_mobile" class="search-mobile" placeholder="Search for...">
</div>

<#if (currentLocale != "en_ZA" &&  currentLocale != "es_AR" && currentLocale != "es_CL") >
    <li class="d-lg-block main-header__meta__language" data-swiftype-index='false'>
        <a href="#">
            <#if iconFlag??>
            		<div class="flag-icon">
            			<img class="top-menu-img" src="${menuLanguage}" alt="${currentLocale}"/>
            			<span id="current-local">${currentLocale?substring(3)}</span>
            		</div>
             <#--Modificado 20-02-01 despliega menu de paises
             <img src="<@hst.link hippobean=iconFlag.original />" alt="${iconFlag.fileName}"> -->
            </#if>
        </a>
    </li>
<#else>
    <li class="d-lg-block" data-swiftype-index='false'>
        <span>
            <#if iconFlag??>
            		<img class="top-menu-img" src="${menuLanguage}" />
                <img src="<@hst.link hippobean=iconFlag.original />" alt="${iconFlag.fileName}">
            </#if>
        </span>
    </li>
</#if>

<script id="swiftypeSearchComponent" data-locale="${.locale}">
    $('.search-input').hide();
    $("input[type='text']").blur(function () {
        $('.search-input').hide();
        $('.flag-icon, .basket-icon, .profile-icon, .icon-search').show();
    })
    $('.showInput').click(function(){
        $('.flag-icon, .basket-icon, .profile-icon, .icon-search').hide();
        $('.search-input').show();
        $('#search_bar_text_input_mobile').focus();
    });

    $(function () {


        var $thisSwiftypeComponent = document.getElementById("swiftypeSearchComponent");
        var locale = $thisSwiftypeComponent.dataset.locale;
        var locales = locale.split("_");
        var language = locales[0];
        var country = locales[1];
        var $input = $("#search_bar_text_input_mobile");

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