<#include "../../../../include/imports.ftl">
<@hst.setBundle basename="CylinderConfigurator,ProductConfigurator"/>


<#if apiSimpleSpecial?? >
    <div id="sscw__selection_table__headings_main" class="sscw__selection_table__headings HERE">
        <div class="sscw__selection_table__heading sscw__selection_table__heading--description">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.description"/></span>
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.partNumber"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.quantity"/></span>
            <#if apiPermission?? && apiPermission.isBomLeadTimes() >
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
            </#if>
        </div>
        <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
                <#if apiPermission.isBomNetPrices() >
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.unitPrice"/></span>
                </#if>
                <#if apiPermission.isBomListPrices() >
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.totalPrice"/></span>
                </#if>
            </div>
        </#if>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--local_ecw_stock">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.localStock"/></span>
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.ecwStock"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--disc_percent">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.discount"/> %</span>
        </div>
        <#if apiPermission?? && apiPermission.isBomNetPrices() >
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_net_price">
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.unitNetPrice"/></span>
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.totalNetPrice"/></span>
            </div>
        </#if>
    </div>
    <#list apiSimpleSpecial.getItems() as item >
        <div class="sscw__selection_table__register">
            <div class="sscw__selection_table__cell sscw__selection_table__cell--description"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.description"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.partNumber"/>">
                <span class="sscw__selection_table__cell__value">${item.getDescription()}</span>
                <span class="sscw__selection_table__cell__value">${item.getPartNumber()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--qty_lead_time"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.quantity"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.lead-time"/>">
                <span class="sscw__selection_table__cell__value">${item.getQuantity()}</span>
                <#if apiPermission?? && apiPermission.isBomLeadTimes() >
                    <span class="sscw__selection_table__cell__value">${item.getLeadTime()}</span>
                </#if>
            </div>
            <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>
                <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                     data-cell-title="<@fmt.message key="cylinderConfigurator.unitPrice"/>"
                     data-cell-title-2="<@fmt.message key="cylinderConfigurator.totalPrice"/>">
                    <#if apiPermission.isBomNetPrices() >
                        <span class="sscw__selection_table__cell__value">${item.getUnitPrice()}</span>
                    </#if>
                    <#if apiPermission.isBomListPrices() >
                        <span class="sscw__selection_table__cell__value">${item.getTotalPrice()}</span>
                    </#if>
                </div>
            </#if>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.localStock"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.ecwStock"/>">
                <span class="sscw__selection_table__cell__value">${item.getLocalStock()}</span>
                <span class="sscw__selection_table__cell__value">${item.getEcwStock()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_discount"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.discount"/>">
                <#if item.getDiscount()?has_content>
                    <span class="sscw__selection_table__cell__value">${item.getDiscount()} %</span>
                <#else>
                    <span class="sscw__selection_table__cell__value"></span>
                </#if>
            </div>
            <#if  apiPermission?? && apiPermission.isBomNetPrices() >
                <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock"
                     data-cell-title="<@fmt.message key="cylinderConfigurator.unitNetPrice"/>"
                     data-cell-title-2="<@fmt.message key="cylinderConfigurator.totalNetPrice"/>">
                    <span class="sscw__selection_table__cell__value">${item.getUnitNetPrice()}</span>
                    <span class="sscw__selection_table__cell__value">${item.getTotalNetPrice()}</span>
                </div>
            </#if>
        </div>
    </#list>
    <#if apiPermission?? && (apiPermission.isBomLeadTimes()  || apiPermission.isTotalPrice())>
    <#--        ENDING HEADERS -->
        <div class="sscw__selection_table__headings">
            <div class="sscw__selection_table__heading sscw__selection_table__heading--part_number">
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.partNumber"/></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
                <#if apiPermission?? && apiPermission.isBomLeadTimes()>
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
                </#if>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
                <#if apiPermission?? && apiPermission.isTotalPrice()>
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.list-price"/></span>
                </#if>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--total-net-price">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--disc_percent">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <#if apiPermission?? && apiPermission.isBomNetPrices() >
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_net_price">
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.totalNetPrice"/></span>
            </div>
            </#if>
        </div>
    <#--        TOTAL VALUES-->
        <div id="sscw__selection_table__summatory" class="sscw__selection_table__register">
            <div class="sscw__selection_table__cell sscw__selection_table__cell--part_number">
                <span class="sscw__selection_table__cell__value">${apiSimpleSpecial.getSimpleSpecialCode()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--qty_lead_time"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.lead-time"/>">
                <#if apiPermission?? && apiPermission.isBomLeadTimes()>
                    <span class="sscw__selection_table__cell__value">${apiSimpleSpecial.getSimpleSpecialLeadTime()}</span>
                </#if>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.list-price"/>">
                <#if apiPermission?? && apiPermission.isTotalPrice()>
                    <span class="sscw__selection_table__cell__value">${apiSimpleSpecial.getSimpleSpecialListPrice()}</span>
                </#if>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--total-net-price not-used">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--total-discount not-used">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
            <#if apiPermission?? && apiPermission.isBomNetPrices() >

            <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_net_price"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.totalNetPrice"/>">
                    <span class="sscw__selection_table__cell__value">${apiSimpleSpecial.getSimpleSpecialNetPrice()}</span>
            </div>
            </#if>
        </div>
    </#if>

<#elseif apiBom?? >
<#--    If the product has rod end and accessories, for some countries simple special can not be created-->
    <input type="hidden" name="can_create_simple_special" value="${apiBom.isCanCreateSimpleSpecial()?c}">

    <div id="sscw__selection_table__headings_main" class="sscw__selection_table__headings">
        <div class="sscw__selection_table__heading sscw__selection_table__heading--description">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.description"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--part_number">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.partNumber"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.quantity"/></span>
            <#if apiPermission?? && apiPermission.isBomLeadTimes() >
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
            </#if>
        </div>
        <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
                <#if apiPermission.isBomNetPrices() >
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.unitPrice"/></span>
                </#if>
                <#if apiPermission.isBomListPrices() >
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.totalPrice"/></span>
                </#if>
            </div>
        </#if>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--local_ecw_stock">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.localStock"/></span>
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.ecwStock"/></span>
        </div>
    </div>

    <#list apiBom.getItems() as item >
        <div class="sscw__selection_table__register">
            <div class="sscw__selection_table__cell sscw__selection_table__cell--description"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.description"/>">
                <span class="sscw__selection_table__cell__value">${item.getDescription()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--part_number"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.partNumber"/>">
                <span class="sscw__selection_table__cell__value">${item.getPartNumber()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--qty_lead_time"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.quantity"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.lead-time"/>">
                <span class="sscw__selection_table__cell__value">${item.getQuantity()}</span>
                <#if apiPermission?? && apiPermission.isBomLeadTimes() >
                    <span class="sscw__selection_table__cell__value">${item.getLeadTime()}</span>
                </#if>
            </div>
            <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>
                <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                     data-cell-title="<@fmt.message key="cylinderConfigurator.unitPrice"/>"
                     data-cell-title-2="<@fmt.message key="cylinderConfigurator.totalPrice"/>">
                    <#if apiPermission.isBomNetPrices() >
                        <span class="sscw__selection_table__cell__value">${item.getUnitPrice()}</span>
                    </#if>
                    <#if apiPermission.isBomListPrices() >
                        <span class="sscw__selection_table__cell__value">${item.getTotalPrice()}</span>
                    </#if>
                </div>
            </#if>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.localStock"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.ecwStock"/>">
                <span class="sscw__selection_table__cell__value">${item.getLocalStock()}</span>
                <span class="sscw__selection_table__cell__value">${item.getEcwStock()}</span>
            </div>
        </div>
    </#list>

<#--        ENDING HEADERS -->
    <#if apiPermission?? && (apiPermission.isBomLeadTimes()  || apiPermission.isTotalPrice())>
        <div class="sscw__selection_table__headings">
            <div class="sscw__selection_table__heading sscw__selection_table__heading--description">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--part_number">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
                <#if apiPermission?? && apiPermission.isBomLeadTimes()>
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
                </#if>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
                <#if apiPermission?? && apiPermission.isTotalPrice()>
                    <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.list-price"/></span>
                </#if>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--local_ecw_stock">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
        </div>
    <#--        TOTAL VALUES-->
        <div id="sscw__selection_table__summatory" class="sscw__selection_table__register">
            <div class="sscw__selection_table__cell sscw__selection_table__cell--description">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--part_number">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--qty_lead_time"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.lead-time"/>">
                <#if apiPermission?? && apiPermission.isBomLeadTimes()>
                    <span class="sscw__selection_table__cell__value">${apiBom.getLeadTime()}</span>
                </#if>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.list-price"/>">
                <#if apiPermission?? && apiPermission.isTotalPrice()>
                    <span class="sscw__selection_table__cell__value">${apiBom.getListPrice()}</span>
                </#if>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
        </div>
    </#if>
<#else >
    <div class="alert alert-info"><@fmt.message key="cylinderConfigurator.couldNotLoadSummary"/></div>
</#if>
