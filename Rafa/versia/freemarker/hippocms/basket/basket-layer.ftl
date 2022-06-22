<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>
<#include "../../digitalcatalog/catalog-macros.ftl">
<#include "../../digitalcatalog/product/product-toolbar-macro.ftl">

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternal"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>

<@security.authentication property="principal.showNetPrice" var="showNetPrice" />
<@security.authentication property="principal.showListPrice" var="showListPrice" />

<@hst.setBundle basename="eshop,scan"/>
<@hst.link var="search" siteMapItemRefId="search"/>
<@hst.link var="basketLink" siteMapItemRefId="basket"/>


<@fmt.message key="eshop.searchPlaceholder" var="searchPlaceHolder"/>
<@fmt.message key="basket.partnumberPlaceholder" var="partnumberPlaceholder"/>
<@fmt.message key="eshop.close" var="msgModalClose"/>
<@fmt.message key="eshop.cancel" var="msgModalCancel"/>
<@fmt.message key="eshop.delete" var="msgModalDelete"/>
<@fmt.message key="favourites.noSelectedTitle" var="modalTitleNothingSelected"/>
<@fmt.message key="eshop.mssg.mustSelectElement" var="modalMsgNothingSelected"/>


<@fmt.message key="eshop.assign" var="labelAssign"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.close" var="labelClose"/>
<@fmt.message key="eshop.selection" var="labelSelection"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.mssg.mustSelectElement" var="labelMsgMustSelectElement"/>
<@fmt.message key="basket.title" var="labelBasketTitle"/>
<@fmt.message key="basket.productAdded" var="labelProductAdded"/>
<@fmt.message key="basket.productsAdded" var="labelProductsAdded"/>
<@fmt.message key="basket.someProductsAdded" var="labelSomeProductsAdded"/>
<@fmt.message key="basket.allProductsAlreadyAdded" var="labelAllProductsAlreadyAdded"/>
<@fmt.message key="basket.productAlreadyAdded" var="labelProductAlreadyAdded"/>
<@fmt.message key="basket.order.byInsertion" var="labelOrderByInsertion"/>
<@fmt.message key="basket.order.byDescription" var="labelOrderByDescription"/>
<@fmt.message key="basket.order.byPartnumber" var="labelOrderByPartnumber"/>
<@fmt.message key="basket.modalAssociatePnCpn.title" var="labelModalAssociatePnCpnTitle"/>
<@fmt.message key="basket.modalAssociatePnCpn.message" var="labelModalAssociatePnCpnMessage"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>
<@fmt.message key="basket.deletemodal.title" var="labelDeleteModalTitle"/>
<@fmt.message key="basket.deletemodal.message" var="labelDeleteModalMessage"/>
<@fmt.message key="basket.deletemodal.emptybasket.message" var="labelDeleteModalEmptyBasketMessage"/>
<@fmt.message key="basket.invalidmodal.title" var="labelInvalidModalTitle"/>
<@fmt.message key="basket.invalidmodal.message" var="labelInvalidModalMessage"/>
<@fmt.message key="eshop.notification.favouritesAdded" var="labelNotificationFavouritesAdded"/>
<@fmt.message key="eshop.notification.favouritesNotAdded" var="labelNotificationFavouritesNotAdded"/>
<@fmt.message key="mail.notificationError" var="labelNotificationError"/>
<@fmt.message key="basket.message.quantityChanged" var="labelMessageQuantityChanged"/>
<@fmt.message key="basket.message.partnumberCodeReplaced" var="labelMessagePartnumberCodeReplaced"/>
<@fmt.message key="basket.message.outOfStockWithFewPieces" var="labeloutOfStockWithFewPieces"/>
<@fmt.message key="basket.message.moreThanMaximunOffered" var="labelmoreThanMaximunOffered"/>
<@fmt.message key="basket.updatedCustomerPartNumber" var="labelUpdatedCustomerPartNumber"/>
<@fmt.message key="basket.updatedCustomerPartNumberError" var="labelUpdatedCustomerPartNumberError"/>
<@fmt.message key="basket.successSaveBasket" var="labelSuccessSaveBasket"/>
<@fmt.message key="basket.errorImport" var="labelErrorImportBasket"/>
<@fmt.message key="basket.startImport" var="labelStartImportBasket"/>
<@fmt.message key="basket.invalidFormatFile" var="labelInvalidFormatFiletBasket"/>
<@fmt.message key="basket.exportNotSelected" var="labelExportNotSelected"/>
<@fmt.message key="basket.exportError" var="labelExportError"/>
<@fmt.message key="basket.outOfStock" var="labelOutOfStock"/>

