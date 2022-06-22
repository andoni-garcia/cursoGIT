<#assign pcComponentId = "productConfigurator_" + product.getNode().getId()?long?c >
<#assign sparesAccessoriesComponentId = "spares_accessories_" + .now?long?c >
<#assign productToolbarForFreeConfiguratorId="producttoolbar_" + product.getNode().getId()?long?c + "_free_configurator" + (isStandalonePage?then("_standalone", ""))>
<#assign projectInformationComponentId = "project_information_" + product.getNode().getId()?long?c >
<#include "_spares-accessories-macro.ftl" />
<#include "_selection-basket-favourites-bar-macro.ftl" />
<#include "product-configurator/_details-modal-macro.ftl" />
<@hst.setBundle basename="SearchPage,ProductToolbar,AddToCartBar,eshop,ProductConfigurator,StandardStockedItems,SparesAccessories,ProductPDFReport"/>
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

<!-- New HTO -->
<div class="idbl_hto_wrapper idbl_hto_wrapper--no_info ${isAuthenticated?then('idbl_hto_wrapper--user_logged_in', '')}"
     id="idbl_hto_wrapper">
    <div class="idbl_hto idbl_hto--light container">
        <header class="idbl_hto__header"></header>
        <div class="idbl_hto__content">
            <section class="idbl_hto__content__data">
            </section>
            <section class="idbl_hto__content__partnumber">
                <div class="idbl_hto__partnumber__actions">
                    <a id="copyToClipBoard_btn" class="btn btn-secondary btn-secondary--blue-border" href="#"
                       data-toggle="tooltip" data-placement="bottom" title=""
                       data-original-title="<@fmt.message key="productConfigurator.copytoclipboard"/>">
                        <div class="icon-container-hto">
                            <i class="icon-copy"></i>
                        </div>
                    </a>
                </div>

                <!-- ToDo: código del cpn_partnumber en data-partnumber-code -->
                <div class="idbl_hto__partnumber__code_wrapper idbl_hto__partnumber__code_wrapper--status-complete"
                     id="idbl_hto__partnumber__code_wrapper" data-partnumber-code="">
                    <span class="idbl_hto__partnumber__code_status"></span>

                    <div class="idbl_hto__partnumber__code config" id="idbl_hto__partnumber__code">
                        <!---------------------------------------------------------------------------------->
                        <!------------------------------- PART NUMBER HTML --------------------------------->
                        <!---------------------------------------------------------------------------------->

                        ${ product.getNode().getPartNumberHtml() }

                        <!---------------------------------------------------------------------------------->
                        <!--------------------------- END PART NUMBER HTML --------------------------------->
                        <!---------------------------------------------------------------------------------->
                    </div>

                </div>
                <div class="idbl_hto__partnumber__accesories_wrapper"></div>
            </section>
            <#if isStandalonePage && !isAuthenticated>
                <@addToBasketBar productId=product.getNode().getId()?long?c renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true showAddToFavoritesBtn=false new_hto=true
                statisticsSource="PCP FREE CONFIGURATION" />
            <#else>
                <@addToBasketBar productId=product.getNode().getId()?long?c renderingMode="configurator" showQuantityBox=true showInfo=true showExtraInfo=true new_hto=true
                statisticsSource="PCP FREE CONFIGURATION" />
            </#if>
            <section class="idbl_hto__content__actions idbl_hto__content__actions--switch"></section>
        </div>
    </div>
</div>
<!-- /New HTO-->

