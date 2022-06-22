<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="registerLink" siteMapItemRefId="register"/>
<@hst.actionURL var="actionURL"/>
<@hst.setBundle basename="eshop"/>

<@fmt.message key="users.usernameAlreadyExists" var="labelUsernameAlreadyExists"/>
<@fmt.message key="users.notEqualsMssg" var="labelNotEqualsMssg"/>
<@fmt.message key="users.regexMssg" var="labelRegexMssg"/>

<@fmt.message key="users.eshopRegister.successRegisterTitle" var="successRegisterTitle"/>
<@fmt.message key="users.eshopRegister.successRegisterMessage" var="successRegisterMessage"/>
<@fmt.message key="users.eshopRegister.errorRegisterTitle" var="errorRegisterTitle"/>
<@fmt.message key="users.eshopRegister.errorRegisterMessage" var="errorRegisterMessage"/>

<@fmt.message key="users.wrongLengthError" var="wrongLengthError"/>
<@fmt.message key="users.agreeDataPrivacyUrl" var="agreeDPP"/>
<@fmt.message key="users.acceptTermsUrl" var="acceptTerms"/>

<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>

<@fmt.message key="users.eshopRegister.techProperty1" var="techProperty1"/>
<@fmt.message key="users.eshopRegister.techProperty2" var="techProperty2"/>
<@fmt.message key="users.eshopRegister.techProperty3" var="techProperty3"/>
<@fmt.message key="users.eshopRegister.techProperty4" var="techProperty4"/>

<@fmt.message key="users.eshopRegister.proProperty1" var="proProperty1"/>
<@fmt.message key="users.eshopRegister.proProperty2" var="proProperty2"/>
<@fmt.message key="users.eshopRegister.proProperty3" var="proProperty3"/>
<@fmt.message key="users.eshopRegister.proProperty4" var="proProperty4"/>

<@fmt.message key="users.eshopRegister.advProperty1" var="advProperty1"/>
<@fmt.message key="users.eshopRegister.advProperty2" var="advProperty2"/>
<@fmt.message key="users.eshopRegister.advProperty3" var="advProperty3"/>
<@fmt.message key="users.eshopRegister.advProperty4" var="advProperty4"/>




