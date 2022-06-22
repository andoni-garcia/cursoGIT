<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />
<@hst.link var="registerLink" siteMapItemRefId="register"/>
<@hst.actionURL var="actionURL"/>
<@hst.setBundle basename="eshop"/>

<@fmt.message key="users.usernameAlreadyExists" var="labelUsernameAlreadyExists"/>
<@fmt.message key="users.notEqualsMssg" var="labelNotEqualsMssg"/>
<@fmt.message key="users.regexMssg" var="labelRegexMssg"/>

<@fmt.message key="users.successRegisterTitle" var="successRegisterTitle"/>
<@fmt.message key="users.successRegisterMessage" var="successRegisterMessage"/>
<@fmt.message key="users.errorRegisterTitle" var="errorRegisterTitle"/>
<@fmt.message key="users.errorRegisterMessage" var="errorRegisterMessage"/>
<@fmt.message key="users.wrongLengthError" var="wrongLengthError"/>
<@fmt.message key="users.invalidNameIncludesError" var="invalidNameIncludesError"/>
<@fmt.message key="users.agreeDataPrivacyUrl" var="agreeDPP"/>
<@fmt.message key="users.acceptTermsUrl" var="acceptTerms"/>

<@fmt.message key="eshop.accept" var="labelAccept"/>
<@fmt.message key="eshop.cancel" var="labelCancel"/>

<script src="https://www.google.com/recaptcha/api.js"></script>
<@hst.headContribution category="htmlHead">
	<script>
		var actionUrl;
	</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
	<script type="text/javascript">
		$(document).ready(function(){
			actionUrl = "${actionURL}";
    });
    </script>
</@hst.headContribution>

<script>
    function onSubmit(token) {
        // document.getElementById("registerForm").submit();
        $("#registerFormBtn").click();
    }
</script>

