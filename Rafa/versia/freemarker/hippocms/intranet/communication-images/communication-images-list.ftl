<#include "../../../include/imports.ftl">
<#include "../macros/dashboardCI.ftl">
<#include "../intranet-credentials.ftl">
<#compress>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
    <@hst.setBundle basename="intranet-communication_images, SearchPage"/>
</#compress>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/intranet/intranet.component.css"/>" type="text/css"/>
</@hst.headContribution>

<#assign empty=true>

<#if pageable?? && pageable.items?has_content>
    <#assign empty=false>
</#if>

<div class="container">
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="ci_list.title"/></h2>
    <h1 class="heading-02 heading-main"></h1>
</div>

<div class="container generalList-list generalList-container">
    <@hst.include ref="facets" />

    <#include "search-box.ftl">
    <div class="row align-self-end">
        <#if !empty>
            <#include "filters.ftl">
        </#if>
    </div>


    <form>
        <div class="row mt-3">
            <div class="col-12">
                <!-- Communication images text list table -->
                <#if !empty>
                    <div class="table-responsive-lg">
                        <table class="table">
                            <thead>
                            <tr>
                                <#if cparam.showExport>
                                    <th scope="col"><input id="ci_check-all" type="checkbox"></th>
                                </#if>
                                <th scope="col"><@fmt.message key="ci.description"/></th>
                                <th scope="col"><@fmt.message key="ci.subsidiary"/></th>
                                <th scope="col"><@fmt.message key="ci.filetype"/></th>
                                <th scope="col"><@fmt.message key="ci.brand"/></th>
                                <th scope="col"><@fmt.message key="ci.productfamily"/></th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <@hst.link var="link" siteMapItemRefId="CIdetailId"/>

                            <#if pageable?? && pageable.items?has_content>
                                <#list pageable.items as item>
                                    <tr>
                                        <#if cparam.showExport>
                                            <td scope="col"><input class="ci_checkbox" type="checkbox" value='${item.getName()}'></td>
                                        </#if>
                                        <td>${item.description}</td>
                                        <td>
                                            ${subsidiaryList[item.subsidiary]}
                                        </td>
                                        <td>${fileList[item.filetype]}</td>
                                        <td>
                                            <#if item.brand?? && item.brand>
                                                <@fmt.message key="ci.yes"/>
                                            <#else>
                                                <@fmt.message key="ci.no"/>
                                            </#if>
                                        </td>
                                        <td>${productFamilyList[item.productfamily]}</td>
                                        <td><a href="${link}/${item.name}"><@fmt.message key="ci.details"/></a></td>
                                    </tr>
                                </#list>
                            </#if>
                            </tbody>
                        </table>
                    </div>

                    <div class="form-row">
                        <div class="col-12">
                            <#if pageable.showPagination??>
                                <#include "pagination.ftl">
                            </#if>
                        </div>
                    </div>
                <#else>

                    <div class="dialog list-dialog">
                        <div class="dialog list-dialog-container">
                            <div class="dialog-icon"><i class="fas fa-search"></i></div>
                            <div class="dialog-content">
                                <span class="dialog-title"><@fmt.message key="ci.noresult"/></span>
                                <span><@fmt.message key="ci.spelled"/></span>
                            </div>
                        </div>
                    </div>

                </#if>
            </div>
        </div>
        <@dashboardCI location="list"/>
    </form>
</div>


<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/intranet/IntranetViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/intranet/exportCI.js"/>" type="text/javascript"></script>
</@hst.headContribution>
