<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="ssiLink" siteMapItemRefId="ssi"/>
<@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@hst.link var="search" siteMapItemRefId="search"/>
<@hst.link var="projectBookLink" siteMapItemRefId="projectBook"/>
<@hst.link var="myProjectBooksUrl" siteMapItemRefId="myProjectBooks"/>


<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.orderByPartNumber" var="labelOrderByPartNumber"/>
<@fmt.message key="eshop.orderByDescription" var="labelOrderByDescription"/>
<@fmt.message key="eshop.orderByFamily" var="labelOrderByFamily"/>
<@fmt.message key="eshop.orderBySerie" var="labelOrderBySerie"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>

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
<@fmt.message key="projectBooks.errorUnsubscribeMssg" var="labelErrorUnsubscribeMssg"/>
<@fmt.message key="projectBooks.successUnsubscribeMssg" var="labelSuccessUnsubscribeMssg"/>
<@fmt.message key="projectBooks.unsubscribeTitle" var="labelUnsubscribeTitle"/>
<@fmt.message key="projectBooks.showAllProducts" var="labelShowAllProducts"/>
<@fmt.message key="projectBooks.showAdditionalProducts" var="labelShowAdditionalProducts"/>
<@fmt.message key="projectBooks.showPBProducts" var="labelShowPBProducts"/>
<@fmt.message key="eshop.all" var="labelAll"/>
<@fmt.message key="favourites.toFavouritesSuccess" var="labelToFavouritesSuccess"/>
<@fmt.message key="favourites.toFavouritesError" var="labelToFavouritesError"/>
</#compress>
 <main class="smc-main-container eshop" id="contenedor">
        <div class="container mb-30">
            <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
        </div>
        <div class="container">
            <#if ALREADY_SUBSCRIBED?has_content>
                <div class="alert alert-warning">
                    <@fmt.message key="projectBooks.alreadySubscribedMssg"/>
                </div>
            </#if>
            <div class="cmseditlink">
            </div>
            <h1 class="heading-02 heading-main">${projectBook.name}</h1>
        </div>
        <br>
        <div class="container">
                <!-- PB list -->
                <#if projectBook?has_content>
            <div class="row">
                <div class="col-lg-3 treeview-block">
                    <div class="group-border mb-5 ">
                        <div class="p-3 d-flex justify-content-center">
                            <#if projectBook.hasLogo>
                                <img src="${s3bucket}project-books/${projectBook.id}/logo.jpg" width="80" height="80">
                            </#if>
                            <#if projectBook.hasLogo2>
                                <img src="${s3bucket}project-books/${projectBook.id}/logo1.jpg" width="80" height="80">
                            </#if>
                        </div>
                        <#if projectBook.company?has_content>
                        <div class="pl-3 pr-3 pb-3">
                            <label class="mb-0"><@fmt.message key="projectBooks.company"/>:</label><br>
                            <label class="heading-09 mb-0 text-with-dots" title="${projectBook.company}">${projectBook.company}</label>
                        </div>
                        </#if>

                        <#if projectBook.versionNumber?has_content>
                        <div class="pl-3 pr-3 pb-3">
                            <label class="mb-0"><@fmt.message key="projectBooks.version"/>:</label><br>
                            <label class="heading-09 mb-0 text-with-dots" title="${projectBook.versionNumber}">${projectBook.versionNumber}</label>
                        </div>
                        </#if>

                        <#if projectBook.description?has_content>
                        <div class="p-3">
                            <label class="mb-0"><@fmt.message key="projectBooks.projectDescription"/>:</label><br>
                            <label class="heading-09 mb-0 text-with-dots" title="${projectBook.description}">${projectBook.description}</label>
                        </div>
                        </#if>

                        <#list projectBook.contacts as contact>
                        <div class="pl-3 pr-3 pb-3 overflow-break">
                            <label class="mb-0"><@fmt.message key="projectBooks.smcContact"/>:</label>
                            <br/>
                            <label class="heading-09 mb-0 text-with-dots" title="${contact.firstName} ${contact.lastName}">${contact.firstName} ${contact.lastName}</label>
                            <#if contact.jobTitle?? && contact.jobTitle??>
                            <div>
                                <label class="heading-09 text-small mb-0 text-with-dots"><i class="fas fa-briefcase"></i> ${contact.jobTitle}</label>
                            </div>
                            </#if>
                            <#if contact.email?? && contact.email??>
                            <div>
                                <a href="mailto:${contact.email}" title="${contact.email}"><label class="heading-09 text-small mb-0 text-with-dots"><i class="fas fa-envelope"></i> ${contact.email}</label></a>
                            </div>
                            </#if>
                            <#if contact.telephone??>
                            <div>
                                <a href="tel:${contact.telephone}" title="${contact.telephone}"><label class="heading-09 text-small mb-0"><i class="fas fa-phone-square"></i> ${contact.telephone}</label></a>
                            </div>
                            </#if>
                        </div>
                        </#list>
                        <#if projectBook.documents?has_content>
                        <div class="p-3 overflow-break">
                            <label class="mb-0"><@fmt.message key="projectBooks.relatedDocuments"/></label>
                            <#list projectBook.documents as document>
                            <div class="mt-2 text-small text-ellipsis" id="">
                                <a title="${document.name}" target="_blank" class="mb-3 pl-0 text-with-dots" href="${s3bucket}project-books/${projectBook.id}/${document.name}"><i class="fas fa-file-pdf"></i> ${document.name}</a>
                            </div>
                            </#list>
                        </div>
                        </#if>
                        <div class="p-3">
                            <button type="button" class="btn btn-danger w-100" data-bind="click: unsubscribe"><@fmt.message key="projectBooks.unsubscribe"/></button>
                        </div>
                    </div>
                    <#if otherProjectBooks?has_content>
                    <div class="p-0">
                        <span class="heading-04"><@fmt.message key="projectBooks.otherProjectBooks"/></span>
                        <#list otherProjectBooks as other>
                            <a class="border border-secondary eshop-box-rounded p-3 d-flex justify-content-center mt-3 mr-3 pb-column other-pb-ref" href="/projectbook?projectBook=${other.id}">
                                <#if other.hasLogo>
                                    <img src="${s3bucket}project-books/${other.id}/logo.jpg" class="other-pb-img">

                                <#else>
                                    <img src="${noImage}" width="80" height="80">
                                    ${other.name}
                                </#if>
                            </a>
                        </#list>

                    </div>
                    </#if>
                </div>
                <!-- PB head and products -->
                <div class="col-lg-9">
                    <div class="position-relative">
                    <smc-spinner-inside-element params="loading: datatable.loading() || exporting()"></smc-spinner-inside-element>

                    <!-- Header -->
                    <div class="row mb-3">
                        <div class="dropdown smc-select col-md-4 pr-0 mt-3">
                            <select id="pb-show-aditional"  data-bind="options: showTypes, optionsText: 'text', optionsValue: 'value', value: filterShowAditional"></select>
                        </div>
                        <div class="col-md-4 pr-0 mt-3">
                            <input class="form-control w-100" id="inputSearch" placeholder="<@fmt.message key="eshop.searchPlaceholder"/>" type="email" data-bind="value: searchTerm">
                        </div>
                        <div class="col-md-4 mt-3">
                            <button type="button" class="btn btn-primary w-100" data-bind="click: filterProducts"><@fmt.message key="eshop.search"/></button>
                        </div>

                        <div class="form-group col-md-4 pr-0 mt-3">
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle w-100" type="button" data-toggle="dropdown" data-bind="text: filterFamilies().name"><span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu w-100">
                                <!-- ko foreach: families    -->
                                    <li><a href="#" data-bind="text: name, click: $parent.getFamilies.bind($data, id, name)"></a></li>
                                <!-- /ko -->
                                </ul>
                            </div>
                        </div>

                        <div class="form-group col-md-4 pr-0 mt-3">
                            <div class="dropdown">
                                    <button class="btn btn-outline-secondary dropdown-toggle w-100" type="button" data-toggle="dropdown" data-bind="text: filterSubfamilies().name"><span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu w-100">
                                    <!-- ko foreach: subfamilies    -->
                                    <li><a href="#" data-bind="text: name, click: $parent.setSubfamilyFilter.bind($data, id, name)"></a></li>
                                    <!-- /ko -->
                                    </ul>
                                </div>
                        </div>
                        <div class="col-md-4 mt-3">
                            <button type="button" class="btn btn-primary w-100" data-bind="click: showAll"><@fmt.message key="eshop.showAll"/></button>
                        </div>
                    </div>

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
                    <div class="row align-bottom">
                        <span class="col-md-7 align-self-end"><ik-datatable-showing params="viewModel : projectBookViewModel"></ik-datatable-showing></span>

                        <div class="col-md-5">
                            <div class="dropdown smc-select">
                                <select id="pb-products-order" data-bind="options: projectBookOrderList, optionsText: 'text', optionsValue: 'order', value: selectedOrder, event:{ change: filterProducts.bind($data)}">
                                </select>
                            </div>
                        </div>
                    </div>
                    <!-- SSI product box -->
                    <!-- ko foreach: elements  -->

                        <div class="row m-0 my-2 favourite-product-box border border-secondary eshop-box-rounded" data-bind="attr: {id: favouriteId}" id="favouriteId">
                        <div class="col-12 nopadding">
                            <div class="row m-3">
                                <div class="col-12 nopadding">
                                    <!-- ko component: {name: 'ik-checkbox', params: {viewModel: $data, cssClass : 'ikSelectAll'}} --><!-- /ko -->
                                    <a class="text-muted partnumber-href" data-bind="text: partNumber, click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, partNumber())" target="_blank"></a>
                                    <!-- ko if: $data.technicalInfo() && $data.technicalInfo().name -->
                                    <span class="text-dark description" data-bind="text: $data.technicalInfo().name"></span>
                                    <!-- /ko -->
                                </div>
                            </div>
                            <div class="row m-3 product-selection-item">
                                <div class="col-2">
                                    <#-- *** See ProjectBookViewModel.js 'self.normalizeDatatable = function (obj)' *** -->
                                    <!-- ko if: $data.technicalInfo() && $data.technicalInfo().image -->
                                        <!-- ko if: $data.customImage -->
                                            <img data-bind="attr: {src: s3bucket + 'project-books/' + projectBookId + '/ref_docs/products/' + $data.technicalInfo().image}">
                                        <!-- /ko -->
                                        <!-- ko if: !$data.customImage -->
                                            <img data-bind="attr: {src: $data.technicalInfo().image}">
                                        <!-- /ko -->
                                    <!-- /ko -->
                                    <!-- ko if: !$data.technicalInfo() || !$data.technicalInfo().image -->
                                        <img src="${noImage}">
                                    <!-- /ko -->
                                </div>
                                <div class="col-xl-10 align-self-end">
                                    <div class="row">
                                        <div class="col-md-5 p-0 pr-md-3 pl-xl-3">
                                        <!-- ko if: $data.technicalInfo() && $data.technicalInfo().family && $data.technicalInfo().family.name -->
                                            <div class="text"> <@fmt.message key="ssi.family"/> </div>
                                            <strong class="text-dark description" data-bind="text: $data.technicalInfo().family.name"></strong>
                                            <!-- /ko -->
                                            <!-- ko if: $data.technicalInfo() && $data.technicalInfo().serie -->
                                            <div class="text"> <@fmt.message key="ssi.serie"/> </div>
                                            <strong class="text-dark description" data-bind="text: $data.technicalInfo().serie"></strong>
                                        <!-- /ko -->
                                        <!-- ko if: $data.customField1() -->
                                        <div class="text" data-bind="text: $root.customField1"></div>
                                        <strong class="text-dark description" data-bind="text: $data.customField1"></strong>
                                        <!-- /ko -->
                                        <!-- ko if: $data.customField2() -->
                                        <div class="text" data-bind="text: $root.customField2"></div>
                                        <strong class="text-dark description" data-bind="text: $data.customField2"></strong>
                                        <!-- /ko -->
                                        </div>
                                        <div class="col-md-7 p-0">
                                            <div class="row w-100 m-0">
                                                <div class="col-4 align-self-end text-left p-0">
                                            <#if isTechnicalUser || isAdvancedUser || isProfessionalUser >
                                                    <span class="text-dark heading-09"> <@fmt.message key="eshop.quantity"/> </span>
                                                    <input type="number" data-bind="value: $data.quantity" max="999" class="form-control" value="1">
                                            </#if>
                                                </div>
                                                <div class="col-8 align-self-end text-right pr-0">
                                                <#if isTechnicalUser || isAdvancedUser || isProfessionalUser >
                                                    <button type="button" data-bind="click: $parent.addToBasket.bind($data, $data)" class="btn btn-primary w-100"><@fmt.message key="eshop.addToBasket"/></button>
                                                <#else>
                                                    <button type="button" data-bind="click: $parent.addToBasket.bind($data, $data)" class="btn btn-primary w-100"><@fmt.message key="eshop.addToList"/></button>
                                                </#if>
                                                </div>

                                            </div>
                                        </div>
                                        <!-- ko if: $data.documents() && $data.documents().length > 0 -->
                                        <div class="pt-3 pl-xl-3">
                                            <label class="mb-1"><@fmt.message key="projectBooks.relatedDocuments"/></label>
                                            <!-- ko foreach: $data.documents()  -->
                                            <div class="text-small text-ellipsis " id="">
                                                <#-- <a class="pl-0 pl-xl-3 row" target="_blank" data-bind="attr: { href : s3bucket + 'project-books/' + projectBookId + '/ref_docs/' + ($parent.additional()?'additionals':'products')+'/'+ $data}"><i class="fas fa-file-pdf mr-2"></i><p data-bind="text: $data"></p></a> -->
                                                <a class="pl-0 pl-xl-3 row" target="_blank" data-bind="attr: { href : s3bucket + 'project-books/' + projectBookId + '/ref_docs/products/' + $data}"><i class="fas fa-file-pdf mr-2"></i><p data-bind="text: $data"></p></a>
                                            </div>
                                            <!-- /ko -->
                                        </div>
                                        <!-- /ko -->

                                    </div>
                                    <!-- ko if: $data.hasInformation() || $data.hasPersonalizedDetails -->
                                    <div class="row">
                                        <div class="col-12 eshop-option-tabs align-self-end  p-0 pr-md-3 pl-xl-3">
                                            <ul>
                                                <li class="heading-09 smc-tabs__head--active"><a class="eshop-nav-link collapsed" data-toggle="collapse" data-bind="attr: {href: '#details' + $index()}, click: $parent.getDetails.bind($data, $data)"><@fmt.message key="eshop.showDetails"/></a></li>
                                                <!-- ko if: $data.hasInformation() -->
                                                <li class="heading-09 more-info-tab">
                                                    <a class="collapsed" data-toggle="collapse" data-bind="attr: {href: '#moreInfo' + $index(), id: 'moreInfoText' + $index()},  click: $parent.getProductMoreInfo.bind($data, partNumber(), $index())">
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
                                    <!-- /ko -->
                                </div>
                            </div>
                            <div class="eshop-tab-line" style=""></div>
                            <div class="eshop-tabs">
                                <section class=" collapse more-info-mobile" data-bind="attr: {id: 'moreInfoMobile' + $index()}"></section>

                                <section class=" collapse" data-bind="attr: {id: 'details' + $index()}">
                                    <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                                        <div class="simple-collapse__bodyInner">
                                            <div class="row">
                                            <!-- ko if: !$data.status() || $data.status() === 'UPDATING' -->
                                                <div class="col-12">
                                                    <div class="spinner-inside">
                                                        <div class="bounce"></div>
                                                        <div class="bounce1"></div>
                                                        <div class="bounce2"></div>
                                                    </div>
                                                </div>
                                            <!-- /ko -->
                                            <!-- ko if: $data.details() != null -->
                                                <div class="col-12">
                                                <!-- ko foreach: details().detailsPart1 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: projectBookViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: projectBookViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->

                                                <!-- ko foreach: details().detailsPart2 -->
                                                    <div class="detail-row p-1">
                                                        <span class="text-muted" data-bind="text: projectBookViewModel.splitString($data,':', 0, true)"></span>
                                                        <span class="text-dark" data-bind="text: projectBookViewModel.splitString($data,':', 1, false)"></span>
                                                    </div>
                                                <!-- /ko -->
                                                </div>
                                            <!-- /ko -->
                                            <!-- ko if: $data.status() === 'ERROR' -->
                                            <div class="row col-12">
                                                <div class="alert alert-danger" role="alert">
                                                    <@fmt.message key="eshop.detailsErrorMssg"/>
                                                </div>
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

                    <ik-datatable-empty params="viewModel : projectBookViewModel"></ik-datatable-empty>
                    <ik-datatable-pager params="viewModel : projectBookViewModel"></ik-datatable-pager>

                    <!-- Favourites options -->
                    <div class="row m-0 my-5 basket-option-box border border-primary eshop-box-rounded">
                        <div class="row m-3 w-100">
                            <div class="col-12 nopadding">
                                <smc-select-all-check params="list: $root.elements, field: 'checked'"><#include "../components/selectall-check.ftl"/></smc-select-all-check>
                            </div>
                        </div>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: addToBasketItems"><i class="fas fa-cart-plus"></i> <@fmt.message key="eshop.toBasket"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: addToFavouritesSelecteds.bind($data)"><i class="fas fa-share"></i> <@fmt.message key="eshop.toFavourites"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: exportPB.bind($data, false, 'xlsx', false)" style="color: '#90a4ae'"><i class="fas fa-file-excel"></i> <@fmt.message key="eshop.XLS"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: exportPB.bind($data, true, 'xlsx', false)" style="color: '#90a4ae'"><i class="fas fa-file-excel"></i> <@fmt.message key="projectBooks.PBtoXLS"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: exportPB.bind($data, false, 'pdf', false)" style="color: '#90a4ae'"><i class="fas fa-file-pdf"></i> <@fmt.message key="eshop.createPDF"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: exportPB.bind($data, true, 'pdf', false)" style="color: '#90a4ae'"><i class="fas fa-file-pdf"></i> <@fmt.message key="projectBooks.PBtoPDF"/></a>
                        <a class="a-ko col-md-3 mb-3 heading-09" data-bind="click: exportPB.bind($data, true, 'pdf', true)" style="color: '#90a4ae'"><i class="fas fa-file-pdf"></i> <@fmt.message key="projectBooks.extendedPBtoPDF"/></a>
                    </div>

                    </div>

                </div>
            </div>
        </div>
        <#include "./projectbook-unsubscribe.ftl">
    </#if>
    </main>


