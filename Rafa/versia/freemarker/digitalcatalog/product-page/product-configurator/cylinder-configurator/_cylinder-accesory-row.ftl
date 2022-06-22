<#include "../../../../include/imports.ftl">
<#include "../../../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="CylinderConfigurator,ProductConfigurator,StandardStockedItems,ProductToolbar"/>
<div id = "aareo_accesory_summary_${partNumberAcc}_${selectedZone}" zone-value = "${selectedZone}"  partnumber-value = "${partNumberAcc}" group-value = "${group}" class="aareo_accesory_summary_element accordion__item accordion__item-${selectedZone}-position">
    <div class="accordion__item__header">
        <h3 id="tools_tab_${partNumber}_${selectedZone}" class="heading-06 color-blue mb-0 accordion__item__toggler collapsed" data-toggle="collapse" data-target="#${selectedZone}-position__collapse" aria-expanded="false" aria-controls="accesories_${partNumber}_${selectedZone}_collapse">
            <span>${selectedZone} <@fmt.message key="cylinderConfigurator.position"/></span>
            <i class="fa fa-plus"></i>
        </h3>
    </div>
    <div  id="${selectedZone}-position__collapse" class = "aareo_accesory_summary_data collapse"  aria-labelledby="accesories_${partNumber}_${selectedZone}" data-parent="#${partNumber}_${selectedZone}__accordion">
        <div class="accordion__item__body__content">
            <figure class="accessories-selection-summary__position__image image d-flex align-items-center">
                <img src="${product.getImageUrl()}" class="img-fluid" />
            </figure>
            <div class="accessories-selection-summary__position__info">
                <#if group?has_content>
                    <div class="accessories-selection-summary__position__info__title"><@fmt.message key="standardstockeditems.group"/>:</div>
                    <div class="accessories-selection-summary__position__info__value">${group}</div>
                </#if>
                <div class="accessories-selection-summary__position__info__title"><@fmt.message key="standardstockeditems.productdescription"/>:</div>
                <div class="accessories-selection-summary__position__info__value aareo_accesory_summary_row_description">${description}</div>
                <div class="accessories-selection-summary__position__info__title"><@fmt.message key="standardstockeditems.partnumber"/>:</div>
                <div class="accessories-selection-summary__position__info__value">${partNumberAcc}</div>
            </div>
            <div class="accessories-selection-summary__position__actions">
                <div class="aareo_accesory_summary_row_buttons_toolbar_container">
                    <#if product.isHasCad() == true>
                        <div class="spares-accesory-item__actions">
                            <@productToolbar id=("producttoolbar_" + product.getPartNumber() +"_"+selectedZone  + "_desktop") relatedProductId=product.getProductid() boxTitle="" renderingMode="related-product-cad"
                            showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false product="" areWeInCylinderConfigurator=true
                            showCadDownload=true showVideo=false showDataSheet=false partNumber=product.getPartNumber()
                            statisticsSource="SPARE PARTS AND ACCESSORIES"/>
                        </div>
                    </#if>
                </div>
                <div class="aareo_accesory_summary_row_buttons_delete_container">
                    <div class="spares-accesory-item__actions">
                        <button  class="btn btn-secondary btn-secondary--blue-border" onclick="javascript:removeAccesoryFromSummary('aareo_accesory_summary_${partNumberAcc}_${selectedZone}');"
                                 data-toggle="tooltip" data-placement="bottom" title="" data-original-title="<@fmt.message key="cylinderConfigurator.remove"/>">
                            <i class="fa fa-trash"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>