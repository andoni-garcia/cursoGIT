
<#include "../../../include/imports.ftl">
<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator"/>

	<#if Meassure??>		
	
		<div class="row">
			<div class="col-sm-12">	
			<#if Meassure.infoExtraMeassures?has_content >			
					${Meassure.infoExtraMeassures} 					
			</#if>	      
			</div>		
		</div>
		
		<div class="row">
			<div class="col-sm-6">		
			<#if Meassure.manifoldMaxLengthLabel?has_content >			
					${Meassure.manifoldMaxLengthLabel} ${Meassure.manifoldMaxLengthValue} 					
			</#if>			
											      
			</div>
			<div class="col-sm-6">
			<#if Meassure.manifoldMaxWidthLabel?has_content >			
					${Meassure.manifoldMaxWidthLabel} ${Meassure.manifoldMaxWidthValue} 					
			</#if>					
																      
			</div>			
		</div>
		
		<div class="row">
			<div class="col-sm-6">
			<#if Meassure.weightLabel?has_content >			
					${Meassure.weightLabel} ${Meassure.weightValue}			
			</#if>					
											      
			</div>
			<div class="col-sm-6">
			<#if Meassure.manifoldMaxHeightLabel?has_content >			
					${Meassure.manifoldMaxHeightLabel} ${Meassure.manifoldMaxHeightValue} 					
			</#if>					
																      
			</div>			
		</div>
		
		<div class="row">
			<div class="col-sm-6">
			<#if Meassure.inputsLabel?has_content >			
					${Meassure.inputsLabel} ${Meassure.inputsValue} 					
			</#if>					
											      
			</div>
			<div class="col-sm-6">	
			<#if Meassure.outputsLabel?has_content >			
					${Meassure.outputsLabel} ${Meassure.outputsValue}						
			</#if>				
															      
			</div>			
		</div>
		
		<div class="row">
			<div class="col-sm-6">	
			<#if Meassure.railDinLabel?has_content >			
					${Meassure.railDinLabel} ${Meassure.railDinValue} 					
			</#if>				
							        						      
			</div>					
		</div> 
		
	</#if>
