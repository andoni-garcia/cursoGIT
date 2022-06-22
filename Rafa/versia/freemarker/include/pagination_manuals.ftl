<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#include "../include/imports.ftl">
<#if pageable??>
<@hst.setBundle basename="essentials.pagination"/>
<ul class="pagination ">
  <#if pageable.totalPages gt 1>
    <#list pageable.pageNumbersArray as pageNr>
        <@hst.renderURL var="pageUrl">
            <@hst.param name="page" value="${pageNr}"/>
            <@hst.param name="pageSize" value="${pageable.pageSize}"/>
            <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
        </@hst.renderURL>
        <#if (pageNr_index==0 && pageable.previous)>
            <@hst.renderURL var="pageUrlFirst">
                <@hst.param name="page" value="${0}"/>
                <@hst.param name="pageSize" value="${pageable.pageSize}"/>
                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
            </@hst.renderURL>
            <li class = "list-inline-item"><a href="${pageUrlFirst}" class="iconed-text"><i class="icon-pagination-double-left"></i></a></li>

            <@hst.renderURL var="pageUrlPrevious">
                <@hst.param name="page" value="${pageable.previousPage}"/>
                <@hst.param name="pageSize" value="${pageable.pageSize}"/>
                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
            </@hst.renderURL>
            <li class = "list-inline-item"><a href="${pageUrlPrevious}"><i class="icon-pagination-single-left"></i></a></li>
        <#elseif  (pageNr_index==0)>
            <li class = "list-inline-item"><i class="icon-pagination-double-left"></i></li>
            <li class = "list-inline-item"><i class="icon-pagination-single-left"></i></li>
        </#if>
        <#if pageable.currentPage == pageNr>
            <li class="list-inline-item active"><a href="#">${pageNr}</a></li>
        <#else >
            <li class = "list-inline-item"><a href="${pageUrl}">${pageNr}</a></li>
        </#if>

        <#if !pageNr_has_next && pageable.next>
            <@hst.renderURL var="pageUrlNext">
                <@hst.param name="page" value="${pageable.nextPage}"/>
                <@hst.param name="pageSize" value="${pageable.pageSize}"/>
                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
            </@hst.renderURL>
            <li class = "list-inline-item"><a href="${pageUrlNext}" class="iconed-text"><i class="icon-pagination-single-right"></i></a></li>
            <@hst.renderURL var="pageUrlLast">
                <@hst.param name="page" value="${pageable.totalPages}"/>
                <@hst.param name="pageSize" value="${pageable.pageSize}"/>
                <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
            </@hst.renderURL>
            <li class = "list-inline-item"><a href="${pageUrlLast}" class="iconed-text"><i class="icon-pagination-double-right"></i></a></li>
        <#elseif !pageNr_has_next && !pageable.next >
            <li class = "list-inline-item"><span><i class="icon-pagination-single-right"></i></span></li>
            <li class = "list-inline-item"><span><i class="icon-pagination-double-right"></i></span></li>
        </#if>
    </#list>
  </#if>
</ul>
</#if>