<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="projectBookServerListUrl" resourceId="GET_PROJECT_BOOKS_PRODUCTS"/>
<@hst.resourceURL var="ssiFamiliesListUrl" resourceId="GET_FAMILIES"/>
<@hst.resourceURL var="projectBookUnsubscribe" resourceId="UNSUBSCRIBE_PROJECT_BOOK"/>
<@hst.resourceURL var="projectBookExportToXlsxUrl" resourceId="EXPORT_TO_XLS"/>


<@hst.headContribution category="htmlHead">
<script>

	var actionUrl;
	var renderUrl;
	var resourceUrl;
	var refreshTechnicalInfo;
    var s3bucket;

    var projectBookServerListUrl;
    var projectBookDetailsUrl;
    var projectBookUnsubscribe;
    var projectBookExportToXlsxUrl;

	var permissions = {};
    var projectBookId;
    var projectBookCustomField1;
    var projectBookCustomField2;
	var PB_CONFIGURATION_VARIABLES = {};
	var PB_MESSAGES = {};

	var token;

	var projectBookViewModel;

	var knockoutTemplates = '<@hst.webfile path="/freemarker/versia/js-menu/knockout/templates/"/>';


    var orderByPartNumber = '${labelOrderByPartNumber?js_string}';
    var orderByDescription = '${labelOrderByDescription?js_string}';
    var orderByFamily = '${labelOrderByFamily?js_string}';
    var orderBySerie = '${labelOrderBySerie?js_string}';

    var cancelBtn = '${labelCancel?js_string}';
    var updateBtn = '${labelUpdate?js_string}';
    var deleteBtn = '${labelDelete?js_string}';

    var myProjectBooksUrl;

