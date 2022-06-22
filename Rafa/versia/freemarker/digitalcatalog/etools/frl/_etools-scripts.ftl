<#include "../../../include/imports.ftl">
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/functionality/functionality.css" />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/select/bootstrap-select.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/functionality/jquery.dataTables.css" />"
          type="text/css"/>
</@hst.headContribution>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.js"></script>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/porthole.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/etools-frl.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools/etools-frl.component.js"/>" type="text/javascript"></script>
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
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/spares-accessories.module.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/standard-stocked-items/related-products.module.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/series-spares-related.module.js" fullyQualified=true />"></script>
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
    <#include "../../_spinner.ftl">
</@hst.headContribution>
<@hst.setBundle basename="ETools,SearchPage,SearchBar,ProductConfigurator"/>