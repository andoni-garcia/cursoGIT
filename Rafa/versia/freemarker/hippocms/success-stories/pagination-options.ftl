<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#-- @ftlvariable name="paginationOptions" type="java.util.List" -->
<#include "../../include/imports.ftl">
<#include "imports.ftl">

<#if paginationOptions?? && paginationOptions?has_content>
    <div class="form-row">
        <div class="col-12">
            <ul class="eshop pagination">
                <li class="page-item disabled"><a class="page-link" href=" #"><@fmt.message key="sstories.display"/></a></li>

                <#list paginationOptions as item>
                    <@renderUrl name="paginationOptionUrl" pageSize="${item}"/>

                    <#if pageSize?? && pageSize == item>
                        <li class="page-item"><a class="page-link active" href="#" style="border: none !important; border-radius: 5px;">${item}</a></li>
                    <#else>
                        <li class="page-item"><a class="page-link" href="${paginationOptionUrl}">${item}</a></li>
                    </#if>
                </#list>
            </ul>
        </div>
    </div>
</#if>

