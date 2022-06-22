<#assign pcComponentId = "productConfigurator_" + product.getNode().getId()?long?c >
<#assign sparesAccessoriesComponentId = "spares_accessories_" + .now?long?c >
<#assign productToolbarForFreeConfiguratorId="producttoolbar_" + product.getNode().getId()?long?c + "_free_configurator" + (isStandalonePage?then("_standalone", ""))>
<#assign projectInformationComponentId = "project_information_" + product.getNode().getId()?long?c >
<#include "_spares-accessories-macro.ftl" />
<#include "_selection-basket-favourites-bar-macro.ftl" />
<#--<#include "../product/product-toolbar-macro.ftl">-->
<#--<@hst.include ref="product-toolbar-category-page" />-->
<#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
    <#include "product-configurator/_cylinder_wizard_modal.ftl" />
</#if>
<#include "product-configurator/_create_alias_modal.ftl" />
<@hst.setBundle basename="SearchPage,ProductToolbar,AddToCartBar,eshop,ProductConfigurator,CylinderConfigurator,ProductPDFReport"/>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/components/product-page/product-configurator/cylinder-wizard-modal.js"/>"></script>
</@hst.headContribution>

<#if ( simpleSpecialData?? )  >
    <script type="text/javascript" charset="utf-8">
        var simpleSpecialData = ${simpleSpecialData};
    </script>
<#else>
    <script type="text/javascript" charset="utf-8">
        var simpleSpecialData;
    </script>
</#if>

<#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
    <#include "_product-page-scripts.ftl">
</#if>

<script type="text/javascript" charset="utf-8">
    var loading_lbl = "Loading" + "..."; //Loading...
    var close_lbl = "Close"; //Close
    var features_catalogues_lbl = "Features Catalogues"; //Features Catalogues
    var technical_documentation_lbl = "Technical Documentation"; //Technical Documentation
    var ask_SMC_about_lbl = "Ask SMC About"; //Ask SMC about
    var partnumber_lbl = "Part Number"; //Partnumber
    var problem_on_request_lbl = "There has been a problem making the request."; //There has been a problem making the request.
    var try_again_later_lbl = "Please, try it again later."; //Please, try it again later.
    var item_cannot_saved_into_basket_lbl = "Item cannot be saved into the basket unless the configuration is complete and valid."; //Items cannot be saved into the basket unless the configuration is complete and valid.
    var choose_cad_format_lbl = "Please, choose a CAD format."; //Please, choose a CAD format.
    var no_search_lbl = "No search"; //No search.
    var error_ocurred_lbl = "An error has occurred."; //An error has occurred.
    var search_engine_working_lbl = "The search engine is working."; //The search engine is working.
    var wait_a_moment_lbl = "Please, wait a moment."; //Please, wait a moment.
    var search_error_lbl = "Search error"; //Search error
    var partnumber_search_lbl = "Part Number search"; //Partnumber search
    var keywords_search_lbl = "Keywords search"; //Keywords search
    var search_lbl = "Search"; //Search
    var no_info_to_get_preview_3d = "It has been not possible to get all necessary info to make the preview 3D request."; //It has been not possible to get all necessary info to make the preview 3D request.
    //var contact_emc = "Please, contact the SMC European Marketing Department."; //Please, contact the SMC European Marketing Department.
    var some_products_not_added = "Some of the selected products have not been added because they were already saved."; //Some of the selected products have not been added because they were already saved.
    var problem_to_add_products = "There has been a problem to add the selected products."; //There has been a problem to add the selected products.
    var functionality_temporarily_unavailable = "This functionality is temporarily unavailable."; //This functionality is temporarily unavailable.
    var complete_rod_enf_configuration_lbl = "Please, complete rod end configuration. "; //Please, complete rod end configuration.

    var readMoreMessage = "Learn more"; //read more
    var addedToBasketMessage = "Product successfully added to basket"; //Product successfully added to basket
    var addedToProductSelectionMessage = "Product successfully added to selection"; //Product successfully added to selection

    var select_favourites_folder = '';
    var product_only_to_one_folder = '';
    var select_only_one_folder = '';
    var can_not_create_folder_here = '';
    var specify_new_folder_name = '';
    var can_not_use_those_characters = '';
    var folder_not_created_inside_default = '';

    var language = "en";
    var isEshop = false;
    var isSaveAtBasket = false;
    var isSaveAtFavorites = false;
    var iketek_product_id = "";
    var tabTipMessage = "Change your preferred tab by clicking on the box"; //Change your prefered tab by clicking on the box
    var tabTipLinkMessage = "Do not show this message again"; //Do not show this message again
    var noRelatedProducts = "There are not related products"; //There are not related product
    var noItemSelected = "You must select at least one product"; //You must select at least one product

    var showingRecords_txt = "Showing _START_ to _END_ of _TOTAL_ entries"; //Showing _START_ to _END_ of _TOTAL_ entries
    var recordsPerPage_txt = "_RECORDS_ records per page"; //_RECORDS_ records per page
    var noElementsInTable_txt = "There are no elements"; //There are no elements
