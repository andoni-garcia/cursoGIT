<#include "../../include/imports.ftl">
<#compress>
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.webfile var="noImage" path='/images/nodisp3_big.png'/>
<@hst.link var="registerLink" siteMapItemRefId="register"/>
<@hst.link var="myProjectBooksLink" siteMapItemRefId="myProjectBooks"/>
<@hst.link var="projectBookLink" siteMapItemRefId="projectBook"/>

<@hst.setBundle basename="eshop"/>
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>

<@security.authentication property="principal.companyName" var="principalName" />
<@security.authentication property="principal.fullName" var="principalFullname" />

<@fmt.message key="projectbooks.subscribeErrorMesssage" var="subscribeErrorMesssage"/>
<@fmt.message key="projectbooks.subscribeInputErrorMesssage" var="subscribeInputErrorMesssage"/>
<@fmt.message key="projectbooks.subscribeInvalidMesssage" var="subscribeInvalidMesssage"/>
<@fmt.message key="projectbooks.alreadySubscribedMssg" var="alreadySubscribedMssg"/>

<@fmt.message key="projectbooks.subscribeSuccessMesssage" var="subscribeSuccessMesssage"/>

<@fmt.message key="eshop.cancel" var="labelCancel"/>
<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.login" var="labelLogin"/>

</#compress>

<br>
<div class="login-box pb-form" id="contenedor">

     <h2 class="heading-08 color-blue mt-20 text-center"><@fmt.message key="projectbooks.subscribe.title"/></h2>
    <div>
         <div class="col-12">
            <div class="form-check">
                <label class="form-check-label" for=""><@fmt.message key="register.username"/></label>
                <input type="text" class="form-control" id="pbSubName"/>
            </div>
        </div>
        <div class="col-12">
            <div class="form-check">
                <label class="form-check-label" for=""><@fmt.message key="register.password"/></label>
                <input type="password" class="form-control" id="pbSubPwd"/>
            </div>
        </div>
        <div class="col-12 mt-20 mb-20">
            <button type="button btn-primary " class="btn btn-primary col-12" id="pbSubBtn"><@fmt.message key="eshop.accept"/></button>
        </div>
    </div>
    <#include "./projectbook-subscribe-modal.ftl">
</div>
<div class="ko-hide" id="subscription-spinner">
            <div class="overlay-inside eshop-box-rounded" data-bind="css: {'overlay-inside-button': isButton}"></div>
            <div class="spinner-inside" data-bind="css: {'spinner-button': isButton}">
                <div class="bounce"></div>
                <div class="bounce1"></div>
                <div class="bounce2"></div>
            </div>
</div>


<@hst.resourceURL var="projectBookSubscribe" resourceId="SUBSCRIBE_TO_PB"/>
<@hst.headContribution category="htmlHead">

<script>
    var myProjectBooksLink = '${myProjectBooksLink}';
    var projectBookLink = '${projectBookLink}';

    var projectBookSubscribe = '${projectBookSubscribe}';
    //var projectBookId = '${projectBook.id}';

    var isAuthenticated = '${isAuthenticated?c}' === "true";
    var subscribeErrorMesssage = '${subscribeErrorMesssage?js_string}';
    var subscribeSuccessMesssage = '${subscribeSuccessMesssage?js_string}';
    var subscribeInputErrorMesssage = '${subscribeInputErrorMesssage?js_string}';
    var subscribeInvalidMesssage = '${subscribeInvalidMesssage?js_string}';
    var alreadySubscribedMssg = '${alreadySubscribedMssg?js_string}';

    var loginBtn = '${labelLogin?js_string}';
    var acceptBtnText = '${labelAccept?js_string}';
    var cancelBtn = '${labelCancel?js_string}';

    var token = '${_csrf.token}';

</script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/popper.min.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/knockout-3.4.2.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="jquery">
    <script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery.min.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/jquery-ui.min.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/js.cookie.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="scriptsEssential">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/libs/extend/extend.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="htmlBodyEnd">
	<script type="text/javascript" src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap.js"/>"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/knockout/components/ko.comp.bootstrap-modal.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/bootstrap-components/custom-modal.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/projectbook/projectbook-subscribe.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<script type="text/javascript">
    var smc = window.smc || {};
</script>