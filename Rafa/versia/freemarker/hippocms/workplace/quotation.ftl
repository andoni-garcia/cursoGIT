<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />

<@hst.setBundle basename="workplace"/>
</#compress>
<main id="quotation-main" class="smc-main-container eshop">
    <div class="container">
            <noscript>
            <strong>We're sorry but vue-app doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
            </noscript>
            <div id="app"></div>
    </div>
</main>

<#-- Head -->
<@hst.headContribution category="htmlHead">
    <link href="<@hst.webfile path="/freemarker/versia/css-menu/workplace/quotation/quotation.css"/>" rel="preload" as="style"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link href="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/chunk-vendors.js"/>" rel="preload" as="script"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link href="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/quotation.js"/>" rel="preload" as="script"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link href="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/0.js"/>" rel="preload" as="script"/>
</@hst.headContribution>

<@hst.headContribution category="htmlHead">
    <link href="<@hst.webfile path="/freemarker/versia/css-menu/workplace/quotation/quotation.css"/>" rel="stylesheet"/>
</@hst.headContribution>

<#-- Script -->
<@hst.headContribution  category="htmlBodyEnd">
<script type="text/javascript">

    window.smc = window.smc || {};
    window.smc.workplace = window.smc.workplace || {};
    window.smc.workplace.channel = window.koUtils.getUrlWithLanguage();

</script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/chunk-vendors.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/quotation.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/workplace/quotation/0.js"/>" type="text/javascript"></script>
</@hst.headContribution>
