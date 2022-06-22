<#compress>



</#compress>

<div class="modal fade" id="modal-import-baskets" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><@fmt.message key="basket.importModal.title"/></h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-save" class="alert alert-danger m-2 modal-message" hidden> </div>
            <div class="modal-body">
                <smc-spinner-inside-element params="loading: loading"></smc-spinner-inside-element>

                <!-- ko if: $data.currentPage() === 0 -->
                    <#include "./import-modal-file.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 1 -->
                    <#include "./import-modal-complete.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 2 -->
                    <#include "./import-modal-summary.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 3 -->
                    <#include "./import-modal-end.ftl">
                <!-- /ko -->

            </div>
            <div class="modal-footer">

                <!-- ko if: $data.currentPage() !== 3 -->
                    <button type="button btn-danger"  class="btn btn-danger" data-bind="click: $data.close"><@fmt.message key="eshop.cancel"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 3 -->
                    <button type="button btn-danger"  class="btn btn-primary" data-bind="click: $data.close"><@fmt.message key="eshop.accept"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 1 -->
                    <button type="button btn-danger"  class="btn btn-primary" data-bind="click: $data.nextPage, enable: $data.nextToSummaryEnabled"><@fmt.message key="eshop.next"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 2 -->
                    <button type="button btn-danger"  class="btn btn-primary" data-bind="click: $data.confirmProducs"><@fmt.message key="eshop.import.addProducts"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 0 -->
                <form id="importForm" enctype="multipart/form-data" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post" >
                    <div class="">
                        <label for="importBasket" class="btn btn-primary btn-import">
                            <@fmt.message key="eshop.importFromFile"/>
                        </label>
                        <input data-bind="event: { change: $root.validateFile.bind($data, 'BASKET')}" multiple type="file" name="file_input[]" id="importBasket" style="display:none;" accept=".xls,.xlsx">
                    </div>
                </form>
                <!-- /ko -->
            </div>
        </div>
    </div>
</div>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/basket/ImportBasketViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution  category="htmlBodyEnd">

<script type="text/javascript">

	var IMPORT_MESSAGES = {

	};

    var importBasketViewModel;

    $(document).ready(function(){
        ko.di.register(IMPORT_MESSAGES,"ImportMessages");
        ko.di.register(window['$1110'] ? $1110 : $,"jQuery");

		importBasketViewModel = new ImportBasketViewModel();
		$(document).ready(function(){
			var importDOM = document.getElementById("modal-import-baskets");
			ko.applyBindings(importBasketViewModel, importDOM);

		});
    });
 </script>
 </@hst.headContribution>