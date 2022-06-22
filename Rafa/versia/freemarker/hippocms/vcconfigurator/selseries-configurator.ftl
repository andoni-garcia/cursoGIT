<#include "../../include/imports.ftl">
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>

<@hst.include ref="selseries-wizard-simple-special"/>
<@hst.link var="refSelseries" siteMapItemRefId="valveConfigurator"/>

<#include "../../digitalcatalog/catalog-macros.ftl">
<#include "../../digitalcatalog/product/product-toolbar-macro.ftl">
<@hst.setBundle basename="SearchPage,SearchBar,ProductToolbar,eshop,valveconfigurator,global"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authentication property="principal.showNetPrice" var="showNetPrice" />
<@security.authentication property="principal.showListPrice" var="showListPrice" />

<@fmt.message key="modal.contact.title" var="labelVcModalContactTitle"/>
<@fmt.message key="modal.contact.confirm" var="labelVcModalContactConfirm"/>
<@fmt.message key="modal.contact.cancel" var="labelVcModalContactCancel"/>
<@fmt.message key="modal.contact.noItems" var="labelVcModalContactNoItems"/>

<@fmt.message key="modal.saveConfirmation.title" var="labelmodalSaveConfirmationTitle"/>
<@fmt.message key="modal.saveConfirmation.message" var="labelmodalSaveConfirmationMessage"/>
<@fmt.message key="modal.saveConfirmation.close" var="labelmodalSaveConfirmationClose"/>

<@fmt.message key="modal.errorCopying.title" var="labelModalErrorCopyingTitle"/>
<@fmt.message key="modal.errorCopying.station" var="labelModalErrorCopyingStation"/>
<@fmt.message key="modal.errorCopying.message" var="labelModalErrorCopyingMessage"/>

<@fmt.message key="savedContactSuccess" var="labelSavedContactSuccess"/>
<@fmt.message key="savedContactError" var="labelSavedContactError"/>

<@fmt.message key="errorSendingVcToBasket" var="labelErrorSendingVcToBasket"/>
<@fmt.message key="startSendingVcToBasket" var="labelStartSendingVcToBasket"/>
<@fmt.message key="startSendingVcToFavourites" var="labelStartSendingVcToFavourites"/>


<@fmt.message key="simpleSpecial.alias.mandatoryField" var="labelAliasMandatoryField"/>
<@fmt.message key="simpleSpecial.alias.successMessage" var="labelAliasSuccessMessage"/>
<@fmt.message key="simpleSpecial.alias.errorMessage" var="labelAliasErrorMessage"/>

<@fmt.message key="global.generalError" var="generalError"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.no" var="labelNo"/>

