
         <div class="container">
            <div class="cmseditlink">
            </div>
            <h1 class="heading-02 heading-main"><@fmt.message key="users.myprofile.title"/></h1>
        </div>
        <br>
       
        <form class="container" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" accept-charset="UTF-8" method="post">
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
                    <label class="heading-03"><@fmt.message key="users.profileInfoTitle"/></label>
                    <p><@fmt.message key="users.profileInfoDescription"/></p>
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.username"/>: </label>
                    <input name="username" class="form-control" id="username" type="text" readonly value="${form.getValue('username')}">
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.companyName"/>: </label>
                    <input name="company" class="form-control" id="company" type="text" readonly value="${form.getValue('company')}">
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.firstName"/>: *</label>
                    <input required name="firstName" class="form-control" id="firstName" type="text" value="${form.getValue('firstName')}">
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.lastName"/>: *</label>
                    <input required name="lastName" class="form-control" id="lastName" type="text" value="${form.getValue('lastName')}">
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.email"/>: *</label>
                    <input required name="email" class="form-control" id="email" type="email" readonly value="${form.getValue('email')}">
                </div>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.phone"/>: *</label>
                    <input required name="phone" class="form-control" id="phone" type="text" value="${form.getValue('phone')}">
                </div>

                <#if !isInternalUser>
                <#if invoicingAddress?has_content>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.invoicingAddress"/>:</label>
                    <div class="form-control" id="inovicingAddress" readonly>
                        <#list invoicingAddress as address>
                            <#if address?has_content>
                                <span> ${address}</span>
                                </br>
                            </#if>
                        </#list>
                    </div>
                </div>
                </#if>
                <#if deliveryAddress?has_content>
                <div class="col-md-6 mt-3">
                    <label class=""><@fmt.message key="users.deliveryAddress"/>:</label>
                    <div name="deliveryAddress" class="form-control" id="deliveryAddress" rows="4" readonly>
                        <#list deliveryAddress as address >
                            <#if address?has_content>
                                <span> ${address}</span>
                                </br>
                            </#if>
                        </#list>
                    </div>
                </div>
                </#if>

                <div class="col-12 mt-5 mb-5">
                    <button id="update-pwd-btn" class="btn btn-primary" data-bind="click: showPasswordModal.bind($data)" type="button"><@fmt.message key="users.changePassword"/></button>
                    <button type="submit" class="btn btn-primary"><@fmt.message key="eshop.save"/></button>
                </div>
            </div>
            </#if>
        </form>