<main class="smc-main-container eshop" style="margin-bottom: 10rem">

        <div class="mb-30 container">
            <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
        </div>

        <div class="container">
            <div class="cmseditlink">
            </div>
            <h1 class="heading-02 heading-main"><@fmt.message key="users.register.title"/></h1>
        </div>
        <br>
        <form class="container" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post" id="registerForm">
         <#if createError??>
        <div class="row">
            <div class="col-12">
                <div class="alert alert-danger" role="alert">
                <#if repeatedUser>
                    <@fmt.message key="users.usernameAlreadyExists"/>
                <#elseif captchaError >
                    <@fmt.message key="eshop.captchaError"/>
                <#else>
                    <@fmt.message key="eshop.errorAlert"/>
                </#if>
                </div>
            </div>
        </div>
        </#if>
            <div class="row">
                <div class="col-12">
                    <label class="heading-03">1. <@fmt.message key="users.countryInformationTitle"/></label>
                    <p><@fmt.message key="users.countryInformationDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.country"/>: *</label>
                    <div class="dropdown smc-select">
                        <select id="country" name="country" required value="">
                            <option value="">-<@fmt.message key="users.selectCountryLbl"/>-</option>
                            <#list countries as country>
                                <option value="${country.getCode()}">${country.getDescription()}</option>
                            </#list>
                        </select>
                    </div>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">2. <@fmt.message key="users.userAndPassTitle"/></label>
                    <p><@fmt.message key="users.userAndPassDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.username"/>: *</label>
                    <input name="username" autofocus required class="form-control" id="username" type="text"/>
                </div>
                <div class="col-md-5 validation-spinner">
                        <span class="text-success hide" id="validUsername"><i class="fas fa-check"></i></span>
                        <span class="text-danger hide" id="wrongUsername"><i class="fas fa-times">&nbsp;<@fmt.message key="users.usernameAlreadyExists"/></i></span>
                        <div class="spinner-grow text-info hide" role="status" id="usernameValidationSpinner">
                            <span class="sr-only">Loading...</span>
                        </div>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.password"/>: *</label>
                    <input name="password1" class="form-control" id="password1" type="password"
                        required
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$"
                        title="<@fmt.message key='users.regexErrorMssg'/>"
                        placeholder=" "
                        />
                    <span class="form-validation" style="display: inline"><@fmt.message key="users.regexMssg"/></span>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.repeatPassword"/>: *</label>
                    <input name="password2" class="form-control" id="password2" type="password"
                        required
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,20}$"
                        title="<@fmt.message key='users.notEqualsMssg'/>"
                        placeholder=" "
                        />
                        <span class="form-validation"><@fmt.message key="users.notEqualsMssg"/></span>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">3. <@fmt.message key="users.userInformationTitle"/></label>
                    <p><@fmt.message key="users.userInformationDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.firstName"/>: *</label>
                    <input name="firstName" required class="form-control" id=firstName"" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.lastName"/>: *</label>
                    <input name="lastName" required class="form-control" id="lastName" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.email"/>: *</label>
                    <input name="email" required class="form-control" id="" type="email"/>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">4. <@fmt.message key="users.companyInformationTitle"/></label>
                    <p><@fmt.message key="users.companyInformationDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.companyName"/>: *</label>
                    <input required name="company" class="form-control" id="company" type="text">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.industryType"/>: *</label>
                    <div class="dropdown smc-select">
                        <select required name="industry" id="industry" value="${form.getValue('industry')}">
                            <option value="">-<@fmt.message key="users.selectIndustryLbl"/>-</option>
                            <option value="aerospace"><@fmt.message key="users.aerospace"/></option>
                            <option value="automotive"><@fmt.message key="users.automotive"/></option>
                            <option value="electronic"><@fmt.message key="users.electronic"/></option>
                            <option value="food_beverage"><@fmt.message key="users.foodbeverage"/></option>
                            <option value="forestry_paper_products"><@fmt.message key="users.forestry"/></option>
                            <option value="heavy_vehicle"><@fmt.message key="users.heavyVehicle"/></option>
                            <option value="manufacturing"><@fmt.message key="users.manufacturing"/></option>
                            <option value="material_handling"><@fmt.message key="users.materialHandling"/></option>
                            <option value="medical_pharmaceutical"><@fmt.message key="users.medical"/></option>
                            <option value="packaging"><@fmt.message key="users.packaging"/></option>
                            <option value="petroleum_chemical"><@fmt.message key="users.petroleo"/></option>
                            <option value="reseller_distributor"><@fmt.message key="users.reseller"/></option>
                            <option value="school_university"><@fmt.message key="users.school"/></option>
                            <option value="semi_conductor"><@fmt.message key="users.semiConductor"/></option>
                            <option value="specialty_oem"><@fmt.message key="users.specialty"/></option>
                            <option value="steel"><@fmt.message key="users.steel"/></option>
                            <option value="textile"><@fmt.message key="users.textile"/></option>
                            <option value="other"><@fmt.message key="users.other"/></option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.titleLbl"/>:</label>
                    <input name="title" class="form-control" id="title" type="text">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.jobDescription"/>:</label>
                    <div class="dropdown smc-select">
                        <select name="job" id="job" value="${form.getValue('job')}">
                            <option value="" selected="">-<@fmt.message key="users.jobDescriptionSelect"/>-</option>
                            <option value="manufacturing_engineering"><@fmt.message key="users.manufacturingEngineering"/></option>
                            <option value="engineering_management"><@fmt.message key="users.engineeringManagement"/></option>
                            <option value="rd_engineering"><@fmt.message key="users.rdEngineering"/></option>
                            <option value="system_design_engineering"><@fmt.message key="users.systemEngineering"/></option>
                            <option value="industrial_design_engineering"><@fmt.message key="users.industrialEngineering"/></option>
                            <option value="testing_qc_engineering"><@fmt.message key="users.testingEngineering"/></option>
                            <option value="corporate_management"><@fmt.message key="users.corporateManagement"/></option>
                            <option value="purchasing_buyer"><@fmt.message key="users.purchase"/></option>
                            <option value="marketing_sales"><@fmt.message key="users.marketing"/></option>
                            <option value="student_educator"><@fmt.message key="users.studentEducator"/></option>
                            <option value="other"><@fmt.message key="users.other"/></option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.address"/>: *</label>
                    <input required name="address" class="form-control" id="address" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.address2"/>:</label>
                    <input  name="address2" class="form-control" id="address2" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.city"/>: *</label>
                    <input required name="city" class="form-control" id="city" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.state"/>: *</label>
                    <input required name="state" class="form-control" id="state" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.zip"/>: *</label>
                    <input required name="pc" class="form-control" id="pc" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.phone"/>: *</label>
                    <input required name="phone" class="form-control" id="phone" type="text"/>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.fax"/>:</label>
                    <input name="fax" class="form-control" id="fax" type="text"/>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">5. <@fmt.message key="users.consentTitle"/></label>
                    <p><@fmt.message key="users.consentDescription"/></p>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_email" type="checkbox" class="form-check-input ml-0" id="subscriptionEmail"/>
                        <label class="form-check-label" for="subscriptionEmail"><@fmt.message key="users.email"/></label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_phone" type="checkbox" class="form-check-input ml-0" id="subscriptionPhone"/>
                        <label class="form-check-label" for="subscriptionPhone"><@fmt.message key="users.phone"/></label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_post" type="checkbox" class="form-check-input ml-0" id="subscriptionPost"/>
                        <label class="form-check-label" for="subscriptionPost"><@fmt.message key="users.post"/></label>
                    </div>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">6. <@fmt.message key="users.termsTitle"/></label>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input required name="acceptTerms" type="checkbox" class="form-check-input ml-0" id="acceptTerms"/>
                        <label class="form-check-label" for="acceptTerms"><@fmt.message key="users.acceptTerms"/>*</label>
                        <a href="${acceptTerms}" target="_blank" > <@fmt.message key="users.readHere"/></a>

                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input required name="agreeDPP" type="checkbox" class="form-check-input ml-0" id="agreeDPP"/>
                        <label class="form-check-label" for="agreeDPP"><@fmt.message key="users.agreeDataPrivacy"/>*</label>
                        <a href="${agreeDPP}" target="_blank"> <@fmt.message key="users.readHere"/></a>
                    </div>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">7. <@fmt.message key="users.unsubscribeTitle"/></label>
                    <p><@fmt.message key="users.unsubscribeRegister"/></p>
                </div>

                <div class="col-12 mt-5 hidden">
                    <button type="submit" id ="registerFormBtn" class="btn btn-primary"><@fmt.message key="users.registerBtn"/></button>
                </div>
                <div class="col-12 mt-5">
                    <button
                            data-sitekey="6Ley36cZAAAAACt4n_ErumuK7DDSgU0RVX-JTtgg"
                            data-callback='onSubmit'
                            data-action='submit'
                            class="btn btn-primary g-recaptcha"><@fmt.message key="users.registerBtn"/></button>
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

