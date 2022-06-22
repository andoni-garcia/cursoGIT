        <div class="container">
            <div class="cmseditlink">
            </div>
            <h1 class="heading-02 heading-main"><@fmt.message key="users.myprofile.title"/></h1>
        </div>
        <br>
        <form class="container" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" accept-charset="ISO-8859-1" method="post">
            <#if UPDATE_STATUS??>
            <div class="row">
                <div class="col-12">
                    <#if UPDATE_STATUS == 'ERROR'>
                    <div class="alert alert-danger" role="alert">
                        <@fmt.message key="eshop.errorAlert"/>
                    </div>
                    <#else>
                    <div class="alert alert-success" role="alert">
                        <@fmt.message key="users.myprofile.updateSuccess"/>
                    </div>
                    </#if>
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
                        <select  id="country" name="country" value="${form.getValue('country')}" required>
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
                    <label class=""><@fmt.message key="users.username"/>: </label>
                    <input name="username" class="form-control" id="username" type="text" readonly value="${form.getValue('username')}">
                </div>
                <div class="col-md-6 align-self-end">
                    <button id="update-password" class="btn btn-primary w-100" data-bind="click: showPasswordModal.bind($data)" type="button"><@fmt.message key="users.changePassword"/></button>
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">3. <@fmt.message key="users.userInformationTitle"/></label>
                    <p><@fmt.message key="users.userInformationDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.firstName"/>: *</label>
                    <input required name="firstName" class="form-control" id="firstname" type="text" value="${form.getValue('firstName')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.lastName"/>: *</label>
                    <input required name="lastName" class="form-control" id="lastName" type="text" value="${form.getValue('lastName')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.email"/>: *</label>
                    <input required name="email" class="form-control" id="email" type="email" value="${form.getValue('email')}">
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">4. <@fmt.message key="users.companyInformationTitle"/></label>
                    <p><@fmt.message key="users.companyInformationDescription"/></p>
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.companyName"/>: *</label>
                    <input required name="company" class="form-control" id="company" type="text" value="${form.getValue('company')}">
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
                            <option value="forestry_paper_products/>"><@fmt.message key="users.forestry"/></option>
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
                    <input name="title" class="form-control" id="title" type="text" value="${form.getValue('title')}">
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
                    <input required name="address" class="form-control" id="address" type="text" value="${form.getValue('address')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.address2"/>:</label>
                    <input  name="address2" class="form-control" id="address2" type="text" value="${form.getValue('address2')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.city"/>: *</label>
                    <input required name="city" class="form-control" id="city" type="text" value="${form.getValue('city')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.state"/>: *</label>
                    <input required name="state" class="form-control" id="state" type="text" value="${form.getValue('state')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.zip"/>: *</label>
                    <input required name="pc" class="form-control" id="pc" type="text" value="${form.getValue('pc')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.phone"/>: *</label>
                    <input required name="phone" class="form-control" id="phone" type="text" value="${form.getValue('phone')}">
                </div>
                <div class="col-md-6">
                    <label class=""><@fmt.message key="users.fax"/>:</label>
                    <input name="fax" class="form-control" id="fax" type="text" value="${form.getValue('fax')}">
                </div>

                <div class="col-12 mt-5">
                    <label class="heading-03">5. <@fmt.message key="users.consentTitle"/></label>
                    <p><@fmt.message key="users.consentDescription"/></p>
                </div>
                                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_email" type="checkbox" class="form-check-input ml-0" id="subscription_email">
                        <label class="form-check-label" for="subscription_email"><@fmt.message key="users.email"/></label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_phone" type="checkbox" class="form-check-input ml-0" id="subscription_phone">
                        <label class="form-check-label" for="subscription_phone"><@fmt.message key="users.phone"/></label>
                    </div>
                </div>
                <div class="col-12">
                    <div class="form-check">
                        <input name="subscription_post" type="checkbox" class="form-check-input ml-0" id="subscription_post">
                        <label class="form-check-label" for="subscription_post"><@fmt.message key="users.post"/></label>
                    </div>
                </div>

                <div class="col-12 mt-5 mb-5">
                    <button type="button" data-bind="click: deleteUser.bind($data)" class="btn btn-danger"><@fmt.message key="users.unsubscribe"/></button>
                    <button type="submit" class="btn btn-primary"><@fmt.message key="eshop.save"/></button>
                </div>
            </div>
        </form>
    

    <#include "./my-profile-delete.ftl">


<script>

    var setSelected = function(elem, value){
        for(i = 0; elem.options.length; i++){
            if(elem.options[i].value === value) {
                elem.options[i].selected = true;
                break;    
            }
        }
    }

    var setChecked = function(elem, value) {
        elem.checked = (value === 'on');
    }

    var countryValue = "${form.getValue('country')}";
    var jobValue = "${form.getValue('job')}";
    var industrialValue = "${form.getValue('industry')}";
    var consentPhoneValue = "${form.getValue('subscription_phone')}";
    var consentEmailValue = "${form.getValue('subscription_email')}";
    var consentPostValue = "${form.getValue('subscription_post')}";

    $(function(){
        setSelected(document.getElementById('country'), countryValue);
        setSelected(document.getElementById('industry'), industrialValue);
        setSelected(document.getElementById('job'), jobValue);
        
        setChecked(document.getElementById('subscription_phone'), consentPhoneValue);
        setChecked(document.getElementById('subscription_email'), consentEmailValue);
        setChecked(document.getElementById('subscription_post'), consentPostValue);
    });
</script>