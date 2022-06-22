<#include "../../../include/imports.ftl">

<@hst.setBundle basename="eshop,valveconfigurator"/>
<@fmt.message key="type2DTitle" var="type2DTitleLabel"/>
<@fmt.message key="type3DTitle" var="type3DTitleLabel"/>
<@fmt.message key="wizardsimplespecial.createsimplespecial.creationError" var="labelSSCreationError"/>

<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.multistep-title.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WssStepVersioning.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep1.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep2.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep3.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep4.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep5.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep6.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep7.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialCompStep8.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/wizard-simple-special/WizardSimpleSpecialViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<div class="modal fade multi-step" id="wizard-simple-special-modal" role="dialog">
    <div class="modal-dialog modal-lg wss-modal">
        <div class="modal-content">
            <div class="modal-header row m-0 pb-0">
                <div class="col-12 mb-1">
                    <h4 class="modal-title d-inline">Simple special creation wizard</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="col-12">
                    <smc-multi-step-title params="config: config, currentStep: currentPage, increment: incrementor, sharedSteps: $root.sharedSteps">
                        <span data-mst="1"><@fmt.message key="simpleSpecial.step1.title"/></span>
                        <#if versioningPermission>
                        <span data-mst="1a"><@fmt.message key="simpleSpecial.versioning.title"/></span>
                        </#if>
                        <span data-mst="2"><@fmt.message key="simpleSpecial.step2.title"/></span>
                        <span data-mst="3"><@fmt.message key="simpleSpecial.step3.title"/></span>
                        <span data-mst="4"><@fmt.message key="simpleSpecial.step4.title"/></span>
                        <span data-mst="5"><@fmt.message key="simpleSpecial.step5.title"/></span>
                        <span data-mst="6"><@fmt.message key="simpleSpecial.step6.title"/></span>
                        <span data-mst="7"><@fmt.message key="simpleSpecial.step7.title"/></span>
                        <span data-mst="8"><@fmt.message key="simpleSpecial.step8.title"/></span>
                    </smc-multi-step-title>
                </div>
            </div>
            <div class="modal-body">

                <smc-wss-step-1 params="parentVm: $root">
                    <#include "./steps/step-1.ftl">
                </smc-wss-step-1>
                <smc-wss-step-2 params="parentVm: $root">
                    <#include "./steps/step-2.ftl">
                </smc-wss-step-2>
                <smc-wss-step-3 params="parentVm: $root">
                    <#include "./steps/step-3.ftl">
                </smc-wss-step-3>
                <smc-wss-step-4 params="parentVm: $root">
                    <#include "./steps/step-4.ftl">
                </smc-wss-step-4>
                <smc-wss-step-5 params="parentVm: $root">
                    <#include "./steps/step-5.ftl">
                </smc-wss-step-5>
                <smc-wss-step-6 params="parentVm: $root">
                    <#include "./steps/step-6.ftl">
                </smc-wss-step-6>
                <smc-wss-step-7 params="parentVm: $root">
                    <#include "./steps/step-7.ftl">
                </smc-wss-step-7>
                <smc-wss-step-8 params="parentVm: $root">
                    <#include "./steps/step-8.ftl">
                </smc-wss-step-8>
            </div>
            <div class="modal-footer">
                <button type="button" id="vc-wss-btn-create-folder" class="btn btn-primary mr-auto" data-bind="visible: $root.creatingNewFolder() == false, click: $root.createFolder.bind($data)"><@fmt.message key="favourites.createFolder"/></button>
                <div class="mr-auto">
                    <button type="button" id="vc-wss-btn-complete-create-folder" class="btn btn-primary" data-bind="visible: $root.creatingNewFolder() == true, click: $root.completeCreateFolder.bind($data)"><@fmt.message key="eshop.save"/></button>
                    <button type="button" id="vc-wss-btn-cancel-create-folder" class="btn btn-primary mr-auto" data-bind="visible: $root.creatingNewFolder() == true, click: $root.cancelCreateFolder.bind($data)"><@fmt.message key="eshop.cancel"/></button>
                </div>

                <!-- ko if: $root.versioningPermission && $root.versioningState() -->
                <button type="button" id="vc-wss-btn-back" class="btn btn-secondary step step-1" data-bind="click: $root.goToPrevVersioning.bind($data)"><@fmt.message key="eshop.back"/></button>
                <!-- /ko -->

                <!-- ko if: !$root.versioningPermission || ($root.versioningPermission && !$root.versioningState()) -->
                <button type="button" id="vc-wss-btn-back" class="btn btn-secondary step step-1 step-2 step-3 step-4" data-bind="disable: disableBack(), click: $root.goToPrev.bind($data)"><@fmt.message key="eshop.back"/></button>
                <!-- /ko -->

                <button type="button" id="vc-wss-btn-back" class="btn btn-secondary step step-5 step-6 step-7" data-bind="disable: disableBack(), click: $root.generateBackEvent.bind($data)"><@fmt.message key="eshop.back"/></button>
                <button type="button" id="vc-wss-btn-skip" class="btn btn-secondary step step-3" data-bind="click: $root.skip.bind($data)"><@fmt.message key="eshop.skip"/></button>
                <button type="button" id="vc-wss-btn-skip" class="btn btn-secondary step step-4" data-bind="click: $root.skipFile.bind($data)"><@fmt.message key="eshop.skip"/></button>

                <!-- ko if: $root.versioningPermission && !$root.versioningState() -->
                <button type="button" id="vc-wss-btn-next" class="btn btn-primary step step-1" data-bind="disable: selectedCustomerNumber() == null, click: $root.goToNextVersioning.bind($data)"><@fmt.message key="eshop.next"/></button>
                <!-- /ko -->

                <!-- ko if: !$root.versioningPermission || ($root.versioningPermission && $root.versioningState()) -->
                <button type="button" id="vc-wss-btn-next" class="btn btn-primary step step-1" data-bind="disable: disableNext(), click: $root.goToNext.bind($data)"><@fmt.message key="eshop.next"/></button>
                <!-- /ko -->

                <button type="button" id="vc-wss-btn-next" class="btn btn-primary step step-2 step-3 step-7" data-bind="disable: disableNext(), click: $root.goToNext.bind($data)"><@fmt.message key="eshop.next"/></button>

                <button type="button" id="vc-wss-btn-next-4" class="btn btn-primary step step-4 step-5 step-6" data-bind="disable: disableNext(), click: $root.generateNextEvent.bind($data)"><@fmt.message key="eshop.next"/></button>
                <button type="button" id="vc-wss-btn-close" class="btn btn-primary step step-8" data-bind="disable: disableNext(), click: closeWizard"><@fmt.message key="eshop.close"/></button>
            </div>
        </div>
    </div>
