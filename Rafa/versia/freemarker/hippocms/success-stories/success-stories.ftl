<#include "../../include/imports.ftl">
<#include "imports.ftl">
<#include "../bootstrap-components/custom-modal.ftl">
<#include "functions/get-ss-url.ftl">
<#-- @ftlvariable name="key" type="java.lang.String" -->
<#-- @ftlvariable name="isSuccessStoryAdmin" type="java.lang.Boolean" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.SuccessStory" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<#compress>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
    <@hst.link var="search" siteMapItemRefId="search"/>

    <@hst.setBundle basename="success-stories.list"/>
</#compress>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/success-stories/success-stories.component.css"/>" type="text/css"/>
</@hst.headContribution>

<#assign empty=true>
<#if pageable?? && pageable.items?has_content>
    <#assign empty=false>
</#if>

<div class="container">

    <div class="mb-30">
        <#-- <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />-->
    </div>
    <div class="cmseditlink">
    </div>
    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="sstories.title"/></h2>
    <h1 class="heading-02 heading-main"><@fmt.message key="sstories.subtitle"/></h1>


    <#if approveSuccess?has_content && approveSuccess>
        <div id="success-approve" class="dialog blue-dialog temporary">
            <div class="dialog-icon"><i class="fas fa-check"></i></div>
            <div class="dialog-content">
                <span class="dialog-title"><@fmt.message key="sstories.dialog.approve.title"/></span>
                <span><@fmt.message key="sstories.dialog.approve.content"/></span>
            </div>
            <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
        </div>
    </#if>

    <#if disapproveSuccess?has_content && disapproveSuccess>
        <div id="success-disapprove" class="dialog blue-dialog temporary">
            <div class="dialog-icon"><i class="fas fa-check"></i></div>
            <div class="dialog-content">
                <span class="dialog-title"><@fmt.message key="sstories.dialog.disapprove.title"/></span>
                <span><@fmt.message key="sstories.dialog.disapprove.content"/></span>
            </div>
            <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
        </div>
    </#if>

    <#if deletionSuccess?has_content && deletionSuccess>
        <div class="dialog blue-dialog temporary">
            <div class="dialog-icon"><i class="fas fa-check"></i></div>
            <div class="dialog-content">
                <span class="dialog-title"><@fmt.message key="sstories.dialog.delete.title"/></span>
                <span><@fmt.message key="sstories.dialog.delete.content"/></span>
            </div>
            <div class="dialog-close"><i class="fas fa-times-circle"></i></div>
        </div>
    </#if>
</div>
<br>
<div class="container ss-list ss-container">
    <@hst.include ref="facets" />

    <#include "search-box.ftl">
    <#if !empty>
        <#include "pagination-options.ftl">
    </#if>

    <div class="row align-self-end">
        <#if !empty>
            <span class="col-md-7 align-self-end"><@fmt.message key="sstories.results.showing"/> ${pageable.startOffset+1} <@fmt.message key="sstories.results.to"/> ${pageable.endOffset} <@fmt.message key="sstories.results.of"/> ${pageable.total} <#if pageable.total==1><@fmt.message key="sstories.results.entry"/><#else><@fmt.message key="sstories.results.entries"/></#if></span>
            <#include "ordering-options.ftl">
        </#if>
    </div>
    <form class="ss-edit"
          action="<@hst.actionURL escapeXml=false />&${_csrf.parameterName}=${_csrf.token}"
          method="post"
          role="form"
          id="ssForm">
        <div class="row mt-3">
            <div class="col-12">
                <!-- Success stories table -->
                <#if !empty>
                    <div class="table-responsive-lg">
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col">
                                    <#if isSuccessStoryAdmin><input id="approvecheck-all" type="checkbox"></#if>
                                </th>
                                <th scope="col"><@fmt.message key="sstories.reference"/></th>
                                <th scope="col"><@fmt.message key="sstories.date"/></th>
                                <th scope="col"><@fmt.message key="sstories.subsidiary"/></th>
                                <th scope="col"><@fmt.message key="sstories.industry_code"/></th>
                                <th scope="col"><@fmt.message key="sstories.application"/></th>
                                <th scope="col"><@fmt.message key="sstories.smc_series"/></th>
                                <th scope="col"><@fmt.message key="sstories.competitor"/></th>
                                <#if isSuccessStoryAdmin><th class="centered" scope="col"><@fmt.message key="sstories.status"/></th></#if>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <#if pageable?? && pageable.items?has_content>
                                <#list pageable.items as item>
                                    <@hst.link var="link" hippobean=item/>

                                    <#if isSuccessStoryAdmin || item.publish>
                                        <tr>
                                            <td>
                                                <#if isSuccessStoryAdmin>
                                                    <input class="ss-item-checkbox"
                                                           id="approvecheck"
                                                           name="reference-${item?index}"
                                                           type="checkbox"
                                                           value="${item.getReference()}">
                                                </#if>
                                            </td>
                                            <td>${item.formattedReference}</td>
                                            <td>
                                                ${item.formattedDate?string["dd/MM/yyyy"]}
                                            </td>
                                            <td>${item.subsidiary}</td>
                                            <td>${item.industry_code}</td>
                                            <td>${item.application}</td>
                                            <td>${item.smc_series}</td>
                                            <td>${item.competitor}</td>
                                            <#if isSuccessStoryAdmin>
                                                <#if item.publish>
                                                    <td class="centered"><i class="fas fa-check-circle"></i></td>
                                                <#else>
                                                    <td class="centered"><i class="fas fa-minus-circle disabled"></i></td>
                                                </#if>
                                            </#if>
                                            <td><a href="${cleanDetailUrl(link)}"><@fmt.message key="sstories.details"/></a></td>
                                        </tr>
                                    </#if>
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
                                <span class="dialog-title"><@fmt.message key="sstories.dialog.noresults.title"/></span>
                                <span><@fmt.message key="sstories.dialog.noresults"/></span>
                            </div>
                        </div>
                    </div>

                </#if>

                <@dashboard location="list" isAdmin=isSuccessStoryAdmin  />

            </div>
        </div>
    </form>
</div>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/success-stories/SuccessStoriesViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<#function cleanDetailUrl link>
    <#if !link?contains("en-eu")>
        <#return link?replace("/success-stories", "/${locale}/success-stories")>
    <#else>
        <#return link>
    </#if>
    <#return facetLink>
</#function>
