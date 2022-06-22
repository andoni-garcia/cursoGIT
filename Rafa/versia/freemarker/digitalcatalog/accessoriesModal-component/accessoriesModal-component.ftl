<!doctype html>
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<@hst.setBundle basename="ProductToolbar,ProductConfigurator"/>
<div class="modal fade show-accessories-modal show accessories-details-modal" id="_showAccessoryModal" role="dialog" aria-labelledby="_showAccessoryModalTitle" style="padding-right: 17px; display: block;">
    <div class="modal-dialog modal-xl modal-dialog-centered " role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="_showAccessoryModalTitle"><@fmt.message key="productConfigurator.showDetails"/></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div data-title="${partNumberResponse.getProduct().getNode().getName()}"
                     class="product-configuration-header-section ${deviceInfo.deviceType?lower_case} pdm__title_wrapper">
                    <p class="pdm__title"
                       data-swiftype-index="true">${partNumberResponse.getProduct().getNode().getName()}</p>
                    <p class="pdm__title__partnumber" data-swiftype-index="true">${accessoryPartNumber}</p>
                </div>
                <div class="pdm__image_wrapper">
                    <div class="image"><@renderImage images=partNumberResponse.getProduct().getNode().getImages() type='LARGE' /></div>
                </div>
                <div class="pdm__info_wrapper">
                    <div class="product-detail-content">
                        <div id="modal_settings_container" class="detail-table">
                            <#if partNumberResponse.getProduct().getNode()?? && partNumberResponse.getTechnicalData()?? && partNumberResponse.getTechnicalData()?size != 0 >
                                <#list partNumberResponse.getTechnicalData() as item>
                                    <div class="detail-register">
                                        <#if item.getKey() == "PITW_SETTING_CONFIGURATION_FILE">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target="_blank"
                                                   href="${item.getValue()}"><@fmt.message key="product.toolbar.title.PITW_SETTING_CONFIGURATION_FILE"/></a>
                                            </div>
                                            <div class="pl-1 pr-0 key-text-value"></div>
                                        <#elseif item.getKey() == "PITW_SETTING_DRIVERS">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target="_blank"
                                                   href="${item.getValue()}"><@fmt.message key="product.toolbar.title.PITW_SETTING_DRIVERS"/></a>
                                            </div>
                                            <div class="pl-1 pr-0 key-text-value"></div>
                                        <#elseif item.getKey() == "PITW_SETTING_SOFTWARE">
                                            <div class="pl-2 pr-0 key-text">
                                                <a target="_blank"
                                                   href="${item.getValue()}"><@fmt.message key="product.toolbar.title.PITW_SETTING_SOFTWARE"/></a>
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
                <#include "../product/product-toolbar-macro.ftl">
                <div class="pdm__toolbars_wrapper">
                    <@productToolbar id=("producttoolbar_accessory_modal_materials_" + partNumberResponse.getProduct().getNode().getId()?long?c + "_header")
                    product=partNumberResponse.getProduct().getNode() boxTitle="product.toolbar.materials" renderingMode="simple"
                    partNumber=accessoryPartNumber
                    showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showAskSMC=false
                    statisticsSource="PCP ACCESSORY MODAL GENERAL" />

                    <@productToolbar id=("producttoolbar_accessory_modal_preview_" + partNumberResponse.getProduct().getNode().getId()?long?c + "_header")
                    product=partNumberResponse.getProduct().getNode() boxTitle="product.toolbar.materials" renderingMode="3d-preview" sticky=true
                    partNumber=accessoryPartNumber
                    showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false
                    showAskSMC=false showVideo=false inConfigurationPage=true comesFromModalDetails=true
                    statisticsSource="PCP ACCE  SSORY MODAL" />

                    <#if partNumberResponse.getProduct().getNode().getVideo()?has_content && (partNumberResponse.getProduct().getNode().getVideo()?ends_with(".mp4"))>
                        <video src="${partNumberResponse.getProduct().getNode().getVideo()}" controls
                               class="product-video"
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