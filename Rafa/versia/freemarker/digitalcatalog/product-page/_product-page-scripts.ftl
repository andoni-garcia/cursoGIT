<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#include "../product/product-toolbar-macro.ftl">
<#include "../addtobasketbar-component/addtobasketbar-component.ftl">

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/libs/select2.min.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-page/product-configurator/product-configurator.component.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/idbl_hto/estilos.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-page/standard-stocked-items/standard-stocked-items.component.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/libs/select2.full.min.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/libs/clamp.min.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-page.controller.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/cookie-consent.component.js" />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/spares-accessories.module.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/selection-basket-favourites-bar.module.js" fullyQualified=true />"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/standard-stocked-items/standard-stocked-items.component.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/standard-stocked-items/ssi-product.component.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/standard-stocked-items/related-products.module.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/standard-stocked-items/compare-product.module.js" fullyQualified=true />"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/product-configurator.component.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/project-information.module.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/cylinder-configurator.component.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/cylinder-wizard-modal.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/general-search/general-search-navigation.component.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="empty-layout">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/forms/form-validator.js" fullyQualified=true />"></script>
</@hst.headContribution>

<#include "etech_libraries.ftl">
