<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">

<@hst.setBundle basename="essentials.global,DigitalCatalog"/>

<@osudio.renderComponent ajax=renderPlaceholder >
    <section class="smc-main-container product-catalogue">
        <div class="container">
            <h2 class="heading-08 text-center color-blue"><@fmt.message key="catalog.title" /></h2>
            <#if exceptionMsg??>
                <h2>${exceptionMsg}</h2>
            <#else>
                <ul class="product-catalogue__list" data-event="dc-families-loaded">
                    <#list families as family>
                        <li>
                            <div class="product-catalogue-item">
                                <a href="${family.getUrl()}" title="${family.getName()}">
                                    <div class="product-catalogue-item__title heading-09">${family.getName()}</div>
                                    <div class="product-catalogue-item__image d-none d-xxl-block">
                                        <@renderImage images=family.getImages() type='SMALL' />
                                    </div>
                                </a>
                            </div>
                        </li>
                    </#list>
                </ul>
            </#if>
        </div>
    </section>
</@osudio.renderComponent>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
</@hst.headContribution>