<div class="row">
    <div class="col-lg-8 configurator-container" data-swiftype-index='false'>
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
                    <a id="showTechSpecsPCLink" href="<@hst.resourceURL resourceId='showTechSpecs'/>"></a>
                    <a id="getStandardValuesLink" href="<@hst.resourceURL resourceId='getStandardValues'/>"></a>
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
                        var smc = window.smc || {};
                        smc.isAuthenticated = ${isAuthenticated?c};
                        smc.pc = smc.pc || {};
                        smc.pc.urls = {
                            showTechSpecs: document.getElementById('showTechSpecsPCLink').href,
                            getStandardValues: document.getElementById('getStandardValuesLink').href
                        };
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

                        var rodEndConfValues = "";

                        <#if rodEndConf?? >
                            rodEndConfValues = "${rodEndConf}";
                        </#if>

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
                            rodEndConf: getRodEndConf(rodEndConfValues),
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

        <#if isSeriesPage?? && isSeriesPage == true>
            <div class="product__related_information mt-20">
                <div id="producttoolbar_related_information_header"
                     class="product-toolbar-component product-toolbar-component-simple desktop">
                    <div class="product-toolbar-item" data-swiftype-index="false">
                        <div class="product-toolbar-item__content product-toolbar-content-js">
                            <h2 class="heading heading-07">
                                <span><@fmt.message key="product.toolbar.putittowork"/></span>
                            </h2>
                            <div class="list-items filters-wrapper">
                                <#if node.getCatalogues()?? && node.getCatalogues().getDocuments()?size != 0>
                                    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                                        <div class="simple-collapse__head">
                                            <h2 class="heading-06"><@fmt.message key="product.toolbar.manuals"/></h2>
                                        </div>
                                        <div class="simple-collapse__body">
                                            <div class="simple-collapse__bodyInner">
                                                <ul class="filters-categories__item__level2">
                                                    <li>
                                                        <a href="${item.getUrl()}" target="_blank">Installation
                                                            Manual</a>
                                                    </li>
                                                    <li>
                                                        <a href="${item.getUrl()}" target="_blank">Operation Manual</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                                        <div class="simple-collapse__head">
                                            <h2 class="heading-06"><@fmt.message key="product.toolbar.settings"/></h2>
                                        </div>
                                        <div class="simple-collapse__body">
                                            <div class="simple-collapse__bodyInner">
                                                <ul class="filters-categories__item__level2">
                                                    <li>
                                                        <a href="${item.getUrl()}" target="_blank">Configuration
                                                            file</a>
                                                    </li>
                                                    <li>
                                                        <a href="${item.getUrl()}" target="_blank">Setting software</a>
                                                    </li>
                                                    <li>
                                                        <a href="${item.getUrl()}" target="_blank">Drivers</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </#if>
                                <#if true>
                                    <div class="smc-filters__categories filters-wrapper__item simple-collapse simple-collapse--generic simple-collapse--filter">
                                        <div class="simple-collapse__head">
                                            <h2 class="heading-06"><@fmt.message key="product.toolbar.libraries"/></h2>
                                        </div>
                                        <div class="simple-collapse__body">
                                            <div class="simple-collapse__bodyInner">
                                                <ul class="filters-categories__item__level2">
                                                    <li>
                                                        <a href="${ceCertificateUrl}" class="" target="_blank">e-Plan
                                                            library</a>
                                                    </li>
                                                    <li>
                                                        <a href="${ceCertificateUrl}" class="" target="_blank">SISTEMA
                                                            library</a>
                                                    </li>
                                                    <li>
                                                        <a href="${ceCertificateUrl}" class="" target="_blank">Pneumatic
                                                            symbol</a>
                                                    </li>
                                                    <#--                                                    <#list libraries as item>-->
                                                    <#--                                                        <li>-->
                                                    <#--&lt;#&ndash;                                                            <a href="${item.getUrl()}" target="_blank"><@fmt.message key="product.toolbar.title." + item.getName() /></a>&ndash;&gt;-->
                                                    <#--                                                        </li>-->
                                                    <#--                                                    </#list>-->
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </#if>
    </div>
</div>

<!-- technical-specifications -->
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
<!-- /technical-specifications -->

<div class="project-section-block">
    <div class="project-alert-container hidden">
        <div class="row">
            <div class="col-lg-12">
                <div class="alert alert-info"><@fmt.message key="productConfigurator.projectinfo.disclaimer"/></div>
            </div>
        </div>
    </div>

    <div id="project-section" class="row project-section hidden">
        <#if deviceInfo.deviceType == 'DESKTOP'>
            <div id="project-section-container" class="smc-tabs ${deviceInfo.deviceType?lower_case}">
                <ul class="navbar-full nav border-bottom">
                    <li class="nav-item ml-sm-5">
                        <a class="nav-link active" id="configuration-summary-tab" data-toggle="tab"
                           href="#configuration-summary" role="tab" aria-controls="configuration-summary"
                           aria-selected="false">
                            <span><@fmt.message key="productConfigurator.projectinfo.configurationsummary.tabtitle"/></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${isAuthenticated?then('', 'disabled')}" id="project-information-tab"
                           data-toggle="tab" href="#project-information" role="tab" aria-controls="project-information"
                           aria-selected="false"
                                ${isAuthenticated?then('', 'disabled')}>
                            <span><@fmt.message key="productConfigurator.projectinfo.projectinformation.tabtitle"/></span>
                        </a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="configuration-summary" role="tabpanel"
                         aria-labelledby="configuration-summary-tab">
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
                        <a href="#configuration-summary" data-section="project-information" class="js-accordion-mobile"
                           data-target="#configuration-summary">
                            <span><@fmt.message key="productConfigurator.projectinfo.configurationsummary.tabtitle"/></span>
                        </a>
                    </div>
                    <div class="collapse" data-toggle="collapse" id="configuration-summary"
                         data-parent="#project-section-container">
                        <div class="attribute-list project-summary-attribute-list-js">
                            <!-- Filled by Javascript -->
                        </div>
                    </div>
                </div>
                <div>
                    <div class="simple-collapse navigation-links-js">
                        <a href="#project-information" data-section="project-information"
                           data-target="#project-information"
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

    <div id="project-section-buttons" class="project-section-buttons hidden">
        <div class="row">
            <div class="col-lg-12">
                <button id="pdfReportBtn" class="btn btn-secondary btn-secondary--blue-border mr-3"
                        disabled><@fmt.message key="productConfigurator.pdfreport"/></button>
                <button id="saveProjectBtn"
                        class="btn btn-primary mt-10 mt-sm-0"><@fmt.message key="productConfigurator.projectinfo.saveprojectbtn"/></button>
            </div>
        </div>
    </div>
