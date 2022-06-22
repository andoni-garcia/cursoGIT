<#include "../../include/imports.ftl">

<#if eshopCadsZipEnabled?? && eshopCadsZipEnabled != "NONE" && ((eshopCadsZipEnabled == "ESHOP_INTERNAL" && !isLightUser) || eshopCadsZipEnabled == "ALL") >

<@hst.setBundle basename="eshop"/>

<@fmt.message key="eshop.download.cads.request.processed" var="eshopDownloadCadRequestProcessed"/>
<@fmt.message key="eshop.download.cads.request.error" var="eshopDownloadCadRequestError"/>
<@fmt.message key="eshop.download.cads.processing.products" var="eshopDownloadCadProcessing"/>
<@fmt.message key="eshop.download.cads.processing.products.max" var="eshopDownloadCadMaxProcessing"/>
<@fmt.message key="eshop.download.cads.type2DTitle" var="type2DTitleLabel"/>
<@fmt.message key="eshop.download.cads.type3DTitle" var="type3DTitleLabel"/>

<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/eshop/download-cads.repository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/eshop/download-cads.viewmodel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<div class="col-xl-3 col-md-6 p-0">
    <div class="mt-3" style="white-space: nowrap;">
        <a href="#" class="a-ko heading-09" data-bind="click: $component.open.bind($data), css: { 'disabled': processing() }">
            <i class="fas fa-envelope"></i> <@fmt.message key="eshop.download.cads"/>
        </a>
        <div style="position: relative; width: 99px; display: inline-block; line-height: normal;"><smc-spinner-inside-element params="loading: processing(), isButton: false"></smc-spinner-inside-element></div>
    </div>
</div>

<div class="modal fade eshop-download-cads-modal" id="eshop-download-cads-modal" tabindex="-1" role="dialog" aria-labelledby="eshop-download-cads-modal-title" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="eshop-download-cads-modal-title">${askSmcAboutLbl}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <!-- ko foreach: cadOptions()    -->
                    <div class="col-6 ">
                        <span class="options-cad--name" data-bind="text: $data.name"></span>
                        <div class="cad-download-format-list collapse show options-cad" >
                            <!-- ko foreach: $data.options    -->
                                <div class="form-check">
                                    <input type="radio" name="cad" data-bind="value: $data.key, attr: { id: $data.key }, event: { change: $component.changeCadOption.bind($data, $data.key) }" />
                                    <label data-bind="text: $data.value, attr: { for: $data.key }"></label>
                                </div>
                            <!-- /ko -->
                        </div>
                    </div>
                    <!-- /ko -->

                </div>
            </div>
            <div class="modal-footer">
                <div class="button_group--left">
                    <button type="button" id="btn-alias-return" class="btn btn-secondary btn-secondary--blue-border" data-bind="click: closeModal"><@fmt.message key="eshop.cancel"/></button>
                </div>
                <div class="button_group--right">
                    <button type="button" id="btn-alias-finish" class="btn btn-primary" data-bind="click: $component.process.bind($data)"><@fmt.message key="eshop.accept"/></button>
                </div>
            </div>
        </div>
    </div>
</div>

<@hst.resourceURL var="eshopDownloadCadGetCadOptionsUrl" resourceId="GET_CAD_OPTIONS"/>
<@hst.resourceURL var="eshopDownloadProcessCadsUrl" resourceId="PROCESS_CADS"/>

<@hst.headContribution category="scripts">
<script type="text/javascript">

    var eshopDownloadCadGetCadOptionsUrl = '${eshopDownloadCadGetCadOptionsUrl}';
    var eshopDownloadProcessCadsUrl = '${eshopDownloadProcessCadsUrl}';
    var eshopDownloadCadMaxNumberOfProducts = <#if eshopDownloadCadMaxProducts??>${eshopDownloadCadMaxProducts}<#else>50</#if>;
    var eshopDownloadCadsViewmodel;
    var type3DTitleLabel = '${type3DTitleLabel?js_string}';
    var type2DTitleLabel = '${type2DTitleLabel?js_string}';

    var ESHOP_DOWNLOAD_CADS_MESSAGES = {
        requestProcessed : '${eshopDownloadCadRequestProcessed?js_string}',
        requestError : '${eshopDownloadCadRequestError?js_string}',
        productsNotUpdated : '${eshopDownloadCadProcessing?js_string}',
        reachMaxProducts : '${eshopDownloadCadMaxProcessing?js_string}'
    }

    $(document).ready(function(){

        //let modalId = 'eshop-download-cads-container';
        //var element = document.getElementById(modalId)
        //eshopDownloadCadsViewmodel = new EshopDownloadCadsViewmodel();
        //ko.cleanNode(element);
        //ko.applyBindings(eshopDownloadCadsViewmodel, element);

    });

</script>
</@hst.headContribution>
</#if>