</script>

<script type="text/javascript">
    var ctry = "";
    var lang = "";
    var hasEshop = true;
    var isEshop = false;
    var isDC = true;
    var forceLoginDialog = false;
    var forceEshopLogin = false;
    var forceInternalLogin = false;
    var userType = 0;
    var idUser = "NL18080308";
    var launchAction = "";
    var basket_prod_N = "";
    var userErp = "";

    var noty_status = 'on';

    var etech_online_status = 'on';
</script>
<div class="hidden" data-swiftype-index='false'>
    <a id="showTechSpecsPCLink" href="<@hst.resourceURL resourceId='showTechSpecs'/>"></a>
    <a id="getStandardValuesLink" href="<@hst.resourceURL resourceId='getStandardValues'/>"></a>
    <a id="showSeriesSpareAndRelatedProductsLinkPC"
       href="<@hst.resourceURL resourceId='showSeriesSpareAndRelatedProductsPC'/>"></a>
    <a id="hasSpareAndRelatedProductsPC" href="<@hst.resourceURL resourceId='hasSpareAndRelatedProducts'/>"></a>
    <input id="product_series_code" class="hidden"/>
    <input id = "product_seriesAttrValue" class="hidden" value = "${product.getNode().getSerie()}" />
</div>

<script type="text/javascript">
    var smc = window.smc || {};
    smc.isAuthenticated = ${isAuthenticated?c};
    smc.pc = smc.pc || {};
    smc.pc.urls = {
        showTechSpecs: document.getElementById('showTechSpecsPCLink').href,
        hasSpareAndRelatedProducts: document.getElementById('hasSpareAndRelatedProductsPC').href,
        showSeriesSpareAndRelatedProducts: document.getElementById('showSeriesSpareAndRelatedProductsLinkPC').href,
        getStandardValues: document.getElementById('getStandardValuesLink').href
    };
</script>

<#if hstRequestContext.servletRequest.getParameter("show")??>
    <#assign show=hstRequestContext.servletRequest.getParameter("show")/>
<#else>
    <#assign show=""/>
</#if>

<#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
    <#include "product-configurator/cylinder-configurator/_series-cylinder-taco.ftl">
<#else>
    <#include "product-configurator/_series-taco.ftl">
</#if>


<#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
    <div class="row cylinders_configurator_container">
<#else>
    <div class="row configurator-container-row">
