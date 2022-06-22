<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="NewProducts,SearchPage,SearchBar,ParametricSearch,ProductToolbar"/>
<@hst.include ref="product-toolbar-category-page" />


<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/psearch/psearch.component.css"/>" type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlHead">
    <link rel="stylesheet" href="<@hst.webfile path="/freemarker/versia/css-menu/components/new-products/new-products.component.css"/>"
          type="text/css"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        var currentUrl = "${currentUrl?string}";
        var isSeriesIndex = "${isSeriesIndex?string}";
    </script>
</@hst.headContribution>

<section class="row" id="catalogue__filters">
    <h1 class="col-12 heading-03 color-blue"><@fmt.message key="newproducts.newproductscatalogue" /></h1>
</section>

<section class="row" id="catalogue__filters">
    <#--    TODO: Correct in high resolutions-->
    <#if isEtechEnabled>
        <form name="catalogue__filter_form" class="catalogue__filter_form">
            <div class="form-group col-xl-10" id="np_search" style="display: none">
                <div id="searchNPType" class="input-group catalogue__filter_container"></div>
            </div>
            <div class="form-group col-xl-2" id="catalogue__filters_reset">
                <#if isSeriesIndex>
                    <input id="resetButton" type="button" class="reset btn btn-secondary btn-secondary--blue-border"
                           value="<@fmt.message key="newproducts.showall" />">
                <#else>
                    <input id="resetButton" type="button" class="reset btn btn-secondary btn-secondary--blue-border"
                           value="<@fmt.message key="newproducts.restart" />">
                </#if>
            </div>
        </form>
    </#if>

    <div class="manual-pagination-container catalogue__pagination_display" id="catalogue__pagination_display">
        <div id="root-filter">
            <form name="manualsListForm" id="manualsListForm" class="row">

                <#if pageable??>
                    <#if (pageable.total > 0) >
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
                                    <div class="col-md-4 text-center mt-10 mt-lg-0 d-none d-sm-block">
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
                                               href="${pageUrl10}">10</a> |
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
                                               href="${pageUrl20}">20</a> |
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
                                               href="${pageUrl50}">50</a> |
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
                                               href="${pageUrl100}">100</a>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <#else>
                        <#if !query?has_content >
                            <div class="searchResult text-center m-auto p-5">
                                <div class="col align-self-center"><@fmt.message key="psearch.noresultsfound"/></div>
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
                    </#if>
                </#if>
            </form>
        </div>
    </div>
</section>


