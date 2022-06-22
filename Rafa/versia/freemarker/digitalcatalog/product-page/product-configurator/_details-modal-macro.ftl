<#macro detailsModalMacro buttonPresent product id statisticsSource boxTitle>
    <@hst.setBundle basename="ProductConfigurator,ProductToolbar"/>

    <@hst.headContribution category="htmlBodyEnd">
        <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/details-modal-macro.js"/>"></script>
    </@hst.headContribution>

    <#if buttonPresent>
        <button class = "btn btn-primary" onclick="showModal();">
            <@fmt.message key="productConfigurator.showDetails"/>
        </button>
    </#if>
    <div class="hidden" data-swiftype-index='false'>
        <a id="showModalProductDetailJSONLink" href="<@hst.resourceURL resourceId='showProductDetailJson'/>"></a>
    </div>
    <div class="modal fade show-details-modal show product-details-modal" id="_showDetailsModal" tabindex="-1" role="dialog" aria-labelledby="_showDetailsModalTitle" style="padding-right: 17px; display: block;">
        <div class="modal-dialog modal-xl modal-dialog-centered hidden" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="_showDetailsModal"><@fmt.message key="productConfigurator.showDetails"/></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div data-title="${product.getNode().getName()}" class="product-configuration-header-section ${deviceInfo.deviceType?lower_case} pdm__title_wrapper">
                        <p class="pdm__title" data-swiftype-index="true">${product.getNode().getName()}</p>
                        <p class="pdm__title__partnumber" data-swiftype-index="true">${hstRequestContext.servletRequest.getParameter("partNumber")}</p>
                    </div>
                    <div class="pdm__image_wrapper">
                        <div class="image"><@renderImage images=product.getNode().getImages() type='LARGE' /></div>
                    </div>
                    <div class="pdm__info_wrapper">
                        <div class="product-detail-content">
                            <div id = "modal_settings_container"  class="detail-table">
                                <#if product.getNode()?? && product.getNode().getSettings()?? && product.getNode().getSettings()?size != 0 >
                                    <#list product.getNode().getSettings() as item>
                                        <div class="detail-register">
                                        <#if item.getKey() == "PITW_SETTING_CONFIGURATION_FILE">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target = "_blank" href = "${item.getValue()}" ><@fmt.message key="product.toolbar.title.PITW_SETTING_CONFIGURATION_FILE"/></a>
                                            </div>
                                            <div class="pl-1 pr-0 key-text-value"></div>
                                        <#elseif item.getKey() == "PITW_SETTING_DRIVERS">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target = "_blank" href = "${item.getValue()}" ><@fmt.message key="product.toolbar.title.PITW_SETTING_DRIVERS"/></a>
                                            </div>
                                            <div class="pl-1 pr-0 key-text-value"></div>
                                        <#elseif item.getKey() == "PITW_SETTING_SOFTWARE">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target = "_blank" href = "${item.getValue()}" ><@fmt.message key="product.toolbar.title.PITW_SETTING_SOFTWARE"/></a>
                                            </div>
                                            <div class="pl-1 pr-0 key-text-value"></div>
                                        <#else>
                                            <div class="pl-2 pr-0 key-text">${item.getKey()}:</div>
                                            <div class="pl-1 pr-0 key-text-value">${item.getValue()}</div>
                                        </#if>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                    </div>
                    <div class="pdm__toolbars_wrapper">
                        <@productToolbar id=("producttoolbar_acccessory_modal_materials_" + product.getNode().getId()?long?c + "_header")
                        product=product.getNode() boxTitle="product.toolbar.materials" renderingMode="simple"
                        showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showAskSMC=false
                        statisticsSource="PCP SMART-QUOTATIONS MODAL GENERAL" />

                        <@productToolbar id=("producttoolbar_acccessory_modal_" + product.getNode().getId()?long?c + "_header")
                        product=product.getNode() boxTitle="product.toolbar.materials" renderingMode="3d-preview" sticky=true
                        showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false
                        showAskSMC=false showVideo=false inConfigurationPage=true comesFromModalDetails=true
                        statisticsSource="PCP SMART-QUOTATIONS MODAL" />

                        <#if product.getNode().getVideo()?has_content && (product.getNode().getVideo()?ends_with(".mp4"))>
                            <video src="${product.getNode().getVideo()}" controls class="product-video"
                                   smc-statistic-action="DOWNLOAD FILE" smc-statistic-data3="PRODUCT VIDEO"
                                   smc-statistic-source="${statisticsSource}" smc-statistic-on="play">
                                <@fmt.message key="productConfigurator.browsernotcompatible.youcandownload"/> <a
                                        href="${videoURL}"><@fmt.message key="productConfigurator.browsernotcompatible.youcandownloadhere"/></a>
                            </video>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var smc = window.smc || {};
        smc.isAuthenticated = ${isAuthenticated?c};
        smc.pc = smc.pc || {};
        smc.pc.urls = {};
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var smc = window.smc || {};
            var DetailsModal = window.smc.DetailsModal;
            smc.details = smc.details || {};
            smc.details.urls = {
                showProductDetail: document.getElementById('showModalProductDetailJSONLink').href
            };
            var messages = {
                PITW_SETTING_CONFIGURATION_FILE : "<@fmt.message key='product.toolbar.title.PITW_SETTING_CONFIGURATION_FILE' />",
                PITW_SETTING_DRIVERS : "<@fmt.message key='product.toolbar.title.PITW_SETTING_DRIVERS' />",
                PITW_SETTING_SOFTWARE : "<@fmt.message key='product.toolbar.title.PITW_SETTING_SOFTWARE' />"
            };
            var config = {
                id : 'details_modal',
                productId : '${product.getNode().getId()?long?c}',
                showParameter : '${hstRequestContext.servletRequest.getParameter("show")}',
                showModal : "${showModal}",
                partNumber : '${hstRequestContext.servletRequest.getParameter("partNumber")}',
                messages : messages
            }
            var detailsModal =  new DetailsModal(config);
            detailsModal.init();
        });
    </script>
</#macro>