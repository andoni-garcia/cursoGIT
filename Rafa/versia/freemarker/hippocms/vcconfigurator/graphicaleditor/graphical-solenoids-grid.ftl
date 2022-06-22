
<#include "../../../include/imports.ftl">
<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator"/>
	<#if Solenoid??>
		<div class="row">
			<div id="freeSolenoids" class="col-sm-12">
				<#if Solenoid.remainingFreeSolenoidsLabel?has_content >
					<label class="${negativeRemaining?then('ik_red', '')}">
						${Solenoid.remainingFreeSolenoidsLabel} ${Solenoid.remainingFreeSolenoidsText}
					</label>
				</#if>
			</div>
		</div> 
	</#if>