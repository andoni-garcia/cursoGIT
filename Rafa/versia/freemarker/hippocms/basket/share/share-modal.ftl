<#compress>

    <@fmt.message key="share.descriptionEmpty" var="labelDescriptionCannotBeEmpty"/>
    <@fmt.message key="share.basketEmpty" var="labelBasketEmpty"/>
    <@fmt.message key="share.errorSaving" var="labelErrorSavingBasket"/>
    <@fmt.message key="share.contactNotSelected" var="labelContactNotSelected"/>
    <@fmt.message key="share.successShare" var="labelSuccessShare"/>
    <@fmt.message key="share.errorShare" var="labelErrorShare"/>

    <@fmt.message key="share.title.step1" var="labelTitle1"/>
    <@fmt.message key="share.title.step2" var="labelTitle2"/>
    <@fmt.message key="share.title.step3" var="labelTitle3"/>
    <@fmt.message key="share.title.step4" var="labelTitle4"/>

</#compress>

<div class="modal fade" id="modal-share-baskets" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><span data-bind="text: $data.modalTitle()"></span> <span data-bind="text: $data.currentPage() + 1"></span>&nbsp;/&nbsp;4</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div id="error-dialog-save" class="alert alert-danger m-2 modal-message" hidden> </div>
            <div class="modal-body">
                <smc-spinner-inside-element params="loading: loading"></smc-spinner-inside-element>

                <!-- ko if: $data.currentPage() === 0 -->
                    <#include "./share-modal-save.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 1 -->
                    <#include "./share-modal-contact.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 2 -->
                    <#include "./share-modal-send.ftl">
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 3 -->
                    <#include "./share-modal-end.ftl">
                <!-- /ko -->

            </div>
            <div class="modal-footer">
                <!-- ko if: $data.currentPage() !== 3 -->
                    <button type="button btn-danger"  class="btn btn-danger" data-bind="click: $data.close"><@fmt.message key="eshop.cancel"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() !== 3 && !($data.currentPage() === 1 && $data.contacts().length === 0)-->
                    <button type="button btn-danger"  class="btn btn-primary" data-bind="click: $data.nextPage"><@fmt.message key="eshop.next"/></button>
                <!-- /ko -->
                <!-- ko if: $data.currentPage() === 3 -->
                    <button type="button btn-danger"  class="btn btn-primary" data-bind="click: $data.nextPage"><@fmt.message key="eshop.send"/></button>
                <!-- /ko -->
            </div>
        </div>
    </div>
</div>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/basket/ShareBasketViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution  category="htmlBodyEnd">

<script type="text/javascript">

	var SHARE_MESSAGES = {
        descriptionCannotBeEmpty : '${labelDescriptionCannotBeEmpty?js_string}',
        basketEmpty: '${labelBasketEmpty?js_string}',
        errorSavingBasket: '${labelErrorSavingBasket?js_string}',
        contactNotSelected: '${labelContactNotSelected?js_string}',
        successShare: '${labelSuccessShare?js_string}',
        errorShare: '${labelErrorShare?js_string}',

        title1: '${labelTitle1?js_string}',
        title2: '${labelTitle2?js_string}',
        title3: '${labelTitle3?js_string}',
        title4: '${labelTitle4?js_string}'
	};

    var shareBasketViewModel;

    $(document).ready(function(){
        ko.di.register(SHARE_MESSAGES,"ShareMessages");
        ko.di.register(window['$1110'] ? $1110 : $,"jQuery");

		shareBasketViewModel = new ShareBasketViewModel();
		$(document).ready(function(){
			var shareDOM = document.getElementById("modal-share-baskets");
			ko.applyBindings(shareBasketViewModel, shareDOM);

		});
    });
 </script>
 </@hst.headContribution>