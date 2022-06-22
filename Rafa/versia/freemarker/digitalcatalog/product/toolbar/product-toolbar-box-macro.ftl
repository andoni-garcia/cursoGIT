<#macro productToolbarBox product boxTitle renderingMode
showFeaturesCatalogues
showTechnicalDocumentation
show3dPreview
showCadDownload
cadDownloadURL
showAskSMC
showDataSheet
showVideo
askSMCTitleKey
statisticsSource,
showPressRelease
showInstallationManuals
showOperationManuals
showCECertificates
switchoverDocumentURL
showTechnicalPresentationJP
technicalPresentationJPURL
showSalesDocument
showFlyer
flyerURL
showEnrichData
enrichDataURL
showImages
imageChURL
imageClURL
imageBwURL
showReducedCatalogue
showPressReleaseDocument
showSwitchoverDocument
showNewProductPreview
showShareYourSuccess
comesFromModalDetails
relatedProductId
additionalContent
areWeInNewProducts
areWeInNewProductsDetails
areWeInCylinderConfigurator
renderingOrigin
isSeries
showSeriesCatalogues
>
    <#if isSeries>
        <#if showSeriesCatalogues>
            <ul class="filters-categories__item__level2">
                <#list product.getCatalogues().getDocuments() as item>
                    <li>
                        <a  href="javascript:void(0);"
                            class="show-series-catalogues iconed-text additional-content-dropdown" >
                            <div data-id="${item?index}" class="product-toolbar-menu-item series-catalog-title">${item.getName()}</div>
                        </a>
                        <!-- Series catalog -->
                        <div id="additional_content_${item?index}" class="series-catalogues-additional-content series-catalogues-additional-content-js feature-catalogues-additional-content feature-catalogues-additional-content-js product-toolbar-content-js"></div>
                    </li>
                </#list>
            </ul>

        <#else>
            <a href="javascript:void(0);"
               class="show-feature-catalogues iconed-text additional-content-dropdown" disabled>
                <div class="product-toolbar-menu-item features-catalog-title"><@fmt.message key="product.toolbar.featureCatalogues"/></div>
            </a>

            <!-- Features catalog -->
            <div class="series-feature-catalogues feature-catalogues-additional-content feature-catalogues-additional-content-js product-toolbar-content-js"></div>
        </#if>

    <#else>
        <div class="product-toolbar-item" data-swiftype-index='false'>
            <#if renderingMode == 'related-product-cad'>
            <#if cadDownloadURL != "">
                <a href="${cadDownloadURL}" target="_blank"
                   class="pl-2 product-toolbar-menu-item iconed-text">
                    <i class="icon-download-cad"></i>
                </a>
            <#else>
            <#if areWeInCylinderConfigurator >
                <button href="javascript:void(0);"
                        class="show-cad-download series-ssi-cad-download btn btn-primary add-to-basket-btn add-to-basket-btn-js"
                        data-toggle="tooltip" data-placement="bottom"
                        title="<@fmt.message key="product.toolbar.downloadCad"/>"
                        data-original-title="<@fmt.message key="product.toolbar.downloadCad"/>">
                    <i class="icon-download-cad"></i>
                </button>
            <#else>
                <a href="javascript:void(0);" data-toggle="tooltip" data-placement="bottom"
                   title="<@fmt.message key="product.toolbar.downloadCad"/>"
                   class="show-cad-download iconed-text series-ssi-cad-download" ${partNumber?has_content?then('', 'disabled')}>
                    <div class="pl-2 product-toolbar-menu-item"><i class="icon-download-cad"></i></div>
                    <i class="loading-container-js"></i>
                </a>
            </#if>
            </#if>
                <script>
                    $(function () {
                        $('[data-toggle="tooltip"]').tooltip();
                    });
                </script>
            <#else>



            <#if boxTitle != "" && renderingMode == 'dropdown-plain'>
                <span class="product-toolbar-title product-toolbar-title-js"><@fmt.message key="${boxTitle}"/></span>
            </#if>

            <#if boxTitle != "" && renderingMode == 'dropdown-category-item'>
                <div class="category-footer">
                <span class="product-toolbar-title-js"><i
                            class="category-tile__footer__icon icon-info-circled"></i> <@fmt.message key="${boxTitle}"/></span>
                    <span class="category-tile__footer__mailIcon show-ask-smc"><a href="#"><i
                                    class="icon-mail"></i><span
                                    class="show-ask-smc__anchor-text"><@fmt.message key="product.toolbar.askourexperts"/></span></a></span>
                </div>
            </#if>

                <div class="product-toolbar-item__content product-toolbar-content-js <#if boxTitle == "" && renderingMode == "simple">no-title</#if> ">
                    <#if boxTitle != "" || renderingMode != "simple">
                        <h2 class="heading heading-07">
                            <#if boxTitle != "" && renderingMode != '3d-preview'>
                                <span>
                    <@fmt.message key="${boxTitle}"/>
                </span>
                            </#if>
                            <#if renderingMode == 'dropdown-plain' || renderingMode == 'dropdown-category-item'>
                                <a href="javascript:void(0);"
                                   class="close-btn close-btn-js close-btn-main-js iconed-text">
                                    <i class="icon-close"></i>
                                </a>
                            </#if>
                            <#if renderingMode == '3d-preview'>
                                <div>
                                    <#if product.isHasPreview3d()?? && product.isHasPreview3d()?c == "false">
                                        <div class="preview-3d-iframe-disabled">
                                            <p class="no-preview-3D-message"><@fmt.message key="product.toolbar.noPreview3DForProduct"/></p> <!--No 3D Preview available for this product-->
                                        </div>
                                    <#else>
                                        <a id="aument-preview-link" class="aument-preview-link hidden"
                                           href="javascript:void(0);">
                                            <div class="aument-preview-icon">
                                                <i class="icon-enlarge"></i>
                                            </div>
                                        </a>

                                        <div class="preview-3d-iframe">
                                            <!-- Loaded by AJAX -->
                                        </div>
                                    </#if>
                                </div>
                            </#if>
                        </h2>
                    </#if>
                    <#if renderingMode == 'simple-description'>
                        <p class="product-toolbar-description">${product.getName()}</p>
                    </#if>
                    <ul class="list-items empty-list">
                        <#if renderingMode == '3d-preview'>
                            <li class="preview-3d-title">
                                <span><@fmt.message key="product.toolbar.3dPreview"/></span>
                            </li>
                        </#if>

                        <#if showFeaturesCatalogues>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-feature-catalogues iconed-text additional-content-dropdown" disabled>
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.featureCatalogues"/></div>
                                </a>

                                <!-- Features catalog -->
                                <div class="feature-catalogues-additional-content feature-catalogues-additional-content-js product-toolbar-content-js"></div>
                            </li>
                        </#if>
                        <#if showTechnicalDocumentation>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-technical-documentation iconed-text additional-content-dropdown" hidden>
                                    <div class=" pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.technicalDocumentation"/></div>
                                </a>

                                <!-- Technical Documentation -->
                                <div class="technical-documentation-additional-content technical-documentation-additional-content-js product-toolbar-content-js"></div>
                            </li>
                        </#if>
                        <#if showInstallationManuals>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-technical-documentation iconed-text additional-content-dropdown" hidden>
                                    <div class="pl-2 product-toolbar-menu-item <#if renderingOrigin?has_content && renderingOrigin == "series" >series-pitw imms-doc</#if>"
                                         data-type="installation-manuals"><@fmt.message key="product.toolbar.installationManuals"/>
                                    </div>
                                </a>

                                <!-- Technical Documentation -->
                                <div class="technical-documentation-additional-content technical-documentation-additional-content-js product-toolbar-content-js"
                                     type="installation-manuals"></div>
                            </li>
                        </#if>
                        <#if showOperationManuals>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-technical-documentation iconed-text additional-content-dropdown" hidden>
                                    <div class="pl-2 product-toolbar-menu-item  <#if renderingOrigin?has_content && renderingOrigin == "series" >series-pitw opmm-doc</#if>"
                                         data-type="operation-manuals"><@fmt.message key="product.toolbar.operationmanuals"/>
                                    </div>
                                </a>

                                <!-- Technical Documentation -->
                                <div class="technical-documentation-additional-content technical-documentation-additional-content-js product-toolbar-content-js"
                                     type="operation-manuals"></div>
                            </li>
                        </#if>
                        <#if showCECertificates>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-technical-documentation iconed-text additional-content-dropdown" hidden>
                                    <div class="pl-2 product-toolbar-menu-item  <#if renderingOrigin?has_content && renderingOrigin == "series" >series-pitw cecertificates-doc</#if>"
                                         data-type="ce-certificates"><@fmt.message key="product.toolbar.cecertificates"/>
                                    </div>
                                </a>

                                <!-- Technical Documentation -->
                                <div class="technical-documentation-additional-content technical-documentation-additional-content-js product-toolbar-content-js"
                                     type="ce-certificates"></div>
                            </li>
                        </#if>
                        <#if showPressRelease>
                            <li>
                                <a href="javascript:void(0);" class="show-press-release iconed-text">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.pressRelease"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showTechnicalPresentationJP>
                            <li>
                                <a href="${technicalPresentationJPURL}" target="_blank"
                                   class="pl-2 product-toolbar-menu-item iconed-text"><@fmt.message key="product.toolbar.technicalPresentationJP"/></a>
                            </li>
                        </#if>
                        <#if show3dPreview>
                            <li>
                                <a href="javascript:void(0);" class="show-3d-preview iconed-text"
                                   <#if product.isHasPreview3d()?? && !product.isHasPreview3d()>disabled</#if>
                                   smc-statistic-action="PREVIEW 3D" smc-statistic-source="${statisticsSource}">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.3dPreview"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showCadDownload>
                            <li>
                                <#if cadDownloadURL != "">
                                    <a href="${cadDownloadURL}" target="_blank"
                                       class="pl-2 product-toolbar-menu-item iconed-text">
                                        <@fmt.message key="product.toolbar.downloadCad"/>
                                    </a>
                                <#else>
                                    <#if product.isHasPreview3d()?? && product.isHasPreview3d()?c == "false">
                                        <a href="javascript:void(0);"
                                           class="show-cad-download-disabled iconed-text disabled"}>
                                            <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.downloadCad"/></div>
                                            <i class="loading-container-js"></i>
                                        </a>
                                    <#else>
                                        <a href="javascript:void(0);"
                                           class="show-cad-download iconed-text" ${partNumber?has_content?then('', 'disabled')}>
                                            <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.downloadCad"/></div>
                                            <i class="loading-container-js"></i>
                                        </a>
                                    </#if>

                                </#if>
                            </li>
                        </#if>
                        <#if showDataSheet>
                            <li>
                                <a id="show-datasheet-link" href="javascript:void(0);"
                                   class="show-datasheet iconed-text hidden <#if !product.isHasDatasheet()>no-datasheet hidden</#if>"
                                   smc-statistic-action="DOWNLOAD FILE" smc-statistic-data3="DATA SHEET"
                                   smc-statistic-source="${statisticsSource}">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.datasheetDownload"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showSalesDocument>
                            <li>
                                <a id="show-sales-document-link" href="javascript:void(0);"
                                   class="show-sales-document iconed-text">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.createPDF"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showVideo>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-video iconed-text" ${product.getVideo()?has_content?then('', 'disabled')}
                                   smc-statistic-action="DOWNLOAD FILE" smc-statistic-source="${statisticsSource}"
                                   smc-statistic-data3="PRODUCT VIDEO">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.video"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showImages>
                            <li>
                                <a href="javascript:void(0);" class="show-images iconed-text"
                                   data-image-ch="${imageChURL}"
                                   data-image-cl="${imageClURL}" data-image-bw="${imageBwURL}">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.images"/></div>
                                    <i class="loading-container-js"></i>
                                </a>

                                <div class="show-images-additional-content show-images-additional-content-js product-toolbar-content-js"
                                     data-image-ch="${imageChURL}" data-image-cl="${imageClURL}"
                                     data-image-bw="${imageBwURL}"></div>
                            </li>
                        </#if>
                        <#if showAskSMC>
                            <li>
                                <a href="javascript:void(0);" class="show-ask-smc iconed-text">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="${askSMCTitleKey}"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if showShareYourSuccess>
                            <li>
                                <a id="show-share-your-success" href="javascript:void(0);"
                                   class="show-share-your-success iconed-text">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.shareYourSuccess"/></div>
                                    <i class="loading-container-js"></i>
                                </a>
                            </li>
                        </#if>
                        <#if areWeInNewProducts && additionalContent?has_content >
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-additional-content iconed-text additional-content-dropdown">
                                    <div class=" pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.additionalContent"/></div>
                                </a>
                                <!-- Additional Content -->
                                <div class="additional-content-additional-content additional-content-additional-content-js product-toolbar-content-js">
                                    <div class="product-toolbar-item__content additional-content-template-content additional-content-template-content-js">
                                        <h2 class="heading heading-07">
                                    <span>
                                        <@fmt.message key="product.toolbar.additionalContent"/>
                                    </span>
                                            <a href="javascript:void(0);" class="close-btn close-btn-js iconed-text">
                                                <i class="icon-close"></i>
                                            </a>
                                        </h2>
                                        <div class="content-item content-body content-body-js">
                                            <#if areWeInNewProducts>
                                                <#list  additionalContent as item>
                                                    <#if item.getUrl()?has_content>
                                                        <div class="additional-content additional-content-js">
                                                            <div class="product-toolbar-item">
                                                                <#if item.getUrl()?has_content >
                                                                    <a target="_blank"
                                                                       href="${item.getUrl()}">${item.getName()}</a>
                                                                <#else>
                                                                    <span class="product-toolbar-info">${item.getName()}</span>
                                                                </#if>
                                                            </div>
                                                        </div>
                                                    <#else>
                                                        <div class="additional-content additional-content-js">
                                                            <div class="product-toolbar-item">
                                                                <span class="product-toolbar-info">${item.getName()}</span>
                                                            </div>
                                                        </div>
                                                    </#if>
                                                </#list>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </li>

                        </#if>
                        <#if areWeInNewProductsDetails && additionalContent?has_content >
                            <#list  additionalContent as item>
                                <#if item.getValue()?has_content && item.getValue()?? >
                                    <div class="additional-content additional-content-js">
                                        <div class="product-toolbar-item">
                                            <a target="_blank" href="${item.getValue()}">${item.getKey()}</a>
                                        </div>
                                    </div>
                                <#else>
                                    <div class="additional-content additional-content-js">
                                        <div class="product-toolbar-item">
                                            <span class="product-toolbar-info disabled-link">${item.getKey()}</span>
                                        </div>
                                    </div>
                                </#if>
                            </#list>
                        </#if>
                        <#if showReducedCatalogue>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-multilingual-documents iconed-text additional-content-dropdown">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.reducedCatalogue"/></div>
                                </a>
                                <!-- Reduced Catalogue -->
                                <div class="multilingual-documents-additional-content multilingual-documents-additional-content-js product-toolbar-content-js"
                                     data-document-type="reduced"
                                     data-document-type-title="<@fmt.message key="product.toolbar.reducedCatalogue"/>"></div>
                            </li>
                        </#if>
                        <#if showPressReleaseDocument>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-multilingual-documents iconed-text additional-content-dropdown">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.pressReleaseDocument"/></div>
                                </a>
                                <div class="multilingual-documents-additional-content multilingual-documents-additional-content-js product-toolbar-content-js"
                                     data-document-type="pressRelease"
                                     data-document-type-title="<@fmt.message key="product.toolbar.pressReleaseDocument"/>"></div>
                            </li>
                        </#if>
                        <#if showSwitchoverDocument>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-multilingual-documents iconed-text additional-content-dropdown">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.switchoverDocument"/></div>
                                </a>
                                <div class="multilingual-documents-additional-content multilingual-documents-additional-content-js product-toolbar-content-js"
                                     data-document-type="switchover"
                                     data-document-type-title="<@fmt.message key="product.toolbar.switchoverDocument"/>"></div>
                            </li>
                        </#if>
                        <#if showNewProductPreview>
                            <li>
                                <a href="javascript:void(0);"
                                   class="show-multilingual-documents iconed-text additional-content-dropdown">
                                    <div class="pl-2 product-toolbar-menu-item"><@fmt.message key="product.toolbar.newProductPreview"/></div>
                                </a>
                                <div class="multilingual-documents-additional-content multilingual-documents-additional-content-js product-toolbar-content-js"
                                     data-document-type="preview"
                                     data-document-type-title="<@fmt.message key="product.toolbar.newProductPreview"/>"></div>
                            </li>
                        </#if>
                        <#if showFlyer>
                            <li>
                                <a href="${flyerURL}" target="_blank"
                                   class="product-toolbar-menu-item iconed-text"><@fmt.message key="product.toolbar.distributorFlyer"/></a>
                            </li>
                        </#if>
                        <#if showEnrichData>
                            <li>
                                <a href="${enrichDataURL}" target="_blank"
                                   class="product-toolbar-menu-item iconed-text"><@fmt.message key="product.toolbar.enrichData"/></a>
                            </li>
                        </#if>
                    </ul>
                </div>

            </#if>
        </div>
    </#if>
</#macro>
