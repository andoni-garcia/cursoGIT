<input id = "product_seriesAttrValue" class="hidden" value = "${product.getNode().getSerie()}" />
<#include "../accessoriesModal-component/_accessories-modal_links.ftl">
<#if showOnlyFreeConfigurationTab>
    <#if deviceInfo.deviceType=='DESKTOP'>
        <div id="productConfiguratorContainer" class="smc-tabs main-tabs ${deviceInfo.deviceType?lower_case}">
            <ul id="tabSearchResult" class="navbar-full nav border-bottom" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="free_configuration_tab" data-toggle="tab"
                       href="#free_configuration" role="tab" aria-controls="free_configuration"
                       aria-selected="false"><@fmt.message key="productConfigurator.freeconfiguration" /></a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="free_configuration" role="tabpanel"
                     aria-labelledby="free_configuration_tab">
                    <#include "product_configurator-tab.ftl">
                </div>
            </div>
        </div>
    <#else>
        <div id="productConfiguratorContainer" class="${deviceInfo.deviceType?lower_case}">
            <div>
                <div class="simple-collapse navigation-links-js">
                    <a href="#free_configuration_tab" data-section="free_configuration_tab" class="js-accordion-mobile active" data-target="#free_configuration_tab">
                        <span><@fmt.message key="productConfigurator.freeconfiguration"/></span>
                    </a>
                </div>
                <div class="collapse show" data-toggle="collapse" id="free_configuration_tab" data-parent="#productConfiguratorContainer">
                    <#include "product_configurator-tab.ftl">
                </div>
            </div>
        </div>
    </#if>

<#else>
    <#if deviceInfo.deviceType=='DESKTOP'>
        <div id="productConfiguratorContainer" class="smc-tabs main-tabs ${deviceInfo.deviceType?lower_case}">
            <ul id ="tabSearchResult" class="navbar-full nav border-bottom" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="standard_stocked_items_tab" data-toggle="tab"
                       href="#standard_stocked_items" role="tab" aria-controls="standard_stocked_items"
                       aria-selected="true"><@fmt.message key="productConfigurator.standardstockeditems" /></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled" id="free_configuration_tab" data-toggle="tab" href="#free_configuration"
                       role="tab" aria-controls="free_configuration"
                       aria-selected="false"><@fmt.message key="productConfigurator.freeconfiguration" /></a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="standard_stocked_items" role="tabpanel"
                     aria-labelledby="standard_stocked_items_tab">
                    <#include "standard_stocked_items-tab.ftl">
                </div>
                <div class="tab-pane fade" id="free_configuration" role="tabpanel"
                     aria-labelledby="free_configuration_tab">
                    <#include "product_configurator-tab.ftl">
                </div>
            </div>
        </div>

    <#else>
        <div id="productConfiguratorContainer" class="${deviceInfo.deviceType?lower_case}">
            <div>
                <div class="simple-collapse navigation-links-js">
                    <a href="#standard_stocked_items_tab" data-section="standard_stocked_items_tab"
                       class="js-accordion-mobile"
                       data-target="#standard_stocked_items_tab">
                        <span><@fmt.message key="productConfigurator.standardstockeditems"/></span>
                    </a>
                </div>
                <div class="collapse" data-toggle="collapse" id="standard_stocked_items_tab" data-parent="#productConfiguratorContainer">
                    <#include "standard_stocked_items-tab.ftl">
                </div>
            </div>
            <div>
                <div class="simple-collapse navigation-links-js">
                    <a href="#free_configuration_tab" data-section="free_configuration_tab" class="js-accordion-mobile" data-target="#free_configuration_tab">
                        <span><@fmt.message key="productConfigurator.freeconfiguration"/></span>
                    </a>
                </div>
                <div class="collapse" data-toggle="collapse" id="free_configuration_tab" data-parent="#productConfiguratorContainer">
                    <#include "product_configurator-tab.ftl">
                </div>
            </div>
        </div>
    </#if>
</#if>