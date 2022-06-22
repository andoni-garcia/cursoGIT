<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#include "../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="ComingSoon,SearchPage,SearchBar,ParametricSearch,ProductToolbar"/>
<@hst.include ref="product-toolbar-category-page" />
<#setting number_format="computer">

<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/psearch/psearch.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/coming-soon/coming-soon.component.css"/>" type="text/css"/>
</@hst.headContribution>


    <section class="row" id="catalogue__filters">
        <h1 class="col-12 heading-03 color-blue"><@fmt.message key="coming.soon.title" /></h1>
         <#if pageable??>
            <#if (pageable.total > 0) >
                <div class="manual-pagination-container catalogue__pagination_display" id="catalogue__pagination_display">
                            <#assign pageSizez= "${pageable.pageSize}">
                            <div class="col-md-12 manual-pagination-container">
                                <div class="col-lg-12 p-0 ">
                                    <div class="row pagination_showing align-items-center">
                                        <div class="col-md-4 mt-10 mt-lg-0 text-center text-md-left">
                                            <@fmt.message key="search.searchresult.paging.showing"/>
                                            <span class="js-search-init-page-number">${((pageable.currentPage - 1) * pageable.pageSize) + 1 }</span>
                                            <@fmt.message key="search.searchresult.paging.to"/>
                                            <#if (pageable.total >= (pageable.currentPage * (pageable.pageSize + 1)) )>
                                                <span class="js-search-finish-page-number">${(((pageable.currentPage - 1) * pageable.pageSize) +  pageable.pageSize )}</span>
                                            <#else>
                                                <span class="js-search-finish-page-number">${pageable.total}</span>
                                            </#if>
                                            <@fmt.message key="search.searchresult.paging.of"/>
                                            <span class="js-search-total">${pageable.total}</span>
                                            <@fmt.message key="search.searchresult.paging.entries"/>
                                        </div>
                                        <div class="col-md-4 div-right mt-10 mt-lg-0 d-none d-sm-block">
                                            <@fmt.message key="search.searchresult.paging.display"/>
                                            <#if pageable.pageSize == 10 >
                                                <span data-section='product_catalogue' class="changelen" data-len="10"
                                                      href="#">10</span> |
                                            <#else>
                                                <@hst.renderURL var="pageUrl10">
                                                    <@hst.param name="page" value="1"/>
                                                    <@hst.param name="pageSize" value="10"/>
                                                    <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                                </@hst.renderURL>
                                                <a data-section='product_catalogue' class="changelen" data-len="10"
                                                   href="${pageUrl10}" onmousedown="javascript:resetManual('10');">10</a> |
                                            </#if>
                                            <#if pageable.pageSize == 20 >
                                                <span data-section='product_catalogue' class="changelen" data-len="20"
                                                      href="#">20</span> |
                                            <#else>
                                                <@hst.renderURL var="pageUrl20">
                                                    <@hst.param name="page" value="1"/>
                                                    <@hst.param name="pageSize" value="20"/>
                                                    <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                                </@hst.renderURL>
                                                <a data-section='product_catalogue' class="changelen" data-len="20"
                                                   href="${pageUrl20}" onmousedown="javascript:resetManual('20');">20</a> |
                                            </#if>
                                            <#if pageable.pageSize == 50 >
                                                <span data-section='product_catalogue' class="changelen" data-len="50"
                                                      href="#">50</span> |
                                            <#else>
                                                <@hst.renderURL var="pageUrl50">
                                                    <@hst.param name="page" value="1"/>
                                                    <@hst.param name="pageSize" value="50"/>
                                                    <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                                </@hst.renderURL>
                                                <a data-section='product_catalogue' class="changelen" data-len="50"
                                                   href="${pageUrl50}" onmousedown="javascript:resetManual('50');">50</a> |
                                            </#if>
                                            <#if pageable.pageSize == 100 >
                                                <span data-section='product_catalogue' class="changelen" data-len="100"
                                                      href="#">100</span>
                                            <#else>
                                                <@hst.renderURL var="pageUrl100">
                                                    <@hst.param name="page" value="1"/>
                                                    <@hst.param name="pageSize" value="100"/>
                                                    <@hst.param name="lastPageSize" value="${pageable.pageSize}"/>
                                                </@hst.renderURL>
                                                <a data-section='product_catalogue' class="changelen" data-len="100"
                                                   href="${pageUrl100}" onmousedown="javascript:resetManual('100');">100</a>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <#else>
                            <#if !query?has_content >
                                <div class="searchResult text-center m-auto p-5">
                                    <div class="col align-self-center"><@fmt.message key="coming.soon.noresultsfound"/></div>
                                </div>
                            <#else>
                                <div class="searchResult text-center m-auto p-5">
                                    <p>
                                        <span><@fmt.message key="search.searchresult.begin.text"/> </span>
                                        <span id="searchResultText" class="search-query"> "${query}" </span>
                                        <span> <@fmt.message key="search.searchresult.middle.text"/> </span>
                                        <span id="searchResultNumber" class="search-query"> 0 </span>
                                        <span> <@fmt.message key="search.searchresult.end.text"/></span>
                                    </p>
                                </div>
                            </#if>
                </div>
            </#if>
         </#if>
    </section>

    <section class="row" id="catalogue__products">
        <#if results??>
            <#list results as item>
                <@hst.link var="link" hippobean=item/>
                <article class="col-12 catalogue__product">
                    <div class="catalogue__product__wrapper">
                        <header class="catalogue__product__header">
                            <h2 class="heading-04 catalogue__product__title">
                                <span class="catalogue__product__name">${item.getSoonDesc()}</span>
                            </h2>
                        </header>
                        <div class="catalogue__product__body">
                            <figure class="catalogue__product__image">
                                <a class="partNumber" style="cursor:pointer;">
                                    <img class="product-list-image" data-bind="attr: { src: soonImage }"
                                         src="${item.getSoonImage()}">
                                </a>
                            </figure>

                            <div class="catalogue__product__basic_info">
                                <div class="info_field">
                                    <span class="info_field__name"><@fmt.message key="coming.soon.series"/></span>
                                    <span class="info_field__value">${item.getSerie()}</span>
                                </div>
                                <div class="info_field">
                                    <span class="info_field__name"><@fmt.message key="coming.soon.launchDate"/></span>
                                    <span class="info_field__value">${textDates[item.getId()?c]}</span>
                                </div>
                            </div>
                            <div class="catalogue__product__info">
                                <section id="comingSoonProductInfo" class="smc-tabs main-tabs desktop coming_soon_product__information">
                                    <div class = "smc-tabs__head">
                                        <ul id="comingSoonProductInfoTabs" class="navbar-full nav border-bottom" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link " id="comingSoonProduct_${item.getId()}_description_tab"
                                                   data-toggle="tab" href="#comingSoonProduct_${item.getId()}_description" role="tab"
                                                   aria-controls="comingSoonProduct_${item.getId()}_description" aria-selected="false"><@fmt.message key="coming.soon.productDescription"/></a>
                                            </li>
                                            <#if item.getSeries()?has_content>
                                                <li class="nav-item">
                                                    <a class="nav-link" id="comingSoonProduct_${item.getId()}_tools_tab"
                                                       data-toggle="tab" href="#comingSoonProduct_${item.getId()}_tools" role="tab"
                                                       aria-controls="comingSoonProduct_${item.getId()}_tools" aria-selected="false"><@fmt.message key="coming.soon.tools"/></a>
                                                </li>
                                            </#if>
                                        </ul>
                                    </div>
                                    <div class="tab-content">
                                        <div class="tab-pane fade " id="comingSoonProduct_${item.getId()}_description" role="tabpanel" aria-labelledby="comingSoonProduct_${item.getId()}_description_tab">
                                            <p>${item.getSoonDesc()} </p>
                                            <span class="info_field__value">${item.getSoonFeat()}</span>
                                        </div>
                                        <#if item.getSeries()?has_content>
                                            <div class="tab-pane fade coming-soon-toolbar" id="comingSoonProduct_${item.getId()}_tools" role="tabpanel" aria-labelledby="comingSoonProduct_${item.getId()}_tools_tab">
                                                <div class ="additional_element product-toolbar-item simple-fixed">
                                                    <a href="${item.getSeries()}" target = "_blank"
                                                       class="show-feature-catalogues iconed-text">
                                                        <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.featureCatalogues"/></div>
                                                    </a>
                                                </div>
                                            </div>
                                        </#if>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </article>
            </#list>
        <#else>
            <div class="searchResult text-center m-auto p-5">
                <div class="col align-self-center"><@fmt.message key="coming.soon.noresultsfound"/></div>
            </div>
        </#if>
    </section>

<section class="row" id="catalogue__pagination">
    <div class="manual-pagination-container pagination-container align-items-center">
        <#include "../../include/pagination_manuals.ftl">
    </div>
</section>
