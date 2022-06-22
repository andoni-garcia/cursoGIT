<#include "product-configurator/_details-modal-macro.ftl" />
<#if showOnlyFreeConfigurationTab>

    <#if deviceInfo.deviceType=='DESKTOP'>
        <div id="productConfiguratorContainer" class="smc-tabs main-tabs ${deviceInfo.deviceType?lower_case} ${(isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true)?then('free_configuration--cylinder','')}">
            <div class="tab-content">
                <div class="col-12">
                    <#if !isSingleChildrenNode>
                        <h2 class="productconfigurator__section__title"><@fmt.message key="productConfigurator.tabSubtitle"/></h2>
                    <#else>
                        <h2 class="productconfigurator__section__title"><@fmt.message key="productConfigurator.singleChildTabSubtitle"/></h2>
                    </#if>
                </div>
                <div class="tab-pane fade show active" id="free_configuration" role="tabpanel"
                     aria-labelledby="free_configuration_tab">
                    <section class="col-12 productconfigurator__section item__selection">

                        <#include "product-serie_configurator-tab.ftl">
                    </section>
                </div>
            </div>
        </div>
    <#else>
        <div id="productConfiguratorContainer" class="${deviceInfo.deviceType?lower_case}">
            <div>
                <div class="simple-collapse navigation-links-js">
                    <a href="#free_configuration_tab" data-section="free_configuration_tab"
                       class="js-accordion-mobile active" data-target="#free_configuration_tab">
                        <span><@fmt.message key="productConfigurator.freeconfiguration"/></span>
                    </a>
                </div>
                <div class="collapse show" data-toggle="collapse" id="free_configuration_tab"
                     data-parent="#productConfiguratorContainer">
                    <#include "product-serie_configurator-tab.ftl">
                </div>
            </div>
        </div>
    </#if>
<#else>
    <div class="ssi-load">
        <div class="loading-container-ssi-js category-spinner-container"></div>
    </div>
    <div id="productConfiguratorContainer" style="display:none" class="smc-tabs main-tabs ${deviceInfo.deviceType?lower_case}">
        <ul id="tabSearchResult" class="navbar-full nav border-bottom" role="tablist" style="display: none">
            <li class="nav-item">
                <a class="nav-link active" id="standard_stocked_items_tab" data-toggle="tab"
                   href="#standard_stocked_items" role="tab" aria-controls="standard_stocked_items"
                   aria-selected="false"><@fmt.message key="productConfigurator.standardstockeditems" /></a>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" id="free_configuration_tab" data-toggle="tab"
                   href="#free_configuration"
                   role="tab" aria-controls="free_configuration"
                   aria-selected="true"><@fmt.message key="productConfigurator.freeconfiguration" /></a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="col-12">
                <#if !isSingleChildrenNode>
                    <h2 class="productconfigurator__section__title"><@fmt.message key="productConfigurator.tabSubtitle"/></h2>
                <#else>
                    <h2 class="productconfigurator__section__title"><@fmt.message key="productConfigurator.singleChildTabSubtitle"/></h2>
                </#if>
            </div>
            <div class="tab-pane fade show active" id="standard_stocked_items" role="tabpanel"
                 aria-labelledby="standard_stocked_items_tab">
                <section class="col-12 productconfigurator__section ssi-component item__selection">
                    <p class="alert alert-info text-center">
                            <span><@fmt.message key="productConfigurator.lookingforothervariations"/> <a href="#"
                                                                                                         id = "free_configuration_trigger" onclick="$('#free_configuration_tab').tab('show')">  <strong><@fmt.message key="productConfigurator.clickhereforfreeconf"/></strong></a></span>
                    </p>
                    <#include "standard_stocked_items-tab.ftl">
                </section>
            </div>
            <div class="tab-pane fade" id="free_configuration" role="tabpanel"
                 aria-labelledby="free_configuration_tab">
                <section class="col-12 productconfigurator__section item__selection">
                    <p class="alert alert-info text-center">
                            <span><@fmt.message key="productConfigurator.lookingforssi"/> <a href="#"
                                                                                             onclick="$('#standard_stocked_items_tab').tab('show')"> <strong><@fmt.message key="productConfigurator.clickhereforssi"/> </strong></a></span>
                    </p>
                    <#include "product-serie_configurator-tab.ftl">
                </section>
            </div>
        </div>
    </div>
</#if>

<#if hstRequestContext.servletRequest.getParameter("show")??>
    <#assign show=hstRequestContext.servletRequest.getParameter("show")/>
<#else>
    <#assign show=""/>
</#if>

<#if (showModal?has_content && showModal == "true") || show == "details"  >
    <@detailsModalMacro id=("detailsModalMacro" + product.getNode().getId()?long?c + "_header")
    product=product boxTitle="productConfigurator.productDetails" buttonPresent = false
    statisticsSource="PCP GENERAL" />
</#if>
<@hst.headContribution category="scripts">
    <script type="text/javascript">
        $(document).ready(function(){
            $('#free_configuration_trigger').click();
            $("#productConfiguratorContainer").show();
        });
    </script>
</@hst.headContribution>