</#if>

    <div class="${( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )?then('col-lg-12','col-lg-8')}  configurator-container" data-swiftype-index='false'>
        <div class="configuratorMessage ikTableMultiRow ikTableContent" style="display: none;">
            <div class="ikSelectAll ikTableColumn">
                <span class="icon icon-warning"></span>
            </div>
            <div class="ikTableColumn ikGridColumn_big"></div>
        </div>
        <form id="form" action="" method="post">
            <div class="dc_productConfiguratorForm" style="clear: both;">
                <!---------------------------------------------------------------------------------->
                <!------------------------------- CONFIGURATION HTML ------------------------------->
                <!---------------------------------------------------------------------------------->

                <#-- Change http links to https, Remove port (:80) from links -->
                ${ product.getNode().getConfiguratorHtml()?replace('http:', 'https:', 'r')?replace(':80', '', 'r') }

                <#--https://www.smc.eu/portal_ssl/WebContent/digital_catalog/jsp/view_product_configurator/productConfigurator.js?nocache=1.0-->
                <#--https://www.smc.eu/portal_ssl/WebContent/digital_catalog_2/jsp/view_product_configurator/productConfigurator2.js?nocache=1.0-->
                <#--https://www.smc.eu/portal_ssl/WebContent/digital_catalog/jsp/scripts.js?nocache=2.0-->
                <#--get_cylinder_specification_sheet: http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/get_cylinder_specification_sheet.jsp-->
                <#--Create CC File: http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/cc/save_cc_document.jsp-->
                <#--http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/get_FDP_for_product.jsp-->
                <#--http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/refresh_features_catalogs_tip.jsp-->
                <#--http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/get_features_catalogs_tip.jsp-->
                <#--http://evx4405946.sys.ntt.eu/portal_edit/WebContent/digital_catalog/jsp/refresh_technical_documentation_tip.jsp-->

                <script id="configuratorJs">
                    <#-- Change http links to https, Remove port (:80) from links -->
                    ${ product.getNode().getConfiguratorJs()?replace('http:', 'https:', 'r')?replace(':80', '', 'r') }
                </script>

                <div class="hidden" data-swiftype-index='false'>
                    <a id="productConfiguratorStandalonePageLink"
                       href="<@hst.link siteMapItemRefId='products-standalone'/>"></a>
                </div>
                <script id="ProductConfiguratorInit">
                    function getRodEndConf(rodEndConfValue) {
                        var rodEndConf = {};
                        var rodEndConfParams = rodEndConfValue.split(';');
                        rodEndConfParams.forEach(function (param) {
                            var key = param.split('=')[0];
                            key = key ? key.toLowerCase() : null;
                            var value = param.split('=')[1];
                            rodEndConf[key] = decodeURIComponent(value);
                        });
                        return rodEndConf;
                    }

                    $(function () {
                        var projectInformationMessages = {
                            customerCreated: "<@fmt.message key="productConfigurator.projectinfo.notify.customerCreated" />",
                            customerUpdated: "<@fmt.message key="productConfigurator.projectinfo.notify.customerUpdated" />",
                            designerCreated: "<@fmt.message key="productConfigurator.projectinfo.notify.designerCreated" />",
                            designerUpdated: "<@fmt.message key="productConfigurator.projectinfo.notify.designerUpdated" />",
                            contactRemoved: "<@fmt.message key="productConfigurator.projectinfo.notify.contactRemoved" />",
                            notLogged: "<@fmt.message key="productConfigurator.projectinfo.notify.notLogged" />",
                            noResultsToDisplay: "<@fmt.message key="productConfigurator.projectinfo.notify.noResultsToDisplay" />",
                            completeRodEndConfiguration: "<@fmt.message key="productConfigurator.projectinfo.notify.completeRodEndConfiguration" />"
                        };

                        var ProductConfigurator = window.smc.ProductConfigurator;
                        var config = {
                            id: '${pcComponentId}',
                            productId: '${product.getNode().getId()?long?c}',
                            defaultLanguage: '${lang}',
                            isStandalonePage: ${isStandalonePage?c},
                            messages: {
                                selectPlaceholder: "<@fmt.message key="productConfigurator.select.placeholder" />",
                                featuredOptions: "<@fmt.message key="productConfigurator.select.featuredOptions" />",
                                partNumberCopied: "<@fmt.message key="productConfigurator.partnumbercopied" />",
                                browserNotCompatibleLbl: "<@fmt.message key="productConfigurator.browsernotcompatible" />",
                                clickheretoloadrodendproject: "<@fmt.message key="productConfigurator.clickheretoloadrodendproject" />",
                                standardMessage: "<@fmt.message key="standard" />"
                            },
                            urls: {
                                productConfiguratorStandalonePage: document.getElementById('productConfiguratorStandalonePageLink').href
                            },
                            etech: {
                                Init: window.Init,
                                oDomains: window.oDomains,
                                oStateMessages: window.oStateMessages
                            },
                            rodEndConf: getRodEndConf('${rodEndConf}'),
                            sparesAccessoriesModule: new window.smc.SparesAccessories({
                                id: '${sparesAccessoriesComponentId}',
                                container: $('#${sparesAccessoriesComponentId}'),
                                items: window.smc.productSparesAccessoryList,
                                paginateResults: true
                            }),
                            projectInformationModule: new window.smc.ProjectInformationModule({
                                id: '${projectInformationComponentId}',
                                productId: '${product.getNode().getId()?long?c}',
                                container: $('#project-section'),
                                messages: projectInformationMessages
                            }),
                            productToolbarForFreeConfiguratorId: "${productToolbarForFreeConfiguratorId}",
                            relatedProductsCount: ${relatedProducts?size},
                            drawingSupplier: '${drawings_supplier}',
                            productModel: '${product_model}',
                            productCode: '${product_code}',
                            productLine: '${product_line}',
                            cadenasStatus: '${cadenas_status}',
                            isRodEndCylinder: ${is_rod_end_cylinder?c},
                            isCylinderConfActive: ${isCylinderConfActive?c},
                            isEtechEnabled: ${ isEtechEnabled???then(isEtechEnabled?c, 'false') }
                        };
                        window.smc.productConfiguratorComponent = new ProductConfigurator(config);
                    });
                </script>

                <!---------------------------------------------------------------------------------->
                <!----------------------------- END CONFIGURATION HTML ----------------------------->
                <!---------------------------------------------------------------------------------->

            </div>
        </form>
        <#if is_rod_end_cylinder && isCylinderConfActive>
            <div id="xRodFormArea"></div>
            <div id="xRodFormError"></div>
            <div id="div_product_tabs_cc" style="display:none;width: 100%; clear: both;">
                <ul id="product_tabs_cc" class="shadetabsr">
                    <li>
                        <div id="configuration_summary_tab" rel="configuration_summary_container" is_first_load="true"
                             cadenas_status="$cadenas_status">$configurationSummary
                        </div>
                    </li>
                    <li>
                        <div rel="project_information_container" is_first_load="true" cadenas_status="cadenas_status">
                            $projectInformation
                        </div>
                    </li>
                </ul>
                <div class="cctabcontentstyle">
                    <div id="configuration_summary_container" class="tabcontent confPageRestylingTEMP2"></div>
                    <div id="project_information_container" class="tabcontent confPageRestylingTEMP2">
                        <jsp:include page="/WebContent/digital_catalog/jsp/cc/inc_project_information.jsp"/>
                    </div>
                </div>
            </div>
            <div id="specialCylinderInfoMessage" style="display:none;"></div>
        </#if>
        <div class="dc_productSheet" style="float: left; width: 100%;">
        </div>
        <div id="related_products" class="dc_relatedProducts">
            <div class="ikTableMultiRow ikTableContent ikTableRowHeader" style="width: 100%; margin-bottom: 10px;">
                <div class="ikTableColumn ikGridColumn_big"></div>
            </div>
            <div id="rp_container" class="dc_rpContainer" dc_product_id="${product.getNode().getId()}"
                 product_line="${product_line}" product_code="${product_code}" part_number=""
                 cadenas_status="${cadenas_status}">
                <img src="{VIPDEPLOYMENT_URL}/WebContent/digital_catalog/images/loading.gif" alt=""/><!-- Loading... -->
            </div>
        </div>
    </div>
    <div class="col-lg-4 sticky-sidebar">
        <@productToolbar id=productToolbarForFreeConfiguratorId
        product=product.getNode() boxTitle="product.toolbar.materials" renderingMode="3d-preview" sticky=true
        showFeaturesCatalogues=false showTechnicalDocumentation=false show3dPreview=false
        showAskSMC=false showVideo=false inConfigurationPage=true
        statisticsSource="PCP FREE CONFIGURATION" />

        <#assign putItToWorkViewType = "">
        <#assign putItToWorkProduct = product>
        <#if (putItToWork?? && ((putItToWork.getShowFeaturesCatalogues()?? && putItToWork.getShowFeaturesCatalogues() == true) || (putItToWork.getShowMenuManuals()?? && putItToWork.getShowMenuManuals()==true)  || (putItToWork.getShowMenuLibraries()?? && putItToWork.getShowMenuLibraries()==true) || (putItToWork.getShowMenuSettings()?? && putItToWork.getShowMenuSettings()==true)))>
            <div id="putItToWorkContainer" class="position-relative">
                <div id="producttoolbar_158137_header" class="product-toolbar-component product-toolbar-component-simple desktop" style="margin-top: 20px">
                <div class="product-toolbar-item" data-swiftype-index="false">
                    <div class="product-toolbar-item__content product-toolbar-content-js">
                        <h2 class="heading heading-07">
                            <span><@fmt.message key="product.toolbar.putittowork"/></span>
                        </h2>
                        <div id="pitw-wrapper" class="list-items filters-wrapper">
                            <#include "product-put_it_to_work.ftl">
