<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />

<#setting locale=hstRequest.requestContext.resolvedMount.mount.locale>

<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authentication property="principal.customerId" var="customerId" />
<@security.authentication property="principal.userMovexTypeExternal" var="userMovexTypeExternal" />

<@hst.setBundle basename="workplace"/>

<@hst.link var="workplaceCustomerOrderEntrySite" siteMapItemRefId="wpCustomerOrderEntry"/>
<@hst.link var="workplaceOrderStatusSite" siteMapItemRefId="wpOrderStatus"/>
<@hst.link var="workplacePriceAndDeliverySite" siteMapItemRefId="wpPriceAndDelivery"/>
<@hst.link var="workplaceQuotationSite" siteMapItemRefId="wpQuotation"/>

<@fmt.message key="orderStatus" var="labelOrderStatus"/>
<@fmt.message key="priceAndDelivery" var="labelPriceAndDelivery"/>
<@fmt.message key="quotation" var="labelQuotation"/>
<@fmt.message key="customerOrderEntry" var="labelCustomerOrderEntry"/>
<@fmt.message key="createInstance" var="labelCreateInstance"/>

</#compress>

<#if isAuthenticated>
<div  data-swiftype-index='false'>
	<#list workplace.activeApplications as app>${app} </#list>
</div>

<div id="wp-menu-instance-template" style="display: none">
	<li>
		<a class="wp-menu-instance-item" href="#"></a>
	</li>
</div>

<div class="workspace-apps-selector text-01" data-swiftype-index="false">
    <h2 class="heading-04"><@fmt.message key="workplace"/></h2>
    <div class="smc-close-button" data-swiftype-index="false">×</div>
	<p></p>
	<div class="row row-0 row-workspace-apps">
		<#if workplaceActiveApplications?seq_contains("ORST")>
		<div class="col-item-app col-workspace-app-order-status">
			<img src="<@hst.webfile  path="/images/workplace/ico-order-status.png"/>">
			<h3 class="heading-04">${labelOrderStatus}</h3>
			<ul id="wp-menu-instance-orst" class="wp-menu-instance-orst">
				<#if workplaceInstancesSummariesOrderStatus??>
				<#list workplaceInstancesSummariesOrderStatus as instance>
				<li><a href="${workplaceOrderStatusSite}?instanceId=${instance.id?long?c}">${instance.name}</a></li>
				</#list>
				</#if>
			</ul>
			<#if !workplaceInstancesSummariesOrderStatus?? || workplaceInstancesSummariesOrderStatus?size == 0>
			<div class="empty-instances"><@fmt.message key="workplace.layer.emptyInstances"/></div>
			</#if>
			<div class="add-instance">
				<a href="${workplaceOrderStatusSite}?instanceId=" class="btn btn-plus" data-toggle="tooltip" data-placement="top" title="" data-original-title="${labelCreateInstance}"><i class="fas fa-plus"></i></a>
			</div>
		</div>
		</#if>

		<#if workplaceActiveApplications?seq_contains("PRDE")>
		<div class="col-item-app col-workspace-app-price-delivery">
            <img src="<@hst.webfile  path="/images/workplace/ico-price-delivery.png"/>">
            <h3 class="heading-04">${labelPriceAndDelivery}</h3>
            <ul id="wp-menu-instance-prde" class="wp-menu-instance-prde">
				<#if workplaceInstancesSummariesPriceDelivery??>
				<#list workplaceInstancesSummariesPriceDelivery as instance>
				<li><a href="${workplacePriceAndDeliverySite}?instanceId=${instance.id?long?c}">${instance.name}</a></li>
				</#list>
				</#if>
            </ul>
			<#if !workplaceInstancesSummariesPriceDelivery?? || workplaceInstancesSummariesPriceDelivery?size == 0>
			<div class="empty-instances"><@fmt.message key="workplace.layer.emptyInstances"/></div>
			</#if>
            <div class="add-instance">
                <a href="${workplacePriceAndDeliverySite}?instanceId=" class="btn btn-plus" data-toggle="tooltip" data-placement="top" title="" data-original-title="${labelCreateInstance}"><i class="fas fa-plus"></i></a>
            </div>

		</div>
		</#if>

		<#if workplaceActiveApplications?seq_contains("QUOT")>
		<div class="col-item-app col-workspace-app-quotation">
            <img src="<@hst.webfile  path="/images/workplace/ico-quotation.png"/>">
            <h3 class="heading-04">${labelQuotation}</h3>
            <ul id="wp-menu-instance-quot" class="wp-menu-instance-quot">
				<#if workplaceInstancesSummariesQuotation??>
				<#list workplaceInstancesSummariesQuotation as instance>
				<li><a href="${workplaceQuotationSite}/#/?instanceId=${instance.id?long?c}">${instance.name}</a></li>
				</#list>
				</#if>
            </ul>
			<#if !workplaceInstancesSummariesQuotation?? || workplaceInstancesSummariesQuotation?size == 0>
			<div class="empty-instances"><@fmt.message key="workplace.layer.emptyInstances"/></div>
			</#if>
            <div class="add-instance">
                <a href="${workplaceQuotationSite}#new-instance" class="btn btn-plus" data-toggle="tooltip" data-placement="top" title="" data-original-title="${labelCreateInstance}"><i class="fas fa-plus"></i></a>
            </div>
		</div>
		</#if>

		<#if workplaceActiveApplications?seq_contains("OREN")>
		<div class="col-item-app col-workspace-app-customer-order">
            <img src="<@hst.webfile  path="/images/workplace/ico-customer-entry.png"/>">
            <h3 class="heading-04">${labelCustomerOrderEntry}</h3>
            <ul id="wp-menu-instance-oren" class="wp-menu-instance-oren">
				<#if workplaceInstancesSummariesCustomerOrderEntry??>
				<#list workplaceInstancesSummariesCustomerOrderEntry as instance>
				<li><a href="${workplaceCustomerOrderEntrySite}?instanceId=${instance.id?long?c}">${instance.name}</a></li>
				</#list>
				</#if>
            </ul>
			<#if !workplaceInstancesSummariesCustomerOrderEntry?? || workplaceInstancesSummariesCustomerOrderEntry?size == 0>
			<div class="empty-instances"><@fmt.message key="workplace.layer.emptyInstances"/></div>
			</#if>
            <div class="add-instance">
                <a href="${workplaceCustomerOrderEntrySite}?instanceId=" class="btn btn-plus" data-toggle="tooltip" data-placement="top" title="" data-original-title="${labelCreateInstance}"><i class="fas fa-plus"></i></a>
            </div>
		</div>
		</#if>

	</div>
