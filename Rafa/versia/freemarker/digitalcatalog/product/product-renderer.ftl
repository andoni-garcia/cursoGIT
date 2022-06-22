<#ftl encoding="UTF-8">

<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<#macro renderItem item size>
    <div class="lister-row__item col-lg-${size} col-md-6 col-sm-12">
        <div class="category-tile-wrapper category-tile--smallImage">
            <div class="category-tile category-tile--has-footer category-tile--noExpand">
                <div class="category-tile__image">
                    <a href="${item.getUrl()}" title="${item.getNodeData().getName()}" class="js--LazyImageContainer image-shown" <@osudio.openInNewTab item.getUrl()/>>
                        <@renderImage images=item.getNodeData().getImages() type='MEDIUM' />
                        <span class="category-tile__image__mask"></span>
                    </a>
                </div>
                <div class="category-tile__text text-01">
                    <#if item.getNodeData().getName()??>
                        <a href="${item.getUrl()}"><h2 class="heading-07 category-tile__title">${item.getNodeData().getName()}</h2></a>
                    </#if>
                    <div class="category-tile__text__inner">
                        <#if item.getNodeData().getDescription()??>
                            <p>${item.getNodeData().getDescription()}</p>
                        </#if>
                    </div>
                    <div class="category-tile__text__accordion-trigger"></div>
                </div>
            </div>
            <span class="icon-close category-tile-mobile-close smc-close-button"></span>
        </div>
    </div>
</#macro>