<#--                            <@productToolbar id=("producttoolbar_"+ product.getNode().getId()?c +"_doc_sh_header")-->
<#--                            product=product.getNode()  boxTitle=""-->
<#--                            showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false-->
<#--                            showFeaturesCatalogues= false-->
<#--                            showDataSheet=false showAskSMC=false renderingMode="simple" showPressRelease=false-->
<#--                            areWeInNewProducts=false  areWeInNewProductsDetails=false showInstallationManuals=true showOperationManuals=true-->
<#--                            showCECertificates=true />-->

<#--                            <@productToolbar id=("producttoolbar_"+ product.getNode().getId()?c +"_doc_imm_sh_header")-->
<#--                            product=product.getNode()  boxTitle=""-->
<#--                            showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false-->
<#--                            showFeaturesCatalogues= false-->
<#--                            showDataSheet=false showAskSMC=false renderingMode="simple" showPressRelease=false renderingOrigin = "series"-->
<#--                            areWeInNewProducts=false  areWeInNewProductsDetails=false showInstallationManuals=true showOperationManuals=false-->
<#--                            showCECertificates=false />-->

<#--                            <@productToolbar id=("producttoolbar_"+ product.getNode().getId()?c +"_doc_opmm_sh_header")-->
<#--                            product=product.getNode()  boxTitle=""-->
<#--                            showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false-->
<#--                            showFeaturesCatalogues= false-->
<#--                            showDataSheet=false showAskSMC=false renderingMode="simple" showPressRelease=false renderingOrigin = "series"-->
<#--                            areWeInNewProducts=false  areWeInNewProductsDetails=false showInstallationManuals=false showOperationManuals=true-->
<#--                            showCECertificates=false />-->