<div class="container">
	<div>
		<@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
	</div>
	<#--  SYConfigurationJSON se obtiene en el doBeforeRender del SelseriesConfiguratorComponent -->
	<p id ="mensajeJSON">
	<#assign jsonConfiguration = SYConfigurationJSON?eval>
	</p>
	${jsonConfiguration}
		<#if SYConfigurationJSON??>
			<#-- ${SYConfigurationJSON} -->
		<#else>
			<@fmt.message key="error.cargaJson.comprobarServicios"/>
			No se ha podido cargar el Json. Comprobar que los servicios estan en ejecucion.
		</#if>

	<main id="valve-configurator-container" class="smc-main-container valve-configurator">
		<smc-spinner-inside-element params="loading: sendingProduct"></smc-spinner-inside-element>
		 <smc-spinner-inside-element params="loading: creatingPdf"></smc-spinner-inside-element>
        <smc-modal-customer-contact params="titleLabel: titleLabel,confirmLabel:confirmLabel,cancelLabel:cancelLabel,noItemsLabel:noItemsLabel ,showModal: showModalContact, selectedDataParam: selectedContact"></smc-modal-customer-contact>
        <div>
            <div class="row">
                <div class="col-lg-9 col-md-8">
                    <div class="cmseditlink">
                    </div>
                    <h2 class="heading-08 color-blue mt-20"><@fmt.message key="valveConfigurator"/></h2>
                    <#if SYSerie=="SV">
						<h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesSV"/></h1>
                    <#elseif SYSerie=="VQC">
						<h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesNVQC"/></h1>
					<#elseif SYSerie=="JSY">
						<h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesJSY"/></h1>
                    <#else>
						<h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesSY"/></h1>
                    </#if>
                    <h4>${SYInitialDescription}</h4>
                    <#--  meassures_div -->
					<div id="solenoids_div">
						<div class="row">
							<div id="freeSolenoids" class="col-sm-12">
								<label class="${negativeRemaining?then('ik_red', '')}">
									${SYInitialSolenoid}
								</label>
							</div>
						</div>
					</div>
					<div id="meassures_div"></div>
					<p id="mensajeJSON">
                    </p>

                    <!-- GRAPHICAL EDITOR -->
                    <#-- graphical_editor_content_div -->
						<#include "graphicaleditor/graphical-editor-grid.ftl">
                    <!-- FIN GRAPHICAL EDITOR -->
                </div>
                <div class="col-lg-3 col-md-4">
					<#include "selseries-back-modal.ftl">
                    <div  id="back-btn">
						<span class="btn btn-primary noactive mt-4 mb-4 w-100"><@fmt.message key="btn.backToSelection"/></span>
                    </div>
                    <div id="valveConfigurator-options">
						<@productToolbar product=node boxTitle="documentation" showDataSheet=false showVideo=false renderingMode="simple" partNumber=partNumber
						inValveConfiguratorPage=true statisticsSource="VALVE CONFIGURATOR" />
                    </div>
                    <div class="category-tile mt-3">
                        <div class="category-tile__text text-01">
                            <div class="category-tile__text__inner">
                                <ul class="vc empty-list">
                                    <li> <a id="saveConfiguration" class="a-ko iconed-text"><@fmt.message key="saveConfiguration"/><i class="fas fa-save"></i></a> </li>
                                    <li> <a class="a-ko iconed-text" data-bind="visible: !isOpenedGroup(), click: openClosedConfiguration.bind()" style="display:none"><@fmt.message key="openClosedConfiguration"/><i class="fas fa-save"></i></a> </li>
                                    <#if vcEshopConnection>
									<#if !isInternalUser>
									<li> <a id="sendVcToBasket" data-bind="click: sendVcBasket.bind($data)" class="a-ko iconed-text"><@fmt.message key="sendVcToBasket"/><i class="fas fa-cart-plus"></i></a> </li>
									</#if>
									<li> <a id="sendVcToFavourites" data-bind="click: sendVcFavourites.bind($data)" class="a-ko iconed-text"><@fmt.message key="sendVcToFavourites"/><i class="fas fa-share"></i></a> </li>
									</#if>
									<#if bomPermission>
										<li> <a  data-configuration="invalid" id="exportBom" class="a-ko iconed-text"><@fmt.message key="exportBOM"/><i class="far fa-file-excel"></i></a> </li>
									</#if>
									<#if isInternalUser>
										<li> <a data-configuration="invalid" id="exportSpecifications" class="a-ko iconed-text"><@fmt.message key="exportJP"/><i class="far fa-file-excel"></i></a> </li>
									</#if>
									<#if addAlias>
										<li data-bind="visible: simpleSpecialCode() != null && simpleSpecialCode().simpleSpecialCode() != null" style="display:none"> <a id="addAliasOption" class="a-ko iconed-text"><@fmt.message key="simpleSpecial.addAlias"/><i class="fas fa fa-font"></i></a> </li>
									</#if>
										<li> <a  data-configuration="invalid" id="exportValvePDF" class="a-ko iconed-text"><@fmt.message key="createPDF"/><i class="far fa-file-pdf"></i></a> </li>
                                </ul>
                            </div>
                            <div class=""></div>
                        </div>
                    </div>

					<#if vcEshopConnection && !isInternalUser>
					<div class="category-tile mt-3 category-tile--noExpand">
                        <div class="category-tile__text text-01">
							<span class="btn btn-primary noactive mt-1 mb-1 w-100" data-bind="click: loadExternalPriceAndDelivery.bind($data), css: { disabled: !enabledSimpleSpecial() }"><@fmt.message key="external.checkPriceAndDelivery"/></span>
                            <div class="category-tile__text__inner mt-1" id="valve_external_pdSummary" style="display:none;">
								<smc-spinner-inside-element params="loading: loadingBomItemsList()"></smc-spinner-inside-element>
                                <ul class="vc empty-list">
                                    <li><span><@fmt.message key="vc.bom.leadTime.notInternal"/>:</span>&nbsp;<span class="valve external_price_and_delivery" data-bind="text: totalLeadTime"></li>
                                    <#if isInternalUser || (isProfessionalUser && showListPrice)>
									<li><span><@fmt.message key="vc.bom.listPrice"/>:</span>&nbsp;<span class="valve external_price_and_delivery" data-bind="text: totalListPrice"></li>
									</#if>
									<#if isInternalUser || (isProfessionalUser && showNetPrice)>
									<li><span><@fmt.message key="vc.bom.netPrice"/>:</span>&nbsp;<span class="valve external_price_and_delivery" data-bind="text: totalNetPrice"></li>
									</#if>
                                </ul>
                            </div>
                        </div>
                    </div>
					</#if>
                </div>
            </div>
        </div>

        <div>
            <div class="row">
                <div class="col-lg-9 col-md-8">

                </div>
            </div>


            <!-- GRAPHICAL EDITOR TOOLS -->

            <div id="graphicalToolsContainer" class="row info-box p-3">
                <div class="col-sm-3">
                    <ul class="empty-list">
                        <#if !(vcMeassures??) || !vcMeassures >
	                        <li class="">
	                            <a class="a-ko">
									<span id="meassures" style="color: gray;text-decoration: none;cursor:auto;" data-title="<@fmt.message key="gt.meassures"/>"><i class="fas fa-tachometer-alt"></i><@fmt.message key="gt.meassures"/></span>
								</a>
	                        </li>
                        <#else>
	                        <#if vcMeassures?? && vcMeassures >
		                        <li class="">
		                            <a class="a-ko">
										<span id="meassures" class="enabled" data-title="<@fmt.message key="gt.meassures"/>"><i class="fas fa-tachometer-alt"></i><@fmt.message key="gt.meassures"/></span>
									</a>
		                        </li>
	                        </#if>
                        </#if>
                        <li class="">
                            <a class="a-ko">
								<span id="brush" class="disabled" data-title="<@fmt.message key="gt.copyPaste"/>"><i class="fas fa-copy"></i> <@fmt.message key="gt.copyPaste"/></span>
							</a>
                        </li>

                    </ul>

                </div>

                <div class="col-sm-3">
                    <ul class="empty-list">

                        <li class="">
                            <a class="a-ko">
                                <span id="moveLeft" class="enabled" data-title="<@fmt.message key="gt.moveLeft"/>"><i class="fas fa-caret-left"></i> <@fmt.message key="gt.moveLeft"/></span> <#-- funcionalidad implementada -->
                            </a>
                        </li>
                        <li class="">
							<a class="a-ko">
								<span id="moveRight" class="disabled" data-title="<@fmt.message key="gt.moveRight"/>"><i class="fas fa-caret-right"></i> <@fmt.message key="gt.moveRight"/></span>
                            </a>
                        </li>

                    </ul>
                </div>

                <div class="col-sm-3">
                    <ul class="empty-list">

                        <li class="">
                            <a class="a-ko">
                                <span id="addStation" class="disabled" data-title="<@fmt.message key="gt.addStation"/>"><i class="fas fa-plus"></i> <@fmt.message key="gt.addStation"/></span>
                            </a>
                        </li>
                        <li class="">
                            <a class="a-ko">
								<span id="deleteStation" class="disabled" data-title="<@fmt.message key="gt.deleteStation"/>"><i class="fa fa-trash" aria-hidden="true"></i> <@fmt.message key="gt.deleteStation"/></span>
                            </a>
                        </li>

                    </ul>
                </div>

                <div class="col-sm-3">
                    <ul class="empty-list">

                        <li class="">

                            <a class="a-ko">
                                <span id="undoAction" class="disabled" data-title="<@fmt.message key="gt.undo"/>"><i class="fas fa-undo"></i> <@fmt.message key="gt.undo"/></span>
                            </a>
                        </li>
                        <li class="">
                            <a class="a-ko disabled">
                                <span id="redoAction" class="disabled" data-title="<@fmt.message key="gt.redo"/>"><i class="fas fa-redo"></i> <@fmt.message key="gt.redo"/></span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>


            <!-- FIN GRAPHICAL EDITOR TOOLS-->


            <div class="row">
                <div class="col" id="simpleSpecialRef" data-bind="visible: simpleSpecialCode() != null && simpleSpecialCode().simpleSpecialCode() != null" style="display:none">
                    <h3 class="simple-special-block">
                        <span data-bind="text: simpleSpecialCode().simpleSpecialCode()"></span>
                    </h3>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12 col-md-12">
					<div class="smc-tabs" id="vcTabs">
						<div class="smc-tabs__head">
							<div class="container">
								<ul>
									<li class="heading-0a smc-tabs__head--active" ><a href="#configuration" class="a-ko"><@fmt.message key="configuration"/></a></li>
									<li class="heading-0a"><a href="#summary" class="a-ko SY_tab_image_name" id="sy-summary"><@fmt.message key="summary"/></a></li>
									<#if createSimpleSpecialPermission ?? && createSimpleSpecialPermission && (!vcEshopConnection || (vcEshopConnection && isInternalUser)) >
										<li class="heading-0a"><a href="#simpleSpecial" class="a-ko" id="sy-simple-especial" data-bind="click: $root.loadSimpleSpecial.bind($data, $root.isPricesTable())"><@fmt.message key="createSimpleEspecial"/></a></li>
									</#if>
									<li class="heading-0a"><a href="#information" class="a-ko" id="sy-product-information"><@fmt.message key="productInformation"/></a></li>
								</ul>
							</div>
						</div>

						<section id="configuration" class="search-results">
							<div id="borrarBoton" class="col-md-6">
								<a class="a-ko">
									<span id="deleteProduct" class="enabled" data-title="<@fmt.message key="deleteProduct"/>" title="<@fmt.message key="deleteProduct"/>"> <i class="fa fa-trash" aria-hidden="true"></i> <@fmt.message key="deleteProduct"/></span>
								</a>
							</div>
							<div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
								<div class="simple-collapse__head">
									<h2 class="heading-06 heading-semi-light"><@fmt.message key="configuration"/></h2>
								</div>
								<div class="simple-collapse__body p-0">
									<#include "graphicaleditor/configurator-editor-grid.ftl">
								</div>
							</div>
						</section>

						<section id="summary" class="search-results">
							<div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly">
								<div class="simple-collapse__head">
									<h2 class="heading-06 heading-semi-light"><@fmt.message key="summary"/></h2>
								</div>
								<div class="simple-collapse__body p-0">
									<div id="configuration_summary_div" class="table-responsive-lg">
									</div>
								</div>
							</div>
						</section>
						<#if createSimpleSpecialPermission ?? && createSimpleSpecialPermission && (!vcEshopConnection || (vcEshopConnection && isInternalUser)) >
						<section id="simpleEspecial" class="search-results position-relative">
							<smc-spinner-inside-element params="loading: loadingBomItemsList()"></smc-spinner-inside-element>
							<div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly">
								<div class="simple-collapse__head">
									<h2 class="heading-06 heading-semi-light"><@fmt.message key="createSimpleEspecial"/></h2>
								</div>
								<div class="simple-collapse__body p-0">
									<div class="col-12 hide-configuration">
										<!-- ko if: enabledSimpleSpecial() -->
										<!-- ko if: !$root.creatingProcess() -->
										<div class="col-12 mb-4 row">
											<div class="col-6">
												<label><@fmt.message key="simpleSpecial.code"/></label>
												<span data-bind="text: simpleSpecialCode().simpleSpecialCode()"></span>
											</div>
											<div class="col-6"></div>
											<div class="col-6">
												<label><@fmt.message key="simpleSpecial.customerCode"/>:</label>
												<span data-bind="text: customerCode()"></span>
											</div>
											<div class="col-6">
												<label><@fmt.message key="simpleSpecial.enduserCode"/>:</label>
												<span data-bind="text: endUserCode()"></span>
											</div>
											<div class="col-6">
												<label><@fmt.message key="simpleSpecial.customerName"/>:</label>
												<span data-bind="text: customerName()"></span>
											</div>
											<div class="col-6">
												<label><@fmt.message key="simpleSpecial.enduserName"/>:</label>
												<span data-bind="text: endUserName()"></span>
											</div>
										</div>
										<!-- /ko -->
										<table class="table" cellspacing="0">
											<tbody>
												<tr class="eliminar-ik_report_header">
													<td class="eliminar-ik_report_column1"><@fmt.message key="mybaskets.description"/></td>
													<td class="eliminar-ik_report_column2"><@fmt.message key="eshop.partnumber"/></td>
													<td class="eliminar-ik_report_column3">
														<@fmt.message key="eshop.qty"/>
														<!-- ko if: $root.isPricesTable() -->
														<br><@fmt.message key="vc.bom.leadTime"/>
														<!-- /ko -->
													</td>
													<!-- ko if: $root.isPricesTable() -->
													<#if (bomListPricesPermission ?? && bomListPricesPermission)>
													    <td class="eliminar-ik_report_column4 text-right">
														    <@fmt.message key="vc.bom.unitPrice"/><br>
														    <@fmt.message key="vc.bom.totalPrice"/>
													    </td>
													</#if>
													<td class="eliminar-ik_report_column5 text-right">
														<@fmt.message key="vc.bom.localStock"/><br>
														<@fmt.message key="vc.bom.ecwStock"/>
													</td>
													<!-- /ko -->
													<#if (bomNetPricesPermission ?? && bomNetPricesPermission)>
													<!-- ko if: !$root.creatingProcess() -->
													    <td>
														    <@fmt.message key="vc.bom.disc"/>
													    </td>
													    <td class="text-right">
														    <@fmt.message key="vc.bom.unitNetPrice"/><br>
														    <@fmt.message key="vc.bom.totalNetPrice"/>
													    </td>
													<!-- /ko -->
													</#if>
												</tr>
												<!-- ko foreach: bomItemsList -->
												<tr data-bind="css: { valve_bom_list_invalid: leadTime == '-' && totalPrice == '-' && $root.isPricesTable()}">
													<td class="eliminar-ik_report_column1"><span data-bind="text: description"></span></td>
													<td class="eliminar-ik_report_column2"><span data-bind="text: partnumber"></span></td>
													<td class="eliminar-ik_report_column3">
														<span data-bind="text: quantity"></span>
														<!-- ko if: $root.isPricesTable() -->
														<br><span data-bind="text: leadTime"></span>
														<!-- /ko -->
													</td>
													<!-- ko if: $root.isPricesTable() -->
													<#if (bomListPricesPermission ?? && bomListPricesPermission)>
													    <td class="eliminar-ik_report_column4 text-right">
														    <span data-bind="text: unitPrice"></span><br>
														    <span data-bind="text: totalPrice"></span>
													    </td>
													</#if>
													<td class="eliminar-ik_report_column5 text-right">
														<span data-bind="text: localStock"></span><br>
														<span data-bind="text: ecwStock"></span>
													</td>
													<!-- /ko -->
													<!-- ko if: !$root.creatingProcess() -->
													<#if (bomNetPricesPermission ?? && bomNetPricesPermission)>
													    <td class="text-right">
														    <span data-bind="text: discount"></span>
													    </td>
													    <td class="text-right">
														    <span data-bind="text: netPrice"></span><br>
														    <span data-bind="text: totalNetPrice"></span>
													    </td>
													</#if>
													<!-- /ko -->
												</tr>
												<!-- /ko -->
												<!-- ko if: $root.isPricesTable() -->
												<tr>
													<td colspan="2"></td>
													<td class="eliminar-ik_report_column3"><@fmt.message key="vc.bom.leadTime"/></td>
													<#if (bomListPricesPermission ?? && bomListPricesPermission)>
													    <td class="eliminar-ik_report_column4 text-right"><@fmt.message key="vc.bom.listPrice"/></td>
													</#if>
													<td></td>
													<!-- ko if: !$root.creatingProcess() -->
													<#if (bomNetPricesPermission ?? && bomNetPricesPermission)>
													    <td></td>
													    <td class="eliminar-ik_report_column7 text-right"><@fmt.message key="vc.bom.netPrice"/></td>
													</#if>
													<!-- /ko -->
												</tr>
												<tr>
													<td colspan="2"></td>
													<td><span data-bind="text: totalLeadTime"></span></td>
													<#if (bomListPricesPermission ?? && bomListPricesPermission)>
													    <td class="text-right"><span data-bind="text: totalListPrice"></span></td>
													</#if>
													<td></td>
													<!-- ko if: !$root.creatingProcess() -->
													<#if (bomNetPricesPermission ?? && bomNetPricesPermission)>
													    <td></td>
													    <td class="text-right"><span data-bind="text: totalNetPrice"></td>
													</#if>
													<!-- /ko -->
												</tr>
												<!-- /ko -->
											</tbody>
										</table>
										<!-- ko if: $root.creatingProcess() -->

										<!-- ko if: !$root.isPricesTable() -->

											<button class="btn btn-primary" data-bind="click: $root.loadSimpleSpecial.bind($data, true), visible: enabledSimpleSpecial()">
											    <#if (bomNetPricesPermission ?? && bomNetPricesPermission) || (bomListPricesPermission ?? && bomListPricesPermission)>
											        <@fmt.message key="vc.bom.listPrices"/>
											    <#else>
											        <@fmt.message key="vc.bom.leadTime"/>
											    </#if>
											</button>

										<!-- /ko -->
										<!-- ko if: $root.isPricesTable() -->
										<button class="btn btn-primary" data-bind="click: $root.openWizardModal.bind($data), disable: invalid()">
												<!-- ko if: $root.isOpenedGroup() -->
										<@fmt.message key="vc.bom.closeAndCreateSimpleSpecial"/>
												<!-- /ko -->
												<!-- ko if: !$root.isOpenedGroup() -->
										<@fmt.message key="vc.bom.createSimpleSpecial"/>
												<!-- /ko -->
										</button>
										<!-- /ko -->

										<!-- /ko -->
										<!-- ko if: !$root.creatingProcess() -->
										<!-- /ko -->
										<!-- /ko -->
										<!-- ko if: !enabledSimpleSpecial() -->
										<div class="alert alert-warning" role="alert">
											<span class="font-weight-bold"><@fmt.message key="vc.configuration.incomplete"/></span>
										</div>
										<!-- /ko -->
									</div>
								</div>
							</div>
						</section>
						</#if>
						<section id="information" class="search-results">
							<div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly">
								<div class="simple-collapse__head">
									<h2 class="heading-06 heading-semi-light"><@fmt.message key="productInformation"/></h2>
								</div>
								<div class="simple-collapse__body p-0">
									<#if isAuthenticated>
										<#include "graphicaleditor/project-information-grid.ftl">
									</#if>
								</div>
							</div>
						</section>
					</div>

                </div>

            </div>

        </div>


    </main>
											   <#include './edit-alias-modal.ftl'>


