<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#include "../../../include/imports.ftl">
<#include "../macros/url-renderer.ftl">

<#if pageable??>
    <div class="pagination-container col-12">
        <ul class="pagination">
            <#if pageable.totalPages gt 1>
                <#list pageable.pageNumbersArray as pageNr>
                    <@renderUrl name="pageUrl" page="${pageNr}" pageSize="${pageable.pageSize}"/>
                    <#if pageNr_index==0>
                        <#if pageable.previous>
                            <@renderUrl name="pageUrlPrevious" page="${pageable.previousPage}" pageSize="${pageable.pageSize}"/>
                            <@renderUrl name="pageUrlStart" page="${pageable.startPage}" pageSize="${pageable.pageSize}"/>
                            <li><a class="pagination-item" href="${pageUrlStart}"><span class="prev fas fa-angle-double-left"></span></a></li>
                            <li><a class="pagination-item" href="${pageUrlPrevious}"><span class="prev fas fa-angle-left"></span></a></li>
                        <#else>
                            <li class="disabled"><span class="prev fas fa-angle-double-left pagination-item"></span></li>
                            <li class="disabled"><span class="prev fas fa-angle-left pagination-item"></span></li>
                        </#if>
                    </#if>
                    <#if pageable.currentPage == pageNr>
                        <li><span class="current pagination-item">${pageNr}</span></li>
                    <#else >
                        <li><a class="pagination-item" href="${pageUrl}">${pageNr}</a></li>
                    </#if>
                    <#if !pageNr_has_next>
                        <#if pageable.next>
                            <@renderUrl name="pageUrlNext" page="${pageable.nextPage}" pageSize="${pageable.pageSize}"/>
                            <@renderUrl name="pageUrlEnd" page="${pageable.endPage}" pageSize="${pageable.pageSize}"/>
                            <li><a class="pagination-item" href="${pageUrlNext}"><span class="next fas fa-angle-right"></span></a></li>
                            <li><a class="pagination-item" href="${pageUrlEnd}"><span class="prev fas fa-angle-double-right"></span></a></li>
                        <#else>
                            <li class="disabled"><span class="next fas fa-angle-right pagination-item"></span></li>
                            <li class="disabled"><span class="next fas fa-angle-double-right pagination-item"></span></li>
                        </#if>
                    </#if>
                </#list>
            </#if>
        </ul>
    </div>
</#if>
