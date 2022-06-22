<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<#macro renderItem item>
    <div class="lister-row__item col-lg-4 col-md-4 col-sm-12">
        <div class="category-tile-wrapper">
            <div class="category-tile">
                <div class="category-tile__image">
                    <a href="<@hst.link hippobean=item />" class="js--LazyImageContainer image-shown">
                        <#if item.image??>
                            <img src="<@hst.link hippobean=item.image.medium/>" alt="${item.title?html}" class="img-fit-contain"/>

                        </#if>
                        <span class="category-tile__image__mask"></span>
                    </a>
                </div>
                <div class="category-tile__text text-01">
                    <a href="<@hst.link hippobean=item />"><h2 class="heading-07 category-tile__title">${item.title}</h2></a>
                    <div class="category-tile__text__inner">
                        <p><i class="icon-location icon"></i> <#list item.address as address>${address}<br></#list>${item.postalCode} ${item.city}</p>
                        <#if item.country?has_content>
                            <p><a href="tel:${item.country}"><i class="faicon fas fa-phone fa-sm"></i> ${item.country}</a></p>
                        </#if>
                        <#if item.telephone?has_content>
                            <p><a href="tel:${item.telephone}"><i class="faicon fas fa-phone fa-sm"></i> ${item.telephone}</a></p>
                        </#if>
                        <#if item.fax?has_content>
                            <p><i class="faicon fas fa-fax fa-sm"></i> ${item.fax}</p>
                        </#if>
                        <#if item.website?has_content>
                            <p><a href="${item.website?starts_with("http")?then(item.website, "http://" + item.website)}" target="_blank"><i class="faicon fas fa-globe fa-sm"></i> ${item.website}</a></p>
                        </#if>
                        <#if item.email?has_content>
                            <p><a href="mailto:${item.email}"><i class="faicon fas fa-envelope fa-sm"></i> ${item.email}</a></p>
                        </#if>
                    </div>
                    <div class="category-tile__text__accordion-trigger"></div>
                </div>
            </div>
        </div>
    </div>
</#macro>