<#--                            <@productToolbar id=("producttoolbar_"+ product.getNode().getId()?c +"_doc_cecc_sh_header")-->
<#--                            product=product.getNode()  boxTitle=""-->
<#--                            showCadDownload=false show3dPreview=false showDataSheet=false showVideo=false showTechnicalDocumentation=false-->
<#--                            showFeaturesCatalogues= false-->
<#--                            showDataSheet=false showAskSMC=false renderingMode="simple" showPressRelease=false renderingOrigin = "series"-->
<#--                            areWeInNewProducts=false  areWeInNewProductsDetails=false showInstallationManuals=false showOperationManuals=false-->
<#--                            showCECertificates=true />-->
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </#if>


    </div>
        <#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
            <#include "product-configurator/cylinder-configurator/_cylinder-configurator.extras.ftl" />
        </#if>

        <div class="project-section-block">

        <#if  ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
        <#--    <h3 class="mb-4 sub-title">-->
        <#--        <span><@fmt.message key="cylinderConfigurator.fullProjectSummary"/></span>-->
        <#--    </h3>-->
        <#--    <div class="alert alert-info">-->
        <#--        <@fmt.message key="cylinderConfigurator.printOrSaveInstructions"/>-->
        <#--    </div>-->
            <div class="project-alert-container col-lg-12 hidden">
                <h3 class="mb-4 sub-title">
                    <span><@fmt.message key="cylinderConfigurator.fullProjectSummary"/></span>
                </h3>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info"><@fmt.message key="cylinderConfigurator.printOrSaveInstructions"/></div>
                    </div>
                </div>
            </div>
        <#else>
            <div class="project-alert-container  col-lg-12  hidden">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info"><@fmt.message key="productConfigurator.projectinfo.disclaimer"/></div>
                    </div>
                </div>
            </div>
        </#if>
        <div id="project-section" class="row project-section col-lg-12 hidden">
            <#if deviceInfo.deviceType == 'DESKTOP'>
                <div id="project-section-container" class="smc-tabs ${deviceInfo.deviceType?lower_case}">
                    <ul class="navbar-full nav border-bottom">
                        <li class="nav-item ml-sm-5">
                            <a class="nav-link active project-summary-tab" id="project-configuration-summary-tab" data-toggle="tab"
                               href="#project-configuration-summary" role="tab" aria-controls="project-configuration-summary"
                               aria-selected="false">
                                <span><@fmt.message key="productConfigurator.projectinfo.configurationsummary.tabtitle"/></span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${isAuthenticated?then('', 'disabled')} project-summary-tab" id="project-information-tab"
                               data-toggle="tab" href="#project-information" role="tab" aria-controls="project-information"
                               aria-selected="false"
                                    ${isAuthenticated?then('', 'disabled')}>
                                <span><@fmt.message key="productConfigurator.projectinfo.projectinformation.tabtitle"/></span>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="project-configuration-summary" role="tabpanel"
                             aria-labelledby="project-configuration-summary-tab">
                            <div class="attribute-list project-summary-attribute-list-js">
                                <!-- Filled by Javascript -->
                            </div>
                        </div>
                        <div class="tab-pane fade" id="project-information" role="tabpanel"
                             aria-labelledby="project-information-tab">
                            <#include "product-configurator/_project_information_form.ftl" />
                        </div>
                    </div>
                </div>
            <#else>
                <div id="project-section-container" class="smc-tabs ${deviceInfo.deviceType?lower_case} ">
                    <div>
                        <div class="simple-collapse navigation-links-js">
                            <a href="#project-configuration-summary" data-section="project-information" class="js-accordion-mobile"
                               data-target="#project-configuration-summary">
                                <span><@fmt.message key="productConfigurator.projectinfo.configurationsummary.tabtitle"/></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="project-configuration-summary"
                             data-parent="#project-section-container">
                            <div class="attribute-list project-summary-attribute-list-js">
                                <!-- Filled by Javascript -->
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="simple-collapse navigation-links-js">
                            <a href="#project-information" data-section="project-information" data-target="#project-information"
                               class="${isAuthenticated?then('', 'disabled')} js-accordion-mobile" ${isAuthenticated?then('', 'disabled')}>
                                <span><@fmt.message key="productConfigurator.projectinfo.projectinformation.tabtitle"/></span>
                            </a>
                        </div>
                        <div class="collapse" data-toggle="collapse" id="project-information"
                             data-parent="#project-section-container">
                            <#include "product-configurator/_project_information_form.ftl" />
                        </div>
                    </div>
                </div>
            </#if>
        </div>


        <div id="project-section-buttons" class="project-section-buttons hidden col-lg-12">
            <div class="row">
                <div class="col-lg-12">
                    <#if  ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true && apiPermission?? && apiPermission.isBom() )  >
                        <button id="exportBomBtn" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="cylinderConfigurator.exportBom"/></button>
                    </#if>
                    <button id="pdfReportBtn" class="btn btn-secondary btn-secondary--blue-border mr-3"
                            disabled><@fmt.message key="productConfigurator.pdfreport"/></button>
                    <button id="saveProjectBtn"
                            class="btn btn-primary mt-10 mt-sm-0"><@fmt.message key="productConfigurator.projectinfo.saveprojectbtn"/></button>
                </div>
            </div>
        </div>
        </div>

    </div>
