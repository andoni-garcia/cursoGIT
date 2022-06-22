<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="favouritesLink" siteMapItemRefId="favourites"/>
<@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>
<@hst.actionURL var="actionURL"/>
<@hst.link var="search" siteMapItemRefId="search"/>

<@hst.setBundle basename="eshop"/>

<@fmt.message key="favourites.noSelectedTitle" var="labelNoSelectedTitle"/>
<@fmt.message key="favourites.deleteTitle" var="labelDeleteTitle"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.create" var="labelCreate"/>
<@fmt.message key="eshop.close" var="labelClose"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.import" var="labelImport"/>

<@fmt.message key="favourites.exportStart" var="labelExportStart"/>
<@fmt.message key="favourites.deleteFolderTitle" var="labelDeleteFolderTitle"/>
<@fmt.message key="favourites.deleteFolderMssg" var="labelDeleteFolderMssg"/>
<@fmt.message key="favourites.deletedFolderMsg" var="labelDeletedFolderMsg"/>
<@fmt.message key="favourites.addedFolderMsg" var="labelAddedFolderMsg"/>
<@fmt.message key="favourites.updatedFolderMsg" var="labelUpdatedFolderMsg"/>
<@fmt.message key="eshop.orderByCustomerPartNumber" var="labelOrderByCustomerPartNumber"/>
<@fmt.message key="eshop.orderByPartNumber" var="labelOrderByPartNumber"/>
<@fmt.message key="eshop.orderByDescription" var="labelOrderByDescription"/>
<@fmt.message key="eshop.moreInfoNotAvailable" var="labelMoreInfoNotAvailable"/>

<@fmt.message key="eshop.mssg.datatableInfoMessage" var="labelMssgDatatableInfoMessage"/>
<@fmt.message key="eshop.mssg.recordsPerPage" var="labelMssgRecordsPerPage"/>
<@fmt.message key="eshop.mssg.noProductsAvailable" var="labelMssgNoProductsAvailable"/>
<@fmt.message key="eshop.mssg.orderByVarLbl" var="labelMssgOrderByVarLbl"/>
<@fmt.message key="eshop.mssg.partNumberLbl" var="labelMssgPartnumberLbl"/>
<@fmt.message key="eshop.mssg.customerPartNumberLbl" var="labelMssgCustomerPartnumberLbl"/>
<@fmt.message key="eshop.mssg.productDescriptionLbl" var="labelMssgProductDescriptionLbl"/>
<@fmt.message key="eshop.mssg.descriptionLbl" var="labelMssgDescriptionLbl"/>
<@fmt.message key="eshop.mssg.mustSelectElement" var="labelMssgMustSelectElement"/>
<@fmt.message key="eshop.mssg.sureDeleteElements" var="labelMssgSureDeleteElements"/>
<@fmt.message key="eshop.mssg.oneOrMoreCanNotBeAdded" var="labelMssgOneOrMoreCanNotBeAdded"/>
<@fmt.message key="eshop.mssg.noneCanBeAdded" var="labelMssgNoneCanBeAdded"/>
<@fmt.message key="eshop.mssg.canNotExportExcel" var="labelMssgCanNotExportExcel"/>
<@fmt.message key="eshop.mssg.canNotExportExcelAllProducts" var="labelMssgCanNotExportExcelAllProducts"/>
<@fmt.message key="eshop.mssg.canNotCreatePDF" var="labelMssgCanNotCreatePDF"/>
<@fmt.message key="eshop.mssg.canNotCreatePDFAllProducts" var="labelMssgCanNotCreatePDFAllProducts"/>
<@fmt.message key="eshop.mssg.processCanTakeSeveralMinutes" var="labelMssgProcessCanTakeServeralMinutes"/>
<@fmt.message key="eshop.mssg.moreProductsThanPDFLimit" var="labelMssgMoreProductsThanPDFLimit"/>
<@fmt.message key="eshop.mssg.otherImportProcessLaunched" var="labelMssgOtherImportProcessLaunched"/>
<@fmt.message key="favourites.updateCustomerPartNumberError" var="labelFavouritesUpdateCustomerParnumberError"/>
<@fmt.message key="favourites.updateCustomerPartNumberSuccess" var="labelFavouritesUpdateCustomerPartnumberSuccess"/>
<@fmt.message key="favourites.errorEmptyExport" var="labelErrorEmptyExport"/>
<@fmt.message key="favourites.errorImport" var="labelErrorImportFavourites"/>
<@fmt.message key="favourites.errorImportFormat" var="labelInvalidFormatFile"/>
<@fmt.message key="favourites.successImport" var="labelSuccessImport"/>