<main class="smc-main-container eshop" style="margin-bottom: 10rem">

        <div class="mb-30 container">
            <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
        </div>

        <div class="container">
            <div class="cmseditlink">
            </div>
            <h1 class="heading-02 heading-main"><@fmt.message key="users.eshopRegister.title"/></h1>
        </div>
        <form class="container" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post" id="registerForm">

            <div class="row">


                 <div class="col-md-8 col-sm-12 ">
                    <p><@fmt.message key="users.eshopRegister.description1"/></p>
                    <p><@fmt.message key="users.eshopRegister.description2"/></p>

                    <b><@fmt.message key="users.eshopRegister.downloadCadTitle"/></b>
                    <p><@fmt.message key="users.eshopRegister.downloadCadMssg"/>
                        <a href="<@fmt.message key="users.eshopRegister.downloadCadHref"/>"> <@fmt.message key="users.clickHere"/></a>
                    </p>

                    <!-- Access level -->
                    <label class="heading-03"><@fmt.message key="users.eshopRegister.accessTitle"/>:</label>
                        <!--
                        <div class="col-12">
                            <div class="form-check">
                                <input name="accessLevel" type="radio" class="form-check-input ml-0" id="technicalAccess" value="technical" checked/>
                                <label class="form-check-label" for="technicalAccess"><@fmt.message key="users.eshopRegister.technicalAccess"/></label>

                            </div>
                            <ul>

                                <#if techProperty1?has_content && !techProperty1?contains('???')><li> ${techProperty1} </li></#if>
                                <#if techProperty2?has_content && !techProperty2?contains('???')><li> ${techProperty2} </li></#if>
                                <#if techProperty3?has_content && !techProperty3?contains('???')><li> ${techProperty3} </li></#if>
                                <#if techProperty4?has_content && !techProperty4?contains('???')><li> ${techProperty4} </li></#if>

                            </ul>
                        </div>
                        -->


                        <div class="col-12">
                            <div class="form-check">
                                <input name="accessLevel" type="radio" class="form-check-input ml-0" id="advancedAccess" value="advanced" checked/>
                                <label class="form-check-label" for="advancedAccess"><@fmt.message key="users.eshopRegister.advancedAccess"/></label>

                            </div>
                            <ul>
                                <#if advProperty1?has_content && !advProperty1?contains('???')><li> ${advProperty1} </li></#if>
                                <#if advProperty2?has_content && !advProperty2?contains('???')><li> ${advProperty2} </li></#if>
                                <#if advProperty3?has_content && !advProperty3?contains('???')><li> ${advProperty3} </li></#if>
                                <#if advProperty4?has_content && !advProperty4?contains('???')><li> ${advProperty4} </li></#if>


                            </ul>
                        </div>

                        <div class="col-12">
                            <div class="form-check">
                                <input name="accessLevel" type="radio" class="form-check-input ml-0" id="proAccess" value="professional"/>
                                <label class="form-check-label" for="proAccess">	<@fmt.message key="users.eshopRegister.proAccess"/></label>

                            </div>
                            <ul>
                                <#if proProperty1?has_content && !proProperty1?contains('???')><li> ${proProperty1} </li></#if>
                                <#if proProperty2?has_content && !proProperty2?contains('???')><li> ${proProperty2} </li></#if>
                                <#if proProperty3?has_content && !proProperty3?contains('???')><li> ${proProperty3} </li></#if>
                                <#if proProperty4?has_content && !proProperty4?contains('???')><li> ${proProperty4} </li></#if>

                            </ul>
                        </div>


                    </div>
                    <!-- /Access level -->




                <!-- /Info -->
                <div class="col-md-4 col-sm-12">
                    <div class="row eshop-box">
                    <div class="p-3">

                            <label class="heading heading-07 register-info-list--title"><@fmt.message key="users.eshopRegister.infoTitle"/>:</label>
                                <img src="<@hst.webfile path='/images/eshop.jpg'/>" width="200px" height="57" style="margin:20px;">

                            <ul class="col-12 list-items  register-info-list">
                                <li class="register-info-list--item"> <@fmt.message key="users.eshopRegister.info1"/>  </li>
                                <li class="register-info-list--item"> <@fmt.message key="users.eshopRegister.info2"/> </li>
                                <li class="register-info-list--item"> <@fmt.message key="users.eshopRegister.info3"/>  </li>
                                <li class="register-info-list--item"> <@fmt.message key="users.eshopRegister.info4"/>  </li>
                                <li class="register-info-list--item"> <@fmt.message key="users.eshopRegister.info5"/> </li>

                            </ul>
                            <ul class="col-12 list-items empty-list register-info-list">
                                 <li class="mt-1 register-info-list--link">
                                    <i class="register-info-list--icon fa fa-download" aria-hidden="true"></i>
                                    <a href="<@fmt.message key="users.eshopRegister.info6Href"/>"> <@fmt.message key="users.eshopRegister.info6"/> </a>

                                </li>
                                <li class="register-info-list--link">
                                    <i class="register-info-list--icon fa fa-caret-right" aria-hidden="true"></i>
                                    <a href="<@fmt.message key="users.eshopRegister.info7Href"/>"> <@fmt.message key="users.eshopRegister.info7"/> </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /info -->


                <!-- User type -->
                <!-- /user type -->
                <!-- Data level -->
                <div class="row col-12 mt-5">
                    <label class="heading-03 col-12 "><@fmt.message key="users.eshopRegister.dataTitle"/>:</label>
                    <div class="col-12">
                        <div class="col-12 mt-5 mb-10 row">
                            <label class="heading-04"><@fmt.message key="users.eshopRegister.chooseClientType"/></label>
                                <div class="col-12">
                                    <div class="form-check">
                                        <input name="userType" type="radio" class="form-check-input ml-0 user-type-radio" id="existClient" checked value="existClient"/>
                                        <label class="form-check-label" for="existClient"><@fmt.message key="users.eshopRegister.existsClient"/>*</label>

                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form-check">
                                        <input name="userType" type="radio" class="form-check-input ml-0 user-type-radio" id="newClient" value="newClient"/>
                                        <label class="form-check-label" for="newClient"><@fmt.message key="users.eshopRegister.newClient"/>*</label>

                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.userTitle"/>: *</label>
                        <div class="dropdown smc-select">
                            <select name="userTitle" id="userTitle" required>
                                <option value="" selected="">- <@fmt.message key="users.eshopRegister.chooseOne"/> --</option>
                                <option value="<@fmt.message key="users.eshopRegister.mr"/>"><@fmt.message key="users.eshopRegister.mr"/></option>
                                <option value="<@fmt.message key="users.eshopRegister.mrs"/>"><@fmt.message key="users.eshopRegister.mrs"/></option>

                            </select>
                        </div>
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.name"/>: *</label>
                        <input required name="name" class="form-control" id="name" type="text">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.lastName"/>: *</label>
                        <input required name="lastName" class="form-control" id="lastName" type="text">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.company"/>: *</label>
                        <input required name="company" class="form-control" id="company" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.orderNumber"/>: </label>
                        <input name="orderNumber" class="form-control" id="orderNumber" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.cif"/>: </label>
                        <input  name="cif" class="form-control" id="cif" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.departament"/>: </label>
                        <input name="departament" class="form-control" id="departament" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.positions"/>: </label>
                        <input  name="positions" class="form-control" id="positions" type="text">
                    </div>

                    <div class="col-12 col-sm-6 old-user">
                        <label class=""><@fmt.message key="users.eshopRegister.customerId"/>: *</label>
                        <input required name="customerId" class="form-control" id="customerId" type="text">
                    </div>

                    <div class="col-12 col-sm-6 old-user">
                        <label class=""><@fmt.message key="users.eshopRegister.address"/>: </label>
                        <input name="address" class="form-control" id="address" type="text">
                    </div>

                     <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.street"/>: * </label>
                        <input required name="address" class="form-control" id="street" type="text">
                    </div>


                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.cp"/>: *</label>
                        <input required name="cp" class="form-control" id="cp" type="text">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.place"/>: </label>
                        <input name="place" class="form-control" id="place" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.location"/>: * </label>
                        <input required name="location" class="form-control" id="location" type="text">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.country"/>: </label>
                        <input  name="country" class="form-control" id="country" type="text" readonly value="${countryName}">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.telephone"/>: *</label>
                        <input required name="telephone" class="form-control" id="telephone" type="text">
                    </div>

                    <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.fax"/>:  </label>
                        <input  name="fax" class="form-control" id="fax" type="text">
                    </div>

                    <div class="col-12 col-sm-6">
                        <label class=""><@fmt.message key="users.eshopRegister.email"/>: *</label>
                        <input required name="email" class="form-control" id="email" type="text">
                    </div>

                     <div class="col-12 col-sm-6 new-user">
                        <label class=""><@fmt.message key="users.eshopRegister.website"/>: </label>
                        <input  name="website" class="form-control" id="website" type="text">
                    </div>
                </div>
                <!-- /Data level -->


                <!-- Terms level -->
                <div class="col-12 mt-5">
                    <label class="heading-03"><@fmt.message key="users.eshopRegister.terms"/></label>
                    <div class="form-check">
                        <input required name="agreeDPP" type="checkbox" class="form-check-input ml-0" id="agreeDPP"/>
                        <label class="form-check-label" for="agreeDPP"><@fmt.message key="users.agreeDataPrivacy"/>*</label>
                        <a href="<@fmt.message key="users.eshopRegister.dataPricacyHref"/>" target="_blank"> <@fmt.message key="users.readHere"/></a>
                    </div>

                    <div class="form-check">
                        <input required name="acceptTerms" type="checkbox" class="form-check-input ml-0" id="acceptTerms"/>
                        <label class="form-check-label" for="acceptTerms"><@fmt.message key="users.acceptTerms"/>*</label>
                        <a href="<@fmt.message key="users.eshopRegister.termsHref"/>" target="_blank" > <@fmt.message key="users.readHere"/></a>

                    </div>
                </div>
                <!-- /Terms level -->


                <div class="col-12 mt-5">
                    <button id="submitForm" type="submit" class="btn btn-primary"><@fmt.message key="users.registerBtn"/></button>
                </div>
            </div>
        </form>
        <#include 'register-modal.ftl'>
        <div class="register-spinner ko-hide" id="spinner">
            <div class="overlay-inside eshop-box-rounded" data-bind="css: {'overlay-inside-button': isButton}"></div>
            <div class="spinner-inside" data-bind="css: {'spinner-button': isButton}">
                <div class="bounce"></div>
                <div class="bounce1"></div>
                <div class="bounce2"></div>
            </div>
        </div>
    </main>

<@hst.resourceURL var="registerEshopUrl" resourceId="REGISTER_ESHOP"/>
<@hst.headContribution category="scripts">

<script type="text/javascript">


    var registerEshopUrl;

    var country;
    var redirectRegister;
    var wrongLengthError;

    var successRegisterTitle = '${successRegisterTitle?js_string}';
    var successRegisterMessage = '${successRegisterMessage?js_string}';
    var errorRegisterTitle = '${errorRegisterTitle?js_string}';
    var errorRegisterMessage = '${errorRegisterMessage?js_string}';

    var labelAccept = '${labelAccept?js_string}';
    var labelCancel  = '${labelCancel?js_string}';
$(document).ready(function() {

    registerEshopUrl = '${registerEshopUrl}';

});

</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/profile/eshop-register.functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>
