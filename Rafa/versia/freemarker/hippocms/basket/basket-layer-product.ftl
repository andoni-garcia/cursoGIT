<#include "../../include/imports.ftl">
<#assign security=JspTaglibs["http://www.springframework.org/security/tags"] />


<#if basketProduct??>
<@security.authorize access="isAuthenticated()" var="isAuthenticated"/>
<@security.authorize access="hasRole('ROLE_light_user')" var="isLightUser"/>




 <li id="item-${basketProduct.basketProductId?c}">

	 <#if isAuthenticated && !isLightUser>
    <div class="row">    
	    <div class="col-4">
	 <#else>
    <div class="row m-3">
       <div class="col-10">
	</#if>
       	 <div>
			<a class="text-muted partnumber-href" data-bind="text: '${basketProduct.erpProduct.partnumberCode}', click : GlobalPartnumberInfo.getPartNumberUrl.bind($data, ${basketProduct.erpProduct.partnumberCode}, $parent.personalizedType())" target="_blank"></a>

			</div>
   	   </div>
    
        <#if isAuthenticated && !isLightUser>
		    <div class="col-2">
		        <div>
		            <input type="text" type="number" max="999" class="form-control float-left" value="${basketProduct.erpProduct.totalQuantity}">
		        </div>
		    </div>
		    
		
		
		    <div class="col-2">
		        <div><span class="text-muted"> ${basketProduct.erpProduct.deliveryDate?c} </span></div>
		    </div>
		    <div class="col-2">
		        <div>
		            <span class=""> ${basketProduct.erpProduct.netPrice} € </span><br/>
		            <span class="text-muted"> ${basketProduct.erpProduct.listPrice} € </span>
		        
		        </div>
		    </div>
   		 </#if>

    
    <div class="col-1">                        
        <a href="#"><i class="fas fa-info-circle"></i></a>
    </div>
    <div class="col-1">
        <a href="javascript:deleteProductFromBasket(${basketProduct.basketProductId?c})" ><i class="fas fa-trash"></i></a>
    </div>
    </div>        
   </li>
 </#if> 