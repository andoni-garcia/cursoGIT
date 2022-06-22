<#include "../../include/imports.ftl">
<#include "../catalog-macros.ftl">
<#include "../product/product-toolbar-macro.ftl">
<@hst.setBundle basename="essentials.global,SearchPage,SearchBar,ProductToolbar"/>

<div class="equivalent-row mt-4 p-2 ${deviceInfo.deviceType?lower_case}">
    <div class="row">
        <div class="col-sm-6 col-xs-12 name-description name-description-phone">
            <div class="name"><strong>${product.getName()}</strong></div>
        </div>
        <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
            <div class="image"><@renderImage images=product.getImages() type='LARGE' /></div>
            <div class="image-disclaimer small mt-4">
                <span><@fmt.message key="search.equivalences.imagedisclaimer.line1"/></span><br/>
                <span><@fmt.message key="search.equivalences.imagedisclaimer.line2"/></span>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 name-description name-description-desktop">
            <div class="name"><strong>${product.getName()}</strong></div>
            <div class="description">${product.getDescription()}</div>
        </div>
        <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
            <@productToolbar product=product boxTitle="product.toolbar.materials" renderingMode="simple"
                showCadDownload=false show3dPreview=false showDataSheet=false partNumber=partNumber
                statisticsSource="SEE" />
        </div>
    </div>

    <div class="card additional-information-container mt-4 p-2">
        <div class="general-information">
            <div class="part-number"><a href="${product.getUrl()}" data-result-number="${resultNumber}" data-page-number="0" data-tab-name="${tabName}">${partNumber}</a></div>
            <div class="name"><strong>${product.getName()}</strong></div>
        </div>
        <div class="family-series-data mt-10">
            <div class="attribute-list">
                <div class="attribute-list-row">
                    <span class="attribute-name"><@fmt.message key="search.equivalences.family"/>: </span><span class="attribute-value">${product.getBreadcrumb()[0].getTitle()}</span>
                </div>
                <div class="attribute-list-row">
                    <span class="attribute-name"><@fmt.message key="search.equivalences.series"/>: </span><span class="attribute-value">${product.getSerie()}</span>
                </div>
            </div>
        </div>
        <div class="">
            <#if deviceInfo.deviceType == 'DESKTOP'>
                <div id="equivalencesContainer" class="smc-tabs ${deviceInfo.deviceType?lower_case}">
                    <ul id="tabSearchResult" class="navbar-full nav border-bottom navigation-links-js">
                        <li class="nav-item ml-sm-5">
                            <a href="#show-more-detail" class=" " data-section="show-more-detail">
                                <span class="text-bold"><@fmt.message key="search.equivalences.showmoredetail"/></span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="#tools" class=" " data-section="tools">
                                <span class="text-bold"><@fmt.message key="search.equivalences.tools"/></span>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content" id="content-products">
                        <div class="tab-pane fade" id="show-more-detail" role="tabpanel">
                            <div class="attribute-list">
                                <#list partNumberResponse.getTechnicalData() as technicalData>
                                    <div class="attribute-list-row">
                                        <span class="attribute-name">${technicalData.getKey()}: </span><span class="attribute-value">${technicalData.getValue()}</span>
                                    </div>
                                </#list>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="tools" role="tabpanel">
                            <@productToolbar id=("producttoolbar_" + product.getId()?long?c + "_desktop") product=product boxTitle="" renderingMode="simple-tools"
                            showFeaturesCatalogues=false showTechnicalDocumentation=false showVideo=false showAskSMC=false showDataSheet=false partNumber=partNumber
                            statisticsSource="SEE" />

                        </div>
                    </div>
                </div>
            <#else>
                <div id="equivalencesContainer"  class="smc-tabs ${deviceInfo.deviceType?lower_case}">
                    <div>
                        <div class="simple-collapse navigation-links-js">
                            <a href="#show-more-detail"  data-section="tools" class="js-accordion-mobile" data-target="#show-more-detail">
                                <span class="text-bold"><@fmt.message key="search.equivalences.showmoredetail"/></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="show-more-detail" data-parent="#equivalencesContainer">
                            <div class="attribute-list">
                                <#list partNumberResponse.getTechnicalData() as technicalData>
                                    <div class="attribute-list-row">
                                        <span class="attribute-name">${technicalData.getKey()}: </span><span class="attribute-value">${technicalData.getValue()}</span>
                                    </div>
                                </#list>
                            </div>

                        </div>
                    </div>
                    <div>
                        <div class="simple-collapse navigation-links-js">
                            <a href="#tools" data-section="tools" data-target="#tools" class=" js-accordion-mobile">
                                <span class="text-bold"><@fmt.message key="search.equivalences.tools"/></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="tools" data-parent="#equivalencesContainer">
                            <@productToolbar id=("producttoolbar_" + product.getId()?long?c + "_mobile") product=product boxTitle="" renderingMode="simple-tools"
                            showFeaturesCatalogues=false showTechnicalDocumentation=false showVideo=false showAskSMC=false showDataSheet=false partNumber=partNumber
                            statisticsSource="SEE" />

                        </div>
                    </div>
                </div>
            </#if>
        </div>
    </div>
</div>
