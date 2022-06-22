<#macro multilingualDocumentsTemplate>
    <@hst.setBundle basename="essentials.global,ProductToolbar"/>

    <script id="multilingual-documents-template" type="text/template">
        <div class="product-toolbar-item product-toolbar-item-js hidden">

            <div class="product-toolbar-item__content multilingual-documents-template-content multilingual-documents-template-content-js">
                <h2 class="heading heading-07">
                    <span>
                        {{documentTypeTitle}}
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
    <script id="multilingual-documents-item-template" type="text/template">
        <div class="content-item show-multilingual-documents show-multilingual-documents-js" data-language="{{language}}" data-document-type="{{documentType}}" data-document-type-title="{{documentTypeTitle}}">
            <a href="{{fileUrl}}" class="show-multilingual-documents iconed-text" target="_blank">
                <div class="product-toolbar-menu-item">{{localeName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>

    <!-- Language template -->
    <script id="multilingual-documents-language-item-template" type="text/template">
        <div class="content-item multilingual-documents-change-language-js" data-language="{{locale}}" data-document-type="{{documentType}}" data-document-type-title="{{documentTypeTitle}}">
            <a href="javascript:void(0);" class="iconed-text">
                <div class="product-toolbar-menu-item">{{localeName}} <div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>
</#macro>