</#compress>
<main class="smc-main-container eshop">
        <div class="container">
            <div class="mb-30">
                <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
            </div>
            <div class="cmseditlink">
            </div>
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="favourites.title"/></h2>
            <#if actionURL?contains("/favourites/all")>
                <h1 class="heading-02 heading-main"><@fmt.message key="eshop.allProducts"/></h1>
            <#else>
                <h1 class="heading-02 heading-main">${currentFolderName}</h1>
            </#if>

        </div>
        <br>
        <div class="container">
            <div class="row">
                <!-- Tree folders -->
                <div id="fv-favourites-folders-tree" class="col-lg-4 ">
                    <div class="global-overlay" style="display: none" data-bind="visible: processingRedirect()"></div>
                    <!-- ko if: showTree() == false -->
                    <div>
                    <#if folders??>
                        <div class="treeview-block p-0">
                            <ul class="treeview nopadding">

                            <#list folders as folder>
                                <li>
                                    <i class="fas fa-folder"></i>
                                    <a href="${favouritesLink}/${folder.folderId?c}"><#if !folder.defaultFolder>${folder.name}<#else><@fmt.message key="favourites.defaultFolder"/></#if></a>
                                    <span data-refresh="${folder.folderId?c}">${folder.numFavouriteElements?c}</span>
                                    <#if !folder.defaultFolder>
                                        <a class="a-ko" data-bind="click: $root.updateFolderName.bind($data,${folder.folderId?c})"><i class="option fas fa-edit"></i></a>
                                        <a class="a-ko" data-bind="click: $root.deleteFolder.bind($data,${folder.folderId?c})"><i class="option fas fa-trash"></i></a>
                                    </#if>
                                </li>
                                <#if folder.childrenFolders?size!=0>
                                    <ul>
                                    <#list folder.childrenFolders as childFolder>
                                        <li>
                                            <i class="fas fa-folder"></i>
                                            <a href="${favouritesLink}/${childFolder.folderId?c}"> ${childFolder.name}</a>
                                            <span data-refresh="${childFolder.folderId?c}">${childFolder.numFavouriteElements?c}</span>
                                            <a class="a-ko" data-bind="click: $root.updateFolderName.bind($data,${childFolder.folderId?c})"><i class="option fas fa-edit"></i></a>
                                            <a class="a-ko" data-bind="click: $root.deleteFolder.bind($data,${childFolder.folderId?c})"><i class="option fas fa-trash"></i></a>
                                        </li>
                                    </#list>
                                    </ul></#if>
                            </#list>
                    </#if>
                            <div class="mb-4 mt-4">
                                <a class="a-ko heading-09 mb-4" data-bind="click: createFolderTree.bind($data)"><i class="fas fa-plus"></i> <@fmt.message key="favourites.createFolder"/></a>
                            </div>
                            <div class="form-group">
                                <a href="${favouritesLink}/all" class="eshop btn btn-outline-primary"><@fmt.message key="eshop.showAllProduct"/></a>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                    <!-- ko if: showTree() == true -->
                    <div>
                        <div style="display: none" data-bind="visible: showTree()" class="treeview-block p-0">
                            <ul class="treeview nopadding">
                            <!-- ko foreach: folders() -->
                            <li>
                                <i class="fas fa-folder"></i>
                                <a data-bind="attr: {href: '${favouritesLink}/' + folderId}, text: name"></a>
                                <span data-bind="attr: {'data-refresh': folderId}, text: numFavouriteElements()"></span>
                                <!-- ko if: defaultFolder == false -->
                                    <a class="a-ko" data-bind="click: $root.updateFolderName.bind($data, folderId)"><i class="option fas fa-edit"></i></a>
                                    <a class="a-ko" data-bind="click: $root.deleteFolder.bind($data, folderId)"><i class="option fas fa-trash"></i></a>
                                <!-- /ko -->
                            </li>
                                <!-- ko if: childrenFolders().length > 0 -->
                                <ul>
                                    <!-- ko foreach: childrenFolders() -->
                                    <li>
                                        <i class="fas fa-folder"></i>
                                        <a data-bind="attr: {href: '${favouritesLink}/' + folderId}, text: name"></a>
                                        <span data-bind="attr: {'data-refresh': folderId}, text: numFavouriteElements()"></span>
                                        <a class="a-ko" data-bind="click: $root.updateFolderName.bind($data, folderId)"><i class="option fas fa-edit"></i></a>
                                        <a class="a-ko" data-bind="click: $root.deleteFolder.bind($data, folderId)"><i class="option fas fa-trash"></i></a>
                                    </li>
                                    <!-- /ko -->
                                </ul>
                                <!-- /ko -->
                            <!-- /ko -->
                            </ul>

                            <div class="mb-4">
                                <a class="a-ko heading-09 mb-4" data-bind="click: createFolderTree.bind($data)"><i class="fas fa-plus"></i> <@fmt.message key="favourites.createFolder"/></a>
                            </div>
                            <div class="form-group">
                                <a href="${favouritesLink}/all" class="eshop btn btn-outline-primary">Show All product</a>
                            </div>

                        </div>
                    </div>
                    <!--/ko -->

                    <!-- modal for tree management -->
                    <div class="modal fade" id="modal-tree-folders" role="dialog">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title"><@fmt.message key="favourites.createFolder"/></h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-2">
                                        <div class="row">
                                            <div class="col-6">
                                                <label><@fmt.message key="favourites.folder"/></label>
                                                <div class="dropdown smc-select">
                                                    <select data-bind="disable: disableFolderSelector(), value: $root.treeSelectedFolderId">
                                                        <option value=""><@fmt.message key="favourites.selector.root"/></option>
                                                        <!-- ko foreach: folders -->
                                                        <!-- ko if: !$root.updatingFolder() || $root.selectedFolderId() != folderId -->
                                                        <option data-bind="text: name, value: folderId"></option>
                                                        <!-- /ko -->
                                                        <!-- /ko -->
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <label><@fmt.message key="favourites.nameForFolder"/></label>
                                                <input class="form-control" type="text" data-bind="value: $root.treeModalFolderName, valueUpdate: 'keyup'"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" id="btn-return" class="btn btn-secondary" data-dismiss="modal"><@fmt.message key="eshop.cancel"/></button>
                                    <button type="button" id="btn-submit" class="btn btn-primary" data-dismiss="modal"><@fmt.message key="favourites.create.btn"/></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Foder products -->
                <div id="fv-favourites" class="col-lg-8">
                    <#include "./favourites-import.ftl">
                    <!-- Favourites filters -->
                    <form onsubmit="return false;">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <input class="form-control w-100" data-bind="value: filterSearch, valueUpdate:'keyup', enterkey: filterFavourites" id="inputSearch" placeholder="<@fmt.message key='eshop.searchPlaceholder'/>" type="text">
                            </div>
                            <div class="form-group col-md-3">
                                <button type="button" class="btn btn-primary w-100" data-bind="click: filterFavourites"><@fmt.message key="eshop.search"/></button>
                            </div>
                            <div class="form-group col-md-3">
                                <button type="button" class="btn btn-primary w-100" data-bind="click: resetAndSearch"><@fmt.message key="eshop.showAll"/></button>
                            </div>
                        </div>
                    </form>
                    <div class="form-row">
                        <div class="col-12">
                            <ul class="eshop pagination">
                                <li class="page-item disabled"><a class="page-link" href=" #"><@fmt.message key="eshop.display"/></a></li>
                                <li class="page-item"><a class="a-ko page-link active" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[0]), css: {active: datatable.iDisplayLength().value == 10}" style="border: none !important; border-radius: 5px;">10</a></li>
                                <li class="page-item"><a class="a-ko page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[1]), css: {active: datatable.iDisplayLength().value == 20}">20</a></li>
                                <li class="page-item"><a class="a-ko page-link" data-bind="click: datatable.selectLength.bind($data, datatable.recordsPerPageSelector()[2]), css: {active: datatable.iDisplayLength().value == 50}">50</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="row align-self-end">
                        <span class="col-md-5 align-self-end"><ik-datatable-showing params="viewModel : favouritesViewModel"></ik-datatable-showing></span>

                        <div class="col-md-7">
                            <div class="dropdown smc-select">
                                <select id="my-basket-products-order" data-bind="options: orderTypes, optionsText: 'text', optionsValue: 'order',  value: selectedOrder, event:{ change: filterFavourites.bind($data)}">
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- Favourites product box -->

                    <smc-spinner-inside-element params="loading: datatable.loading"></smc-spinner-inside-element>

                    <!-- ko foreach: elements    -->
                    <div class="row m-0 my-2 favourite-product-box border border-secondary eshop-box-rounded" data-bind="attr: {id: favouriteId}" id="favouriteId">
                        <div class="col-12 nopadding">
                            <div class="row m-3">
                                <div class="col-12 nopadding">
                                    <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                                    <a class="text-muted partnumber-href" data-bind="text: personalizedPartnumber() != null ? personalizedPartnumber() : partnumberCode, click : window.GlobalPartnumberInfo.getPartNumberUrl.bind($data, partnumberCode(), personalizedType())" target="_blank"></a>
                                    <!-- ko if: info() -->
                                        <span class="text-dark partnumber-name" data-bind="text: info().name"></span>
                                    <!-- /ko -->

                                </div>
                            </div>
                            <div class="row m-3 product-selection-item">
                                <div class="col-2">
                                <!-- ko if: info() -->
                                        <img data-bind="attr: {src: info().mediumImage}">
                                <!-- /ko -->
                                <!-- ko if: !info()  -->
                                        <img src="${noImage}">
                                    <!-- /ko -->

                                </div>
                                <div class="col-xl-10 align-self-end">
                                        <#if currentFolder?matches("all", "i")>
                                        <div class="row">
                                            <ol class="folder-breadcrumbs p-0 pr-md-3 pl-xl-3">
                                            <i class="fas fa-folder"></i>
                                            <!-- ko if: $data.folder !== null && $data.folder.parent !== null -->
                                                <li><a data-bind="attr: {href: '${favouritesLink}/' + $data.folder.parent.folderId}, text: $data.folder.parent.name"></a></li>
                                            <!-- /ko -->
                                            <!-- ko if: $data.folder !== null -->
                                            <li class="selected"><a data-bind="attr: {href: '${favouritesLink}/' + $data.folder.folderId}, text: $data.folder.name"></a></li>
                                            <!-- /ko -->
                                            </ol>
                                        </div>
                                        </#if>
                                    <div class="row">
                                        <div class="col-md-5 p-0 pr-md-3 pl-xl-3">
                                            <!-- CustPartNumber control only with light users -->
                                        <@security.authorize access="hasRole('light_user')" var="isLightUser"/>
                                        <#if isLightUser>
                                            <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                                            <input class="form-control w-100" data-bind="value: $data.customerPartNumber, event: { blur: $parent.updateCustomerPartNumber.bind($data, $data)}">
                                        </#if>
                                        <#if !isLightUser>
                                            <!-- ko if: $data.customerPartNumber && $data.customerPartNumber().trim().length > 0 -->
                                            <span class="text-dark heading-09"> <@fmt.message key="eshop.customerPartNumber"/>: </span>
                                            <div class=" w-100" data-bind="text: $data.customerPartNumber" ></div>
                                            <!-- /ko -->
                                        </#if>
                                        </div>
                                        <div class="col-md-7 p-0">
                                            <div class="row w-100 m-0">
                                                <div class="col-4 align-self-end text-left p-0">
                                                    <span class="text-dark heading-09">  <@fmt.message key="eshop.quantity"/>: </span>
                                                    <input type="number" data-bind="value: $data.quantity" max="999" class="form-control" value="1">
                                                </div>
                                                <div class="col-8 align-self-end text-right pr-0">
                                                    <button type="button" data-bind="click: $parent.addToBasket.bind($data, $data, 'FAVOURITES')" class="btn btn-primary w-100"><@fmt.message key="eshop.addToBasket"/></button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12 eshop-option-tabs align-self-end  p-0 pr-md-3 pl-xl-3">
                                            <ul>
                                                <!-- ko if: $data.personalizedType() != 'VC' -->
                                                <li class="heading-09 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-toggle="collapse" data-bind="attr: {href: '#details' + $index()}, click: $parent.getDetails.bind($data, $data)"><@fmt.message key="eshop.showDetails"/></a></li>
                                                <!-- /ko -->
                                                <!-- ko if: $data.personalizedType() == 'VC' || $data.productId -->
                                                <li class="heading-09 more-info-tab">
                                                    <a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partnumberCode(), $index())">
                                                        <@fmt.message key="eshop.moreInfo"/>
                                                    </a>
                                                    <div class="spinner-inside more-info-tab-item ko-hide" data-bind="attr: {id: 'spinner' + $index()}">
                                                        <div class="bounce"></div>
                                                        <div class="bounce1"></div>
                                                        <div class="bounce2"></div>
                                                    </div>
                                                    <div class="collapse more-info-tab-item" data-bind="attr: {id: 'moreInfo' + $index()}"></div>
                                                </li>
                                                <!-- /ko -->
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="eshop-tab-line" style=""></div>
                            <div class="eshop-tabs">
                                <section class="container collapse more-info-mobile" data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>
                                <section class="container collapse" data-bind="attr: {id: 'details' + $index()}">
                                    <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                                        <div class="simple-collapse__bodyInner">
                                            <div class="row">
                                                <smc-spinner-inside-element params="loading: !$data.status() || $data.status() === 'UPDATING'"></smc-spinner-inside-element>
                                            <!-- ko if: $data.status() === 'ERROR' -->
                                            <div class="row col-12">
                                                <div class="col-12">
                                                    <div class="alert alert-danger" role="alert">
                                                        <@fmt.message key="eshop.detailsErrorMssg"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /ko -->
                                            <!-- ko if: $data.details() != null -->
                                            <div class="col-12">
                                                <!-- ko foreach: details().detailsPart1 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: favouritesViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: favouritesViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->
                                                <!-- ko foreach: details().detailsPart2 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: favouritesViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: favouritesViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->
                                                </div>
                                            <!-- /ko -->
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                    <!-- /ko -->
                    <ik-datatable-empty params="viewModel : favouritesViewModel"></ik-datatable-empty>
                    <ik-datatable-pager params="viewModel : favouritesViewModel"></ik-datatable-pager>

                    <!-- Favourites options -->
                    <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                        <div class="row m-3 w-100">
                            <div class="col-12 nopadding">
                                <smc-select-all-check params="list: $root.elements, field: 'checked'"><#include "../components/selectall-check.ftl"/></smc-select-all-check>
                            </div>
                        </div>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: deleteFavourites"><i class="fas fa-trash"></i> <@fmt.message key="eshop.deleteProducts"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: $root.moveOrCopyProducts.bind($data, false)"><i class="fas fa-folder"></i> <@fmt.message key="eshop.moveProduct"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: $root.moveOrCopyProducts.bind($data, true)"><i class="fas fa-plus-square"></i> <@fmt.message key="eshop.copyProduct"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: addToBasketItems"><i class="fas fa-cart-plus"></i> <@fmt.message key="eshop.toBasket"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: importModal.bind($data)"><i class="fas fa-sign-in-alt"></i> <@fmt.message key="eshop.importFromFile"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: exportFavourites.bind($data, 'xls')"><i class="fas fa-file-excel"></i> <@fmt.message key="eshop.XLS"/></a>
                        <a class="a-ko col-md-4 mb-3 heading-09" data-bind="click: exportFavourites.bind($data, 'pdf')"><i class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDF"/></a>
                    </div>

                </div>
            </div>

        </div>