<@fmt.message key="basket.errorSaveBasket" var="labelErrorSaveBasket"/>
<@fmt.message key="oci.dataNotFound" var="labelOciDataNotFound"/>
<@fmt.message key="oci.productsNotFound" var="labelOciProductsNotFound"/>
<@fmt.message key="oci.invalidResponse" var="labelOciInvalidResponse"/>
<@fmt.message key="oci.logoutError" var="labelOciLogoutError"/>
<@fmt.message key="oci.defaultError" var="labelOciDefaultError"/>
<@fmt.message key="oci.hookUrlNotFound" var="labelOciHookUrlNotFound"/>

<@fmt.message key="basket.available" var="labelAvailable"/>
<@fmt.message key="basket.partialAvailable" var="labelPartialAvailable"/>
<@fmt.message key="basket.notAvailable" var="labelNotAvailable"/>

<@fmt.message key="basket.partialAvailableWarningMessage" var="labelPartialAvailableWarningMessage"/>

<@fmt.message key="favourites.toFavouritesSuccess" var="labelToFavouritesSuccess"/>
<@fmt.message key="favourites.toFavouritesError" var="labelToFavouritesError"/>

</#compress>

<#include "../bootstrap-components/custom-modal.ftl">
<@customModal primaryButton="${msgModalDelete}" secondaryButton="${msgModalCancel}"/>
<@customModal htmlId="modal-confirmation" secondaryButton="${msgModalClose}"/>
<@customModal htmlId="modal-nothing-selected" title="${modalTitleNothingSelected}" message="${modalMsgNothingSelected}" primaryButton="${msgModalClose}" haveSecondary=false/>

<div id="basketLayerBind" data-swiftype-index='false'>
<#if !isAuthenticated || isLightUser || isInternal>
	<#include "./basket-layer-anom.ftl">
<#else>
	<#include "./basket-layer-logged.ftl">
</#if>
</div>

<div>
<#if isAuthenticated && !isLightUser && !isInternal>
	<#include "./share/share-modal.ftl">
	<#include "./import/import-modal.ftl">
</#if>
</div>
<#include "./basket-scan.ftl">
<@hst.headContribution keyHint="basket-layer" category="htmlHead">
<script>
	var selectedErp;
    var addBasketProductUrl;
	var getBasketProductsUrl;
	var updateBasketQuantityUrl;
    var deleteBasketProductUrl;
	var addToFavouriteBasketProduct;
	var getMatchingPartnumbers;
	var orderSetPreferredDeliveryDateUrl;
	var orderSetAllPreferredDeliveryDateUrl;
	var partnumberDetailsUrl;
	var addAliasToProductBasketUrl;
	var addAliasBasketUrl
	var getAliasBasketUrl;
	var isPartnumberExistsUrl;
	var isAliasExistsUrl;
	var updatePartnumbersUrl;
	var saveBasketUrl;
	var getOciValues;
	var hasProjectBooksUrl;
	var askToSmcUrl;
	var basketLink;
	var goToBasketLogUrl;
	var loadContactsUrl;
	var sendBasketUrl;
	var generateSaparibaUrl;
	var saparibaFormPostUrl;
	var isLightUser;
	var isTechnicalUser;

	var logoutOciUrl;

	var orderPageRelativePath;
	var basketPageRelativePath;

	var basketOrderField;
	var basketOrderType;

	var basketViewModel;
	var ProjectBooksComponent;
    var basketAmount =<#if basketProducts??>"${basketProducts?size}"<#else>0</#if>;
    var token = "${_csrf.token}";
    var csrfToken = "${_csrf.token}";

	var basket_lang = '${hstRequest.locale.language}';

	var requestDateFormat = '${currentFormatDate}';
	isLightUser ='${isLightUser?c}' === 'true';
	isTechnicalUser = '${isTechnicalUser?c}' === 'true';

	var hippoBaseRelativeUrlTemplate = hippoBaseRelativeUrlTemplate || '${hippoBaseRelativeUrlTemplate?js_string}';

