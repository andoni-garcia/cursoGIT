<#macro imagesTemplate>
    <@hst.setBundle basename="essentials.global,ProductToolbar"/>

    <script id="images-template" type="text/template">
        <div class="product-toolbar-item product-toolbar-item-js hidden">

            <div class="product-toolbar-item__content images-template-content images-template-content-js">
                <h2 class="heading heading-07">
                    <span>
                        Images
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
            </div>
        </div>
    </script>

    <!-- Feature catalogue item template -->
    <script id="images-item-template" type="text/template">
        <div class="content-item show-images show-images-js">
            <a href="{{imageChURL}}" class="show-images iconed-text" target="_blank">
                <div class="pl-2 product-toolbar-menu-item">High resolution<div class="loading-container loading-container-js"></div></div>
            </a>
            <a href="{{imageClURL}}" class="show-images iconed-text" target="_blank">
                <div class="pl-2 product-toolbar-menu-item">Low resolution<div class="loading-container loading-container-js"></div></div>
            </a>
            <a href="{{imageBwURL}}" class="show-images iconed-text" target="_blank">
                <div class="pl-2 product-toolbar-menu-item">Black & White<div class="loading-container loading-container-js"></div></div>
            </a>
        </div>
    </script>

</#macro>