</div><#-- div container  -->


<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/> <#-- para refrescar un componente, aqui no se usa -->
<@hst.resourceURL var="serveResourceURL1"  resourceId="url1"/>
<@hst.resourceURL var="serveResourceURL2"  resourceId="url2"/>
<@hst.resourceURL var="checkValveConfiguration"  resourceId="checkValveConfiguration"/>
<@hst.resourceURL var="addProduct"  resourceId="addProduct"/>
<@hst.resourceURL var="refreshPanel"  resourceId="refreshPanel"/>
<@hst.resourceURL var="move"  resourceId="move"/>
<@hst.resourceURL var="addStation"  resourceId="addStation"/>
<@hst.resourceURL var="deleteStationURL"  resourceId="deleteStation"/>
<@hst.resourceURL var="deleteProductURL"  resourceId="deleteProduct"/>
<@hst.resourceURL var="drawMeassuresURL"  resourceId="drawMeassures"/>
<@hst.resourceURL var="drawSolenoidsURL"  resourceId="drawSolenoids"/>
<@hst.resourceURL var="showConfigurationSummaryURL"  resourceId="showConfigurationSummary"/>
<@hst.resourceURL var="saveOnCacheURL"  resourceId="saveOnCache"/>
<@hst.resourceURL var="saveConfigurationURL"  resourceId="saveConfiguration"/>
<@hst.resourceURL var="sendVcToBasketUrl" resourceId="sendVcToBasket"/>
<@hst.resourceURL var="sendVcToFavouritesUrl" resourceId="sendVcToFavourites"/>
<@hst.resourceURL var="exportSpecificationsURL"  resourceId="exportSpecifications"/>
<@hst.resourceURL var="exportBomURL"  resourceId="exportBom"/>
<@hst.resourceURL var="exportValvePDFURL"  resourceId="exportValvePDF"/>
<@hst.resourceURL var="loadContactsByDesignerURL"  resourceId="loadContactsByDesigner"/>
<@hst.resourceURL var="deleteCustomerByIdURL"  resourceId="deleteCustomerById"/>
<@hst.resourceURL var="copyURL"  resourceId="copy"/>
<@hst.resourceURL var="undoURL"  resourceId="undo"/>
<@hst.resourceURL var="redoURL"  resourceId="redo"/>
<@hst.resourceURL var="loadSimpleSpecialBomUrl" resourceId="loadSimpleSpecialBom"/>
<@hst.resourceURL var="loadSimpleSpecialListPricesUrl" resourceId="loadSimpleSpecialListPrices"/>
<@hst.resourceURL var="closeGroupUrl" resourceId="closeGroup"/>
<@hst.resourceURL var="generateSyImageUrl" resourceId="generateSyImage"/>
<@hst.resourceURL var="openClosedConfigUrl" resourceId="openClosedConfig"/>
<@hst.resourceURL var="saveCustomerOnCacheUrl" resourceId="saveCustomerOnCache"/>
<@hst.resourceURL var="updateContactsUrl"  resourceId="updateContacts"/>
<@hst.resourceURL var="addAliasUrl"  resourceId="addAlias"/>