<@hst.resourceURL var="existsUserUrl" resourceId="VALID_USERNAME"/>
<@hst.headContribution category="scripts">

<script type="text/javascript">

    var usernameAlreadyExists;
    var notEqualMssg;
    var existsUserUrl;
    var regexPasswordMssg;
    var successRegisterTitle;
    var successRegisterMessage;
    var errorRegisterMessage;
    var existsUserUrl;
    var locale;
    var redirectRegister;
    var wrongLengthError;
    var invalidNameIncludesError;

    var labelAccept;
    var labelCancel;

$(document).ready(function() {
    usernameAlreadyExists = '${labelUsernameAlreadyExists?js_string}';
    notEqualMssg = '${labelNotEqualsMssg?js_string}';
    regexPasswordMssg = '${labelRegexMssg?js_string}';
    successRegisterTitle = '${successRegisterTitle?js_string}';
    successRegisterMessage = '${successRegisterMessage?js_string}';
    errorRegisterTitle = '${errorRegisterTitle?js_string}';
    errorRegisterMessage = '${errorRegisterMessage?js_string}';
    wrongLengthError = '${wrongLengthError?js_string}';
    locale = '${.locale}';
    existsUserUrl = '${existsUserUrl}';
    redirectRegister = '${redirectRegister}';
    invalidNameIncludesError = '${invalidNameIncludesError}';


    labelAccept = '${labelAccept?js_string}';
    labelCancel  = '${labelCancel?js_string}';
});

</script>
</@hst.headContribution>
<@hst.headContribution category="scripts">
    <script	src="<@hst.webfile path="/freemarker/versia/js-menu/profile/profile-register.functions.js"/>" type="text/javascript"></script>
</@hst.headContribution>