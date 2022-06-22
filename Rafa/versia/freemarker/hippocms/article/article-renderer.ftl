<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<#macro renderItem item>
    <div class="our-services-item">
        <div class="cmseditlink">
            <@hst.manageContent hippobean=item/>
        </div>
        <div class="our-services-item__text">
            <h2 class="our-services-item__title heading-04">${item.title}</h2>
            <div class="our-services-item__body__content text-01"><@hst.html hippohtml=item.description/></div>
            <#if item.link?? && item.link.linkCaption?length gt 0>
                <#assign link><@osudio.linkUrl link=item.link /></#assign>
                <a href="${link}" class="text-03 our-services-item__body__link" <@osudio.openInNewTab link/>>${item.link.linkCaption}</a>
            </#if>
        </div>
        <div class="our-services-item__image js--LazyImageContainer image-shown">
            <img src="<@hst.link hippobean=item.image.medium />" alt="${item.title}" />
        </div>
    </div>
</#macro>