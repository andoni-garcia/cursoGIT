<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<#assign spring=JspTaglibs["http://www.springframework.org/tags"] />
<@hst.setBundle basename="eshop"/>

<@hst.resourceURL var="moreInfoDetailsUrl" resourceId="GET_MORE_INFO"/>
<@hst.resourceURL var="partnumberLinkUrl" resourceId="GET_PARTNUMBER_URL"/>
<@hst.resourceURL var="ssiFamiliesListUrl" resourceId="GET_FAMILIES"/>

<@fmt.message key="eshop.moreInfoNotAvailable" var="labelMoreInfoNotAvailable"/>
<@fmt.message key="eshop.productUrlNotFound" var="labelProductUrlNotFound"/>

<section id="partnumber-info" class="partnumber-loading" data-swiftype-index='false'>
    <smc-spinner-inside-element params="loading: loading()"></smc-spinner-inside-element>
</section>

<@hst.headContribution  category="htmlBodyEnd">
<script>
    var moreInfoDetailsUrl = '${moreInfoDetailsUrl}';
    var partnumberLinkUrl = '${partnumberLinkUrl}';
	var	ssiFamiliesListUrl = '${ssiFamiliesListUrl}';

    var moreInfoNotAvailableMssg = '${labelMoreInfoNotAvailable?js_string}';
    var urlNotFoundMssg = '${labelProductUrlNotFound?js_string}';

    var GlobalPartnumberInfo;
</script>
 </@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/partnumberinfo/more-info.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/partnumberinfo/partnumber-info.component.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution  category="scripts">
<script type="text/javascript">
 (function(context, $){
    $(document).ready(function(){
    GlobalPartnumberInfo = new PartNumberInfoComponent();
        ko.applyBindings(GlobalPartnumberInfo, document.getElementById("partnumber-info"));
        });
    })(window, jQuery);

</script>
 </@hst.headContribution>