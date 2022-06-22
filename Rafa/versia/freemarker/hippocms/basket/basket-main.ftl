<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
<@security.authorize access="hasRole('ROLE_sapariba_user')" var="isSaparibaUser"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternal"/>
<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />
<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>
<@hst.setBundle basename="eshop,scan"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.save" var="labelSave"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.import" var="labelImport"/>
<@fmt.message key="basket.editErrorMssg" var="labelEditErrorMssg"/>
<@fmt.message key="basket.basketSaveEmptyDescription" var="labelBasketSaveEmptyDescription"/>
<@fmt.message key="eshop.moreInfoNotAvailable" var="labelMoreInfoNotAvailable"/>
<@hst.link var="search" siteMapItemRefId="search"/>
</#compress>
<#if !isAuthenticated || isLightUser || isInternal>
    <#include "./product-selection.ftl">
<#elseif isTechnicalUser || isProfessionalUser || isAdvancedUser || isOciUser || isSaparibaUser >
    <#include "./basket-details.ftl">
</#if>
<#include "../../digitalcatalog/catalog-macros.ftl">
<#include "../../digitalcatalog/product/product-toolbar-macro.ftl">
<@hst.actionURL var="actionURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.componentRenderingURL var="renderUrl"/>
<@hst.headContribution keyHint="3" category="htmlHead">
<@hst.resourceURL var="importFileUrl" resourceId="IMPORT_BASKET"/>
<@hst.resourceURL var="checkAliasUrl" resourceId="CHECK_ALIAS"/>
<@hst.resourceURL var="importProductsUrl" resourceId="IMPORT_PRODUCTS"/>
<@hst.resourceURL var="exportBasketUrl" resourceId="EXPORT_BASKET"/>
<@hst.resourceURL var="exportImportBasketTemplateUrl" resourceId="EXPORT_IMPORT_BASKET_TEMPLATE"/>
<script>
    var renderUrl;
    var actionUrl;
    var resourceUrl;
    var refreshTechnicalInfo;
    var cancelBtn = '${labelCancel?js_string}';
    var saveBtn = '${labelSave?js_string}';
    var acceptBtn = '${labelAccept?js_string}';
    var importBtn = '${labelImport?js_string}';
    var basketSaveError = '${labelEditErrorMssg?js_string}';
    var basketSaveEmptyDescription = '${labelBasketSaveEmptyDescription?js_string}';
    var moreInfoNotAvailableMssg = '${labelMoreInfoNotAvailable?js_string}';
    var importFileUrl = '${importFileUrl}';
    var exportBasketUrl = '${exportBasketUrl}';
    var exportImportBasketTemplateUrl = '${exportImportBasketTemplateUrl}';
    var checkAliasUrl = '${checkAliasUrl}';
    var importProductsUrl = '${importProductsUrl}';
</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
<script type="text/javascript">
$(document).ready(function(){
    renderUrl="${renderUrl}";
    resourceUrl="${serveResourceURL}";
    refreshTechnicalInfo = <#if updating??>"${updating}"<#else>"false"</#if>;
    actionUrl = "${actionURL}";
});
</script>
</@hst.headContribution>
<@hst.headContribution  category="htmlBodyEnd">
    <script type="text/javascript">
        $(document).ready(function(){
            var basketLayerBindDom = document.getElementById("new_box_container")
            //ko.cleanNode(basketLayerBindDom);
            ko.applyBindings(basketViewModel, basketLayerBindDom);
        });
    </script>
</@hst.headContribution>