</div>

<@hst.resourceURL var="wssGetCustomersUrl" resourceId="GET_CUSTOMERS"/>
<@hst.resourceURL var="wssCreateSimpleSpecialUrl" resourceId="CREATE_SIMPLE_SPECIAL"/>
<@hst.resourceURL var="wssSendToFavouritesUrl" resourceId="SEND_TO_FAVOURITES_SS"/>
<@hst.resourceURL var="wssGenerateZipUrl" resourceId="GENERATE_ZIP_FILE"/>
<@hst.resourceURL var="wssGetCadOptions" resourceId="GET_CAD_OPTIONS"/>
<@hst.resourceURL var="wssGetVersion" resourceId="GET_VERSION"/>


<@hst.headContribution category="scripts">
<script type="text/javascript">

    var wssGetCustomersUrl = '${wssGetCustomersUrl}';
    var wssCreateSimpleSpecialUrl = '${wssCreateSimpleSpecialUrl}';
    var wssSendToFavouritesUrl = '${wssSendToFavouritesUrl}';
    var wssGenerateZipUrl = '${wssGenerateZipUrl}';
    var wssGetCadOptions = '${wssGetCadOptions}';
    var wssGetVersion = '${wssGetVersion}';
    var type3DTitleLabel = '${type3DTitleLabel?js_string}';
    var type2DTitleLabel = '${type2DTitleLabel?js_string}';
    var createSSCreationErrorLabel = '${labelSSCreationError?js_string}';
    var createXls = true;

    var wizardSimpleSpecialViewModel;
    var wizardSimpleSpecialViewModelStep1;
    $(document).ready(function(){

        const TOTAL_SHARED_STEPS = 8;

        let modalId = 'wizard-simple-special-modal';
        wizardSimpleSpecialViewModel = new WizardSimpleSpecialViewModel('#' + modalId, TOTAL_SHARED_STEPS);
        ko.applyBindings(wizardSimpleSpecialViewModel, document.getElementById(modalId));

    });

</script>
</@hst.headContribution>