<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator"/>



<@hst.headContribution category="htmlHead">
	<script>
		/* Urls generated by Hippo for being used in our JS */
		var partNumber;
		var vcPath = "<@hst.webfile  path=""/>"
		var itemsetsPath = "${s3bucket}valve-configurator/style/series${SYSerie}/itemsets"
		var actionUrl;
		var renderUrl;
		var resourceUrl1;
		var resourceUrl2;
		var checkValveConfiguration;
		var addProduct;
		var refreshPanel;
		var move;
		var addStation;
		var deleteStationURL;
		var deleteProductURL;
		var drawMeassuresURL;
		var drawSolenoidsURL;
		var showConfigurationSummaryURL;
		var saveConfigurationURL;
		var sendVcToBasketUrl;
		var sendVcToFavouritesUrl;
		var exportSpecificationsURL;
		var exportBomURL;
		var exportValvePDFURL;
		var loadContactsByDesignerURL;
        var deleteCustomerByIdURL;
		var copyURL;
		var undoURL;
		var redoURL;
		var loadSimpleSpecialBomUrl;
		var loadSimpleSpecialListPricesUrl;
		var closeGroupUrl;
		var generateSyImageUrl;
		var getCadOptionsURL;
		var getCadUrlURL;
		var saveCustomerOnCacheUrl;
		var updateContactsUrl;
		var addAliasUrl;
		var labelSavedContactSuccess;
		var labelSavedContactError;

		var labelAliasMandatoryField = '${labelAliasMandatoryField?js_string}';
		var labelAliasSuccessMessage = '${labelAliasSuccessMessage?js_string}';
		var labelAliasErrorMessage = '${labelAliasErrorMessage?js_string}';
		var cancelBtn = '${labelCancel?js_string}';
		var noBtnText = '${labelNo?js_string}';

		var hrefParams = new URL(window.location.href).searchParams;

		var showNotices;
		var showMeassures;

		var stateMachine;
		var simpleSpecialCode;

		var drawingsBasePath = 'drawing/';
        var graphToolsBasePath = 'actions/';
        var updatesBasePath = 'updates/';

        var sessionState = {
            groupState : "incomplete"
        };

        var sessionState = {
            selectedTab : 0,
            tabsCount : 4,
            minStations : 2,
            maxStations : 12,
            currentElement : "manifold",
            currentState : "configuring",
            closedConfiguration : "false",
            groupState : "incomplete",
            withFreeElements : "without_free_elements",
            isFirstSelected : false,
            isLastSelected : false,
            deleteProductActive : true,
            changesList : {"index" : -1, "current_index" : 0, "undo_counter" : 0, "actions" : []},
            copyingCellId : "null",
            copyingTab : "-1",
            copyingElem : "null",
            noCSS : "DPR_021;DPR_022;DPR_023;DPR_025;DPR_026;DPR_051;DPR_053;DPR_057;DPR_058;DPR_059;DPR_060;DPR_061;DPR_066;DPR_082;DPR_085;DPR_086;DPR_087;DPR_088;DPR_089;DPR_090;DPR_101;DPR_102;DPR_103;DPR_104;DPR_106;DPR_111;DPR_112;DPR_113;DPR_114;DPR_115;DPR_116;DPR_183;DPR_196;DPR_220;DPR_221",
            syAction : ""
        };

        var messages;
        var labelErrorSendingVcToBasket;

        var SYSerie = '${SYSerie}';
        var userCountry = '${userCountry}';

	</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
	<script type="text/javascript">

		var checkedPriceAndLeadtime = <#if vcWssStateCheckedPricesLeadtime??>true<#else>false</#if>;
		var isOpenedGroup = <#if openedStatus??>${openedStatus?c}<#else>false</#if>;
		var creatingProcess = <#if simpleSpecialCode??>false<#else>true</#if>;

		var simpleSpecialVersioningPermission = <#if versioningPermission?? && versioningPermission>true<#else>false</#if>;

		var isAuthenticated = ${isAuthenticated?c};
        var modalContactLabels;
        var modalSaveConfirmationLabels;
		var modalErrorCopyingLabels;
        var globalError;
		var selseriesUrl;


		$(document).ready(function(){
			csrfToken = "${_csrf.token}";
			renderUrl="${componentRenderingURL}";
			resourceUrl1="${serveResourceURL1}";
            resourceUrl2="${serveResourceURL2}";
            checkValveConfiguration="${checkValveConfiguration}";
            addProduct="${addProduct}";
            refreshPanel ="${refreshPanel}";
            move="${move}";
            addStation="${addStation}";
            deleteStationURL = "${deleteStationURL}";
			deleteProductURL = "${deleteProductURL}";
			drawMeassuresURL = "${drawMeassuresURL}";
			drawSolenoidsURL = "${drawSolenoidsURL}";
			showConfigurationSummaryURL = "${showConfigurationSummaryURL}";
			saveOnCacheURL = "${saveOnCacheURL}";
			saveConfigurationURL = "${saveConfigurationURL}";
			sendVcToBasketUrl = "${sendVcToBasketUrl}";
			sendVcToFavouritesUrl = "${sendVcToFavouritesUrl}";
			exportSpecificationsURL = "${exportSpecificationsURL}";
			exportBomURL = "${exportBomURL}";
			exportValvePDFURL = "${exportValvePDFURL}";
			loadContactsByDesignerURL = "${loadContactsByDesignerURL}";
            deleteCustomerByIdURL = "${deleteCustomerByIdURL}";
			copyURL = "${copyURL}";
			undoURL = "${undoURL}";
			redoURL = "${redoURL}";
			loadSimpleSpecialBomUrl = "${loadSimpleSpecialBomUrl}";
			loadSimpleSpecialListPricesUrl = '${loadSimpleSpecialListPricesUrl}';
			closeGroupUrl = '${closeGroupUrl}';
			generateSyImageUrl = '${generateSyImageUrl}';
            openClosedConfigUrl = '${openClosedConfigUrl}';
            saveCustomerOnCacheUrl = '${saveCustomerOnCacheUrl}';
			updateContactsUrl = '${updateContactsUrl}';
			addAliasUrl = '${addAliasUrl}';

			actionUrl = "${actionURL}";
			selseriesUrl = '${refSelseries}';

			var showMeassures = hrefParams.get('showMeassures');
			var showNotices = hrefParams.get('showNotices');

			simpleSpecialCode = <#if simpleSpecialCode?? && simpleSpecialCode != "">'${simpleSpecialCode}'<#else>null</#if>;


			var messages = {};
			messages['AVISO_SALVADO'] = {msg: 'Before creating a new project, do you want to save the present one?', type: 'D'};

			window.stateMachine = new StateMachine($ , sessionState, showMeassures, showNotices, vcPath, messages );

            modalContactLabels = {
                title: '${labelVcModalContactTitle?js_string}',
                confirm: '${labelVcModalContactConfirm?js_string}',
                cancel: '${labelVcModalContactCancel?js_string}',
                noItems: '${labelVcModalContactNoItems?js_string}'
            }

            modalSaveConfirmationLabels = {
                title:'${labelmodalSaveConfirmationTitle?js_string}',
                message:'${labelmodalSaveConfirmationMessage?js_string}',
                close:'${labelmodalSaveConfirmationClose?js_string}'
            }

			modalErrorCopyingLabels = {
				title:'${labelModalErrorCopyingTitle?js_string}',
				station:'${labelModalErrorCopyingStation?js_string}',
				message: '${labelModalErrorCopyingMessage?js_string}'
			}

			labelErrorSendingVcToBasket = '${labelErrorSendingVcToBasket?js_string}';
			labelStartSendingVcToBasket = '${labelStartSendingVcToBasket?js_string}';
			labelStartSendingVcToFavourites = '${labelStartSendingVcToFavourites?js_string}';
            globalError = '${generalError?js_string}';
			labelSavedContactSuccess = '${labelSavedContactSuccess?js_string}';
			labelSavedContactError = '${labelSavedContactError?js_string}';

    });
    </script>