</div>

<#if hstRequestContext.servletRequest.getParameter("show")??>
    <#assign show=hstRequestContext.servletRequest.getParameter("show")/>
<#else>
    <#assign show=""/>
</#if>
<#if showModal?has_content && showModal == "true"  >
<#--    <#assign  show = hstRequestContext.servletRequest.getParameter("show")  && "${showModal}" == "true"  />-->
<#--    <#if show?has_content >-->
    <@detailsModalMacro id=("detailsModalMacro" + product.getNode().getId()?long?c + "_header")
    product=product boxTitle="productConfigurator.productDetails" buttonPresent = false
    statisticsSource="PCP GENERAL" />
<#--    </#if>-->
<#else>
    <#assign  show ="" />
</#if>


<#if !isSeriesPage?? || isSeriesPage == false>
    <#if !isStandalonePage && (relatedProducts?size > 0) >
        <hr class="section-separator mt-5 mb-5"/>
        <h3 class="sub-title"><@fmt.message key="productConfigurator.relatedproducts.title"/></h3>
        <div class="row related-products-container">
            <!-- Slider main container -->
            <div class="col-lg-12 related-products-slider">
                <#list relatedProducts as relatedProduct>
                    <div class="related-product-item">
                        <div class="image"><@renderImage images=relatedProduct.getImages() type='MEDIUM' /></div>
                        <div class="name">
                            <div class="name-content">
                                ${relatedProduct.getName()}
                            </div>
                        </div>
                        <div class="configure">
                            <a href="${relatedProduct.getUrl()}"
                               class="show-product-configuration show-product-configurator-js iconed-text"
                               data-id="${relatedProduct.getId()?long?c}"
                               data-name="${relatedProduct.getName()}"
                               data-url="${relatedProduct.getUrl()}">
                                <span><@fmt.message key="productConfigurator.relatedproducts.item.linktext"/></span><i
                                        class="icon-arrow-right icon-arrow-right-js"></i>
                            </a>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
        <script>
            $(function () {
                $('.related-product-item .name-content').each(function (index, element) {
                    $clamp(element, {clamp: 3});
                });
            });
        </script>
    </#if>
</#if>

<#if !isStandalonePage && (sparesAccessories?size > 0) >
    <hr class="section-separator mt-5 mb-5"/>
    <h3 class="sub-title"><@fmt.message key="productConfigurator.sparesaccesories" /></h3>
    <div class="row col-lg-12">
        <@spareAccessoryList componentId=sparesAccessoriesComponentId sparesAccessories=sparesAccessories />
    </div>
    <div class="row col-lg-12">
        <@selectionBasketFavouritesBar sparesAccessoriesComponentId=sparesAccessoriesComponentId
        statisticsSource="SPARE PARTS AND ACCESSORIES" />
    </div>
</#if>

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
<#if  showRodEndConfiguration  >
    <#assign showRodEndConfigurationAssign = "true" />
</#if>
<input type="hidden" id="showRodEndConfiguration" value="${showRodEndConfigurationAssign}"/>
<#assign isAccessoryDetailsModalEnabledAssign = "" />
<#if  ( isAccessoryDetailsModalEnabled?? && isAccessoryDetailsModalEnabled == true)  >
    <#assign isAccessoryDetailsModalEnabledAssign = "true" />
<#else>
    <#assign isAccessoryDetailsModalEnabledAssign = "false" />
</#if>
<input type="hidden" id="isAccessoryDetailsModalEnabled" value="${isAccessoryDetailsModalEnabledAssign}"/>

<#if showRodEndConfiguration >
    <h3 id="rodEndOptionsSubtitle"
        class="sub-title hidden"><@fmt.message key="productConfigurator.rodEndOptions" /></h3>
    <div id="rodEndOptionsSwitch" class="form-group hidden">
        <label class="switch">
            <input id="rodEndOptionsSwitchToggle" type="checkbox" class="primary" disabled>
            <span class="slider round"></span>
        </label>
        <label for="rodEndOptionsSwitchToggle" class="switch-label">
            <@fmt.message key="productConfigurator.cylinderRodEndOrderOptions" />
        </label>
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
