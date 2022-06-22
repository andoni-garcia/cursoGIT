<h3 class="sub-title"><@fmt.message key="productConfigurator.projectinfo.projectdescription" /></h3>
<div class="form-group">
    <label for="description"><@fmt.message key="productConfigurator.projectinfo.description" /></label>
    <textarea maxlength = "400" id="projectDescription" name="projectDescription" class="form-control" rows="3" max-rows = "10"></textarea>
</div>

<form id="project-designer-contact-form">
    <h3 class="sub-title"><@fmt.message key="productConfigurator.projectinfo.designercontact" /></h3>
    <span class="small font-italic"><span class="required-dot">*</span> <@fmt.message key="productConfigurator.projectinfo.mandatoryfields" /></span>

    <input type="hidden" name="id">
    <div class="eforms-field form-group">
        <label for="name"><@fmt.message key="productConfigurator.projectinfo.name" /> *</label>
        <div class="form-group__inputWrapper"><!-- class is-invalid to error state -->
            <input type="text" class="form-control" name="name" required> <!-- class is-invalid to error state -->
            <div class="invalid-feedback"><@fmt.message key="productConfigurator.projectinfo.validation.notvalid" /></div>
        </div>
    </div>
    <div class="eforms-field form-group">
        <label for="company"><@fmt.message key="productConfigurator.projectinfo.company" /> *</label>
        <div class="form-group__inputWrapper"><!-- class is-invalid to error state -->
            <input type="text" class="form-control" name="company" required> <!-- class is-invalid to error state -->
            <div class="invalid-feedback"><@fmt.message key="productConfigurator.projectinfo.validation.notvalid" /></div>
        </div>
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="email"><@fmt.message key="productConfigurator.projectinfo.email" /></label>
            <div class="form-group__inputWrapper"><!-- class is-invalid to error state -->
                <input type="email" class="form-control check-validation" name="email">
                <div class="invalid-feedback"><@fmt.message key="productConfigurator.projectinfo.validation.notvalid" /></div>
            </div>
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="address"><@fmt.message key="productConfigurator.projectinfo.address" /></label>
            <input type="text" class="form-control" name="address">
        </div>
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="phone"><@fmt.message key="productConfigurator.projectinfo.phone" /></label>
            <input type="tel" class="form-control" name="phone">
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="town"><@fmt.message key="productConfigurator.projectinfo.town" /></label>
            <input type="text" class="form-control" name="town">
        </div>
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="fax"><@fmt.message key="productConfigurator.projectinfo.fax" /></label>
            <input type="tel" class="form-control" name="fax">
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="zip"><@fmt.message key="productConfigurator.projectinfo.zip" /></label>
            <input type="text" class="form-control" name="zip">
        </div>
    </div>

    <button type="submit" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="productConfigurator.projectinfo.savedesignerbtn" /></button>
</form>

<br/>

<form id="project-customer-contact-form">
    <h3 class="sub-title"><@fmt.message key="productConfigurator.projectinfo.customercontact" /></h3>
    <span class="small font-italic"><span class="required-dot">*</span> <@fmt.message key="productConfigurator.projectinfo.mandatoryfields" /></span><br/>
    <span class="small font-italic"><span class="required-dot">**</span> <@fmt.message key="productConfigurator.projectinfo.donotfillsameperson" /></span>

    <#--//XXX This forces always to create a new Customer contact-->
    <#--<input type="hidden" name="id">-->
    <div class="eforms-field form-group">
        <label for="name"><@fmt.message key="productConfigurator.projectinfo.name" /> *</label>
        <div class="form-group__inputWrapper"><!-- class is-invalid to error state -->
            <input type="text" class="form-control" name="name" required> <!-- class is-invalid to error state -->
            <div class="invalid-feedback"><@fmt.message key="productConfigurator.projectinfo.validation.notvalid" /></div>
        </div>
    </div>
    <div class="eforms-field form-group">
        <label for="company"><@fmt.message key="productConfigurator.projectinfo.company" /></label>
        <input type="text" class="form-control" name="company">
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="email"><@fmt.message key="productConfigurator.projectinfo.email" /></label>
            <div class="form-group__inputWrapper"><!-- class is-invalid to error state -->
                <input type="email" class="form-control check-validation" name="email">
                <div class="invalid-feedback"><@fmt.message key="productConfigurator.projectinfo.validation.notvalid" /></div>
            </div>
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="address"><@fmt.message key="productConfigurator.projectinfo.address" /></label>
            <input type="text" class="form-control" name="address">
        </div>
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="phone"><@fmt.message key="productConfigurator.projectinfo.phone" /></label>
            <input type="tel" class="form-control" name="phone">
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="town"><@fmt.message key="productConfigurator.projectinfo.town" /></label>
            <input type="text" class="form-control" name="town">
        </div>
    </div>
    <div class="row">
        <div class="eforms-field form-group col-lg-6">
            <label for="fax"><@fmt.message key="productConfigurator.projectinfo.fax" /></label>
            <input type="tel" class="form-control" name="fax">
        </div>
        <div class="eforms-field form-group col-lg-6">
            <label for="zip"><@fmt.message key="productConfigurator.projectinfo.zip" /></label>
            <input type="text" class="form-control" name="zip">
        </div>
    </div>

    <button id="load-contact-btn" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="productConfigurator.projectinfo.loadcontactbtn" /></button>
    <button type="submit" class="btn btn-secondary btn-secondary--blue-border"><@fmt.message key="productConfigurator.projectinfo.savecontactbtn" /></button>
