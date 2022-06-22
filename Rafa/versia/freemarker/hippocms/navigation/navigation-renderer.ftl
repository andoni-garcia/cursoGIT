<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<#macro renderItem item size>
    <div class="lister-row__item col-lg-${size} col-md-6 col-sm-12">
        <div class="cmseditlink">
            <@hst.manageContent hippobean=item/>
        </div>
        <div class="category-tile-wrapper">
            <div class="category-tile category-tile--noExpand">
                <div class="category-tile__image">
                    <#assign link><@osudio.linkUrl link=item.link /></#assign>
                    <#if !link?has_content || link == "#">
                        <img src="<@hst.link hippobean=item.image.large />" alt="${item.title}">
                    <#else>
                        <a href="${link}" class="js--LazyImageContainer image-shown" <@osudio.openInNewTab link/>>
                            <img src="<@hst.link hippobean=item.image.large />" alt="${item.title}">
                            <span class="category-tile__image__mask"></span>
                        </a>
                    </#if>
                </div>
                <div class="category-tile__text text-01">
                    <#if !link?has_content || link == "#">
                        <h2 class="heading-07 category-tile__title">${item.title}</h2>
                    <#else>
                        <a href="${link}" <@osudio.openInNewTab link/>><h2 class="heading-07 category-tile__title">${item.title}</h2></a>
                    </#if>
                    <div class="category-tile__text__inner"><@hst.html hippohtml=item.description/></div>
                    <div class="category-tile__text__accordion-trigger"></div>
                </div>
            </div>
            <span class="icon-close category-tile-mobile-close smc-close-button"></span>
        </div>
    </div>
</#macro>