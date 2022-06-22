<#include "../../../include/imports.ftl">
<@hst.setBundle basename="ETools,CylinderConfigurator,ProductConfigurator"/>


<#if apiBom?? >
    <input id="partnumbers" class="hidden" value="${partNumbers!""}"/>
    <div id="sscw__selection_table__headings_main" class="sscw__selection_table__headings">
        <div class="sscw__selection_table__heading sscw__selection_table__heading--description">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.description"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--part_number">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.partNumber"/></span>
        </div>
        <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.quantity"/></span>
            <#--            <#if apiPermission?? && apiPermission.isBomLeadTimes() >-->
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
            <#--            </#if>-->
        </div>
        <#--        <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>-->
        <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
            <#--                <#if apiPermission.isBomNetPrices() >-->
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.unitPrice"/></span>
            <#--                </#if>-->
            <#--                <#if apiPermission.isBomListPrices() >-->
            <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.totalPrice"/></span>
            <#--                </#if>-->
        </div>
        <#--        </#if>-->
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
<#--                <#if apiPermission?? && apiPermission.isBomLeadTimes() >-->
<#--                    <span class="sscw__selection_table__cell__value">${item.getLeadTime()}</span>-->
<#--                </#if>-->
                <span class="sscw__selection_table__cell__value">${item.getLeadTime()}</span>

            </div>
<#--            <#if apiPermission?? && (apiPermission.isBomNetPrices()  || apiPermission.isBomListPrices())>-->
<#--                <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"-->
<#--                     data-cell-title="<@fmt.message key="cylinderConfigurator.unitPrice"/>"-->
<#--                     data-cell-title-2="<@fmt.message key="cylinderConfigurator.totalPrice"/>">-->
<#--                    <#if apiPermission.isBomNetPrices() >-->
<#--                        <span class="sscw__selection_table__cell__value">${item.getUnitPrice()}</span>-->
<#--                    </#if>-->
<#--                    <#if apiPermission.isBomListPrices() >-->
<#--                        <span class="sscw__selection_table__cell__value">${item.getTotalPrice()}</span>-->
<#--                    </#if>-->
<#--                </div>-->
<#--            </#if>-->
            <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.unitPrice"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.totalPrice"/>">
                <span class="sscw__selection_table__cell__value">${item.getUnitPrice()}</span>
                <span class="sscw__selection_table__cell__value">${item.getTotalPrice()}</span>
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.localStock"/>"
                 data-cell-title-2="<@fmt.message key="cylinderConfigurator.ecwStock"/>">
                <span class="sscw__selection_table__cell__value">${item.getLocalStock()}</span>
                <span class="sscw__selection_table__cell__value">${item.getEcwStock()}</span>
            </div>
        </div>
    </#list>

<#--        ENDING HEADERS -->
<#--    <#if apiPermission?? && (apiPermission.isBomLeadTimes()  || apiPermission.isTotalPrice())>-->
        <div class="sscw__selection_table__headings">
            <div class="sscw__selection_table__heading sscw__selection_table__heading--description">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--part_number">
                <span class="sscw__selection_table__heading__title"></span>
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--qty_lead_time">
                <#--                <#if apiPermission?? && apiPermission.isBomLeadTimes()>-->
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.lead-time"/></span>
                <#--                </#if>-->
            </div>
            <div class="sscw__selection_table__heading sscw__selection_table__heading--unit_total_price">
                <#--                <#if apiPermission?? && apiPermission.isTotalPrice()>-->
                <span class="sscw__selection_table__heading__title"><@fmt.message key="cylinderConfigurator.list-price"/></span>
                <#--                </#if>-->
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
                <#--                <#if apiPermission?? && apiPermission.isBomLeadTimes()>-->
                <span class="sscw__selection_table__cell__value">${apiBom.getLeadTime()}</span>
                <#--                </#if>-->
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--unit_total_price"
                 data-cell-title="<@fmt.message key="cylinderConfigurator.list-price"/>">
                <#--                <#if apiPermission?? && apiPermission.isTotalPrice()>-->
                <span class="sscw__selection_table__cell__value">${apiBom.getListPrice()}</span>
                <#--                </#if>-->
            </div>
            <div class="sscw__selection_table__cell sscw__selection_table__cell--local_ecw_stock">
                <span class="sscw__selection_table__cell__value"></span>
            </div>
        </div>
<#--    </#if>-->
<#else >
    <div class="alert alert-info"><@fmt.message key="cylinderConfigurator.couldNotLoadSummary"/></div>
</#if>
