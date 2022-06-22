<#include "product-page/_product-configurator-test-page-scripts.ftl">

<@hst.setBundle basename="essentials.global,ProductConfigurator,ProductToolbar,AddToCartBar,StandardStockedItems,SearchPage,SparesAccessories"/>

<style>
    .productconfigurator-component .configurator-container #configuration_area tr.configurationRow td.optionStatus span:nth-child(3):after, .productconfigurator-component .configurator-container #configuration_area tr.builder td.optionStatus span:nth-child(3):after {
        content: '\79';
    }

    .productconfigurator-component .configurator-container #configuration_area tr.configurationRow td.optionStatus span:after, .productconfigurator-component .configurator-container #configuration_area tr.builder td.optionStatus span:after {
        position: relative;
        top: 8px;
        left: 0;
        right: 15px;
        width: 20px;
        height: 20px;
        font-family: 'smc';
        font-size: 20px;
        color: #0bdf00;
    }

    .productconfigurator-component .configurator-container #configuration_area tr.configurationRow td.optionStatus span>img, .productconfigurator-component .configurator-container #configuration_area tr.builder td.optionStatus span>img {
        display: none;
    }

    .productconfigurator-component .product-info-container table.config .config-cell {
        display: none;
    }

    .productconfigurator-component .product-info-container table.config {
        margin-bottom: 10px;
    }

    .productconfigurator-component .product-info-container table.config tr>td {
        padding: 10px;
        border: 2px solid #0074BE;
    }

    .productconfigurator-component .product-info-container table.config tr>td.partnumber_variable_chain {
        background: #f2dede;
    }

    .productconfigurator-component .configurator-container #configuration_area #xRodFormArea table.builder table.rodEndTable tr.rodEndRow td.formStatusOK::after {
        content: '\79';
        color: #0bdf00;
    }

    .productconfigurator-component .configurator-container #configuration_area #xRodFormArea table.builder table.rodEndTable tr.rodEndRow td.formStatusNO_OK::after {
        content: '\7a';
        color: #FF191F;
    }

    .productconfigurator-component .configurator-container #configuration_area .image_sel_class_selected {
        border: 2px solid #0074BE !important;
    }
</style>

<div class="productconfigurator-component container-fluid is-standalone-page"
     data-swiftype-index='true'>
    <div>
        <div class="col-lg-12 product-info-container configurator-component">
            <div class="dc_partnumberContainer confPageRestylingTEMP1">
                <!---------------------------------------------------------------------------------->
                <!------------------------------- PART NUMBER HTML --------------------------------->
                <!---------------------------------------------------------------------------------->

                ${ product.getNode().getPartNumberHtml() }

                <!---------------------------------------------------------------------------------->
                <!--------------------------- END PART NUMBER HTML --------------------------------->
                <!---------------------------------------------------------------------------------->

            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 configurator-container" data-swiftype-index='false'>
            <form id="form" action="" method="post">
                <div class="dc_productConfiguratorForm" style="clear: both;">
                    <!---------------------------------------------------------------------------------->
                    <!------------------------------- CONFIGURATION HTML ------------------------------->
                    <!---------------------------------------------------------------------------------->

                    <#-- Change http links to https, Remove port (:80) from links -->
                    ${ product.getNode().getConfiguratorHtml()?replace('http:', 'https:', 'r')?replace(':80', '', 'r') }

                    <script id="configuratorJs">
                        <#-- Change http links to https, Remove port (:80) from links -->
                        ${ product.getNode().getConfiguratorJs()?replace('http:', 'https:', 'r')?replace(':80', '', 'r') }
                    </script>

                    <!---------------------------------------------------------------------------------->
                    <!----------------------------- END CONFIGURATION HTML ----------------------------->
                    <!---------------------------------------------------------------------------------->

                </div>
            </form>
            <div id="xRodFormArea"></div>
            <div id="xRodFormError"></div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
       Init();
    })
</script>