<!-- Add to cart Bar -->
<#--<div class="row">-->
<#--    <div class="col-lg-12">-->
<#--        &lt;#&ndash;TODO Remove this condition when the login implementation in the iframe is done&ndash;&gt;-->
<#--        <#if isStandalonePage && !isAuthenticated>-->
<#--            <@addToBasketBar product=product.getNode() renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true showAddToFavoritesBtn=false-->
<#--            statisticsSource="PCP FREE CONFIGURATION" />-->
<#--        <#else>-->
<#--            <@addToBasketBar product=product.getNode() renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true-->
<#--            statisticsSource="PCP FREE CONFIGURATION" />-->
<#--        </#if>-->
<#--    </div>-->
<#--</div>-->
<#--<#if ( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true &&  isAuthenticated )  >-->


<#if  !( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true )  >
    <#if !isStandalonePage>
        <div id="series-techspecs" class="container hidden">
            <hr class="section-separator mt-5 mb-5"/>
            <div class="tech_specs_area" data-toggle="collapse" data-target="#tech_specs_list">
                <h3 class="sub-title collapsed"
                    aria-expanded="false"
                    aria-controls="tech_specs_collapse">
                    <span><@fmt.message key="productConfigurator.technicalspecifications"/></span>
                    <i class="fa fa-plus"></i>
                </h3>
            </div>
            <div id="tech_specs_list" class="collapse">
                <div class="tab-loading-container loading-container-js align-items-center"></div>
                <div class="w-100 product-detail-content product-detail-content-js"></div>
            </div>
        </div>
    </#if>
</#if>

<#if !( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true ) || ( mustShowCompleteCylinderSeries != true)  >
    <div id="freeConfiguration-spares-related" class="hidden">
        <hr class="section-separator mt-5 mb-5"/>
        <h3 class="sub-title"><@fmt.message key="productConfigurator.sparesaccesories" /></h3>
        <div id="free_configuration_spares_tab" class="row col-lg-12">
            <div class="tab-loading-container loading-container-js align-items-center"></div>
            <div id="free_configuration_spares_container"
                 class="spares-accessories spare-related-content spare-related-content-js spares-accessories-result-container"></div>
        </div>
    </div>
</#if>

<!-- technical-specifications -->
<#if !isStandalonePage>
    <div id="series-techspecs" class="container hidden">
        <hr class="section-separator mt-5 mb-5"/>
        <div class="tech_specs_area" data-toggle="collapse" data-target="#tech_specs_list">
            <h3 class="sub-title collapsed"
                aria-expanded="false"
                aria-controls="tech_specs_collapse">
                <span><@fmt.message key="productConfigurator.technicalspecifications"/></span>
                <i class="fa fa-plus"></i>
            </h3>
        </div>
        <div id="tech_specs_list" class="collapse">
            <div class="tab-loading-container loading-container-js align-items-center"></div>
            <div class="w-100 product-detail-content product-detail-content-js"></div>
        </div>
    </div>
</#if>
<!-- /technical-specifications -->

<script type="text/template" id="configurationSummaryAttributeListItemTemplate">
    <div class="attribute-list-row">
        <span class="attribute-name">{{attributeName}}: </span><span class="attribute-value">{{attributeValue}}</span>
    </div>
</script>

<script type="text/template" id="productConfigurationModalTemplate">
    <div class="modal product-configuration-modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">{{productName}}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <#include "../../include/spinner.ftl">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</script>
<#assign showRodEndConfigurationAssign = "" />
<#if  ( showRodEndConfiguration?? && showRodEndConfiguration == true) || (isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true && mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries == true)  >
    <#assign showRodEndConfigurationAssign = "true" />
<#else>
    <#assign showRodEndConfigurationAssign = "false" />
</#if>
<#assign isAccessoryDetailsModalEnabledAssign = "" />
<#if  ( isAccessoryDetailsModalEnabled?? && isAccessoryDetailsModalEnabled == true)  >
    <#assign isAccessoryDetailsModalEnabledAssign = "true" />
<#else>
    <#assign isAccessoryDetailsModalEnabledAssign = "false" />
