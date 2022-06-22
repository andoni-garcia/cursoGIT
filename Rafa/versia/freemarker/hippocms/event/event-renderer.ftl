<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">

<#macro renderItem item size>
    <div class="lister-row__item col-lg-${size} col-md-6">
        <div class="cmseditlink">
            <@hst.manageContent hippobean=item/>
        </div>
        <div class="product-catalogue-tile-container">
            <div class="product-catalogue-tile product-catalogue-tile--smallImage event-tile">

                <div class="category-tile__image js--LazyImageContainer image-shown">
                    <img src="<@hst.link hippobean=item.image.medium />" alt="${item.title}" />
                </div>

                <div class="category-tile__text text-01">
                    <h2 class="heading-07 event-tile__title">${item.title}</h2>
                    <h2 class="heading-07 color-blue event-tile__date">
                        <#if item.timePeriod?? && item.timePeriod.startingDate??>
                             <p><@fmt.formatDate value=item.timePeriod.startingDate.time/>
                             <#if item.timePeriod.endingDate??>
                                 - <@fmt.formatDate value=item.timePeriod.endingDate.time/>
                             </#if></p>
                        </#if>
                    </h2>
                    <#if item.location?? && item.location.city?has_content && item.location.name?has_content>
                        <p>${item.location.city}<#if item.location.name??>, ${item.location.name}</#if><#if item.location.stand??>, ${item.location.stand}</#if></p>
                    </#if>
                    <#-- How to show the localized values of the event types value list
                    <@hst.setBundle basename="EventTypes"/>
                    <#list item.eventtype as type>
                        <@fmt.message key=type />
                    </#list>-->
                </div>
                <div class="event-tile__footer">
                    <#if item.visitLink?? >
                        <#assign visitLink><@osudio.linkUrl link=item.visitLink /></#assign>
                        <a href="${visitLink}" <@osudio.openInNewTab visitLink/>>
                            <span><i class="category-tile__footer__icon icon-info-circled"></i> ${item.visitLink.linkCaption}</span>
                        </a>
                    </#if>
                    <#if item.contactLink?? >
                        <#assign contactLink><@osudio.linkUrl link=item.contactLink /></#assign>
                        <a href="${contactLink}" <@osudio.openInNewTab contactLink/>>
                            <span><i class="category-tile__footer__icon icon-mail"></i> ${item.contactLink.linkCaption}</span>
                        </a>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</#macro>