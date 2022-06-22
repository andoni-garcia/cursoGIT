
<#include "../../../include/imports.ftl">
<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator,eshop"/>


<#-- Product wrapper options -->
<#if CellConfiguration.productList??>
<div id="products_wrapper">
	
	
	
	<div id="products_div">
		
		<#assign productGroup="-1">	
		<#assign closePending=false>	
				
		<#list CellConfiguration.getProductList() as pl >	 
		
		<#if productGroup != pl.productGroup>
			
			<#if closePending>
				</fieldset>
			</#if>
		
				<fieldset class="products_group p${pl.getProductGroup()}">
				<#assign productGroup=pl.productGroup>	
				<#assign closePending=true>	
				<h3><@fmt.message key="select.one.of.the.following.type.of.options"/></h3>
					<div class="row info-box p-3">
		</#if>
								
						<div class="col-lg-4 col-sm-12">
								<div class=""></div>
								<div class="product_link">
									<a href="#" class="link_product" 
									idcell="${pl.getIdCell()}" idproduct="${pl.getIdProduct()}" baseproductid="${pl.getBaseProductId()}" 
									celltype="${pl.getCellType()}" othercellproduct="${pl.isOtherCellProduct()?c}" 
									recalculatesizepositions="${pl.isRecalculateSizePositions()?c}"	
									producttab="${pl.getProductTab()}" producttype="${pl.getProductType()}" title="${pl.getTitle()}">${pl.getTitle()}</a>
								</div>
						</div>
								
						<#if !pl?has_next >
		
				</fieldset>
			</div>		
		</#if>

		</#list>
		
	</div>
<#-- 
<#else>
			No hay ningun productList
-->
</#if>