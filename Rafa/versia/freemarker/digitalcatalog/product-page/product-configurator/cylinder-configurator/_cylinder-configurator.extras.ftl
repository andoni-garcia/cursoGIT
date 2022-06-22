
<@hst.setBundle basename="CylinderConfigurator,ProductConfigurator,StandardStockedItems,AddToCartBar,ProductPDFReport"/>
<div class="col-12 mt-4 aareo cylinders_configurator hidden" id="cylindersConfigurator">
    <#if mustShowCompleteCylinderSeries >
        <div class="row">
<#--            <!-- cylinder parts &ndash;&gt;-->
<#--            <div class="col-12 aareo__cylinder aareo_configuration_part hidden">-->
<#--                <div class="alert alert-info"><@fmt.message key="cylinderConfigurator.chooseAccesory"/></div>-->
<#--                <div class="aareo__cylinder__parts py-5">-->
<#--                    <#if apiAccesories?? && apiAccesories.getItems()?? && (apiAccesories.getItems()?size != 0) >-->
<#--                        <div class="aareo__cylinder__parts_selection_container">-->
<#--                            <div class="aareo__cylinder__parts_selection_container_buttons">-->
<#--                                <#list apiAccesories.getItems() as accesory >-->
<#--                                    <div class="aareo__cylinder__part" >-->
<#--                                        <#if accesory.isRodEnd()>-->
<#--                                            <div class="aareo__cylinder__part_position aareo__cylinder__part_rodEnd" >-->
<#--                                                <#if accesory?index == 0 >-->
<#--                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js selected btn" data-value="${accesory.getZone()}" >${accesory.getZone()}</a>-->
<#--                                                <#else>-->
<#--                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js btn" data-value="${accesory.getZone()}" >${accesory.getZone()}</a>-->
<#--                                                </#if>-->
<#--                                            </div>-->
<#--                                        <#else>-->
<#--                                            <div class="aareo__cylinder__part_position" >-->
<#--                                                <#if accesory?index == 0 >-->
<#--                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js selected btn"  data-value="${accesory.getZone()}">${accesory.getZone()}</a>-->
<#--                                                <#else>-->
<#--                                                    <a href="javascript:void(0);" class= "aareo__cylinder__part_position_js btn"  data-value="${accesory.getZone()}">${accesory.getZone()}</a>-->
<#--                                                </#if>-->
<#--                                            </div>-->
<#--                                        </#if>-->
<#--                                    </div>-->
<#--                                </#list>-->
<#--                            </div>-->
<#--                            <div class="aareo__cylinder__parts_legend">-->
<#--                                <div class="aareo__cylinder__parts_legend_line">-->
<#--                                    <span class="aareo__cylinder__parts_legend_color accesory_end" ></span>-->
<#--                                    <@fmt.message key="cylinderConfigurator.addOneAccesory"/>-->
<#--                                </div>-->
<#--                                <div class="aareo__cylinder__parts_legend_line">-->
<#--                                    <span class="aareo__cylinder__parts_legend_color rod_end"></span>-->
<#--                                     <@fmt.message key="cylinderConfigurator.addAccesoryOrRodEnd"/>-->
<#--                                </div>-->
<#--                            </div>-->
<#--                        </div>-->
<#--                        <div class="aareo__cylinder__images_part" >-->
<#--                            <#list apiAccesories.getItems() as accesory >-->
<#--                                    <div class="aareo__cylinder__part_image aareo__cylinder__images_part_image" data-value="${accesory.getZone()}" >-->
<#--                                        <#if accesory?index == 0 >-->
<#--                                            <img id="aareo__cylinder__images_part_image_${accesory.getZone()}" src="${accesory.getImageUrl()}"  />-->
<#--                                        <#else>-->
<#--                                            <img id="aareo__cylinder__images_part_image_${accesory.getZone()}"  src="${accesory.getImageUrl()}" class="hidden" />-->
<#--                                        </#if>-->
<#--                                    </div>-->
<#--                            </#list>-->
<#--                        </div>-->
<#--                    </#if>-->
<#--                </div>-->
<#--            </div>-->
<#--            <!-- / cylinder parts &ndash;&gt;-->
<#--            <!-- choose-add-modify &ndash;&gt;-->
<#--            <div class="col-12 mb-4 aareo__choose-add-modify aareo_configuration_part hidden">-->
<#--                <h3 class="heading-05 mb-4 text-center"><@fmt.message key="cylinderConfigurator.chooseAction"/></h3>-->
<#--                <div class="d-sm-flex justify-content-center align-items-center">-->
<#--                    <button id="aareo_configuration_part_addAccesory" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.addAccesory"/></button>-->
<#--                    <button id="aareo_configuration_part_modifyRodEnd" class="btn btn-secondary btn-secondary--blue-border mt-3 mt-sm-0 ml-sm-2"><@fmt.message key="cylinderConfigurator.modifyRodEndOptions"/></button>-->
<#--                </div>-->
<#--            </div>-->
    <!-- / rod end moved container -->
    <div class="col-12 aareo_configuration_part_rod_end_container configurator-container hidden">
        <table id ="cylinder_rod_end_configuration_table">

        </table>
    </div>
            <!-- choose-accesory -->
            <div id="aareo__choose-accesory" class="col-12 aareo__choose-accesory aareo_configuration_part hidden">
                <h3 class="heading-04 productconfigurator__section__title mt-4"><@fmt.message key="cylinderConfigurator.accesoryList"/></h3>
                <div class="alert alert-info hidden">
                    <@fmt.message key="cylinderConfigurator.noAccesoriesFound"/>
                </div>
                <div id="" class="">
                    <div class="sscw__loading_spinner"></div>
                    <div class="tab-loading-container loading-container-js align-items-center"></div>
                    <div  class="spares-accessories spares-accessories-result-container">
                        <div id="sscw_spares-accessories-result-container">
                        </div>
                    </div>
                </div>
            </div>
            <!-- / choose-accesory -->
            <!-- another-reference -->
            <div id="" class="col-12 aareo__another-reference hidden">
                <h3 class="heading-04 productconfigurator__section__title mt-4"><@fmt.message key="cylinderConfigurator.orInsertAnother"/></h3>
                <div class="alert alert-info added-info hidden"><@fmt.message key="cylinderConfigurator.referenceAdded"/></div>
                <div class="alert alert-info not-added-info hidden"><@fmt.message key="cylinderConfigurator.referenceCouldNotBeAdded"/></div>
                <div id="aareo__add-reference">
                    <form class="row mb-4">
                        <label class="col-12 col-md-5" for="reference">
                            <input type="text" name="reference" id="aareo__add-reference_reference" tabindex = "1" value="" placeholder="<@fmt.message key="cylinderConfigurator.typeOtherReference"/>" class="form-control">
                        </label>
                        <label class="col-12 col-md-5" for="product_description">
                            <input type="text" name="product_description" id="aareo__add-reference_product_description" tabindex = "2" value="" placeholder="<@fmt.message key="cylinderConfigurator.insertProductDescription"/>" class="form-control">
                        </label>
                        <div class="col-12 col-md-2" id ="aareo__add-reference_button_container">
                            <button type="button" id="btn-submit-reference" class="btn btn-primary btn-block"  tabindex = "3" >
                                <div class="sscw__loading_spinner"></div>
                                <@fmt.message key="cylinderConfigurator.addReference"/>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- accesories-selection-summary -->
            <div id="" class="col-12 aareo__accesories-selection-summary">
                <div class="product-toolbar-component product-toolbar-component-simple desktop mb-5">
                    <div class="product-toolbar-item__content product-toolbar-content-js">
                        <div class="heading d-flex justify-content-between align-items-center">
                            <h2 class="heading-07">
                                <span><@fmt.message key="cylinderConfigurator.accesories.selection.summary"/></span>
                            </h2>
                            <#if apiPermission?? && apiPermission.isMounted()>
                                <label id="mount_accessories" for="mounted_summary" class="smc-checkbox order-3">
                                    <input id="mounted_summary" type="checkbox" >
                                    <span class="smc-checkbox__label  id = "sscw_mountedText"><@fmt.message key="cylinderConfigurator.mounted"/></span>
                                </label>
                            </#if>
                        </div>
                        <div id="aareo_configuration-summary">
                            <div class="sscw__loading_spinner"></div>
                            <div id="aareo_configuration-summary_accesory_summary-list" class="accordion p-3 aareo_attribute-list accesory-summary-attribute-list-js"></div>
                            <div class="accordion__item accordion__item--without-position hidden accordion p-3">
                                <div class="accordion__item__header">
                                        <h3 id="ssi-detail-tab_no_position" class="heading-06 color-blue mb-0 accordion__item__toggler collapsed" data-toggle="collapse" data-target="#without-position__collapse" aria-expanded="false" aria-controls="product_detail_no_position_collapse">
                                            <span><@fmt.message key="cylinderConfigurator.withoutPosition"/></span>
                                            <i class="fa fa-plus"></i>
                                        </h3>
                                </div>
                                <div id="without-position__collapse" class="accordion__item__body collapse" aria-labelledby="product_detail_no-position" data-parent="#aareo_configuration-summary" style=""></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--/ accesories-selection-summary -->
        </div>

        <div class="templates hidden">
            <div id="aareo_accesory_summary_no_position_header_template" class="hidden">
                <div class="accordion__item__header no-position">
                    <h3 id="ssi-detail-tab_no_position" class="heading-06 color-blue mb-0 accordion__item__toggler collapsed" data-toggle="collapse" data-target="#without-position__collapse" aria-expanded="false" aria-controls="product_detail_no_position_collapse">
                        <span><@fmt.message key="cylinderConfigurator.withoutPosition"/></span>
                        <i class="fa fa-plus"></i>
                    </h3>
                </div>
            </div>
            <div id="aareo_accesory_summary_no_position_template" class="hidden">
                <div id = "aareo_accesory_summary_{{aareo_accesory_partNumber_id}}" zone-value="no-position" partnumber-value = "{{aareo_accesory_header_partNumber}}" class="aareo_accesory_no_position_row aareo_accesory_summary_element">
                    <div class="accordion__item__body__content">
                        <figure class="accessories-selection-summary__position__image image d-flex align-items-center">
                        </figure>
                        <div class="accessories-selection-summary__position__info">
                            <div class="accessories-selection-summary__position__info__title"><@fmt.message key="standardstockeditems.productdescription"/>:</div>
                            <div id="aareo_accesory_summary_no_position_template_default_description" class="accessories-selection-summary__position__info__value aareo_accesory_summary_row_description"><@fmt.message key="cylinderConfigurator.partOf"/> {{aareo_accesory_description}}</div>
                            <div class="accessories-selection-summary__position__info__title"><@fmt.message key="standardstockeditems.partnumber"/>:</div>
                            <div class="accessories-selection-summary__position__info__value">{{aareo_accesory_partNumber}}</div>
                            <div class="accessories-selection-summary__position__info__title"><@fmt.message key="cylinderConfigurator.quantity"/>:</div>
                            <div class="accessories-selection-summary__position__info__value aareo_accesory_summary_row_quantity">1</div>
                        </div>
                        <div class="accessories-selection-summary__position__actions">
                            <div class = "spares-accesory-item__actions" >
                                <button onclick="javascript:removeAccesoryFromSummary('aareo_accesory_summary_{{aareo_accesory_partNumber_remove}}');" class="btn btn-secondary btn-secondary--blue-border" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="Delete">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id = "aareo_accesory_project_row_template" class="hidden">
                <div class="attribute-list-row aareo_accesory" partnumber-value="{{aareo_accesory_project_partNumber}}" zone-value="{{aareo_accesory_project_zone}}">
                    <span class="attribute-name">{{attributeName}} <@fmt.message key="cylinderConfigurator.position"/> <@fmt.message key="cylinderConfigurator.partNumber"/>: </span><span class="attribute-value">{{attributeValue}}</span>
                </div>
            </div>
            <div id = "aareo_no_position_accesory_project_row_template" class="hidden">
                <div class="attribute-list-row aareo_accesory" partnumber-value="{{aareo_accesory_project_partNumber}}" zone-value="{{aareo_accesory_project_zone}}">
                    <span class="attribute-name"><@fmt.message key="cylinderConfigurator.withoutPosition"/> <@fmt.message key="cylinderConfigurator.partNumber"/>: </span><span class="attribute-value">{{attributeValue}}</span>
                </div>
            </div>
        </div>
    </#if>
    <#if isAuthenticated && apiPermission?? && apiPermission.isCreateSimpleSpecial() >
        <!-- create-single-special -->
        <div id="aareo__create-single-special" class="row aareo__create-single-special">
            <div class="col-12">
                <h3 class="heading-06 mb-4 text-center"><@fmt.message key="cylinderConfigurator.wantSingleSpecial"/></h3>
                <div class="d-flex flex-wrap justify-content-center align-items-center">
                    <button id="open-closed-configuration-button" class="open-closed-configuration-js btn btn-secondary btn-secondary-blue-border my-2 my-md-0 mr-0 mr-sm-2 hidden">
                        <i class="fa fa-edit"></i> <@fmt.message key="cylinderConfigurator.openClosedConfiguration"/>
                    </button>
                    <button id="create-simple-special-button" class="btn btn-secondary btn-secondary-blue-border mt-10 mt-sm-0">
                        <i class="fa fa-barcode"></i> <@fmt.message key="cylinderConfigurator.createSimpleSpecial"/></button>
                </div>
                <div class="create-simple-special-disabled-text mb-4 text-center" style="display: none;">
                    <i class="fa fa-info"></i> <@fmt.message key="cylinderConfigurator.cantCreateSimpleSpecial"/></div>
            </div>
        </div>
        <!-- / create-single-special -->
    </#if>
