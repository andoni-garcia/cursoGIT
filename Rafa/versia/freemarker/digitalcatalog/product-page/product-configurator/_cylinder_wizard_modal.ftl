
<@hst.setBundle basename="SearchPage,ProductToolbar,CylinderConfigurator,eshop,ProductPDFReport"/>
<div class="hidden" data-swiftype-index='false'>
    <a id="searchCustomer" href="<@hst.resourceURL resourceId='searchCustomer'/>"></a>
    <a id="acceptSimplePartNumberCreation" href="<@hst.resourceURL resourceId='acceptSimplePartNumberCreation'/>"></a>
    <a id="getSimpleSpecialFromCodeLink" href="<@hst.resourceURL resourceId='getSimpleSpecialFromCode'/>"></a>
    <a id="getCadOptions" href="<@hst.resourceURL resourceId='getCadOptions'/>"></a>
    <a id="getZipFile" href="<@hst.resourceURL resourceId='getZipFile'/>"></a>
    <a id="createSimpleSpecialAlias" href="<@hst.resourceURL resourceId='createSimpleSpecialAlias'/>"></a>
    <a id="exportBomLink" href="<@hst.resourceURL resourceId='exportBom'/>"></a>
    <a id="getCylinderSummaryTableLink" href="<@hst.resourceURL resourceId='getCylinderSummaryTable'/>"></a>
    <a id="getAccessoryListByZoneLink" href="<@hst.resourceURL resourceId='getAccessoryListByZone'/>"></a>
    <a id="getAccessorySummaryRowLink" href="<@hst.resourceURL resourceId='getAccessorySummaryRow'/>"></a>
    <a id="getReferenceSummaryRowLink" href="<@hst.resourceURL resourceId='getReferenceSummaryRow'/>"></a>
    <a id="getCylinderSummaryTableBySimpleSpecialLink" href="<@hst.resourceURL resourceId='getCylinderSummaryTableBySimpleSpecial'/>"></a>
    <span id = "sscw_modal_customer_error"><@fmt.message key="cylinderConfigurator.error.mustSelectCustomer"/></span>
    <span id = "sscw_modal_alias_error"><@fmt.message key="cylinderConfigurator.error.alias.not.created"/></span>
    <span id = "sscw_modal_customer_error"><@fmt.message key="cylinderConfigurator.error.mustSelectCustomer"/></span>
    <span id = "sscw_modal_simple_special_error"><@fmt.message key="cylinderConfigurator.error.invalidSimpleSpecial"/></span>
    <span id = "sscw_modal_simple_special_not_found_error"><@fmt.message key="cylinderConfigurator.error.simpleSpecialNotFound"/></span>
    <span id = "sscw_modal_customer_not_found"><@fmt.message key="cylinderConfigurator.error.noCustomerFound"/></span>
    <span id = "sscw_modal_general_error"><@fmt.message key="cylinderConfigurator.error.general"/></span>
    <div class="hidden error-wizard-text"><p id = "alert-wizard-text-message" style="color:#D20000"><@fmt.message key="sswizard.alertError"/></p></div>
</div>
<@hst.headContribution category="htmlBodyEnd">
    <#include "../../_spinner.ftl">
</@hst.headContribution>

