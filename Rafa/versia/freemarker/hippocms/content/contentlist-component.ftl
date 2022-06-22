<#include "../../include/imports.ftl">

<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.NewsDocument" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#if pageable?? && pageable.items?has_content>
  <div>
    <#list pageable.items as item>
       ${item.title}
    </#list>
    <#if cparam.showPagination>
        <#include "../../include/pagination.ftl">
    </#if>
  </div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
      <img src="<@hst.link path='/images/essentials/catalog-component-icons/news-list.png'/>"> Click to edit Content List
  </div>
</#if>