</#if>
<input type="hidden" id="showRodEndConfiguration" value="${showRodEndConfigurationAssign}"/>
<input type="hidden" id="isCylinderSeriesConfiguration" value ="${isCylinderSeriesConfiguration}" />
<input type="hidden" id="mustShowCompleteCylinderSeries" value ="${mustShowCompleteCylinderSeries}" />
<input id = "isAccessoryDetailsModalEnabled" class="hidden" value = "${isAccessoryDetailsModalEnabledAssign}" />

<#assign rodEndStatusClass = "" />
<#if !( isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true)  >
    <#assign rodEndStatusClass = "hidden" />
</#if>
<#if (showRodEndConfiguration?has_content &&  showRodEndConfiguration == true) || (isCylinderSeriesConfiguration?? && isCylinderSeriesConfiguration == true && mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries == true) >
    <#if mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries >
        <#assign cylinderDisplayCssClass = "rodEndOptionsSwitch_cylinderConfigurator" />
    <#else>
        <#assign cylinderDisplayCssClass = "" />
    </#if>
    <h3 id="rodEndOptionsSubtitle"
        class="sub-title hidden rodEndOptionsSwitch_subtitle"><@fmt.message key="productConfigurator.rodEndOptions" /></h3>
    <div id="rodEndOptionsSwitch" class="form-group hidden ${cylinderDisplayCssClass}">
        <div class="rodEndOptionsSwitch_container">
            <label class="switch">
                <input id="rodEndOptionsSwitchToggle" type="checkbox" class="primary" disabled>
                <span class="slider round"></span>
            </label>
            <label for="rodEndOptionsSwitchToggle" class="switch-label">
                <@fmt.message key="productConfigurator.cylinderRodEndOrderOptions" />
            </label>
        </div>
        <#if mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries >
            <div class="col-12 aareo__switch" id ="aareo_switch_container">
                <div class="d-flex align-items-center">
                    <label class="switch" for="accesoriesAndRodEndOptionsSwitchToggle">
                        <input id="accesoriesAndRodEndOptionsSwitchToggle" type="checkbox" class="primary">
                        <span class="slider round"></span>
                    </label>

                    <#if  ( apiPermission?? && apiPermission.isAccessories() )  >
                        <h3 class="heading-05 switch-label mb-0 ml-4"><@fmt.message key="cylinderConfigurator.accesories.rodEnd.options"/></h3>
                    <#else>
                        <h3 class="heading-05 switch-label mb-0 ml-4"><@fmt.message key="cylinderConfigurator.modifyRodEndOptions"/></h3>
                    </#if>
                </div>
                <span class = "hidden" id = "aareo_cylinderConfigurator_loadProject_text" >
                    <@fmt.message key="cylinderConfigurator.loadProject"/>
                </span>
            </div>
        </#if>
        <#if mustShowCompleteCylinderSeries?? && mustShowCompleteCylinderSeries >
            <div class="col-12 mt-4 aareo cylinders_configurator hidden" id="cylindersConfigurator_beforeRodEnd">
                <#if  ( apiPermission?? && apiPermission.isAccessories() )  >
                    <input type="hidden" id="accessoriesPermission" value="true"/>
                <#else>
                    <input type="hidden" id="accessoriesPermission" value="false"/>
                </#if>
                <div class="row">
                    <!-- cylinder parts -->
                    <div class="col-12 aareo__cylinder aareo_configuration_part hidden">
                        <div class="alert alert-info"><@fmt.message key="cylinderConfigurator.chooseAccesory"/></div>
                        <div class="aareo__cylinder__parts py-5">
                            <#if cylinderParts?? && cylinderParts.getCylinderTypes()?? && cylinderParts.getCylinderTypes()?size != 0>
                                <#list cylinderParts.getCylinderTypes() as cylinderPart>
                                    <#if cylinderPart.getZones()?size != 0 >
                                        <#if cylinderPart?index == 0 >
                                        <div class="cylinder_type_part_container" id="cylinder_type_part_container_${cylinderPart.getName()}">
                                        <#else>
                                        <div class="cylinder_type_part_container hidden" id="cylinder_type_part_container_${cylinderPart.getName()}" data-conditions="${cylinderPart.getConditions()}">
                                        </#if>
                                            <div class="hidden cylinder_type_part_container_conditions" id="cylinder_type_part_container_${cylinderPart.getName()}_conditions">
                                                <#list cylinderPart.getConditions() as condition>
                                                    <span>${condition.getKey()}=${condition.getValue()}</span>
                                                </#list>
                                            </div>
                                            <div class="aareo__cylinder__parts_selection_container">
                                                <div class="aareo__cylinder__parts_selection_container_buttons">
                                                <#list cylinderPart.getZones() as zone>
                                                    <div class="aareo__cylinder__part">
                                                        <#if zone.isRodEnd()>
                                                            <div class="aareo__cylinder__part_position aareo__cylinder__part_rodEnd" >
                                                                <#if zone?index == 0 >
                                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js selected btn" data-value="${zone.getZone()}" >${zone.getZone()}</a>
                                                                <#else>
                                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js btn" data-value="${zone.getZone()}" >${zone.getZone()}</a>
                                                                </#if>
                                                            </div>
                                                        <#else>
                                                            <div class="aareo__cylinder__part_position" >
                                                                <#if zone?index == 0 >
                                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js selected btn"  data-value="${zone.getZone()}">${zone.getZone()}</a>
                                                                <#else>
                                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js btn"  data-value="${zone.getZone()}">${zone.getZone()}</a>
                                                                </#if>
                                                            </div>
                                                        </#if>
                                                    </div>
                                                </#list>
                                                </div>
                                                <div class="aareo__cylinder__parts_legend">
                                                    <div class="aareo__cylinder__parts_legend_line">
                                                        <span class="aareo__cylinder__parts_legend_color accesory_end" ></span>
                                                        <@fmt.message key="cylinderConfigurator.addOneAccesory"/>
                                                    </div>
                                                    <div class="aareo__cylinder__parts_legend_line">
                                                        <span class="aareo__cylinder__parts_legend_color rod_end"></span>
                                                        <@fmt.message key="cylinderConfigurator.addAccesoryOrRodEnd"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="aareo__cylinder__images_part" >
                                                <#list cylinderPart.getZones() as zone >
                                                    <div class="aareo__cylinder__part_image aareo__cylinder__images_part_image" data-value="${zone.getZone()}" >
                                                        <#if zone?index == 0 >
                                                            <img class="aareo__cylinder__images_part_image_${zone.getZone()}" src="${zone.getImageUrl()}"  />
                                                        <#else>
                                                            <img class="aareo__cylinder__images_part_image_${zone.getZone()} hidden" src="${zone.getImageUrl()}" />
                                                        </#if>
                                                    </div>
                                                </#list>
                                            </div>
                                        </div>
                                    </#if>
                                </#list>
                            </#if>
                        </div>
                    </div>
                    <!-- / cylinder parts -->
                    <!-- choose-add-modify -->
                    <div class="col-12 mb-4 aareo__choose-add-modify aareo_configuration_part hidden">
                        <h3 class="heading-05 mb-4 text-center"><@fmt.message key="cylinderConfigurator.chooseAction"/></h3>
                        <div class="d-sm-flex justify-content-center align-items-center">
                            <a id="aareo_configuration_part_addAccesory" class="btn btn-primary mt-0"><@fmt.message key="cylinderConfigurator.addAccesory"/></a>
                            <a id="aareo_configuration_part_modifyRodEnd" class="btn btn-secondary btn-secondary--blue-border mt-3 mt-sm-0 ml-sm-2"><@fmt.message key="cylinderConfigurator.modifyRodEndOptions"/></a>
                        </div>
                    </div>
                    <!-- / choose-add-modify -->
                </div>
            </div>
        </#if>
    </div>