</form>

<div class="hidden" data-swiftype-index='false'>
    <a id="getCustomerByNameLink" href="<@hst.resourceURL resourceId='getCustomerByName'/>"></a>
    <a id="getCustomerByIdLink" href="<@hst.resourceURL resourceId='getCustomerById'/>"></a>
    <a id="deleteCustomerByIdLink" href="<@hst.resourceURL resourceId='deleteCustomerById'/>"></a>
    <a id="addCustomerLink" href="<@hst.resourceURL resourceId='addCustomer'/>"></a>
    <a id="updateCustomerLink" href="<@hst.resourceURL resourceId='updateCustomer'/>"></a>
    <a id="addDesignerLink" href="<@hst.resourceURL resourceId='addDesigner'/>"></a>
    <a id="updateDesignerLink" href="<@hst.resourceURL resourceId='updateDesigner'/>"></a>
    <a id="getDefaultDesignerLink" href="<@hst.resourceURL resourceId='getDefaultDesigner'/>"></a>
    <a id="loadProjectLink" href="<@hst.resourceURL resourceId='loadProject'/>"></a>
    <a id="saveProjectLink" href="<@hst.resourceURL resourceId='saveProject'/>"></a>
    <a id="generatePDFReportLink" href="<@hst.resourceURL resourceId='generatePDFReport'/>"></a>
</div>
<script id="ProductConfiguratorInit">
    var smc =  window.smc || {};
    smc.projectInformationModule = smc.projectInformationModule || {};
    smc.projectInformationModule.urls = {
        getCustomerByName: document.getElementById('getCustomerByNameLink').href,
        getCustomerById: document.getElementById('getCustomerByIdLink').href,
        deleteCustomerById: document.getElementById('deleteCustomerByIdLink').href,
        addCustomer: document.getElementById('addCustomerLink').href,
        updateCustomer: document.getElementById('updateCustomerLink').href,
        updateDesigner: document.getElementById('updateDesignerLink').href,
        getDefaultDesigner: document.getElementById('getDefaultDesignerLink').href,
        loadProject: document.getElementById('loadProjectLink').href,
        saveProject: document.getElementById('saveProjectLink').href,
        generatePDFReport: document.getElementById('generatePDFReportLink').href
    };
</script>

<script id="customerContactPopoverTemplate" type="text/template">
    <div class="popover customer-contact-popover customer-contact-popover-js" role="tooltip">
        <div class="arrow"></div>
        <h2 class="heading heading-07">
            <span class="popover-header"></span>
            <a href="javascript:void(0);" class="close-btn close-btn-js iconed-text">
                <i class="icon-close"></i>
            </a>
        </h2>
        <div class="popover-body"></div>
    </div>
</script>

<script id="customerContactItemTemplate" type="text/template">
    <li class="customer-contact-item customer-contact-item-js iconed-text" data-contactid="{{customer_id}}">
        <span class="name customer-contact-item-name-js">{{customer_fullname}}</span><i class="text-danger icon-invalid remove-contact-btn remove-contact-btn-js"></i>
    </li>
</script>
