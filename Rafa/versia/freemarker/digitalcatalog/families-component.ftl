<#include "../include/imports.ftl">
<#include "catalog-macros.ftl">

<@hst.setBundle basename="essentials.global,DigitalCatalog"/>

<@osudio.renderComponent ajax=renderPlaceholder >
    <div class="container">
        <div class="families-component">
            <h1 class="heading-03 color-blue"><@fmt.message key="catalog.title" /></h1>
            <h3 class="heading-0a"><@fmt.message key="all.products" /></h3>
            <div class="row">
                <#if exceptionMsg??>
                    <h2>${exceptionMsg}</h2>
                <#else>
                    <#list families as family>
                        <div class="lister-row__item col-lg-4 col-md-6 col-sm-12">
                            <div class="product-catalogue-tile-container">
                                <div class="product-catalogue-tile product-catalogue-tile--smallImage ">
                                    <div class="category-tile__image js--LazyImageContainer image-shown">
                                        <a href="${family.getUrl()}" title="${family.getName()}">
                                            <@renderImage images=family.getImages() type='LARGE' />
                                            <span class="category-tile__image__mask"></span>
                                        </a>
                                    </div>
                                    <div class="category-tile__text text-01">
                                        <h2 class="heading-07">${family.getName()}</h2>
                                        <ul class="empty-list">
                                            <#list family.getChildfamilies() as subfamily>
                                                <li>
                                                    <#if subfamily.getExternalUrl()?has_content>
                                                        <a target = "_blank" href="${subfamily.getExternalUrl()}" class="iconed-text">
                                                            <span>${subfamily.getName()}</span><i class="icon-arrow-right"></i>
                                                        </a>
                                                    <#else>
                                                        <a href="${subfamily.getUrl()}" class="iconed-text">
                                                            <span>${subfamily.getName()}</span><i class="icon-arrow-right"></i>
                                                        </a>
                                                    </#if>
                                                </li>
                                            </#list>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </#if>
            </div>
        </div>
    </div>
</@osudio.renderComponent>