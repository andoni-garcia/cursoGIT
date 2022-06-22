<#ftl encoding="UTF-8">
<#include "../../include/imports.ftl">
<#include "../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="NewProducts,SearchPage,SearchBar,ParametricSearch,ProductToolbar"/>
<@hst.include ref="product-toolbar-category-page" />



<@hst.headContribution category="htmlHead">
    <link rel="stylesheet"
          href="<@hst.webfile path="/freemarker/versia/css-menu/components/new-products/detail/new-products-detail.component.css"/>"
          type="text/css"/>
</@hst.headContribution>

<title>${node.getName()}</title>
<div class="new-products-detail-component container desktop" data-swiftype-index="true">
    <div data-title="${dataMap[product.getTitle()]}"
         class="product-configuration-header-section desktop">

        <@osudio.dynamicBreadcrumb identifier="dc-bc" breadcrumb=breadcrumb />

        <#if product ??>

            <div class="container desktop" data-swiftype-index="true">
                <section class="row new_product__presentation">
                    <aside class="fixed_flag share_your_success">
                        <ul class="list-items empty-list">
                            <li class="additional_element product-toolbar-item simple-fixed">
                                <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_sh_header")
                                product=node  boxTitle=""
                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                showDataSheet=false showAskSMC=false showShareYourSuccess=true renderingMode="simple"
                                showSalesDocument=false/>
                            </li>
                        </ul>
                    </aside>


                    <div class="col-12">
                        <h1 class="heading-03 color-blue"
                            data-swiftype-index="false"><@fmt.message key="newproducts.title"/>
                        </h1>
                    </div>
                    <div class="col-12 col-lg-8">
                        <h2 class="heading-01" data-swiftype-index="true">
                            ${dataMap[product.getTitle()]}
                        </h2>
                        <h2 class="heading-02" data-swiftype-index="true">
                            ${dataMap[product.getSubtitle()]}
                        </h2>
                        <div class="name-description name-description-desktop">
                            <div class="description">
                                <h3> ${dataMap[product.getExcerpt().getTitle()]}</h3>
                                ${dataMap[product.getExcerpt().getDetail().getValue()]}

                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-lg-4">

                        <figure class="image new_product__image">
                            <img src="${dataMap[product.getFeaturedImage()]}"
                                 class="img-fluid"
                                 alt="">
                        </figure>
                        <div class="catalogue__product__additional_elements">

                            <ul>
                                <div>
                                    <div id=producttoolbar_${node.getId()?c}_header
                                         class="product-toolbar-component product-toolbar-component-simple desktop">
                                        <div class="product-toolbar-item" data-swiftype-index="false">
                                            <div class="product-toolbar-item__content product-toolbar-content-js  ">
                                                <h2 class="heading heading-07">
                                                    <span><@fmt.message key="newproducts.relatedinformation"/></span>
                                                </h2>
                                                <ul class="list-items empty-list">
                                                    <#if dataMap['NP_SWITCH']?? || dataMap['NP_PRESENT']?? || node.getTechnicalDocumentation()?? >
                                                        <li class="additional_element product-toolbar-item">
                                                            <div>
                                                                <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_td_header")
                                                                product=node  boxTitle="newproducts.technicaldocumentation" renderingMode="dropdown-plain"
                                                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false
                                                                showAskSMC=false showInstallationManuals=true showOperationManuals=true showCECertificates=true showSwitchoverDocument=dataMap['NP_SWITCH']?? showTechnicalPresentationJP=dataMap['NP_PRESENT']??
                                                                switchoverDocumentURL=dataMap['NP_SWITCH'] technicalPresentationJPURL=dataMap['NP_PRESENT']/>
                                                            </div>
                                                        </li>
                                                    </#if>

                                                    <#if true || dataMap['NP_NPP']?? || dataMap['NP_REDUCED']?? || dataMap['NP_PRESS_RELEASE']?? || dataMap['NP_CAD']?? || node.getFeaturesCatalogs()?? || node.isHasPreview3d() || node.getHasDatasheet() ||  node.getImages()?? || node.getVideo()??>
                                                        <li class="additional_element product-toolbar-item">
                                                            <div>
                                                                <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_spc_header")
                                                                product=node  boxTitle="newproducts.salespromotioncontent" renderingMode="dropdown-plain"
                                                                showFeaturesCatalogues=true
                                                                showCadDownload=dataMap['NP_CAD']?? cadDownloadURL=dataMap['NP_CAD']
                                                                show3dPreview=node.isHasPreview3d() showVideo=node.getVideo()?? showTechnicalDocumentation=false
                                                                showDataSheet=false showAskSMC=false showReducedCatalogue=dataMap['NP_REDUCED']?? showPressReleaseDocument=dataMap['NP_PRESS_RELEASE']?? showNewProductPreview=dataMap['NP_NPP']??
                                                                showImages= dataMap['NP_IMAGE_CH'] ?? || dataMap['NP_IMAGE_CL']?? || dataMap['NP_IMAGE_BW']??
                                                                imageChURL=dataMap['NP_IMAGE_CH'] imageClURL=dataMap['NP_IMAGE_CL'] imageBwURL=dataMap['NP_IMAGE_BW']
                                                                />

                                                            </div>
                                                        </li>
                                                    </#if>
                                                    <#if dataMap['NP_FLYER']?? || dataMap["NP_ENRICH"]??>
                                                        <li class="additional_element product-toolbar-item">
                                                            <div>
                                                                <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_ds_header")
                                                                product=node  boxTitle="newproducts.distributionspecific" renderingMode="dropdown-plain"
                                                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false
                                                                showAskSMC=false showFlyer= dataMap['NP_FLYER']?? flyerURL=dataMap["NP_FLYER"] showEnrichData= dataMap["NP_ENRICH"]?? enrichDataURL=dataMap["NP_ENRICH"]/>
                                                            </div>
                                                        </li>
                                                    </#if>
                                                    <#if dataMap['NP_PRICES'] != "">
                                                        <li class="additional_element">
                                                            <a href="${dataMap['NP_PRICES']}" target="_blank">
                                                                <@fmt.message key="newproducts.prices"/>
                                                            </a>
                                                        </li>
                                                    </#if>
                                                    <#assign weHaveAdditionalContent = additionalContentList?has_content >
                                                    <#if additionalContentList?has_content>
                                                        <li class="additional_element product-toolbar-item">
                                                            <div>
                                                                <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_ac_header")
                                                                product=node  boxTitle="product.toolbar.additionalContent"
                                                                showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                                                showDataSheet=false showAskSMC=false renderingMode="dropdown-plain" additionalContent = additionalContentList areWeInNewProductsDetails=weHaveAdditionalContent
                                                                showSalesDocument=false/>
                                                            </div>
                                                        </li>
                                                    </#if>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ul>
                        </div>
                        <div class="buttons-container">
                            <ul class="list-items empty-list">

                                <li class="additional_element product-toolbar-item simple-fixed">
                                    <@productToolbar id=("producttoolbar_"+ node.getId()?c +"_sd_header")
                                    product=node  boxTitle=""
                                    showFeaturesCatalogues=false showCadDownload=false show3dPreview=false showVideo=false showTechnicalDocumentation=false
                                    showDataSheet=false showAskSMC=false renderingMode="simple"
                                    showSalesDocument=true/>
                                </li>
                            </ul>

                            <#if node.getType() == "PRODUCT">
                                <a href="${digCatalogUrl}/${node.getSlug()}~${dataMap["NP_LINK_DIG_CAT"]}~cfg"
                                   class="btn btn-primary btn-block mt-3">
                                    <@fmt.message key="newproducts.gotoproductcatalogue"/>
                                </a>
                            <#else>
                                <a href="${digCatalogUrl}/${node.getSlug()}~${dataMap["NP_LINK_DIG_CAT"]}~nav"
                                   class="btn btn-primary btn-block mt-3">
                                    <@fmt.message key="newproducts.gotoproductcatalogue"/>
                                </a>
                            </#if>
                        </div>
                    </div>
                </section>
                <section id="newProductInfo" class="smc-tabs main-tabs desktop  new_product__information">
                    <#if dataMap["IS_SALES_DOCUMENT_AVAILABLE"] == "true">
                    <div class="smc-tabs__head">
                        <ul id="newProductInfoTabs" class="navbar-full nav border-bottom" role="tablist">
                            <#list product.getTabs() as tab>
                                <#if tab?is_first>
                                    <li class="nav-item smc-tabs__head--active">
                                        <a class="nav-link active"
                                           id="newproduct_${tab.getNameDefault()?lower_case}__tab"
                                           data-toggle="tab"
                                           href="#newproduct_info__${tab.getNameDefault()?lower_case}"
                                           role="tab"
                                           aria-controls="newproduct_info__${tab.getNameDefault()?lower_case}"
                                        ><@fmt.message key="${tab.getNameProperty()}"/></a>
                                    </li>
                                <#else>
                                    <li class="nav-item">
                                        <a class="nav-link" id="newproduct_${tab.getNameDefault()?lower_case}__tab"
                                           data-toggle="tab"
                                           href="#newproduct_info__${tab.getNameDefault()?lower_case}"
                                           role="tab"
                                           aria-controls="newproduct_info__${tab.getNameDefault()?lower_case}"
                                        ><@fmt.message key="${tab.getNameProperty()}"/></a>
                                    </li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                    <div class="tab-content">
                        <#list product.getTabs() as tab>
                        <#if tab?is_first>
                        <div class="tab-pane show active"
                             id="newproduct_info__${tab.getNameDefault()?lower_case}" role="tabpanel"
                             aria-labelledby="newproduct_info__${tab.getNameDefault()?lower_case}_tab">
                            <h3 class="newproduct_info__tab__title"><@fmt.message key="${tab.getTitleProperty()}"/></a></h3>
                            <#else>
                            <div class="tab-pane fade show"
                                 id="newproduct_info__${tab.getNameDefault()?lower_case}" role="tabpanel"
                                 aria-labelledby="newproduct_info__${tab.getNameDefault()?lower_case}_tab">
                                <h3 class="newproduct_info__tab__title"><@fmt.message key="${tab.getTitleProperty()}"/></a></h3>
                                </#if>
                                <#list tab.getContents() as content>
                                    <section class="newproduct_info__tab__section">
                                        <div class="newproduct_info__tab__section__content">
                                            <#list content.getElements() as element>
                                                <#if element.getType() == "html">
                                                    <article class="newproduct_info__tab__section__content__text">
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <p>
                                                            ${dataMap[element.getValue()]}
                                                        </p>
                                                    </article>
                                                <#elseif element.getType() == "image">
                                                    <#if element?index == 0>
                                                        <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                    </#if>
                                                    <figure class="newproduct_info__tab__section__content__image">
                                                        <img src="${dataMap[element.getValue()]}"
                                                             class="img-fluid" alt="">
                                                    </figure>
                                                <#elseif element.getType() == "reasons">
                                                    <#if product.getSdReasons().getReason()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <ul>
                                                            <#list product.getSdReasons().getReason() as reason>
                                                                <li>
                                                                    <h4>${reason.getTitle()}</h4>
                                                                    <p>${reason.getDescription()}</p>
                                                                </li>
                                                            </#list>
                                                        </ul>
                                                    </#if>
                                                <#elseif element.getType() == "arguments">
                                                    <#if product.getSdArgumMain().getArgum()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <#if element.getValue()="NP_ARGUM_MAIN">
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${element.getTitleProperty()}"/></h4>
                                                            <ul class="selling_arguments">
                                                                <#list product.getSdArgumMain().getArgum() as argumMain>
                                                                    <div class="selling_arguments__argument">
                                                                        <p class="selling_arguments__argument__title">${argumMain.getTitle()}</p>
                                                                        <ul class="selling_arguments__argument__parts">
                                                                            <li class="selling_arguments__argument__part">
                                                                                <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.customerproblem"/></span>
                                                                                <#list argumMain.getProblem().getAny() as any>
                                                                                    <span class="selling_arguments__argument__part__text">${any} </span>
                                                                                </#list>
                                                                            </li>
                                                                            <li class="selling_arguments__argument__part">
                                                                                <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.consequence"/></span>
                                                                                <#list argumMain.getConsequence().getAny() as any>
                                                                                    <span class="selling_arguments__argument__part__text">${any} </span>
                                                                                </#list>
                                                                            </li>
                                                                            <li class="selling_arguments__argument__part">

                                                                                <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.solutionthisproductbrings"/></span>

                                                                                <span class="selling_arguments__argument__part__text">${argumMain.getSolutions()} </span>
                                                                            </li>
                                                                            <li class="selling_arguments__argument__part">
                                                                                <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.associatedfeatures"/></span>
                                                                                <#list argumMain.getAssocfeatures().getFeatures() as feature>
                                                                                    <span class="selling_arguments__argument__part__text">${feature.getDescription()}</span>
                                                                                    <figure class="newproduct_info__tab__section__content__image">
                                                                                        <img src="${feature.getImage()}"
                                                                                             class="img-fluid"
                                                                                             alt="${feature.getAltimage()}">
                                                                                    </figure>
                                                                                </#list>
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                </#list>
                                                            </ul>
                                                        </#if>
                                                    </#if>
                                                    <#if element.getValue()="NP_ARGUM_OTHER" && product.getSdArgumOther().getArgum()??>
                                                        <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${element.getTitleProperty()}"/></h4>
                                                        <ul class="selling_arguments">
                                                            <#list product.getSdArgumOther().getArgum() as argumOther>
                                                                <div class="selling_arguments__argument">
                                                                    <p class="selling_arguments__argument__title">${argumOther.getTitle()}</p>
                                                                    <ul class="selling_arguments__argument__parts">
                                                                        <li class="selling_arguments__argument__part">
                                                                            <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.customerproblem"/></span>
                                                                            <#list argumOther.getProblem().getAny() as any>
                                                                                <span class="selling_arguments__argument__part__text">${any} </span>
                                                                            </#list>
                                                                        </li>
                                                                        <li class="selling_arguments__argument__part">
                                                                            <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.consequence"/></span>
                                                                            <#list argumOther.getConsequence().getAny() as any>
                                                                                <span class="selling_arguments__argument__part__text">${any} </span>
                                                                            </#list>
                                                                        </li>
                                                                        <li class="selling_arguments__argument__part">

                                                                            <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.solutionthisproductbrings"/></span>

                                                                            <span class="selling_arguments__argument__part__text">${argumOther.getSolutions()} </span>
                                                                        </li>
                                                                        <li class="selling_arguments__argument__part">
                                                                            <span class="selling_arguments__argument__part__title"><@fmt.message key="newproducts.associatedfeatures"/></span>
                                                                            <#list argumOther.getAssocfeatures().getFeatures() as feature>
                                                                                <span class="selling_arguments__argument__part__text">${feature.getDescription()}</span>
                                                                                <figure class="newproduct_info__tab__section__content__image">
                                                                                    <img src="${feature.getImage()}"
                                                                                         class="img-fluid"
                                                                                         alt="${feature.getAltimage()}">
                                                                                </figure>
                                                                            </#list>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </#list>
                                                        </ul>
                                                    </#if>
                                                <#elseif element.getType() == "comparison">
                                                    <#if element.getValue()="NP_COMP" && product.getSdComp().getImage()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <div class="newproduct_info__tab__section__content">
                                                            <#list product.getSdComp().getImage() as image>
                                                                <figure class="newproduct_info__tab__section__content__image">
                                                                    <img src="${image}" class="img-fluid"
                                                                         alt="">
                                                                </figure>
                                                            </#list>
                                                        </div>
                                                    </#if>
                                                    <#if product.getSdComp().getNotaannex()??>
                                                        <h4 class="newproduct_info__tab__section__title"><@fmt.message key="newproducts.competitorcomparisonfulldata"/></h4>
                                                        <div class="newproduct_info__tab__section__content">
                                                            <article
                                                                    class="newproduct_info__tab__section__content__text">
                                                                <p>${product.getSdComp().getNotaannex()}</p>
                                                            </article>
                                                        </div>
                                                    </#if>

                                                <#elseif element.getType() == "promotional-tools">
                                                    <#if element.getValue()="NP_TOOLS" && product.getSdTools().getTool()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <div class="d-flex flex-wrap justify-content-center flex-column flex-lg-row">
                                                            <#list product.getSdTools().getTool() as tool>
                                                                <a target="_blank" href="${tool.getLink()}"
                                                                   class="px-5">
                                                                    <figure class="newproduct_info__tab__section__content__image">
                                                                        <img src="${tool.getImage()}"
                                                                             class="img-fluid promo-img" alt="">
                                                                        <figcaption>${tool.getName()}
                                                                            (${tool.getPages()})
                                                                        </figcaption>
                                                                    </figure>
                                                                </a>
                                                            </#list>
                                                        </div>
                                                    </#if>

                                                <#elseif element.getType() == "faq">
                                                    <#if element.getValue()="NP_FAQ" && product.getSdFaqs()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <article
                                                                class="newproduct_info__tab__section__content__text">
                                                            <#list  product.getSdFaqs().getFaq() as faq>
                                                                <p class="faq__question selling_arguments__argument__title">
                                                                    <@fmt.message key="newproducts.questionQ"/>${faq?counter}
                                                                    ${faq.getQuestion()}
                                                                </p>
                                                                <p><@fmt.message key="newproducts.answerA"/>${faq?counter}
                                                                <#list faq.getAnswer().getAny() as answer>
                                                                    ${answer}
                                                                    </p>
                                                                </#list>
                                                                <hr>
                                                            </#list>
                                                        </article>
                                                    </#if>

                                                <#elseif element.getType() == "applications">
                                                    <#if element.getValue()="NP_APPL" && product.getSdAppl()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <article
                                                                class="newproduct_info__tab__section__content__text">
                                                            <#list product.getSdAppl().getSummary().getAny() as sumary>
                                                                <p>${sumary}</p>
                                                            </#list>
                                                        </article>
                                                        <#list product.getSdAppl().getApplication() as application>
                                                            <figure class="newproduct_info__tab__section__content__image">
                                                                <figcaption
                                                                        class="newproduct_info__tab__section__content__image_label">
                                                                    <#list application.getTitle().getAny() as title>
                                                                        <span> ${title} </span>
                                                                    </#list>
                                                                </figcaption>
                                                                <img src="${application.getImage()}"
                                                                     class="img-fluid" alt="">
                                                            </figure>
                                                        </#list>
                                                    </#if>

                                                <#elseif element.getType() == "related">
                                                    <#if element.getValue()="NP_RELATED" && product.getSdRelated()??>
                                                        <#if element?index == 0>
                                                            <h4 class="newproduct_info__tab__section__title"><@fmt.message key="${content.getTitleProperty()}"/></a></h4>
                                                        </#if>
                                                        <ul class="related_products">
                                                            <#list product.getSdRelated().getProduct() as related>
                                                                <li class="related_products__product">
                                                                    <figure class="related_products__product__image">
                                                                        <img src="${related.getImage()}"
                                                                             class="img-fluid"
                                                                             alt="${related.getAltimage}">
                                                                    </figure>
                                                                    <p class="related_products__product__name">
                                                                        ${related.getName()}
                                                                    </p>
                                                                    <p class="related_products__product__description">
                                                                        ${related.getDescription()}
                                                                    </p>
                                                                </li>
                                                            </#list>
                                                        </ul>
                                                    </#if>
                                                </#if>
                                            </#list>
                                        </div>
                                    </section>
                                </#list>
                            </div>
                            </#list>
                        </div>
                        <#else>
                            <h3><@fmt.message key="newproducts.newproductmemo"/></h3>
                            ${dataMap[product.getMemo().getContent()]}
                        </#if>
                    </div>
                </section>
            </div>
        </#if>
    </div>
</div>

<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/digital-catalog/dc-components-loading.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript">
        $('body').trigger('dc-component-loaded');
    </script>
</@hst.headContribution>