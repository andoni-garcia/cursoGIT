<#macro featureCatalogueTemplate>
    <@hst.setBundle basename="essentials.global,ProductToolbar"/>

    <script id="feature-catalogues-template" type="text/template">
        <div class="product-toolbar-item product-toolbar-item-js hidden">

            <div class="product-toolbar-item__content feature-catalogues-template-content feature-catalogues-template-content-js">
                <h2 class="heading heading-07">
                    <span>
                        <@fmt.message key="product.toolbar.featureCatalogues"/>
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

    <!-- Feature catalogue item template -->
    <script id="feature-catalogues-item-template" type="text/template">
        <div class="content-item show-feature-catalogues show-feature-catalogues-js" data-language="{{language}}">
            <a id="download-feature-catalogues" href="{{fileUrl}}" class="show-feature-catalogues iconed-text" target="_blank"
               smc-statistic-action="DOWNLOAD FILE" smc-statistic-source="{{statisticsSource}}" smc-statistic-data3="PRODUCT CATALOGUE">
                <div class="product-toolbar-menu-item">{{localeName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>

    <!-- Language template -->
    <script id="feature-catalogues-language-item-template" type="text/template">
        <div class="content-item feature-catalogues-change-language-js" data-language="{{locale}}">
            <a href="javascript:void(0);" class="iconed-text">
                <div class="product-toolbar-menu-item">{{localeName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>
</#macro>