<#else>
    <h3 id="rodEndOptionsSubtitle" class="sub-title hidden"
        style="display:none"><@fmt.message key="productConfigurator.rodEndOptions" /></h3>
    <div id="rodEndOptionsSwitch" class="form-group hidden" style="display:none">
        <label class="switch">
            <input id="rodEndOptionsSwitchToggle" type="checkbox" class="primary" disabled>
            <span class="slider round"></span>
        </label>
        <label for="rodEndOptionsSwitchToggle" class="switch-label">
            <@fmt.message key="productConfigurator.cylinderRodEndOrderOptions" />
        </label>
    </div>
</#if>

<script>
    $(document).ready(function () {
        $('#series-configurator-taco').hide();
        $(window).scroll(function () { // when the page is scrolled run this
            if ($("#productConfiguratorContainer") !== undefined && $("#productConfiguratorContainer").offset() !== undefined){
                var bottom_of_object = $("#productConfiguratorContainer").offset().top ;
                var bottom_of_window = $(window).scrollTop() + $(window).height();

                if( bottom_of_window > bottom_of_object ){
                    $('#series-configurator-taco').fadeIn("fast"); // fade in
                    if (window.screen.availWidth >= 992){
                        $(".back-to-top").css("margin-bottom","10rem");
                    }else {
                        setTimeout(function(){
                            $(".back-to-top").css("margin-bottom",""+$("#series-configurator-taco").height()+"px");
                        },500);
                    }
                } else { // else
                    $('#series-configurator-taco').fadeOut("fast"); // fade out
                    $(".back-to-top").css("margin-bottom","3.5rem");
                }
            }
        });
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>