</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/libs/underscore-min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/ssi-functions.js"/>" type="text/javascript"></script>
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
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/projectbook/ProjectBookViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/projectbook/ProjectBookRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/ssi/SsiRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
 <script type="text/javascript">

 (function($){
		PB_CONFIGURATION_VARIABLES['SSI_URL'] = '${ssiServerListUrl}';
	})(jQuery);

    (function(context, $){
        PB_MESSAGES = {
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
            "errorUnsubscribe": '${labelErrorUnsubscribeMssg?js_string}',
            "successUnsubscribe": '${labelSuccessUnsubscribeMssg?js_string}',
            "unsubscribeTitle": '${labelUnsubscribeTitle?js_string}',
            "showAllProducts": '${labelShowAllProducts?js_string}',
            "showAdditionalProducts": '${labelShowAdditionalProducts?js_string}',
            "showPBProducts":  '${labelShowPBProducts?js_string}',
            "all": '${labelAll}',
            "favouritesSuccess": '${labelToFavouritesSuccess?js_string}',
            "favouritesError": '${labelToFavouritesError?js_string}'

        };

	})(window, jQuery);

	$(document).ready(function() {
        var searchInput = document.getElementById("inputSearch");
		renderUrl = "${componentRenderingURL}";
		resourceUrl = "${serveResourceURL}";
		refreshTechnicalInfo = "${updating}";
		actionUrl = "${actionURL}";
        s3bucket = "${s3bucket}";

        token = '${_csrf.token}';
        projectBookId = '${projectBook.id}';
        projectBookCustomField1 = '${projectBook.customField1}';
        projectBookCustomField2 = '${projectBook.customField2}';
		//Knockout
		projectBookServerListUrl = '${projectBookServerListUrl}';
        projectBookDetailsUrl = '${projectBookDetailsUrl}';
        projectBookUnsubscribe = '${projectBookUnsubscribe}';
        projectBookExportToXlsxUrl = '${projectBookExportToXlsxUrl}';
        myProjectBooksUrl = '${myProjectBooksUrl}';

		ko.di.register(PB_CONFIGURATION_VARIABLES,"ProjectBookConfigurationVariables");

		ko.di.register(PB_MESSAGES,"ProjectBookMessages");

		ko.di.register(permissions,"Permissions");

		projectBookViewModel = new ProjectBookViewModel();
        ko.applyBindings(projectBookViewModel, document.getElementById("contenedor"));


        searchInput.onkeyup = function(e){
            console.log('key')
            if(e.keyCode === 13){
                projectBookViewModel.filterProducts();
            }
        }
        $('.other-pb-ref').each(function(){
            var currentHref = $(this).attr('href');
            $(this).attr('href',smc.channelPrefix+currentHref);
        });

	});
</script>
</@hst.headContribution>
