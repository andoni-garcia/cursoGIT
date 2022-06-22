<#include "../../include/imports.ftl">

<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.NewsDocument" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<@hst.setBundle basename="component.newslist"/>

<#if newsMap?? && newsMap?has_content>
<div class="container">
  <section class="news-releases">
      <#list newsMap?keys as block>
          <div class="news-releases-item">
              <h2 class="heading-07"><@fmt.message key="label.news.${block}" /></h2>
              <ul class="empty-list text-03">
                  <#list newsMap[block]?sort_by("date")?reverse as item>
                      <li>
                          <a href="<@hst.link hippobean=item />" class="iconed-text iconed-text--nogap iconed-text--iconFirst"><i class="icon-arrow-right"></i>
                            <span>${item.title}</span>
                          </a>
                      </li>
                  </#list>
              </ul>
          </div>
      </#list>
  </section>
</div>
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#elseif editMode>
  <div>
    <img src="<@hst.link path='/images/essentials/catalog-component-icons/news-list.png'/>"> Click to edit News Component
  </div>
</#if>