</@hst.headContribution>


    <#-- CSS -->

<@hst.headContribution  category="scripts">
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/sy_styles.css"/>" type="text/css"></link>
<!-- ROLLBACK S3
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/seriesSY/sy_styles.css" type="text/css"></link>
-->
</@hst.headContribution>
<@hst.headContribution  category="scripts">
<!-- ROLLBACK S3
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/graphical_tools.css"/>" type="text/css"></link>
-->
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/graphical_tools.css" type="text/css"></link>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
<!-- ROLLBACK S3
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/tabs.css"/>" type="text/css"></link>
-->
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/tabs.css" type="text/css"></link>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
<!-- ROLLBACK S3
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/standard_product.css"/>" type="text/css"></link>
-->
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/standard_product.css" type="text/css"></link>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
<!-- ROLLBACK S3
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/graphical_editor.css"/>" type="text/css"></link>
-->
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/graphical_editor.css" type="text/css"></link>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
<!-- ROLLBACK S3
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/grid.css"/>" type="text/css"></link>
-->
	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/grid.css" type="text/css"></link>
</@hst.headContribution>


<#--    EXTERNAL LIBRARIES -->


<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/tools/jquery.tools.min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/qtip/jquery.qtip.min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/underscore-min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/autoNumeric.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/functions/page-functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>




    <#--    simple tooltip -->
