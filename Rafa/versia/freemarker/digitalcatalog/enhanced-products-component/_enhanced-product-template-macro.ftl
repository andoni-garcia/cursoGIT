<#macro enhancedProductTemplate product='' url='' cssClass='' fallbackImage=[] productToolbarNode=''>
    <div class="product-item product-item-js lister-row__item ${cssClass}"
         id="${product?has_content?then(product.getId()?long?c, '{{productId}}')}"
         data-id="${product?has_content?then(product.getId()?long?c, '{{productId}}')}"
         data-href="${url?has_content?then(url, product?has_content?then(product.getUrl(), '{{productUrl}}'))}">
        <div class="category-tile-wrapper category-tile--smallImage">
            <div class="category-tile category-tile--has-footer category-tile--noExpand">
                <div class="category-tile__image">
                    <a href="${url?has_content?then(url, product?has_content?then(product.getUrl(), '{{productUrl}}'))}" class=""
                       title="${product?has_content?then(product.getSeriesName(), '{{productSeriesName}}')} <@fmt.message key="enhancedproducts.series" />">
                        <@renderImage images=(fallbackImage?size > 0)?then(fallbackImage, product.getImages()) type='MEDIUM' />
                        <span class="category-tile__image__mask"></span>
                    </a>
                </div>
                <div class="category-tile__text text-01">
                    <a href="${url?has_content?then(url, product?has_content?then(product.getUrl(), '{{productUrl}}'))}">
                        <a href="${url?has_content?then(url, product?has_content?then(product.getUrl(), '{{productUrl}}'))}">
                            <h2 class="heading-07 category-tile__title">${product?has_content?then(product.getSeriesName(), '{{productSeriesName}}')} <@fmt.message key="enhancedproducts.series" /></h2>
                        </a>
                        <div class="category-tile__text__inner">
                            <p>${product?has_content?then(product.getName(), '{{productName}}')}</p>
                        </div>
                    </a>
                </div>
                <#if productToolbarNode??>
                    <div class="category-tile__footer text-01">
                        <@productToolbar product=productToolbarNode boxTitle="product.toolbar.more_info" renderingMode="dropdown-category-item"
                        showCadDownload=false showDataSheet=false
                        statisticsSource="ENHANCED PRODUCTS" />
                    </div>
                </#if>
            </div>
        </div>
    </div>
</#macro>