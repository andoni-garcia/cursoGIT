<#include "../../include/imports.ftl">

<#import "office-renderer.ftl" as officeRenderer>

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Event" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<@hst.setBundle basename="SearchPage,component.newslist"/>

<#if pageable?? && pageable.items?has_content>
    <div class="container">
            <#if (pageable.total > 0) >
                <div class="col-md-12 manual-pagination-container">
                    <div class="col-lg-12 p-0 ">
                        <div class="row pagination_showing align-items-center">
                            <div class="col-md-4 mt-10 mt-lg-0 text-center text-md-left">
                                <@fmt.message key="search.searchresult.paging.showing"/>
                                <span class="js-search-init-page-number">${((pageable.currentPage - 1) * pageable.pageSize) + 1 }</span>
                                <@fmt.message key="search.searchresult.paging.to"/>
                                <#if (pageable.total > (pageable.currentPage * (pageable.pageSize + 1)) )>
                                    <span class="js-search-finish-page-number">${(((pageable.currentPage - 1) * pageable.pageSize) +  pageable.pageSize )}</span>
                                <#else>
                                    <span class="js-search-finish-page-number">${pageable.total}</span>
                                </#if>
                                <@fmt.message key="search.searchresult.paging.of"/>
                                <span class="js-search-total">${pageable.total}</span>
                                <@fmt.message key="search.searchresult.paging.entries"/>
                            </div>
                            <div class="col-md-4 div-right mt-10 mt-lg-0 d-none d-sm-block" >
                                <@fmt.message key="search.searchresult.paging.display"/>
                                <#if pageable.pageSize == 10 >
                                    <span data-section='product_catalogue' class="changelen" data-len="10" href="#">10</span> |
                                <#else>
                                    <@hst.renderURL var="pageUrl10">
                                        <@hst.param name="page" value="1"/>
                                        <@hst.param name="pageSize" value="10"/>
                                        <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                    </@hst.renderURL>
                                    <a data-section='product_catalogue' class="changelen" data-len="10" href="${pageUrl10}" onmousedown="javascript:resetManual('10');">10</a> |
                                </#if>
                                <#if pageable.pageSize == 20 >
                                    <span data-section='product_catalogue' class="changelen" data-len="20" href="#">20</span> |
                                <#else>
                                    <@hst.renderURL var="pageUrl20">
                                        <@hst.param name="page" value="1"/>
                                        <@hst.param name="pageSize" value="20"/>
                                        <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                    </@hst.renderURL>
                                    <a data-section='product_catalogue' class="changelen" data-len="20" href="${pageUrl20}" onmousedown="javascript:resetManual('20');">20</a> |
                                </#if>
                                <#if pageable.pageSize == 50 >
                                    <span data-section='product_catalogue' class="changelen" data-len="50" href="#">50</span> |
                                <#else>
                                    <@hst.renderURL var="pageUrl50">
                                        <@hst.param name="page" value="1"/>
                                        <@hst.param name="pageSize" value="50"/>
                                        <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                    </@hst.renderURL>
                                    <a data-section='product_catalogue' class="changelen" data-len="50" href="${pageUrl50}" onmousedown="javascript:resetManual('50');">50</a> |
                                </#if>
                                <#if pageable.pageSize == 100 >
                                    <span data-section='product_catalogue' class="changelen" data-len="100" href="#">100</span>
                                <#else>
                                    <@hst.renderURL var="pageUrl100">
                                        <@hst.param name="page" value="1"/>
                                        <@hst.param name="pageSize" value="100"/>
                                        <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                    </@hst.renderURL>
                                    <a data-section='product_catalogue' class="changelen" data-len="100" href="${pageUrl100}" onmousedown="javascript:resetManual('100');">100</a>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            <#else>
                <#if !query?has_content >
                    <div class="searchResult text-center m-auto p-5">
                        <div class="col align-self-center"><@fmt.message key="psearch.noresultsfound"/></div>
                    </div>
                <#else>
                    <div class="searchResult text-center m-auto p-5">
                        <p>
                            <span><@fmt.message key="search.searchresult.begin.text"/> </span>
                            <span id="searchResultText" class="search-query"> "${hstRequestContext.servletRequest.getParameter("query")}" </span>
                            <span> <@fmt.message key="search.searchresult.middle.text"/> </span>
                            <span id="searchResultNumber" class="search-query"> 0 </span>
                            <span> <@fmt.message key="search.searchresult.end.text"/></span>
                        </p>
                    </div>
                </#if>
            </#if>
            <div class="events-section">
                <div class="row">
                    <#list pageable.items as item>
                        <@officeRenderer.renderItem item=item/>
                    </#list>
                </div>
                <div class="manual-pagination-container pagination-container align-items-center">
                    <#include "../../include/pagination_manuals.ftl">
                </div>
            </div>
    </div>
<#elseif editMode>
    <div>Click to edit Offices page</div>
<#else>
    <div class="container">
        <div class="row">
            <h2><@fmt.message key="empty.events.message" /></h2>
        </div>
    </div>
</#if>

