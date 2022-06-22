<#macro technicalDocumentationTemplate>
    <@hst.setBundle basename="essentials.global,ProductToolbar"/>

    <script id="technical-documentation-template" type="text/template">
        <div class="product-toolbar-item product-toolbar-item-js hidden">
            <div class="product-toolbar-item__content technical-documentation-template-content technical-documentation-template-content-js">
                <h2 class="heading heading-07">
                    <span>
                        <@fmt.message key="product.toolbar.technicalDocumentation"/>
                    </span>
                    <a href="javascript:void(0);" class="close-btn close-btn-js iconed-text">
                        <i class="icon-close"></i>
                    </a>
                </h2>

                <div class="content-item content-body content-body-js">
                    <div class="operation-manuals operation-manuals-js">
                        <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.operationmanuals"/></span>
                        <ul class="list-items list-items-js empty-list">
                            <li class="hidden no-results-js" data-swiftype-index='false'>
                                <span class="small"><@fmt.message key="product.toolbar.noresults"/></span>
                            </li>
                        </ul>
                    </div>

                    <div class="instructions-maintenance instructions-maintenance-js">
                        <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.instructionsmaintenance"/></span>
                        <ul class="list-items list-items-js empty-list">
                            <li class="hidden no-results-js" data-swiftype-index='false'>
                                <span class="small"><@fmt.message key="product.toolbar.noresults"/></span>
                            </li>
                        </ul>
                    </div>

                    <div class="ce-certificates ce-certificates-js">
                        <span class="product-toolbar-subtitle"><@fmt.message key="product.toolbar.cecertificates"/></span>
                        <ul class="list-items list-items-js empty-list">
                            <li class="hidden no-results-js" data-swiftype-index='false'>
                                <span class="small"><@fmt.message key="product.toolbar.noresults"/></span>
                            </li>
                        </ul>
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

    <!-- Technical document item template -->
    <script id="technical-document-item-template" type="text/template">
        <li data-language="{{language}}">
            <a href="{{fileUrl}}" class="technical-document-item technical-document-item-js iconed-text" target="_blank"
               smc-statistic-action="DOWNLOAD FILE" smc-statistic-source="{{statisticsSource}}" smc-statistic-data3="{{statisticsProductType}}">
                <div class="product-toolbar-menu-item">{{fileName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </li>
    </script>

    <!-- Language template -->
    <script id="technical-document-language-item-template" type="text/template">
        <div class="content-item technical-documentation-change-language-js" data-language="{{locale}}">
            <a href="javascript:void(0);" class="iconed-text">
                <div class="product-toolbar-menu-item" data-type="{{contentType}}">{{localeName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>
</#macro>