<section class="row" id="catalogue__products">
    <#if results??>
        <#list results as item>
            <@hst.link var="link" hippobean=item/>
            <article class="col-12 catalogue__product">
                <div class="catalogue__product__wrapper">
                    <header class="catalogue__product__header">
                        <#if isInternalUserForNPs>
                            <a class="complete-sales-information"
                               title="Complete sales information"
                               href='${currentUrl}/${item.getNode().getSlug()}~${item.getId()?c}'>
                                <h2 class="heading-04 color-blue catalogue__product__title">
                                    <span class="color-blue catalogue__product__name">${item.getNpName()}</span>
                                    <#if item.isSalesDocumentAvailable()>
                                        <span class="icon-star-full"></span>
                                    </#if>
                                </h2>
                            </a>
                        <#else>
                            <#if item.getNode().getType() == "PRODUCT">
                                <a class="complete-sales-information"
                                   title="Complete sales information"
                                   href="${digCatalogUrl}/${item.getNode().getSlug()}~${item.getNpLinkDigCat()}~cfg">
                                    <h2 class="heading-04 color-blue catalogue__product__title">
                                        <span class="color-blue catalogue__product__name">${item.getNpName()}</span>
                                    </h2>
                                </a>
                            <#else>
                                <a class="complete-sales-information"
                                   title="Complete sales information"
                                   href="${digCatalogUrl}/${item.getNode().getSlug()}~${item.getNpLinkDigCat()}~nav">
                                    <h2 class="heading-04 color-blue catalogue__product__title">
                                        <span class="color-blue catalogue__product__name">${item.getNpName()}</span>
                                    </h2>
                                </a>
                            </#if>


                        </#if>
                    </header>
                    <div class="catalogue__product__body">
                        <figure class="catalogue__product__image">
                            <#if isInternalUserForNPs>
                                <a class="partNumber" style="cursor:pointer;"
                                   href='${currentUrl}/${item.getNode().getSlug()}~${item.getId()?c}'>
                                    <img class="img-fluid product-list-image" data-bind="attr: { src: soonImage }"
                                         src="${item.getSoonImage()}" alt="${item.getSoonImage()}">
                                </a>
                            <#else>
                                <#if item.getNode().getType() == "PRODUCT">
                                    <a class="partNumber" style="cursor:pointer;"
                                       href="${digCatalogUrl}/${item.getNode().getSlug()}~${item.getNpLinkDigCat()}~cfg">
                                        <img class="img-fluid product-list-image" data-bind="attr: { src: soonImage }"
                                             src="${item.getSoonImage()}" alt="${item.getSoonImage()}">
                                    </a>
                                <#else>
                                    <a class="partNumber" style="cursor:pointer;"
                                       href="${digCatalogUrl}/${item.getNode().getSlug()}~${item.getNpLinkDigCat()}~nav">
                                        <img class="img-fluid product-list-image" data-bind="attr: { src: soonImage }"
                                             src="${item.getSoonImage()}" alt="${item.getSoonImage()}">
                                    </a>
                                </#if>
                            </#if>
                        </figure>

                        <div class="catalogue__product__basic_info">
                            <div class="info_field">
                                <span class="info_field__name"><@fmt.message key="newproducts.series"/></span>
                                <span class="info_field__value">${item.getSerie()}</span>
                            </div>

                            <div class="info_field">
                                <span class="info_field__name"><@fmt.message key="newproducts.description"/></span>
                                <span class="info_field__value">
                                <span class="partNumber">${item.getSoonDesc()}</span>
                            </span>
                            </div>
                            <div class="info_field">
                                <span class="info_field__name"><@fmt.message key="newproducts.family"/></span>
                                <span class="info_field__value">
                                <span class="partNumber">${item.getNpFamilies()[0]}</span>
                            </span>
                            </div>

                            <div class="info_field">
                                <span class="info_field__name"><@fmt.message key="newproducts.launchdate"/></span>
                                <span class="info_field__value">
                                <span class="partNumber">${textDates[item.getId()?c]}</span>
                            </span>
                            </div>
                        </div>

                        <#if (79 - item?index) gt 58>
                            <#assign zIndex=(79 - item?index)>
                        <#else>
                            <#assign zIndex=(79 - item?index + 58)>
                        </#if>

                        <div class="catalogue__product__additional_elements" style="z-index: ${zIndex}">
                            <#if !isInternalUserForNPs>
                                <ul>

                                    <li class="additional_element product-toolbar-item">
                                        <div>
                                            <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_header")
                                            product=item.getNode()  boxTitle=""
                                            showCadDownload=false show3dPreview=item.getNode().isHasPreview3d() showDataSheet=false showVideo=item.getNode().getVideo()?? showTechnicalDocumentation=true
                                            showDataSheet=false showAskSMC=true renderingMode="simple" showPressRelease=item.getNpPressText()??
                                            areWeInNewProducts=false  areWeInNewProductsDetails=false/>
                                        </div>
                                    </li>
                                </ul>
                            <#else>
                                <ul>
                                    <#if item.getNpSwitch()?? || item.getNpPresent()?? || item.getNode().getTechnicalDocumentation()?? >
                                        <li class="additional_element product-toolbar-item">
                                            <div>
                                                <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_td_header")
                                                product=item.getNode()  boxTitle="newproducts.technicaldocumentation" renderingMode="dropdown-plain"
                                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false
                                                showDataSheet=false showAskSMC=false showInstallationManuals=true showOperationManuals=true showCECertificates=true
                                                showSwitchoverDocument=item.getNpSwitch()?? switchoverDocumentURL=item.getNpSwitch()
                                                showTechnicalPresentationJP=item.getNpPresent()?? technicalPresentationJPURL=item.getNpPresent()
                                                showSalesDocument=false/>
                                            </div>
                                        </li>
                                    </#if>
                                    <#if item.getNpReduced()?? || item.getNpNpp()?? || item.getNpReduced()?? || item.getNpNpp()?? || item.getNpImageCh()??||item.getNpImageCl()??||item.getNpImageBw()?? ||
                                    item.getNpPressText()?? || item.getNode().getFeaturesCatalogs()?? || item.getNpCad() ?? || item.getNode().isHasPreview3d() || item.getNode().getVideo()?? >

                                        <li class="additional_element product-toolbar-item">
                                            <div>
                                                <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_spc_header")
                                                product=item.getNode()  boxTitle="newproducts.salespromotioncontent" renderingMode="dropdown-plain"
                                                showFeaturesCatalogues=true
                                                showCadDownload=item.getNpCad()?? cadDownloadURL=item.getNpCad()
                                                show3dPreview=item.getNode().isHasPreview3d() showDataSheet=false showVideo=item.getNode().getVideo()?? showTechnicalDocumentation=false
                                                showDataSheet=false showAskSMC=false
                                                showPressRelease=item.getNpPressText()??
                                                showImages=item.getNpImageCh()??||item.getNpImageCl()??||item.getNpImageBw()??
                                                imageChURL=item.getNpImageCh()
                                                imageClURL=item.getNpImageCl()
                                                imageBwURL=item.getNpImageBw()
                                                showReducedCatalogue=item.getNpReduced()??
                                                showNewProductPreview=item.getNpNpp()??
                                                showPressReleaseDocument=item.getNpPressRelease()??
                                                />
                                            </div>
                                        </li>
                                    </#if>

                                    <#if item.getNpFlyer()?? || item.getNpEnrich()?? >
                                        <li class="additional_element product-toolbar-item">
                                            <div>
                                                <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_ds_header")
                                                product=item.getNode()  boxTitle="newproducts.distributionspecific" renderingMode="dropdown-plain"
                                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false
                                                showDataSheet=false showAskSMC=false showFlyer=item.getNpFlyer()?? flyerURL= item.getNpFlyer() showEnrichData=item.getNpEnrich()?? enrichDataURL=item.getNpEnrich()/>
                                            </div>
                                        </li>
                                    </#if>

                                    <#if item.getNpPrices() != "">
                                        <li class="additional_element">
                                            <a href="${item.getNpPrices()}" target="_blank">
                                                <@fmt.message key="newproducts.prices"/>
                                            </a>
                                        </li>
                                    </#if>
                                    <li class="additional_element product-toolbar-item simple-fixed">
                                        <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_as_header")
                                        product=item.getNode()  boxTitle=""
                                        showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                        showDataSheet=false showAskSMC=false showShareYourSuccess=true renderingMode="simple"/>
                                    </li>
                                    <#if item.isSalesDocumentAvailable()>
                                        <li class="additional_element product-toolbar-item simple-fixed">
                                            <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_sd_header")
                                            product=item.getNode()  boxTitle=""
                                            showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                            showDataSheet=false showAskSMC=false renderingMode="simple"
                                            showSalesDocument=true/>
                                        </li>
                                    </#if>
                                    <#if item.getAdditionalContent()?? && item.getAdditionalContent()?size != 0 >
                                        <li class="additional_element product-toolbar-item simple-fixed">
                                            <@productToolbar id=("producttoolbar_"+ item.getId()?c +"_ac_header")
                                            product=item.getNode()  boxTitle=""
                                            showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                            showDataSheet=false showAskSMC=false renderingMode="simple"
                                            showSalesDocument=false areWeInNewProducts=true additionalContent=item.getAdditionalContent() />
                                        </li>
                                    </#if>
                                </ul>
                            </#if>
                        </div>
                    </div>
                </div>
            </article>
        </#list>
    </#if>
</section>

<section class="row" id="catalogue__pagination">
    <div class="manual-pagination-container pagination-container align-items-center">
        <#include "../../include/pagination_manuals.ftl">
    </div>
</section>