</div>

<script type="text/javascript">

    var cylinderWizardModal;

    $(document).ready(function () {
        $('#cpn_state img').addClass("hidden");
        var cylinderConfigurator;
        $(function() {
            var CylinderConfigurator = window.smc.CylinderConfigurator;
            var config = {
                id: "cylinder-configurator",
                messages: {
                    aliasCreated: "<@fmt.message key="cylinderConfigurator.aliasCreated" />",
                    partNumberCopied: "<@fmt.message key="productConfigurator.partnumbercopied" />",
                    completeConfigToViewPrices: "<@fmt.message key="addToCartBar.prices.completeconfig" />",
                    completeRodEndConfigToViewPrices: "<@fmt.message key="addToCartBar.prices.completerodendconfig" />"
                }
            };
            smc.CylinderConfigurator.urls = {
                createSimpleSpecialAlias : document.getElementById('createSimpleSpecialAlias').href,
                exportBomURL : document.getElementById('exportBomLink').href,
                getCylinderSummaryTable: document.getElementById('getCylinderSummaryTableLink').href,
                getSimpleSpecialFromCode: document.getElementById('getSimpleSpecialFromCodeLink').href
            };


            cylinderConfigurator = new CylinderConfigurator(config);
            cylinderConfigurator.init();
        });
        if (cylinderWizardModal === undefined) {
            createCylinderWizardModal();
        }
        $("#create-simple-special-button").click(function() {
            $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js:visible").click();
            //If we don't need to remove data from wizard on second attempt, remove this reset
            cylinderWizardModal.resetWizard();
            cylinderWizardModal.showSummaryModal();
        });
    });

    function createCylinderWizardModal() {
        var CylinderWizardModal = window.smc.CylinderWizardModal;
        var config = {
            id: "cylinder-wizard-modal",
            productConfiguratorComponent: window.smc.productConfiguratorComponent
        };
        smc.CylinderWizardModal.urls = {
            searchCustomer: document.getElementById('searchCustomer').href,
            acceptSimplePartNumberCreation: document.getElementById('acceptSimplePartNumberCreation').href,
            getCadOptions:  document.getElementById('getCadOptions').href,
            getZipFile :  document.getElementById('getZipFile').href,
            createSimpleSpecialAlias : document.getElementById('createSimpleSpecialAlias').href,
            getCylinderSummaryTableBySimpleSpecial: document.getElementById("getCylinderSummaryTableBySimpleSpecialLink").href
        };
        cylinderWizardModal = new CylinderWizardModal(config);
        cylinderWizardModal.init();
    }

</script>