</script>
</@hst.headContribution>
<@hst.headContribution category="scriptsEssential">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/libs/underscore-min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scriptsEssential">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/extend/extend.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scriptsEssential">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/common-utils.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout-3.4.2.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/DependencyInjection.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.ajax.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.core.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.alias.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.common-utils.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.common-downloads.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.common-date.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.common-prices.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Autocomplete.enhaced.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Focus.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Submit.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Fade.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/bindings/Numeric.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.bootstrap-modal.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.smc-spinner.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.selectall-check.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/extenders/ToUpperCase.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/BasketViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/BasketProductRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/BasketProduct.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
 	<script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/BasketProductLine.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/AddToBasket.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/basket/ask-smc-item.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap-components/custom-modal.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap-components/multi-step-modal.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap-components/bootstrap-notify.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/partnumberinfo/more-info.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/basket/oci.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/partnumberinfo/partnumber-info.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/projectbook/projectbooks.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution  category="htmlBodyEnd">

<script type="text/javascript">

	var BASKET_MESSAGES = {
		assign : '${labelAssign?js_string}',
		cancel : '${labelCancel?js_string}',
		close : '${labelClose?js_string}',
		selection : '${labelSelection?js_string}',
		accept : '${labelAccept?js_string}',
		selectAtLeastOne : '${labelMsgMustSelectElement?js_string}',
		basketTitle : '${labelBasketTitle?js_string}',
		productAdded : '${labelProductAdded?js_string}',
		productsAdded : '${labelProductsAdded?js_string}',
		someProductsAdded : '${labelSomeProductsAdded?js_string}',
		allProductsAlreadyAdded : '${labelAllProductsAlreadyAdded?js_string}',
		productAlreadyAdded : '${labelProductAlreadyAdded?js_string}',

		orderByInsertion : '${labelOrderByInsertion?js_string}',
		orderByDescription : '${labelOrderByDescription?js_string}',
		orderByPartnumber : '${labelOrderByPartnumber?js_string}',

		modalAssociatePnCpnTitle : '${labelModalAssociatePnCpnTitle?js_string}',
		modalAssociatePnCpnMessage : '${labelModalAssociatePnCpnMessage?js_string}',
		modalDeleteConfirmButtonText : '${labelDelete?js_string}',
		modalDeleteTitle : '${labelDeleteModalTitle?js_string}',
		modalDeleteMessage : '${labelDeleteModalMessage?js_string}',
		modalEmptyDeleteMessage : '${labelDeleteModalEmptyBasketMessage?js_string}',
		modalInvalidProductsTitle : '${labelInvalidModalTitle?js_string}',
		modalInvalidProductsMessage : '${labelInvalidModalMessage?js_string}',

		addedFavouritesNotification : '${labelNotificationFavouritesAdded?js_string}',
		notAddedFavouritesNotification : '${labelNotificationFavouritesNotAdded?js_string}',
		errorSendingAskToSmc : '${labelNotificationError?js_string}',

		messageQuantityChanged : '${labelMessageQuantityChanged?js_string}',
		messagePartnumberCodeReplaced : '${labelMessagePartnumberCodeReplaced?js_string}',
		messageOutOfStockWithFewPieces : '${labeloutOfStockWithFewPieces?js_string}',
		messageMoreThanMaximunOffered : '${labelmoreThanMaximunOffered?js_string}',
		updatedCustomerPartNumber: '${labelUpdatedCustomerPartNumber?js_string}',
		updatedCustomerPartNumberError: '${labelUpdatedCustomerPartNumberError?js_string}',

		successSaveBasket: '${labelSuccessSaveBasket?js_string}',
		errorSaveBasket: '${labelErrorSaveBasket?js_string}',

		errorImportBasket: '${labelErrorImportBasket?js_string}',
		startImportBasket: '${labelStartImportBasket?js_string}',
		invalidFormatFile: '${labelInvalidFormatFiletBasket?js_string}',

		labelExportNotSelected: '${labelExportNotSelected?js_string}',
		labelExportError : '${labelExportError?js_string}',

		favouritesSuccess: '${labelToFavouritesSuccess?js_string}',
        favouritesError: '${labelToFavouritesError?js_string}',

		nothingSelected: '${modalMsgNothingSelected?js_string}',
		closeBtn : '${msgModalClose?js_string}',

		sapAvailable : '${labelAvailable?js_string}',
		sapPartialAvailable : '${labelPartialAvailable?js_string}',
		sapNotAvailable : '${labelNotAvailable?js_string}',
		sapPartialAvailableWarningMessage : '${labelPartialAvailableWarningMessage?js_string}',

		labelOutOfStock: '${labelOutOfStock?js_string}'
	};

	var OCI_MESSAGES = {
		dataNotFound: '${labelOciDataNotFound?js_string}',
		productsNotFound: '${labelOciProductsNotFound?js_string}',
		invalidResponse: '${labelOciInvalidResponse?js_string}',
		logoutError: '${labelOciLogoutError?js_string}',
		defaultError: '${labelOciDefaultError?js_string}',
		hookUrlNotFound: '${labelOciHookUrlNotFound?js_string}',
	}

    $(document).ready(function(){

        addBasketProductUrl = "<@hst.resourceURL resourceId='ADD_PRODUCT'/>";
		getBasketProductsUrl = "<@hst.resourceURL resourceId='GET_PRODUCTS'/>";
		updateBasketQuantityUrl = "<@hst.resourceURL resourceId='UPDATE_QTY_PRODUCT'/>";
        deleteBasketProductUrl =  "<@hst.resourceURL resourceId='DELETE_PRODUCT'/>";
        addToFavouriteBasketProduct = "<@hst.resourceURL resourceId='ADD_FAVOURITE'/>";
		getMatchingPartnumbers = "<@hst.resourceURL resourceId='GET_MATCHING_PARTNUMBER'/>";
		orderSetPreferredDeliveryDateUrl = "<@hst.resourceURL resourceId='SET_BEST_ACHIEVABLE_DELIVERY_DATE'/>";
		orderSetAllPreferredDeliveryDateUrl = "<@hst.resourceURL resourceId='SET_ALL_BEST_ACHIEVABLE_DELIVERY_DATE'/>";
		partnumberDetailsUrl = "<@hst.resourceURL resourceId='GET_PARTNUMBER_DETAILS'/>";
		addAliasToProductBasketUrl = "<@hst.resourceURL resourceId='ADD_CUSTOMER_PARTNUMBER_TO_PRODUCT'/>";
		addAliasBasketUrl = "<@hst.resourceURL resourceId='ADD_CUSTOMER_PARTNUMBER'/>";
		getAliasBasketUrl = "<@hst.resourceURL resourceId='GET_CUSTOMER_PARTNUMBER'/>";
		isPartnumberExistsUrl = "<@hst.resourceURL resourceId='IS_PARTNUMBER_EXISTS'/>";
		isAliasExistsUrl = "<@hst.resourceURL resourceId='IS_ALIAS_EXISTS'/>";
		updatePartnumbersUrl = "<@hst.resourceURL resourceId='UPDATE_PARTNUMBERS'/>";
		saveBasketUrl = "<@hst.resourceURL resourceId='SAVE_BASKET'/>";
		getOciValues = "<@hst.resourceURL resourceId='GET_OCI_VALUES'/>";
		hasProjectBooksUrl = '<@hst.resourceURL resourceId="HAS_PROJECT_BOOKS"/>';
		askToSmcUrl = '<@hst.resourceURL resourceId="ASK_TO_SMC"/>';
		logoutOciUrl = '<@hst.resourceURL resourceId="LOGOUT_OCI"/>';
		goToBasketLogUrl = '<@hst.resourceURL resourceId="GO_TO_ORDERS"/>';
		loadContactsUrl = '<@hst.resourceURL resourceId="LOAD_CONTACTS"/>';
		sendBasketUrl =  '<@hst.resourceURL resourceId="SEND_BASKET"/>';
		generateSaparibaUrl = '<@hst.resourceURL resourceId="GENERATE_SAPARIBA_XML"/>';
		saparibaFormPostUrl = '${browserFormPost}';

		orderPageRelativePath = '<@hst.link siteMapItemRefId="order"/>';
		basketPageRelativePath = '<@hst.link siteMapItemRefId="basket"/>';

		//Order store in session
		basketOrderField = '${productsOrderField}';
		basketOrderType = '${productsOrderType}';

			selectedErp =  <#if selectedErp??>"${selectedErp}"<#else>null</#if>;


        ko.di.register(BASKET_MESSAGES,"BasketMessages");
        ko.di.register(window['$1110'] ? $1110 : $,"jQuery");

		basketViewModel = new BasketViewModel();
		$(document).ready(function(){
			var basketLayerBindDom = document.getElementById("basketLayerBind");
			ko.cleanNode(basketLayerBindDom);
			ko.applyBindings(basketViewModel, basketLayerBindDom);
			ProjectBooksComponent = new ProjectBooksComponent();

			//Extra function
			$(document).on('click', '#eshop-ly-order', function(e){
				e.preventDefault();
				basketViewModel.goToOrder();
			});

		});


        $("#contenido_tablas_eshop").removeClass("hidden");
		$('[data-toggle="tooltip"]').tooltip({
			 selector: true,
		 });

		basketLink = '${basketLink}';

    });
 </script>
 </@hst.headContribution>