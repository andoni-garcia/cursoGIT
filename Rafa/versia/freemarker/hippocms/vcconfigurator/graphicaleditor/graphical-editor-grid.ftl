<#include "../../../include/imports.ftl">

<#-- graphical_editor_content_div -->
<div id="graphical_editor_content_div">
	<#-- div estructura visual  -->
	<div class = "graphical_editor" data-si_manifold="false" data-d2_manifold="false">
	
		<#-- MIXED  -->
		<#list 1..12 as i >	
			<div class="mixeds mixed_${i}">
				<div class="mixed_element selectable unselected"></div>
				<div class="mixed_number label" style="display: none;">
					<label>${i}</label>
				</div>			
			</div>		
		</#list>
		
		<#-- INPUTS  -->
		<#list 12..1 as i >	
			<div class="inputs input_${i}">
				<div class="input_element selectable unselected"></div>
				<div class="input_number label" style="display: none;">
					<label>${i}</label>
				</div>
			</div>	
		</#list>
		
		<#-- D2 MANIFOLD -->
		<div class="manifold_d2 selectable"></div>
		
		
		<#-- OUTPUTS -->		
		<#list 1..12 as i >	
			<div class="outputs output_${i}">
				<div class="output_element selectable unselected"></div>
				<div class="output_number label" style="display: none;">
					<label>${i}</label>
				</div>
			</div>	
		</#list>
		
		<#-- D MANIFOLD -->
		<div class="manifold">
			<div class="manifold_d selectable unselected"></div>
			<div class="manifold_d_label label" style="display: none;">
				<label>D side</label>
			</div>
		</div>
		
		<#-- D MANIFOLD -->
		<#list 1..24 as i >	
			<div class="stations station_${i} no_intermediate no_block_disk">			
			
				<#if i < 24 >
					<div class="station_element block_disk"></div>
				</#if>
				
				<div class="station_element station_wiring label" style="display: none;">
					<label>( D )</label>
				</div>
				
				<div class="station_element base_plate selectable unselected"></div>
				<div class="station_element intermediate_level selectable unselected"></div>
				<div class="station_element valves selectable unselected"></div>
				<div class="station_element station_number label" style="display: none;">
					<label>${i}</label>
				</div>
			
			</div>		
		</#list>
		
		<#-- U MANIFOLD -->
		<div class="manifold">
			<div class="manifold_u selectable unselected"></div>
			<div class="manifold_u_label label" style="display: none;">
				<label>U side</label>
			</div>
		</div>		
		
	<#-- /div estructura visual  --> 
	</div>
<#-- /div graphical_editor_content_div -->
</div>

<div>
	<div class="row">
		<div id="configurator_panel_div_notices" class="col-md-12">
			<div class="valve_notices_small">
				<label></label>
			</div>
		</div>
	</div>
</div>