</main>

<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="favouritesServerListUrl" resourceId="GET"/>
<@hst.resourceURL var="favouritesDeleteUrl" resourceId="DELETE"/>
<@hst.resourceURL var="favouritesMoveUrl" resourceId="MOVE_FAVOURITES"/>
<@hst.resourceURL var="favouritesCopyUrl" resourceId="COPY_FAVOURITES"/>
<@hst.resourceURL var="favouritesGetDetails" resourceId="GET_DETAILS"/>
<@hst.resourceURL var="updateCustomerPartNumber" resourceId="UPDATE_CUSTOMER_PART_NUMBER"/>
<@hst.resourceURL var="exportFavouritesUrl" resourceId="EXPORT_FAVOURITES"/>
<@hst.resourceURL var="importFileUrl" resourceId="IMPORT_FAVOURITES"/>

<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;

    var favouritesServerListUrl;
	var favouritesDeleteUrl;
    var favouritesMoveUrl;
    var favouritesCopyUrl;
    var importFileUrl;
    var favouritesGetDetails;
    var updateCustomerPartNumber;

    var favouritesRelativePath;

	var permissions = {};

	var FAVOURITES_CONFIGURATION_VARIABLES = {};
	var FAVOURITES_MESSAGES = {};

	var token;
    var currentFolder;
	var listOfFolders;

	var favouritesViewModel;

    var noSelectedMssg = '${labelNoSelectedTitle?js_string}';
    var deleteTitle = '${labelDeleteTitle?js_string}';

    var cancelBtn = '${labelCancel?js_string}';
    var updateBtn = '${labelUpdate?js_string}';
    var createBtn = '${labelCreate?js_string}';
    var closeBtn = '${labelClose?js_string}';
    var acceptBtn = '${labelAccept?js_string}';
    var importBtn = '${labelImport?js_string}';

    var deleteFolderTitle = '${labelDeleteFolderTitle?js_string}';
    var deleteFolderMssg = '${labelDeleteFolderMssg?js_string}';
    var deletedFolderMsg = '${labelDeletedFolderMsg?js_string}';
    var addedFolderMsg = '${labelAddedFolderMsg?js_string}';
    var updateFolderMsg = '${labelUpdatedFolderMsg?js_string}';
    var errorEmptyExport =  '${labelErrorEmptyExport?js_string}';

    var orderByCustomerPartNumber = '${labelOrderByCustomerPartNumber?js_string}';
    var orderByPartNumber = '${labelOrderByPartNumber?js_string}';
    var orderByDescription = '${labelOrderByDescription?js_string}';
    var moreInfoNotAvailableMssg = '${labelMoreInfoNotAvailable?js_string}';
    var exportFavouritesUrl = '${exportFavouritesUrl}';

