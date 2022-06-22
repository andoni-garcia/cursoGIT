<#include "../../../include/imports.ftl">

<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.NewsDocument" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<@hst.setBundle basename="component.newslist"/>

<#if newsMap?? && newsMap?has_content>
<div class="container">
  <section class="news-releases">
      <#list newsMap?keys as block>
          <div class="news-releases-item">
              <h2 class="heading-07"><@fmt.message key="label.news.${block}" /></h2>
              <#list newsMap[block]?sort_by("date")?reverse as item>
                  <div class="row">
                    <#if item.image??>
                      <div class="col-6 col-sm-3 ">
                          <a href="<@hst.link hippobean=item />" class="">
                              <@hst.link var="img" hippobean=item.image.medium/>
                              <img src="${img}" class="thumb-new img-fluid mb-2" alt="${item.title?html}" />
                          </a>
                      </div>
                      <div class="col-sm-9">
                            <a href="<@hst.link hippobean=item />" class="font-weight-bold">
                                <span>${item.title}</span>
                            </a>
                            <p class="small">${item.introduction}</p>
                            <a href="<@hst.link hippobean=item />" class="font-weight-bold small"><@fmt.message key="link.read.more" /> <i class="icon-arrow-right"></i></a>
                       </div>
                    <#else>
                        <div class="col-12">
                            <a href="<@hst.link hippobean=item />" class="font-weight-bold">
                                <span>${item.title}</span>
                            </a>
                            <p class="small">${item.introduction}</p>
                            <a href="<@hst.link hippobean=item />" class="font-weight-bold small"><@fmt.message key="link.read.more" /> <i class="icon-arrow-right"></i></a>
                        </div>
                    </#if>
                  </div>
                  <#if item_has_next><div class="separator"></div></#if>
              </#list>
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


