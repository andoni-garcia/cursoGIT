<#ftl encoding="UTF-8">
<#include "./_etools-scripts.ftl">
<#include "../../addtobasketbar-component/addtobasketbar-component.ftl"/>

<div class="container desktop etools-container" data-swiftype-index="false">
    <div class="row">
        <div class="col-12">
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="etools.productcatalogue"/></h2>
            <h1 class="heading-02 heading-main mb-4"><@fmt.message key="etools.FRLConfigurator"/></h1>
        </div>
    </div>

    <div id="eToolsFRLContainer" class="smc-tabs main-tabs ${deviceInfo.deviceType?lower_case}">
        <ul id ="tabSearchResult" class="navbar-full nav border-bottom" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="standard_stocked_items_tab" data-toggle="tab"
                   href="#configurator_tab" role="tab" aria-controls="standard_stocked_items"
                   aria-selected="true"><@fmt.message key="etools.configurator" /></a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" id="free_configuration_tab" data-toggle="tab" href="#summary_tab"
                   role="tab" aria-controls="free_configuration"
                   aria-selected="false"><@fmt.message key="etools.summaryanddocumentation" /></a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="configurator_tab" role="tabpanel"
                 aria-labelledby="standard_stocked_items_tab">
                <#include "etools-frl-configurator-tab.ftl">
            </div>
            <div class="tab-pane fade" id="summary_tab" role="tabpanel"
                 aria-labelledby="free_configuration_tab">
                <#include "etools-frl-summary-tab.ftl">
            </div>
        </div>
    </div>
</div>

<div class="hidden" data-swiftype-index='false'>
    <a id="getErpInfoUrl" class="hidden" href="<@hst.resourceURL resourceId='getErpInfo'/>"></a>
    <a id="getEtoolsFrlSummaryTableLink" href="<@hst.resourceURL resourceId='getEtoolsFrlSummaryTable'/>"></a>
    <a id="generateSummaryTabLink" href="<@hst.resourceURL resourceId='generateSummary'/>"></a>



</div>

<#include "_etools-frl-taco.ftl">

<script type="text/javascript">

    $(function () {
        var smc = window.smc || {};
        <#--smc.isAuthenticated = ${isAuthenticated?c};-->
        smc.etools = smc.etools || {};
        smc.etools.urls = {
            getErpInfo: document.getElementById('getErpInfoUrl').href,
            // createSimpleSpecialAlias : document.getElementById('createSimpleSpecialAlias').href,
            // exportBomURL : document.getElementById('exportBomLink').href,
            getEtoolsFrlSummaryTable: document.getElementById('getEtoolsFrlSummaryTableLink').href,
        };
        var EToolsFRLPageComponent = window.smc.EToolsFRLPageComponent;
        var config = {
            // id: 'productPageComponentId',
            // standardStockedItemsComponent: window.smc.standardStockedItemsComponent,
            // productConfiguratorComponent: window.smc.productConfiguratorComponent,
            container: '#eToolsFRLContainer',
            <#--device: '${deviceInfo.deviceType}',-->
            // cookieConsentComponent: cookieConsentComponent
        };
        var eToolsFRLPageComponent = new EToolsFRLPageComponent(config);
        eToolsFRLPageComponent.init();
        // window.smc.EToolsFRLPageController = EToolsFRLPageController;

        // var GeneralSearchNavigation = window.smc.GeneralSearchNavigation;
        // var generalNavigation = new GeneralSearchNavigation();
        //
        // var configGeneralSearch = {
        //     resultsContainer: 'productConfiguratorContainer',
        //     tabMenuContainer: 'tabSearchResult'
        // };
        //
        // generalNavigation.init(configGeneralSearch);
    });
</script>

<style>
    .etools-container .btn-primary {
        margin: 10px;
    }

    .nav-link.disabled {
        color: #4d4d4d!important;
        opacity: 0.6;
    }

    #BOM td {
        padding: 10px;
    }

    .buttons-container.series-container {
        flex-wrap: nowrap!important;
    }

    section.idbl_hto__content__actions.idbl_hto__content__actions--buttons.add-to-basket-bar-component.configurator {
        margin-top: -8px;
    }

</style>
