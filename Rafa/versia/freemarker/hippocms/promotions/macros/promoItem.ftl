<#-- @ftlvariable name="item" type="com.smc.hippocms.beans.Promotions" -->
<#macro printPromoItem item>
    <@hst.link var="link" hippobean=item/>
    <article class="col-12 catalogue__product">
        <div class="catalogue__product__wrapper">
            <header class="catalogue__product__header">
                <h2 class="heading-04 color-blue catalogue__product__title">
                    <#if item.title?? && item.title?has_content>
                        <span class="color-blue catalogue__product__name">${item.title}</span>
                    <#else>
                        <span class="color-blue catalogue__product__name">${item.getName()}</span>
                    </#if>
                </h2>
            </header>

            <div class="catalogue__product__body">
                <figure class="catalogue__product__image">
                    <img src="<@hst.link hippobean=item.image_item/>" alt="${document.title?html}"
                         class="img-fluid product-list-image">
                </figure>

                <div class="catalogue__product__basic_info">
                    <div class="info_field">
                        <span class="info_field__name"><@fmt.message key="promotions.concept.title"/></span>
                        <span class="info_field__value">${item.concept}</span>
                    </div>

                    <div class="info_field">
                        <span class="info_field__name"><@fmt.message key="promotions.iproducts.title"/></span>
                        <span class="info_field__value"></span>
                        <span class="partNumber">${item.included_products}</span>
                    </div>

                    <div class="info_field">
                        <span class="info_field__name"><@fmt.message key="promotions.ldate.title"/></span>
                        <span class="info_field__value"></span>
                        <span class="partNumber">${item.lauch_date.time?string["dd/MM/yyyy"]}</span>
                    </div>
                </div>

                <div class="catalogue__product__additional_elements" style="z-index: ${zIndex}">
                    <ul class="list-items empty-list">
                        <#if item.sales_notes??>
                            <#assign href><@osudio.linkUrl link=item.sales_notes /></#assign>
                            <#if href?has_content>
                                <li><a href="${href}" target="_blank"><@fmt.message key="promotions.sales_notes.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.leaflet?has_content>
                            <#assign href><@osudio.linkUrl link=item.leaflet /></#assign>
                            <#if href?has_content>
                                <li><a class="${item.leaflet.externalLink}" href="${href}"><@fmt.message key="promotions.leaflet.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.video?has_content>
                            <#assign href><@osudio.linkUrl link=item.video /></#assign>
                            <#if href?has_content>
                                <li><a href="${href}"><@fmt.message key="promotions.video.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.poster?has_content>
                            <#assign href><@osudio.linkUrl link=item.poster /></#assign>
                            <#if href?has_content>
                                <li><a href="${href}"><@fmt.message key="promotions.poster.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.advert?has_content>
                            <#assign href><@osudio.linkUrl link=item.advert /></#assign>
                            <#if href?has_content>
                                <li><a href="${href}"><@fmt.message key="promotions.advert.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.pressRelease?has_content>
                            <#assign href><@osudio.linkUrl link=item.pressRelease /></#assign>
                            <#if href?has_content>
                                <li><a href="${href}"><@fmt.message key="promotions.pressRelease.text"/></a></li>
                            </#if>
                        </#if>
                    </ul>

                    <ul class="list-items empty-list">
                        <#if item.additional_content?has_content>
                            <li><a href="#" id="additional_content_${item.name?replace(".","")}"><@fmt.message key="promotions.additional_content.text"/></a></li>
                        </#if>
                    </ul>
                </div>
            </div>
        </div>
    </article>
</#macro>
</div>