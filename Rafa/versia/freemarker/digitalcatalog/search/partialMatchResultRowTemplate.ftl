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
            <div class="name"><a href="${product.getUrl()}" data-result-number="${resultNumber}" data-page-number="0" data-tab-name="${tabName}"><strong>${product.getName()}</strong></a></div>
            <div class="description">${product.getDescription()}</div>
        </div>
        <div class="col-lg-4 col-md-12 col-sm-12 col-xs-12">
            <@productToolbar product=product boxTitle="product.toolbar.materials" renderingMode="simple"
                showCadDownload=false show3dPreview=false showDataSheet=false partNumber=partNumber
                statisticsSource="SEE"/>
        </div>
    </div>
    <div class="row">
        &nbsp;
    </div>
</div>
