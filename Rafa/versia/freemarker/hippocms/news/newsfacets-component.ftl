<#include "../../include/imports.ftl">

<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.NewsDocument" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->

<@hst.setBundle basename="facets"/>
<#if facets??>
<div class="container" id="news-facets" style="margin-bottom:30px">
    <div class="my-5">
      <#list facets.folders as facet>
          <#if facet.folders?? && facet.folders?has_content>
            <label class="smc-select mr-2 w-auto-md-up">
                <select class="facet-select">
                    <option class="first-option" value=""><@fmt.message key="facets.selector.searchby" /> ${facet.name}</option>
                    <#list facet.folders as value>
                        <#assign facetName><@fmt.message key="facet.label.${value.name}" /></#assign>
                        <#if value.count &gt; 0>
                            <#if value.leaf>
                                <@hst.facetnavigationlink var="removeLink" remove=value current=facets />
                                <option class="remove-option" selected value="${removeLink}">${facetName?contains("???")?then(value.name, facetName)}&nbsp;(${value.count})</option>
                            <#else>
                                <@hst.link var="link" hippobean=value />
                                <option value="${link}">${facetName?contains("???")?then(value.name, facetName)}&nbsp;(${value.count})</option>
                            </#if>
                        </#if>
                    </#list>
                </select>
            </label>
          </#if>
      </#list>
        <div style="display:none">
            <button id="reset" class="btn btn-primary mt-3"><@fmt.message key="facets.button.reset" /></button>
        </div>
    </div>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
      <img src="<@hst.link path='/images/essentials/catalog-component-icons/news-list.png'/>"> Click to edit Facets Component
  </div>
</#if>
<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/lister&detail-pages.js"/>"></script>
</@hst.headContribution>