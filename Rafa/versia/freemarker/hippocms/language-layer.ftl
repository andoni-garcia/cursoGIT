<#include "../include/imports.ftl">


<#assign currentLocale=hstRequest.requestContext.resolvedMount.mount.locale>
<#assign localesFound = 0 >
<#assign multipleLanguageCountry = "false" >
<#assign currentCountry =currentLocale?lower_case?substring(3) >
<#list siblingPagesHighlighted?keys as locale>
    <#if locale?lower_case?substring(3) == currentCountry >
        <#assign localesFound = localesFound + 1 >
    </#if>
</#list>
<#list siblingPages?keys as locale>
    <#if locale?lower_case?substring(3) == currentCountry >
        <#assign localesFound = localesFound + 1 >
    </#if>
</#list>
<#if localesFound != 0 && localesFound!= 1  >
    <#assign multipleLanguageCountry = "true" >
</#if>
<div id="language" class="language-selector text-01" data-swiftype-index='false'>
<div class="close-cross">
	<button class="cross-btn" onclick="closeLanguages()"><span class="fade-icon__icon icon-close"></span></button>
</div>
<div class="region-title">
	<h6>Suggested region and language</h6>
	<div class="suggests">
	<ul class="countries-list">
        <#list siblingPagesHighlighted?keys as locale>
                <#if (locale != "en_ZA" &&  locale != "es_AR" && locale != "es_CL") >
                    <li style="margin-left:-1.25em">
                        <#assign properties=siblingPagesHighlighted[locale].getMount().getChannelInfo().getProperties() >
                        <#assign iconFlagCountry="iconFlag_" + locale >
                        <@hst.link var="linkHippo" link=siblingPagesHighlighted[locale]/>
                        <#assign linkLecacy=properties.legacyHomeWebsite >

                        <a class="language-selector-item language-selector-item-highlighted"
                           href="<#if properties.redirectToLegacyHomeWebsite>${linkLecacy}<#else>${linkHippo}</#if>">
                            <img src="<@hst.link hippobean=iconFlagCountry?eval.original />" >
                            <span>${properties.countryName}</span>
                        </a>
                    </li>
                </#if>
        </#list>
    </ul>
    <div class="suggested-language">
    <#if multipleLanguageCountry ==  "true">
        <ul class="countries-list">
            <#list siblingPagesHighlighted?keys as locale>
                <#if multipleLanguageCountry ==  "true" && locale?lower_case?substring(3) == currentCountry>
                    <li>
                        <#assign properties=siblingPagesHighlighted[locale].getMount().getChannelInfo().getProperties() >
                        <#assign iconFlagCountry="iconFlag_" + locale >
                        <@hst.link var="linkHippo" link=siblingPagesHighlighted[locale]/>
                        <#assign linkLecacy=properties.legacyHomeWebsite >

                        <a class="language-selector-item language-selector-item-highlighted"
                           href="<#if properties.redirectToLegacyHomeWebsite>${linkLecacy}<#else>${linkHippo}</#if>">
                            <img src="<@hst.link hippobean=iconFlagCountry?eval.original />" >
                            <span>&nbsp${locale?substring(0,2)}</span>
                        </a>
                    </li>
                </#if>
            </#list>
            <#list siblingPages?keys as locale>
                <#if multipleLanguageCountry = "true" && locale?lower_case?substring(3) ==  currentCountry>
                    <li>
                        <#assign properties=siblingPages[locale].getMount().getChannelInfo().getProperties() >
                        <#assign iconFlagCountry="iconFlag_" + locale >
                        <@hst.link var="linkHippo" link=siblingPages[locale]/>
                        <#assign linkLecacy=properties.legacyHomeWebsite >

                        <a class="language-selector-item"
                           href="<#if properties.redirectToLegacyHomeWebsite>${linkLecacy}<#else>${linkHippo}</#if>">
                            <img src="<@hst.link hippobean=iconFlagCountry?eval.original />" >
                            <span>&nbsp${locale?substring(0,2)}</span>
                        </a>
                    </li>
                </#if>
            </#list>
        </ul>
    </#if>
    </div>
    </div>
    <h6>Select your region and language</h6>
    </div>
    <hr/>
    <ul class="countries-list">
        <#list siblingPages?keys?sort as locale>
                <#if (locale != "en_ZA" &&  locale != "es_AR" && locale != "es_CL") >
                    <li>
                        <#assign properties=siblingPages[locale].getMount().getChannelInfo().getProperties() >
                        <#assign iconFlagCountry="iconFlag_" + locale >
                        <@hst.link var="linkHippo" link=siblingPages[locale]/>
                        <#assign linkLecacy=properties.legacyHomeWebsite >

                        <a class="language-selector-item"
                           href="<#if properties.redirectToLegacyHomeWebsite>${linkLecacy}<#else>${linkHippo}</#if>">
                            <img src="<@hst.link hippobean=iconFlagCountry?eval.original />" >
                            <span>&nbsp${locale?substring(3)}</span>
                        </a>
                    </li>
                </#if>
        </#list>
    </ul>
</div>
<script>
	// Lo cierra pero no lo vuelve a mostrar
	function closeLanguages() {
        let d = document.getElementById('language');
        d.style.display = "none";
        window.location.reload();
    }
</script>