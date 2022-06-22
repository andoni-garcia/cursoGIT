<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-page/product-configurator/product-configurator.component.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/libs/select2.min.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/psearch/psearch.component.css" fullyQualified=true />"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/libs/select2.full.min.js" fullyQualified=true />"></script>
</@hst.headContribution>
<@hst.setBundle basename="essentials.global,ParametricSearch,ProductConfigurator"/>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/product-catalog/product-catalog.css" fullyQualified=true />" type="text/css"/>
</@hst.headContribution>
<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/product-selection.component.js"/>"></script>
<@hst.headContribution category="htmlBodyEnd">
    <#include "../_spinner.ftl">
</@hst.headContribution>
<#include "etech_libraries.ftl">

<div id = "productSelection-navigation-container" class="dc-navigation-page"  >
    <div id="searchParamsBox">
        <div class="psearch-searching-container"></div>
        <div class="col-12 product_selection">
            <div class="" id="smc-psearch" >
                <form id = "form" action ="" method="post">
                    <div class="hidden" id ="cpn_partnumber"></div>
                    <div id="cpn_state" class="config-state hidden" align="center"><span class="part-number-state part-number-state-ok"></span></div>
                    <div class="pc__loading_spinner"></div>
                    <div class="dc_productConfiguratorForm">
                        <!---------------------------------------------------------------------------------->
                        <!--------------------------- PRODUCT SELECTION HTML ------------------------------->
                        <!---------------------------------------------------------------------------------->
                        ${node.getConfiguratorHtml()?replace('http:', 'https:', 'r')?replace(':80', '', 'r')}

                        <!---------------------------------------------------------------------------------->
                        <!------------------------- END PRODUCT SELECTION HTML ----------------------------->
                        <!---------------------------------------------------------------------------------->

                        <!---------------------------------------------------------------------------------->
                        <!--------------------------- PRODUCT SELECTION JS  -------------------------------->
                        <!---------------------------------------------------------------------------------->

                        <script id="productSelectionConfiguratorJs">
                            <#-- Change http links to https, Remove port (:80) from links -->
                            ${ node.getConfiguratorJs()?replace('http:', 'https:', 'r')?replace(':80', '', 'r') }
                        </script>
                        <!---------------------------------------------------------------------------------->
                        <!------------------------- END PRODUCT SELECTION JS  ------------------------------>
                        <!---------------------------------------------------------------------------------->
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div>
    <a id="searchSelectionLink" href="<@hst.resourceURL resourceId='searchSelection'/>"></a>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var productSelection;
        $(function() {
            var ProductSelection = window.smc.ProductSelection;
            var config = {
                id: "product-selection",
                productId: "${productId}",
                seriesProductId: "${seriesProductId}",
                partNumber: "${partNumber}",
                productSelectionId: "${productSelectionId}",
                messages: {
                    selectPlaceholder: "<@fmt.message key="productConfigurator.select.placeholder" />",
                    featuredOptions: "<@fmt.message key="productConfigurator.select.featuredOptions" />",
                    partNumberCopied: "<@fmt.message key="productConfigurator.partnumbercopied" />",
                    browserNotCompatibleLbl: "<@fmt.message key="productConfigurator.browsernotcompatible" />",
                    clickheretoloadrodendproject: "<@fmt.message key="productConfigurator.clickheretoloadrodendproject" />"
                },
                etech: {
                    Init: window.Init,
                    oDomains: window.oDomains,
                    oStateMessages: window.oStateMessages
                },
                urls :{
                    searchSelection : document.getElementById('searchSelectionLink').href
                }
            };
            productSelection = new ProductSelection(config);
            productSelection.init();
        });
    });
</script>