</div>

<div id="wpHiddenUrl" class="d-none">
    ${workplaceTestUrl}
</div>


</#if>

<@hst.headContribution category="htmlBodyEnd">
<script type="text/javascript">

	console.log("window.smc.workplace");
	window.smc = window.smc || {};
	window.smc.workplace = window.smc.workplace || {};

	// URL's to be used from the front
	window.smc.workplace.urls = window.smc.workplace.urls || {};
	window.smc.workplace.urls.orderStatusSite = "${workplaceOrderStatusSite}";
	window.smc.workplace.urls.priceAndDeliverySite = "${workplacePriceAndDeliverySite}";
	window.smc.workplace.urls.quotationSite = "${workplaceQuotationSite}";
	window.smc.workplace.urls.customerOrderEntrySite = "${workplaceCustomerOrderEntrySite}";

	// User-specific data
    window.smc.workplace.user = window.smc.workplace.user || {};

	// Active applications for the current user
	window.smc.workplace.activeApplications = [<#list workplaceActiveApplications as app> "${app}", </#list>];
	window.smc.workplace.selectedApplication = <#if workplaceSelectedApp?has_content>'${workplaceSelectedApp}'<#else>''</#if>; // TODO TODO

	// CSRF Token
	window.smc.workplace.csrf = "${_csrf.token}";

	// Labels obtained from hippo for the current channel
	window.smc.workplace.labels = {<#list workplaceLabels as item>"${item.left}": <#escape x as x?html>${item.right}</#escape>,</#list>};

	window.smc.workplace.user.isDistributor = <#if userMovexTypeExternal?? && userMovexTypeExternal>true<#else>false</#if>;
	window.smc.workplace.user.username = "${workplaceUsername}";

</script>
</@hst.headContribution>

<@hst.headContribution category="scriptsEssential">
	<script src="<@hst.webfile path="/freemarker/versia/js-menu/workplace/workplace-layer.functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>