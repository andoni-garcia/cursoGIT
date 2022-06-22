<#include "../../include/imports.ftl">

<#-- @ftlvariable name="componentId" type="java.lang.String" -->
<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Banner" -->
<#-- @ftlvariable name="pageable" type="org.onehippo.cms7.essentials.components.paging.Pageable" -->
<#-- @ftlvariable name="cparam" type="org.onehippo.cms7.essentials.components.info.EssentialsCarouselComponentInfo" -->
<#if pageable?? && pageable.items?has_content>
    <div class="banner-carousel">
        <#list pageable.items as item>
            <div>
                <section class="big-banner ">
                <@hst.link var="original" hippobean=item.image.original/>
                <@hst.link var="largeimage" hippobean=item.image.large/>
                <#if item.alt?? && item.alt?length gt 0>
                    <#assign alternativeTag = item.alt>
                <#else>
                    <#assign alternativeTag = item.title>
                </#if>
                <picture>
                    <source media="(min-width: 768px)" srcset="${original}">
                    <img src="${largeimage}" alt="${alternativeTag}">
                </picture>
                <div class="big-banner__text">
                    <div class="container">
                        <div class="big-banner__innerText">
                            <p class="heading-01 <#if item.color??>color-${item.color?replace(" ","")}</#if>">${item.title?html}</p>
                            <#if item.cta1?? && item.cta1.linkCaption?length gt 0>
                                <div class="inline-buttons">
                                    <#assign primaryLink><@osudio.linkUrl link=item.cta1 /></#assign>
                                    <a href="${primaryLink}" class="btn btn-primary mr-10" <@osudio.openInNewTab primaryLink/>>${item.cta1.linkCaption?html}</a>
                                    <#if item.cta2?? && item.cta2.linkCaption?length gt 0>
                                         <#assign secondaryLink><@osudio.linkUrl link=item.cta2 /></#assign>
                                         <a href="${secondaryLink}" class="btn btn-secondary" <@osudio.openInNewTab secondaryLink/>>${item.cta2.linkCaption?html}</a>
                                    </#if>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </section>
            </div>
        </#list>
    </div>
<#elseif editMode>
  <div>
      <img src="<@hst.link path="/images/essentials/catalog-component-icons/carousel.png" />"> Click to edit Carousel
  </div>
</#if>



