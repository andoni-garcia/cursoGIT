
<#include "../../../include/imports.ftl">
<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator"/>

<div id="">
	<@hst.actionURL var="saveOnCache"/>
    <div id="product-information-form" >
        <div class="mb-5">
            <div for="projectDescription" class="heading-07 mb-3"><@fmt.message key="projectDescription"/></div>
            <textarea class="form-control product-information-form" data-key="designer.projectDescription" rows="5" id="projectDescription" name="projectDescription" placeholder="<@fmt.message key="description"/>">${projectDescription}</textarea>
        </div>
        <div class="mb-5">
            <div for="saveAsDefault" class="heading-07 mb-3"><@fmt.message key="designerContact"/></div>
			<button data-key="designer" class="btn btn-primary noactive mb-3" id="save-as-default-btn--designer" ><@fmt.message key="saveAsDefault"/> </button>
			
			<div class="mb-3">
	            <label for="name"><@fmt.message key="name"/></label>                                
	            <input type="text" data-key="designer.name" class="form-control product-information-form" id="name" name="name" value="${syDesignerData.name}" placeholder="<@fmt.message key="name"/>" required/>
            </div>
            
            <div class="mb-3">
            <label for="company"><@fmt.message key="company"/></label>                                
            <input type="text" data-key="designer.company" class="form-control product-information-form"  id="company" name="company" value="${syDesignerData.company}" placeholder="<@fmt.message key="company"/>" required/>
       		</div>
       		<div class="row">
	            <div class="col-lg-6 mb-3">
	              <label for="inputEmail4"><@fmt.message key="email"/></label>
	              <input type="email" data-key="designer.email" class="form-control product-information-form" id="inputEmail4" name="inputEmail4" value="${syDesignerData.email}" placeholder="<@fmt.message key="email"/>" required>
	            </div>
	            <div class=" col-lg-6 mb-3">
	              <label for="adress"><@fmt.message key="address"/></label>
	              <input type="text" data-key="designer.address" class="form-control product-information-form" id="address" name="address" value="${syDesignerData.address}" placeholder="<@fmt.message key="address"/>">
	            </div>
            </div>
            <div class="row">
	             <div class=" col-lg-6 mb-3">
	              <label for="phone"><@fmt.message key="telephone"/></label>
	              <input type="tel" data-key="designer.phone" class="form-control product-information-form" id="phone" name="telephone" value="${syDesignerData.phone}" placeholder="<@fmt.message key="telephone"/>" required>
	            </div>
	            <div class=" col-lg-6 mb-3">
	              <label for="Town"><@fmt.message key="town"/></label>
	              <input type="text" data-key="designer.town" class="form-control product-information-form" id="town" name="town" value="${syDesignerData.town}" placeholder="<@fmt.message key="town"/>">
	            </div>
             </div>
            <div class="row">
	            <div class=" col-md-6 mb-3">
	              <label for="Fax"><@fmt.message key="fax"/></label>
	              <input type="tel" data-key="designer.fax" class="form-control product-information-form" id="fax" name="fax" value="${syDesignerData.fax}" placeholder="<@fmt.message key="fax"/>">
	            </div>
	            <div class=" col-md-6 mb-3">
	              <label for="zip"><@fmt.message key="zipCode"/></label>
	              <input type="number" data-key="designer.zipCode" class="form-control product-information-form" id="zip" name="zip" value="${syDesignerData.zipCode}" placeholder="<@fmt.message key="zipCode"/>">
	            </div>
	            <input type="hidden" class="form-control" name="isDesigner" id="isDesigner" value="true">
							<input data-key="designer.id" type="hidden" class="form-control product-information-form" name="id" id="id" value="${syDesignerData.id}">
	        </div>

          </div>
	</div>

	<@hst.actionURL var="saveOnCache"/>
    <div id="product-information-form" >

          <div class="">
            <div for="saveAsDefault" class="heading-07 mb-3"><@fmt.message key="customerContact"/></div>

            <span class="btn btn-primary noactive mb-3" id="load-btn"><@fmt.message key="loadContact"/></span>
            <button data-key="contact" class="btn btn-primary noactive mb-3" id="save-as-default-btn--contact" ><@fmt.message key="saveCustomer"/> </button>

          	<div class="mb-3">
	            <label for="contactName"><@fmt.message key="name"/></label>                                
	            <input data-key="contact.name" type="text" class="form-control product-information-form" id="contactName" name="name" value="${syContactData.name}" placeholder="<@fmt.message key="name"/>" required/>
            </div>
            
            <div class="mb-3">
            <label for="contactCompany"><@fmt.message key="company"/></label>                                
            <input data-key="contact.company" type="text" class="form-control product-information-form"  id="contactCompany" name="company" value="${syContactData.company}" placeholder="<@fmt.message key="company"/>" required/>
       		</div>
       		
       		<div class="row">
	            <div class="col-lg-6 mb-3">
	              <label for="inputEmail4"><@fmt.message key="email"/></label>
	              <input data-key="contact.email" type="email" class="form-control product-information-form" id="contactInputEmail4" name="inputEmail4" value="${syContactData.email}" placeholder="<@fmt.message key="email"/>" required>
	            </div>
	            <div class=" col-lg-6 mb-3">
	              <label for="adress"><@fmt.message key="address"/></label>
	              <input data-key="contact.address" type="text" class="form-control product-information-form" id="contactAddress" name="address" value="${syContactData.address}" placeholder="<@fmt.message key="address"/>">
	            </div>
            </div>
            <div class="row">
	             <div class=" col-lg-6 mb-3">
	              <label for="phone"><@fmt.message key="telephone"/></label>
	              <input data-key="contact.phone" type="tel" class="form-control product-information-form" id="contactPhone" name="telephone" value="${syContactData.phone}" placeholder="<@fmt.message key="telephone"/>" required>
	            </div>
	            <div class=" col-lg-6 mb-3">
	              <label for="Town"><@fmt.message key="town"/></label>
	              <input data-key="contact.town" type="text" class="form-control product-information-form" id="contactTown" name="town" value="${syContactData.town}" placeholder="<@fmt.message key="town"/>">
	            </div>
             </div>
            <div class="row">
	            <div class=" col-md-6 mb-3">
	              <label for="Fax"><@fmt.message key="fax"/></label>
	              <input data-key="contact.fax" type="tel" class="form-control product-information-form" id="contactFax" name="fax" value="${syContactData.fax}" placeholder="<@fmt.message key="fax"/>">
	            </div>
	            <div class=" col-md-6 mb-3">
	              <label for="zip"><@fmt.message key="zipCode"/></label>
	              <input data-key="contact.zipCode" type="number" class="form-control product-information-form" id="contactZip" name="zip" value="${syContactData.zipCode}" placeholder="<@fmt.message key="zipCode"/>">
	            </div>
	            <input type="hidden" class="form-control" id="isDesigner" value="false">
	            <input data-key="contact.id" type="hidden" class="form-control product-information-form" name="id" id="id" value="${syDesignerData.id}">
	        </div>
          </div>
    </div>
</div>