<@hst.headContribution  category="scripts">
	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/js-menu/vcconfigurator/simple-tooltip/css/jquery.simple-tooltip.css"/>" type="text/css"></link>
</@hst.headContribution>

<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/simple-tooltip/jquery.simple-tooltip.js"/>" type="text/javascript"></script>
</@hst.headContribution>



    <#--    CLASS -->
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/class.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<#--    EVENT BUS SCRIPTS -->
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/Event.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/EventBus.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/ConfiguratorEventBus.js"/>" type="text/javascript"></script>
</@hst.headContribution>


<#--    STATE MACHINE -->
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/StateMachine.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/GraphicalEditorController.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/GraphicalToolsController.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/TabsController.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/ValveConfiguration.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/functions/sy_functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<#-- Knockout customer contact component -->
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.modal-customer-contact.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/valve-configuration-viewmodel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<#-- EXTRA -->

<@hst.headContribution  category="scripts">
	<script src=""<@hst.webfile path="/webfiles/1536846647915/js/category_tile.js"/>" type="text/javascript"></script>
</@hst.headContribution>


<@hst.headContribution  category="htmlBodyEnd">
<script type="text/javascript">

    var valveConfigurationViewModel;
	var aliasCustomerCode;
	var aliasCustomerName;
	var endCustomerCode;
	var endCustomerName;

	var hippoBaseUrlTemplate = hippoBaseUrlTemplate || '${hippoBaseUrlTemplate?js_string}';

	var isInternalUser = '${isInternalUser?c}' === 'true';

    $(document).ready(function(){
		// Valve configurator general view model
		aliasCustomerCode = '${customerNumber}';
		aliasCustomerName = '${customerName}';
		endCustomerCode = '${endCustomerNumber}';
		endCustomerName = '${endCustomerName}';
        valveConfigurationViewModel = new ValveConfigurationViewModel();
		var valveConfiguratorViewmodelDom = document.getElementById("valve-configurator-container");
		ko.applyBindings(valveConfigurationViewModel, valveConfiguratorViewmodelDom);
		partNumber = "${CellConfiguration.reference}";
		console.log(partNumber);
		//new MoreInfoComponent.getValveInfo(partNumber, "valveConfigurator-options");
    });

</script>
</@hst.headContribution>
