<#include "../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>
<@security.authorize access="hasRole('ROLE_professional_user')" var="isProfessionalUser"/>
<@security.authorize access="hasRole('ROLE_advanced_user')" var="isAdvancedUser"/>
<@security.authorize access="hasRole('ROLE_oci_user')" var="isOciUser"/>
<@security.authorize access="hasRole('ROLE_sapariba_user')" var="isSaparibaUser"/>
<@security.authorize access="hasRole('ROLE_internal_user')" var="isInternal"/>
<@security.authorize access="hasRole('ROLE_technical_user')" var="isTechnical"/>

<@security.authentication property="principal.selectedErp" var="selectedErp" />
<@security.authentication property="principal.showOrderStatus" var="principalShowOrderStatus" />

<@hst.link var="favouritesLink" siteMapItemRefId="favourites"/>
<@hst.link var="basketLink" siteMapItemRefId="basket"/>
<@hst.link var="orderLink" siteMapItemRefId="order"/>
<@hst.link var="orderStatusLink" siteMapItemRefId="orderStatus"/>
<@hst.link var="mybasketsLink" siteMapItemRefId="myBaskets"/>
<@hst.link var="myordersLink" siteMapItemRefId="myOrders"/>
<@hst.link var="myProfileLink" siteMapItemRefId="myProfile"/>
<@hst.link var="projectBooks" siteMapItemRefId="myProjectBooks"/>
<@hst.link var="receivedLink" siteMapItemRefId="received"/>

<@hst.setBundle basename="eshop"/>



<div class="eshop-apps-selector text-01" data-swiftype-index="false">
	<h2 class="heading-03"><@fmt.message key="eshop.layer.title"/></h2>
	<div class="smc-close-button" data-swiftype-index="false">&times;</div>

    <p><@fmt.message key="eshop.layer.description"/></p>

    <#if !(blockedUser?has_content) || (blockedUser?has_content && !blockedUser)>
    <ul>
        <!-- We need to filter which ones are bottom left items and which ones are normal items -->
        <li>
            <a href="${basketLink}">
                <#if isLightUser || isInternal>		
                    <@fmt.message key="product.selection.title"/>            		            
                <#else>	
                    <@fmt.message key="basket.title"/>
                </#if>	
            </a>
        </li>
        <#if isProfessionalUser>
        <li><a href="${orderLink}" id="eshop-ly-order"><@fmt.message key="order.title"/></a></li>
        </#if>
        <#if principalShowOrderStatus?? && principalShowOrderStatus == "1"><li><a href="${orderStatusLink}"><@fmt.message key="eshop.orderStatus"/></a></li></#if>
        <li><a href="${favouritesLink}"><@fmt.message key="favourites.title"/></a></li>
        <#if isProfessionalUser || isAdvancedUser || isOciUser || isSaparibaUser || isTechnical >
        <li><a href="${mybasketsLink}"><@fmt.message key="mybaskets.title"/></a></li>
        <#if isProfessionalUser && selectedErp!=DYNAMICS_ERP>
        <li><a href="${myordersLink}"><@fmt.message key="myorders.title"/></a></li>
        </#if>
        </#if>
        <li><a href="${projectBooks}" id="pb-menu-item" class="hidden"><@fmt.message key="projectBooks.title"/></a></li>
        <#if !federatedUser>
        <li><a href="${myProfileLink}"><@fmt.message key="users.myprofile.title"/></a></li>
        </#if>
        <#if receivedCount?? && receivedCount gt 0>
        <li><a href="${receivedLink}"><@fmt.message key="received.title"/> <span class="badge badge-pill badge-primary">${receivedCount}</span></a></li>
        </#if>
    </ul>
    </#if>

    <div class="eshop-apps-selector__footer">
        <a href="${logoutUrl}" type="" class="btn btn-primary"><@fmt.message key="eshop.logoutBtn"/></a>
        
    </div>

</div>

