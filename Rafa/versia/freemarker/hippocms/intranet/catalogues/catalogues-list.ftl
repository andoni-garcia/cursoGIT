<#include "../../../include/imports.ftl">
<#include "../intranet-credentials.ftl">
<#compress>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
    <@hst.setBundle basename="intranet-catalogues.list,SearchPage"/>
</#compress>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/intranet/intranet.component.css"/>" type="text/css"/>
</@hst.headContribution>

<#assign empty=true>

<#if pageable?? && pageable.items?has_content>
    <#assign empty=false>
</#if>

<div class="container">
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="catalogue_list.title"/></h2>
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


    <div class="row mt-3">
        <div class="col-12">
            <!-- Catalogues list table -->
            <#if !empty>
                <div class="table-responsive-lg">
                    <table class="table">
                        <thead>
                        <tr>
                            <th scope="col"><@fmt.message key="catalogues.index"/></th>
                            <th scope="col"><@fmt.message key="catalogues.series"/></th>
                            <th scope="col"><@fmt.message key="catalogues.productname"/></th>
                            <th scope="col"><@fmt.message key="catalogues.language"/></th>
                            <th scope="col"><@fmt.message key="catalogues.lastmodified"/></th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <@hst.link var="link" siteMapItemRefId="detailId"/>
                        <#if pageable?? && pageable.items?has_content>
                            <#list pageable.items as item>
                                <tr>
                                    <td>${indexList[item.index]}</td>
                                    <td>${item.productserie}</td>
                                    <td>${item.catalogueid}</td>
                                    <td>${languageList[item.language]}</td>
                                    <td>
                                        ${item.lastmodified.time?datetime?string["dd/MM/yyyy"]}
                                    </td>
                                    <td><a href="${link}/${item.name}"><@fmt.message key="catalogues.details"/></a></td>
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
                            <span class="dialog-title"><@fmt.message key="catalogues.noresult"/></span>
                            <span><@fmt.message key="catalogues.spelled"/></span>
                        </div>
                    </div>
                </div>

            </#if>
        </div>
    </div>
</div>


<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/intranet/IntranetViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>