</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.withDatatable.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.datatables.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.checkbox.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/FavouritesViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/FavouritesRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script type="text/javascript">

    (function($){
		FAVOURITES_CONFIGURATION_VARIABLES['MODE'] = 'folder';
		FAVOURITES_CONFIGURATION_VARIABLES['FAVOURITES_URL'] = '${favouritesServerListUrl}';
	})(jQuery);

    (function(context, $){
        FAVOURITES_MESSAGES = {
            "datatableInfoMessage" : '${labelMssgDatatableInfoMessage?js_string}',
            "recordsPerPage" : '${labelMssgRecordsPerPage?js_string}',
            "noProductsAvailable" : '${labelMssgNoProductsAvailable?js_string}',
            "orderByVarLbl" : '${labelMssgOrderByVarLbl?js_string}',
            "partNumberLbl" : '${labelMssgPartnumberLbl?js_string}',
            "customerPartNumberLbl" : '${labelMssgCustomerPartnumberLbl?js_string}',
            "productDescriptionLbl" : '${labelMssgProductDescriptionLbl?js_string}',
            "descriptionLbl" : '${labelMssgDescriptionLbl?js_string}',
            "mustSelectElement" : '${labelMssgMustSelectElement?js_string}',
            "sureDeleteElements" : '${labelMssgSureDeleteElements?js_string}',
            "oneOrMoreCanNotBeAdded" : '${labelMssgOneOrMoreCanNotBeAdded?js_string}',
            "noneCanBeAdded" : '${labelMssgNoneCanBeAdded?js_string}',
            "canNotExportExcel" : '${labelMssgCanNotExportExcel?js_string}',
            "canNotExportExcelAllProducts" : '${labelMssgCanNotExportExcelAllProducts?js_string}',
            "canNotCreatePDF" : '${labelMssgCanNotCreatePDF?js_string}',
            "canNotCreatePDFAllProducts" : '${labelMssgCanNotCreatePDFAllProducts?js_string}',
            "processCanTakeSeveralMinutes" : '${labelMssgProcessCanTakeServeralMinutes?js_string}',
            "moreProductsThanPDFLimit" : '${labelMssgMoreProductsThanPDFLimit?js_string}',
            "otherImportProcessLaunched" : '${labelMssgOtherImportProcessLaunched?js_string}',
            "updateCustomerPartNumberError": '${labelFavouritesUpdateCustomerParnumberError?js_string}',
            "updateCustomerPartNumberSuccess": '${labelFavouritesUpdateCustomerPartnumberSuccess?js_string}',
            "invalidFormatFile": '${labelInvalidFormatFile?js_string}',
            "errorImportFavourites": '${labelErrorImportFavourites?js_string}',
            "exportStart": '${labelExportStart?js_string}',
            "successImport": '${labelSuccessImport?js_string}'
        };

	})(window, jQuery);

	$(document).ready(function() {
		renderUrl = "${componentRenderingURL}";
		resourceUrl = "${serveResourceURL}";
		refreshTechnicalInfo = "${updating}";
		actionUrl = "${actionURL}";

        token = '${_csrf.token}';
        currentFolder = '${currentFolder}';

        listOfFolders = [
            <#list folders as folder>
                <#outputformat "XML{HTML}"><#assign folderName>${folder.getName()}</#assign></#outputformat>
                {
                    name: "${folderName}",
                    folderId: parseFloat("${folder.getFolderId()?c}"),
                    childrens: [
                        <#list folder.getChildrenFolders() as children>
                        <#outputformat "XML{HTML}"><#assign childrenName>${children.getName()}</#assign></#outputformat>
                            {
                                name: "${childrenName}",
                                folderId: parseFloat("${children.getFolderId()?c}"),
                            },
                        </#list>
                    ]
                },
            </#list>
        ];

		//Knockout
		favouritesServerListUrl = '${favouritesServerListUrl}';
		favouritesDeleteUrl = '${favouritesDeleteUrl}';
        favouritesMoveUrl = '${favouritesMoveUrl}';
        favouritesCopyUrl = '${favouritesCopyUrl}';
        favouritesGetDetails = '${favouritesGetDetails}';
        updateCustomerPartNumber = '${updateCustomerPartNumber}';
        importFileUrl = '${importFileUrl}';

        favouritesRelativePath = '<@hst.link siteMapItemRefId="favourites"/>';

		ko.di.register(FAVOURITES_CONFIGURATION_VARIABLES,"FavouritesConfigurationVariables");
		ko.di.register(FAVOURITES_MESSAGES,"FavouritesMessages");
		ko.di.register(permissions,"Permissions");

		favouritesViewModel = new FavouritesViewModel();
        var favouritesDom = document.getElementById("fv-favourites");

        var favouritesFoldersTreeDom = document.getElementById("fv-favourites-folders-tree");
        ko.bindingHandlers.enterkey = {
        init: function (element, valueAccessor, allBindings, viewModel) {
            var callback = valueAccessor();
            $(element).keypress(function (event) {
                var keyCode = (event.which ? event.which : event.keyCode);
                if (keyCode === 13) {
                    callback.call(viewModel);
                    return false;
                }
                return true;
            });
        }
        };
        ko.applyBindings(favouritesViewModel, favouritesDom);
        ko.applyBindings(favouritesFoldersViewModel, favouritesFoldersTreeDom);
	});
</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/favourites/favourites-functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>