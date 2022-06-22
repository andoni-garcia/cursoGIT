<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#-- @ftlvariable name="paginationOptions" type="java.util.List" -->
<#include "../../include/imports.ftl">
<#include "macros/url-renderer.ftl">

<div class="manual-pagination-container catalogue__pagination_display" id="catalogue__pagination_display">
    <div id="root-filter">
        <#if paginationOptions?? && paginationOptions?has_content>
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

                            <div class="col-md-4 text-center mt-10 mt-lg-0 d-none d-sm-block">
                                <@fmt.message key="search.searchresult.paging.display"/>
                                <#list paginationOptions as item>
                                    <@renderUrl name="paginationOptionUrl" pageSize="${item}"/>
                                    <#if (pageSize?? && pageSize == item)>
                                        <span data-section='product_catalogue' class="changelen" data-len="${item}" href="#">${item}</span>
                                    <#else>
                                        <a class="changelen" href="${paginationOptionUrl}">${item}</a>
                                    </#if>
                                    ${item?has_next?then('|','')}
                                </#list>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </#if>
    </div>
</div>

