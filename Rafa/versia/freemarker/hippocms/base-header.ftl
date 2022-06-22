<#include "../include/imports.ftl">
<@hst.setBundle basename="essentials.global"/>

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->


<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<@hst.include ref="header-logo"/>
<@hst.link var="profileLogo" path="binaries/content/gallery/smc_global/headicons/menu-web-perfil.svg"/>
<@hst.link var="profileLogoPro" path="binaries/content/gallery/smc_global/headicons/menu-web-perfil-pruebas.svg"/>
<@hst.link var="profileLogoOff" path="binaries/content/gallery/smc_global/headicons/menu-web-without-perfil.svg"/>
<@hst.link var="basket" path="binaries/content/gallery/smc_global/headicons/menu-web-basket-full.svg"/>


<@hst.setBundle basename="essentials.homepage,essential.global,workplace"/>

<#assign currentLocale=hstRequest.requestContext.resolvedMount.mount.locale>
<#assign currentCountry =currentLocale?lower_case?substring(3) >

<@fmt.message key="smc.corporate.url" var="corporateUrl"/>

<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternalUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnicalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@security.authorize access="hasRole('ROLE_sapariba_user')" var="isSaparibaUser"/>
<@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
<@security.authentication property="principal.userErpRealMode" var="userErpRealMode" />
<@security.authentication property="principal.userErpModeValue" var="userErpModeValue" />

<ul class="main-header__meta" data-swiftype-index='false'>
    <#-- Contenido comentado url website
    <li class="main-header__meta__corpo d-none d-lg-block">
        <#-- No property --
        <#if corporateUrl?string == "???smc.corporate.url???">
            <a target="_blank" href="https://www.smcworld.com/corporate/"><@fmt.message key="smc.corporate.webSite"/></a>
        <#-- Property not present in current language --
        <#elseif corporateUrl?string == "">
            <a target="_blank" href="https://www.smcworld.com/corporate/"><@fmt.message key="smc.corporate.webSite"/></a>
        <#-- Poperty exists in current language --
        <#else>
            <a target="_blank" href="${corporateUrl}"><@fmt.message key="smc.corporate.webSite"/></a>
        </#if>
    </li>-->
    <#-- Contenido comentado como prueba de nuevos iconos

      <li>

        <@security.authorize access="isAuthenticated()">
            <a href="#" class="main-header__login main-header_eshop-apps ">
                    <#if (isInternalUser || isProfessionalUser || isTechnicalUser || isAdvancedUser || isSaparibaUser || isOciUser) && !userErpRealMode>
                    <span class="main-header_meta_icon icon-warning mr-2" title="${userErpModeValue}"></span>
                    </#if>
                    <span class="main-header__login__label d-none d-lg-block">
                        <@security.authentication property="principal.name" />
                    </span>
                <span class="main-header__meta__icon icon-login"></span>
            </a>
        </@security.authorize>

        <@security.authorize access="! isAuthenticated()">
            <a href="${loginUrl}" class="main-header__login ">
                <span class="main-header__login__label d-none d-lg-block"><@fmt.message key="smc.login"/></span>
                <span class="main-header__meta__icon icon-login"></span>
            </a>
        </@security.authorize>
    </li>

    <@security.authorize access="isAuthenticated() && hasRole('ROLE_internal_user')">
    <li id="workspaceApps">
        <a href="#" class="main-header__workspace main-header_workspace-apps">
            <span class="main-header__login__label d-none d-lg-inline-block mr-0"><@fmt.message key="workplace"/></span>
            <span><i class="fas fa-th"></i><span class="main-header__workspace__amount" id="workspaceAppsAmount">0</span> </span>
        </a>
    </li>
    </@security.authorize>
    -->
    	<@hst.include ref="channel-picker"/>

	<li id="profile-icon">
        <@security.authorize access="isAuthenticated()">
            <a href="#" class="main-header__login main-header_eshop-apps ">
            		<div class="profile-icon">
                    <#if (isInternalUser || isProfessionalUser || isTechnicalUser || isAdvancedUser || isSaparibaUser || isOciUser) && !userErpRealMode>
	                    <img class="top-menu-img" src="${profileLogoPro}"/>
                    <#else>
                    		<img class="top-menu-img" src="${profileLogo}"/>
                    </#if>
                    <span id="current-profile">
                        <@security.authentication property="principal.name" />
                    </span>
                	</div>
            </a>
        </@security.authorize>

        <@security.authorize access="! isAuthenticated()">
            <a href="${loginUrl}" class="main-header__login ">
            		<div class="profile-icon">
            			<img class="top-menu-img" src="${profileLogoOff}"/>
            			<span id="current-profile">Profile</span>
            		</div>
            </a>
        </@security.authorize>
    </li>

    <@security.authorize access="isAuthenticated() && hasRole('ROLE_internal_user')">
    <li id="workspaceApps">
        <a href="#" class="main-header__workspace main-header_workspace-apps">
            <span class="main-header__login__label d-none d-lg-inline-block mr-0"><@fmt.message key="workplace"/></span>
            <span><i class="fas fa-th"></i><span class="main-header__workspace__amount" id="workspaceAppsAmount">0</span> </span>
        </a>
    </li>
    </@security.authorize>
    </li>

	<li id="basketCart">
        <a href="#" class="main-header__cart">
        		<#--		Mirar como utilizar las variables del js o las funciones #if (getBasketAmount()<0)-->
        			<div class="basket-icon">
        				<img class="top-menu-img" height="44px" src="${basket}"/><span class="main-header__cart__amount"></span>
        				<span id="current-basket">Basket</span>
        			</div>
        		<#--  --else>
        			<div><img class="top-menu-img" src="/site/_cmsinternal/binaries/content/gallery/smc_global/headicons/menu-web-basket-empty.svg"/></div>
        		</#if-->
        </a>
    </li>



</ul>

<@hst.include ref="hamburguer-menu" />

<@hst.include ref="header-search-bar" />

<@hst.include ref="header-search-log" />

<@hst.include ref="header-search-redirection" />

<@hst.headContribution category="jquery">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery-ui.min.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/datepicker_languages.js"/>" type="text/javascript"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/popper.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/typeahead-module.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/components/search/dynamic-pagination.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/slick.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/product_catalogue.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/jquery.waypoints.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/parallax.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/video/videoYoutube.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/nouislider.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/nav_manager.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/plp.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/search.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/category_tile.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/picturefill.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/ofi.min.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/main.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/forms/form-validator.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/main-custom.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/js.cookie.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/basket/basket-layer-functions.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfr4ikUWseQt4I2PS8R5vmIM3o10Qjnl8"/>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/salesInfoMenu/menuController.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/accessories-modal/accessories-modal.component.js"/>"></script>
</@hst.headContribution>
<@hst.headContribution category="htmlBodyEnd">
    <script type="text/javascript"
            src="<@hst.webfile path="/freemarker/versia/js-menu/components/etools-help-modal/etools-help-modal.component.js"/>"></script>
</@hst.headContribution>
<script>
    // Picture element HTML5 shiv
    document.createElement( "picture" );

    var knockoutTemplates = '<@hst.webfile path="/freemarker/versia/js-menu/knockout/templates/"/>';

</script>
