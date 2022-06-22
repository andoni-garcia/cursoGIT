<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="myProfileLink" siteMapItemRefId="myProfile"/>
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
<@security.authorize access="hasRole('ROLE_sapariba_user')" var="isSaparibaUser"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>

<@hst.actionURL var="actionURL"/>
<@hst.setBundle basename="eshop"/>

<@fmt.message key="users.regexErrorMssg" var="labelRegexErrorMssg"/>
<@fmt.message key="users.errorUpdatePassword" var="labelErrorUpdatePassword"/>
<@fmt.message key="users.notEqualsMssg" var="labelNotEqualsMssg"/>
<@fmt.message key="users.succesUpdatingMssg" var="labelSuccessUpdatingMssg"/>
<@fmt.message key="users.errorUpdatingProfileMssg" var="labelErrorUpdatingProfileMssg"/>
<@fmt.message key="users.errorDeletingProfile" var="labelErrorDeletingProfile"/>

<@fmt.message key="users.successUpdatePassword" var="successUpdatePassword"/>
<@fmt.message key="users.errorUpdatePassword" var="errorUpdatePassword"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.update" var="labelUpdate"/>
<@fmt.message key="eshop.delete" var="labelDelete"/>

<main class="smc-main-container eshop" id ="profile-vm">
        <div class="container mb-30">
                <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
        </div>
 <#if isLightUser>

        <#include "./my-profile-light.ftl">
<#elseif isTechnicalUser || isProfessionalUser || isAdvancedUser || isInternalUser || isOciUser || isSaparibaUser >

        <#include "./my-profile-pro.ftl">
</#if>
<#include "./my-profile-password.ftl">
</main>

<@hst.actionURL var="actionURL"/>
<@hst.componentRenderingURL var="componentRenderingURL"/>
<@hst.resourceURL var="serveResourceURL"/>
<@hst.resourceURL var="profileUpdatePasswordUrl" resourceId="UPDATE_PASSWORD"/>
<@hst.resourceURL var="profileDeleteUrl" resourceId="DELETE_USER"/>

<@hst.headContribution category="htmlHead">
<script>

        var actionUrl;
        var renderUrl;
        var resourceUrl;
        var profileUpdatePasswordUrl;
        var profileDeleteUrl;

        var permissions = {};
        var token;
        var profileViewModel;

        var regexPasswordErrorMssg = '${labelRegexErrorMssg?js_string}';
        var errorUpdatingPasswordMssg = '${labelErrorUpdatePassword?js_string}';
        var notEqualsPasswordsMssg = '${labelNotEqualsMssg?js_string}';
        var successUpdatingProfileMssg = '${labelSuccessUpdatingMssg?js_string}';
        var errorUpdatingProfileMssg = '${labelErrorUpdatingProfileMssg?js_string}';
        var errorDeletingProfile = '${labelErrorDeletingProfile?js_string}';
        var successUpdatePassword = '${successUpdatePassword?js_string}';
        var errorUpdatePassword = '${errorUpdatePassword?js_string}';

        var cancelBtn = '${labelCancel?js_string}';
        var updateBtn = '${labelUpdate?js_string}';
        var deleteBtn = '${labelDelete?js_string}';

</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout.checkbox.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/profile/ProfileViewModel.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/profile/ProfileRepository.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
 <script type="text/javascript">

	$(document).ready(function() {
	        renderUrl = "${componentRenderingURL}";
		resourceUrl = "${serveResourceURL}";
		actionUrl = "${actionURL}";

                token = '${_csrf.token}';


		//Knockout
		profileDeleteUrl = '${profileDeleteUrl}';
                profileUpdatePasswordUrl = '${profileUpdatePasswordUrl}';

		profileViewModel = new ProfileViewModel();
                var favouritesDom = document.getElementById("profile-vm");
                ko.applyBindings(profileViewModel, favouritesDom);

	});
</script>
</@hst.headContribution>