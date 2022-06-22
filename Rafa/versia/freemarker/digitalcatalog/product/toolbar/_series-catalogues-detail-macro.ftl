<@hst.setBundle basename="essentials.global,ProductToolbar"/>

<script id="series-catalogues-template" type="text/template">
    <div class="product-toolbar-item product-toolbar-item-js hidden">
        <div class="product-toolbar-item__content series-catalogues-template-content series-catalogues-template-content-js">
            <h2 class="heading heading-07">
                    <span>
                        <@fmt.message key="product.toolbar.catalogue"/>
                    </span>
                <a href="javascript:void(0);" class="close-btn close-btn-js iconed-text">
                    <i class="icon-close"></i>
                </a>
            </h2>

            <div class="content-body content-body-js">
                <div class="content-item no-results-js hidden">
                    <span class="small"><@fmt.message key="product.toolbar.noresults"/></span>
                </div>

            </div>

            <div class="content-item other-languages other-languages-js">
                <a href="javascript:void(0);">
                    <@fmt.message key="product.toolbar.otherlanguages"/>
                </a>
            </div>
        </div>
    </div>
</script>

<!-- Series catalogue item template -->
<script id="series-catalogues-item-template" type="text/template">
    <div class="content-item show-series-catalogues show-series-catalogues-js" data-language="{{language}}"
         data-catalogueid="{{catalogueId}}">
        <a id="download-series-catalogues" href="{{fileUrl}}" class="show-series-catalogues iconed-text" target="_blank"
           smc-statistic-action="DOWNLOAD FILE" smc-statistic-source="{{statisticsSource}}"
           smc-statistic-data3="PRODUCT CATALOGUE">
            <div class="product-toolbar-menu-item">{{localeName}}
                <div class="loading-container loading-container-js"></div>
            </div>
        </a>
    </div>
</script>

<!-- Language template -->
<script id="series-catalogues-language-item-template" type="text/template">

    <div class="content-item series-catalogues-change-language-js" data-language="{{locale}}" data-catalogueid="{{catalogueId}}">
        <a href="javascript:void(0);" class="iconed-text">
            <div class="product-toolbar-menu-item">{{localeName}}
                <div class="loading-container loading-container-js"></div>
            </div>
        </a>
    </div>
</script>