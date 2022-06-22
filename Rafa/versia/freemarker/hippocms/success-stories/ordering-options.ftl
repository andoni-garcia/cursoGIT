<#-- @ftlvariable name="orderingOptions" type="java.util.List" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#include "../../include/imports.ftl">
<#include "imports.ftl">

<#if orderingOptions?? && orderingOptions?has_content>
    <div class="col-md-5">
        <div class="dropdown smc-select">
            <select class="ordering-select">
                <#list orderingOptions as item>
                    <@renderUrl name="orderingOptionUrlASC" sortField="${item}" sortOrder="ASC"/>
                    <@renderUrl name="orderingOptionUrlDESC" sortField="${item}" sortOrder="DESC"/>

                    <#if ( sortField?has_content && sortField == item )>
                        <#if ( sortOrder?has_content && sortOrder == "ASC" )>
                            <option value="${orderingOptionUrlDESC}">▼ <@fmt.message key="sstories.order.${item}"/></option>
                            <option selected value="${orderingOptionUrlASC}">▲ <@fmt.message key="sstories.order.${item}"/></option>
                        <#else>
                            <option selected value="${orderingOptionUrlDESC}">▼ <@fmt.message key="sstories.order.${item}"/></option>
                            <option value="${orderingOptionUrlASC}">▲ <@fmt.message key="sstories.order.${item}"/></option>
                        </#if>
                    <#else>
                        <option value="${orderingOptionUrlDESC}">▼ <@fmt.message key="sstories.order.${item}"/></option>
                        <option value="${orderingOptionUrlASC}">▲ <@fmt.message key="sstories.order.${item}"/></option>
                    </#if>
                </#list>
            </select>
        </div>
    </div>
</#if>

