<#include "../../include/imports.ftl">
<#include "../secure_redirect_common.ftl">
<#include './macros/promoItem.ftl'>

<#-- @ftlvariable name="promotionBean" type="com.smc.hippocms.beans.Promotions" -->
<#-- @ftlvariable name="nameLocaleList" type="java.util.ArrayList" -->

<#compress>
    <#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
    <@hst.setBundle basename="promotions.list,SearchPage,success-stories.list"/>
</#compress>

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/new-products/new-products.component.css"/>"
          type="text/css"/>
</@hst.headContribution>


<div class="new-products-list-component container desktop">
    <section class="row" id="catalogue__filters">
        <h1 class="col-12 heading-03 color-blue"><@fmt.message key="promotion.h1.title" /></h1>
    </section>

    <#if pageable?? && pageable.items?has_content>
        <section class="row" id="catalogue__filters">
            <#include "pagination-options.ftl">
        </section>

        <section class="row" id="catalogue__products">
            <#list pageable.items as promotionBean>
                <#assign override = "${nameLocaleList?seq_contains(promotionBean.name)?string}">
                <#assign overrideNum = "${nameLocaleList?seq_index_of(promotionBean.name)?int}">
                <#if override = "true">
                    <@printPromoItem item=promoLocalePageable.items[overrideNum?number]/>
                <#else>
                    <@printPromoItem item=promotionBean/>
                </#if>
            </#list>

        </section>

    <#else>

        <div class="dialog list-dialog">
            <div class="dialog list-dialog-container">
                <div class="dialog-icon"><i class="fas fa-search"></i></div>
                <div class="dialog-content">
                    <span class="dialog-title"><@fmt.message key="sstories.dialog.noresults.title"/></span><br>
                    <span><@fmt.message key="sstories.dialog.noresults"/></span>
                </div>
            </div>
        </div>

    </#if>

    <section class="row" id="catalogue__pagination">
        <div class="manual-pagination-container pagination-container align-items-center">
            <#include "../../include/pagination_manuals.ftl">
        </div>
    </section>
</div>

<div class="row" id="modals">
    <@hst.setBundle basename="promotions.list"/>
    <#list pageable.items as promotionBean>
        <#assign override = "${nameLocaleList?seq_contains(promotionBean.name)?string}">
        <#assign overrideNum = "${nameLocaleList?seq_index_of(promotionBean.name)?int}">
        <#if override = "true">
            <#assign item = promoLocalePageable.items[overrideNum?number]>
        <#else>
            <#assign item = promotionBean>
        </#if>
        <div class="modal fade" id="modal_${item.name?replace(".","")}" role="dialog" data-swiftype-index='false'>
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><@fmt.message key="promotions.additional_content.text"/></h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <ul class="list-items empty-list">
                            <#list item.additional_content as links>
                                <#assign href><@osudio.linkUrl link=links /></#assign>
                                <#assign caption><@osudio.linkCaption additionalContent=links /></#assign>
                                <li><a href="${href}">${caption}</a></li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $("#additional_content_${item.name?replace(".","")}").on("click", function() {
                createSimpleModal('modal_${item.name?replace(".","")}');
            });
        </script>
    </#list>
</div>