<div class="modal fade mb-5 mb-xl-0 sscw_modal" id="createSimpleEspecialPricesConfirmModal" role="dialog" data-swiftype-index="false" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="cylinderConfigurator.createSimpleSpecial"/></h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <section class="px-md-4 sscw__alias" id="sscw__confirmConfiguration">
                    <div class="row">
                        <div class="col-12 mb-4">
                            <span class=""><@fmt.message key="cylinderConfigurator.configurationSelectionText"/></span>
                        </div>
                        <div class="sscw__loading_spinner"></div>
                        <div id ="sscw__selection_table_pricesConfirm" class="cylinder-info-container__configuration_details  col-12 mb-4 sscw__selection_table">
                        </div>
                        <div class="create-simple-special-disabled-text col-12 mb-4 text-center black" style="display: none;">
                            <i class="fa fa-info"></i> <@fmt.message key="cylinderConfigurator.cantCreateSimpleSpecial"/></div>
                    </div>
                </section>
            </div>
            <div class="modal-footer">
                <div class="button_group--left">
                    <button type="button" id="btn-summary-return" class="btn btn-secondary btn-secondary--blue-border" data-dismiss="modal"><@fmt.message key="cylinderConfigurator.cancel"/></button>
                </div>
                <div class="button_group--right">
                    <button type="button" id="btn-summary-finish" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.continue"/></button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade mb-5 mb-xl-0 sscw_modal" id="createSimpleEspecialContinueConfirmModal" role="dialog" data-swiftype-index="false" style="display: none;" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="cylinderConfigurator.createSimpleSpecial"/></h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <section  class="px-4 sscw__alias" id="sscw__confirmContinue">
                    <div class="row mb-4 sscw__alias__content">
                        <div class="col-12 text-center">
                            <i class="fa fa-question fa-5x mb-4 text-primary"></i>
                        </div>
                        <div class="col-12 text-center">
                            <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.areYouSure"/></strong>
                        </div>
                    </div>
                </section>
            </div>
            <div class="modal-footer">
                <div class="button_group--left">
                    <button type="button" id="btn-confirm-return" class="btn btn-secondary btn-secondary--blue-border" data-dismiss="modal"><@fmt.message key="cylinderConfigurator.cancel"/></button>
                </div>
                <div class="button_group--right">
                    <button type="button" id="btn-confirm-finish" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.accept"/></button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade mb-5 mb-xl-0 sscw_modal" id="simpleSpecialCreationWizardModal" role="dialog" data-swiftype-index="false" style="display: none;" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="cylinderConfigurator.creationWizard"/></h4>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body  main-tabs">
                <nav class="sscw__nav">
                    <span class="sscw__nav__item  active" id = "sscw__customer_selection_tab" >
                        1  <@fmt.message key="cylinderConfigurator.customerSelection"/></a>
                    </span>
                    <span class="sscw__nav__item" id = "sscw__create_simple_special_tab">
                        2 <@fmt.message key="cylinderConfigurator.createSimpleSpecial"/>
                    </span>
                    <span class="sscw__nav__item" id = "sscw__zip_file_tab">
                        3 <@fmt.message key="cylinderConfigurator.zipFile"/>
                    </span>
                    <#--                    <span class="sscw__nav__item" id = "sscw__alias_tab">-->
                    <#--                        4 <@fmt.message key="cylinderConfigurator.alias"/>-->
                    <#--                    </span>-->
                    <span class="sscw__nav__item" id = "sscw__summary_confirmation_tab">
                        4 <@fmt.message key="cylinderConfigurator.summaryAndConfirmation"/>
                    </span>
                </nav>
                <div class="hidden sscw-message-error"><p id = "wizard-error-message" style="color:#D20000"></p></div>
                <section class="">
                    <article class="px-4 sscw__customer_selection wizard_article" id="sscw__customer_selection">
                        <form class="sscw__customer_search mb-4">
                            <label for="customer_number"><span class="d-block mb-2"><@fmt.message key="cylinderConfigurator.customerNumber"/></span>
                                <input type="text" name="customer_number" id="customer_number" value="" placeholder="<@fmt.message key="cylinderConfigurator.customerNumberPlaceholder"/>" class="form-control">
                            </label>
                            <label for="customer_name"><span class="d-block mb-2"><@fmt.message key="cylinderConfigurator.customerName"/></span>
                                <input type="text" name="customer_name" id="customer_name" value="" placeholder="<@fmt.message key="cylinderConfigurator.customerNamePlaceholder"/>" class="form-control">
                            </label>
                            <button type="button" id="btn-search-customer" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.search"/></button>
                            <button type="button" id="btn-reset-selection" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="search.searchresult.categories.reset"/></button>
                        </form>
                        <div class="row sscw__customer__list_header">
                            <div class="col-12 col-lg-3">
                                <label for="accessories_MGPM12-50Z__products_all" class="smc-checkbox">
                                    <@fmt.message key="cylinderConfigurator.customerNumber"/>
                                </label>
                            </div>
                            <div class="col-12 col-lg-4">
                                <label for="accessories_MGPM12-50Z__products_all" class="smc-checkbox">
                                    <@fmt.message key="cylinderConfigurator.customerName"/>
                                </label>
                            </div>
                            <div class="col-12 col-lg-5">
                                <label for="accessories_MGPM12-50Z__products_all" class="smc-checkbox">
                                    <@fmt.message key="cylinderConfigurator.addressZipCode"/>
                                </label>
                            </div>
                        </div>
                        <div class="sscw__loading_spinner"></div>
                        <div id ="sscw__customer__list" class="sscw__customer__list">

                        </div>
                    </article>

                    <article class="hidden px-4 sscw__create_simple_special wizard_article" id="sscw__create_simple_special">
                        <div id = "sscw__create_simple_special_configuration">
                            <#if apiPermission.isMounted() >
                                <div class="row sscw__create_simple_special__mounted">
                                    <div class="col-12">
                                        <label for="mounted" class="smc-checkbox">
                                            <input id="mounted" type="checkbox" class="" value="true">
                                            <strong class="smc-checkbox__label pl-5" id = "sscw_mountedText"><@fmt.message key="cylinderConfigurator.mounted"/></strong>
                                        </label>
                                        <hr>
                                    </div>
                                </div>
                            <#else>
                                <input id="mounted" type="checkbox" class="hidden" value="" disabled>
                            </#if>
                            <div class="row align-items-end sscw__create_simple_special__new">
                                <div class="col-12">
                                    <label for="new" class="smc-checkbox">
                                        <input id="new" name="new" type="radio" class="sscw__create_simple_special__option" value="true">
                                        <strong class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.newSimpleSpecial"/></strong>
                                    </label>
                                    <#if apiPermission?? && apiPermission.isVersioning() >
                                        <p><@fmt.message key="cylinderConfigurator.or"/></p>
                                        <label for="new_version" class="smc-checkbox">
                                            <input id="new_version" name="new" type="radio" class="sscw__create_simple_special__option" value="true">
                                            <strong class="smc-checkbox__label pl-5"><@fmt.message key="cylinderConfigurator.newFromExistingSimpleSpecial"/></strong>
                                        </label>
                                    </#if>
                                </div>
                                <div class="col-12 col-md-9 col-xl-5 mt-4 mt-md-0">
                                    <label for="simple_special_part_number" class="w-100 mb-0">
                                        <#if apiPermission?? && apiPermission.isVersioning() >
                                            <span class="d-block mb-2"><@fmt.message key="cylinderConfigurator.enterSimpleSpecialPN"/></span>
                                            <input type="text" name="simple_special_part_number" id="simple_special_part_number" value="" class="form-control">
                                        </#if>
                                    </label>
                                </div>
                                <div class="col-12 col-md-3 col-lg-2 mt-4 mt-md-0" id = "sscw__create_simple_special__new_button_container" >
                                    <div class="sscw__loading_spinner"></div>
                                    <#--                                    <button type="button" id="btn-accept" class="btn btn-primary btn-new-simple-special disabled"><@fmt.message key="eshop.accept"/></button>-->
                                </div>
                                <div class="col-12 col-lg-5 mt-4 mt-md-0 hidden">
                                    <label class="" for="" id = "new_ss_label" >
                                        <span class="d-block mb-2"><@fmt.message key="cylinderConfigurator.yourNewSS"/></span>
                                    </label>
                                    <label class = "hidden" for=""  id = "new_version_label" >
                                        <span class="d-block mb-2 "><@fmt.message key="cylinderConfigurator.yourNewVersion"/></span>
                                    </label>
                                    <span class="form-control border-0" id="new_version_text"></span>
                                </div>
                            </div>
                        </div>
                        <div id = "sscw__create_simple_special_created" class = "hidden">
                            <section  class="px-4 sscw__alias">
                                <div class="row mb-4 sscw__alias__content">
                                    <div class="col-12 text-center">
                                        <i class="fa fa-check fa-5x mb-4 text-primary"></i>
                                    </div>
                                    <div class="col-12 text-center">
                                        <strong class="sscw__alias__title">
                                            <@fmt.message key="cylinderConfigurator.simpleSpecial_continueProcess"/>
                                            <#--                                            "<span id = "sscw__create_simple_special_created_simpleSpecialCode"></span>"-->
                                            <#--                                            <@fmt.message key="cylinderConfigurator.simpleSpecial_created_post"/>-->
                                        </strong>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div id = "sscw__create_simple_special_creation_failed" class = "hidden">
                            <section  class="px-4 sscw__alias">
                                <div class="row mb-4 sscw__alias__content">
                                    <div class="col-12 text-center">
                                        <i class="fa fa-exclamation-triangle fa-5x mb-4 text-primary"></i>
                                    </div>
                                    <div class="col-12 text-center">
                                        <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.error.general"/></strong>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </article>

                    <article class="hidden px-4 sscw__zip_file wizard_article" id="sscw__zip_file">
                        <div class="row">
                            <div class="col-12">
                                <p><@fmt.message key="cylinderConfigurator.selectDocumentation"/>:</p>
                                <#include "cylinder-configurator/_documentation-options.ftl">
                            </div>
                        </div>
                    </article>

                    <#--                    <article class="hidden px-4 sscw__alias wizard_article" id="sscw__alias">-->
                    <#--                        <div class="row mb-4 sscw__alias__content">-->
                    <#--                            <div class="col-12">-->
                    <#--                                <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.assignAliasToConf"/></strong>-->
                    <#--                            </div>-->
                    <#--                            <div class="col-12 col-lg-8">-->
                    <#--                                <form class="sscw__alias__form mt-4">-->
                    <#--                                    <label for="alias" class="d-block mb-2">-->
                    <#--                                        <input type="text" name="alias" id="alias" value="" placeholder="<@fmt.message key="cylinderConfigurator.aliasPlaceholder"/>" class="form-control">-->
                    <#--                                    </label>-->
                    <#--                                </form>-->
                    <#--                            </div>-->
                    <#--                        </div>-->
                    <#--                    </article>-->

                    <article class="hidden px-4 sscw__summary_confirmation wizard_article" id="sscw__summary_confirmation">
                        <div id = "sscw__summary_confirmation_data_container" >
                            <#--                            <div class="row mb-4 sscw__summary_confirmation__customer">-->
                            <#--                                <div class="col-12">-->
                            <#--                                    <strong class="sscw__summary_confirmation__title"><@fmt.message key="cylinderConfigurator.customer"/></strong>-->
                            <#--                                    <hr>-->

                            <#--                                    <div class="sscw__info_table">-->
                            <#--                                        <div class="sscw__summary_confirmation__content__title sscw__info_table__title">-->
                            <#--                                            <@fmt.message key="cylinderConfigurator.customerNumber"/>-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__info_table__value" id = "sscw__info_table_customerNumber">-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__summary_confirmation__content__title sscw__info_table__title">-->
                            <#--                                            <@fmt.message key="cylinderConfigurator.customerName"/>-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__info_table__value" id = "sscw__info_table_customerName">-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__summary_confirmation__content__title sscw__info_table__title">-->
                            <#--                                            <@fmt.message key="cylinderConfigurator.addressZipCode"/>-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__info_table__value" id = "sscw__info_table_customerAddress">-->
                            <#--                                        </div>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->
                            <#--                            </div>-->
                            <#--                            <div class="row mb-4 sscw__summary_confirmation__simple_special">-->
                            <#--                                <div class="col-12">-->
                            <#--                                    <strong class="sscw__summary_confirmation__title"><@fmt.message key="cylinderConfigurator.simpleSpecial"/></strong>-->
                            <#--                                    <hr>-->
                            <#--                                    <div class="sscw__info_table">-->
                            <#--                                        <div class="sscw__summary_confirmation__content__title sscw__info_table__title">-->
                            <#--                                            <@fmt.message key="cylinderConfigurator.simpleSpecialReference"/>-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__info_table__value" id = "sscw__info_table_simpleSpecialReference">-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__summary_confirmation__content__title sscw__info_table__title">-->
                            <#--                                            <@fmt.message key="cylinderConfigurator.mounted"/>-->
                            <#--                                        </div>-->
                            <#--                                        <div class="sscw__info_table__value" id = "sscw__info_table_mounted">-->
                            <#--                                            <span id = "sscw_summary_mounted_yes" class="hidden"><@fmt.message key="cylinderConfigurator.yes"/></span>-->
                            <#--                                            <span id = "sscw_summary_mounted_no" class="hidden"><@fmt.message key="cylinderConfigurator.no"/></span>-->
                            <#--                                        </div>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->
                            <#--                            </div>-->
                            <#--                            <div class="row sscw__summary_confirmation__zip_file" id = "sscw__summary_confirmation__zip_file_container">-->
                            <#--                                <div class="col-12">-->
                            <#--                                    <strong class="sscw__summary_confirmation__title"><@fmt.message key="cylinderConfigurator.zipFile"/></strong>-->
                            <#--                                    <hr>-->
                            <#--                                    <div class="sscw__summary_confirmation__zip_file__content">-->
                            <#--                                        <#include "cylinder-configurator/_summary_documentation-options.ftl">-->
                            <#--                                        <div class="d-block ">-->
                            <#--                                            <div class="sscw__summary_confirmation__content__title sscw_summary_configurationCAD_container hidden">-->
                            <#--                                                <@fmt.message key="cylinderConfigurator.cadFile"/>-->
                            <#--                                            </div>-->
                            <#--                                            <ul class="pl-4 list-unstyled sscw_summary_configurationCAD_container">-->
                            <#--                                                <li id="sscw_summary_selected_cad"></li>-->
                            <#--                                            </ul>-->
                            <#--                                        </div>-->
                            <#--                                    </div>-->
                            <#--                                </div>-->
                            <#--                            </div>-->
                        </div>
                        <div id = "sscw__summary_confirmation_zip_created" class = "hidden">
                            <section  class="px-4 sscw__alias">
                                <div class="row mb-4 sscw__alias__content">
                                    <div class="col-12 text-center">
                                        <i class="fa fa-check fa-5x mb-4 text-primary"></i>
                                    </div>
                                    <div class="col-12 text-center">
                                        <div id="createdNoError">
                                            <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.zip_created"/></strong>
                                        </div>
                                        <div id="createdCadError" style="display: none;">
                                            <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.zip_created_cad_error"/></strong>
                                        </div>
                                    </div>
                                    <div class="col-12 text-center">
                                        <strong class="sscw__alias__title">
                                            <@fmt.message key="cylinderConfigurator.simpleSpecial_created_pre"/>
                                            "<span id="sscw__create_simple_special_created_simpleSpecialCode"></span>"
                                            <@fmt.message key="cylinderConfigurator.simpleSpecial_created_post"/>
                                        </strong>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div id = "sscw__summary_confirmation_zip_creation_failed" class = "hidden">
                            <section  class="px-4 sscw__alias">
                                <div class="row mb-4 sscw__alias__content">
                                    <div class="col-12 text-center">
                                        <i class="fa fa-exclamation-triangle fa-5x mb-4 text-primary"></i>
                                    </div>
                                    <div class="col-12 text-center">
                                        <strong class="sscw__alias__title"><@fmt.message key="cylinderConfigurator.zip_creation_failed"/></strong>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </article>


                </section>
            </div>
            <div class="modal-footer">
                <div class="button_group--left">
                    <button type="button" id="btn-return" class="btn btn-secondary btn-secondary--blue-border cylinder-cancel-button" data-dismiss="modal"><@fmt.message key="cylinderConfigurator.cancel"/></button>
                    <button type="button" id="btn-back" class="btn btn-secondary btn-secondary--blue-border disabled"><@fmt.message key="cylinderConfigurator.back"/></button>
                </div>
                <div class="button_group--right">
                    <button type="button" id="btn-skip" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="cylinderConfigurator.skip"/></button>
                    <button type="button" id="btn-next" class="btn btn-primary" ><@fmt.message key="cylinderConfigurator.next"/></button>
                    <button type="button" id="btn-finish" class="btn btn-primary"><@fmt.message key="cylinderConfigurator.finish"/></button>
                    <button type="button" id="btn-close" class="btn btn-primary hidden"><@fmt.message key="cylinderConfigurator.close"/></button>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    // var cylinderWizardModal;
    //
    // $(document).ready(function () {
    //     if (cylinderWizardModal === undefined) {
    //         createCylinderWizardModal();
    //     }
    //     $("#create-simple-special-button").click(function() {
    //         $(".aareo__cylinder__part_rodEnd .aareo__cylinder__part_position_js:visible").click();
    //         //If we don't need to remove data from wizard on second attempt, remove this reset
    //         cylinderWizardModal.resetWizard();
    //         cylinderWizardModal.showSummaryModal();
    //     });
    // });
    //
    // function createCylinderWizardModal() {
    //     var CylinderWizardModal = window.smc.CylinderWizardModal;
    //     var config = {
    //         id: "cylinder-wizard-modal",
    //         productConfiguratorComponent: window.smc.productConfiguratorComponent
    //     };
    //     smc.CylinderWizardModal.urls = {
    //         searchCustomer: document.getElementById('searchCustomer').href,
    //         acceptSimplePartNumberCreation: document.getElementById('acceptSimplePartNumberCreation').href,
    //         getCadOptions:  document.getElementById('getCadOptions').href,
    //         getZipFile :  document.getElementById('getZipFile').href,
    //         createSimpleSpecialAlias : document.getElementById('createSimpleSpecialAlias').href,
    //         getCylinderSummaryTableBySimpleSpecial: document.getElementById("getCylinderSummaryTableBySimpleSpecialLink").href
    //     };
    //     cylinderWizardModal = new CylinderWizardModal(config);
    //     cylinderWizardModal.init();
    // }

</script>