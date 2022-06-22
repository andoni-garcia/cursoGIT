<#-- Bundle para las traducciones necesarias -->
<#include "../../../include/imports.ftl">
<@hst.setBundle basename="valveconfigurator,eshop"/>


<div id="configurator_panel_div">

	<div class="row">
		<#if CellConfiguration.reference??>
			<div class="col-md-9">
				<h3>
					<#if CellConfiguration.reference?has_content>
						<span id="sy_product_reference">${CellConfiguration.reference}</span>
						<#if CellConfiguration.productState == "correct">
							<img class="ik_state_image correct" src="<@hst.webfile path="/images/vcconfigurator/imageStatus/correct.png"/>">
						</#if>
					<#else>
						<span id="sy_product_reference"><@fmt.message key="notPartNumber"/></span>
					</#if>
				</h3>
			</div>
		</#if>

	</div>

	<div class="row mt-2 w-100">

	<#assign isCustomizedManifold = false>
	<#if CellConfiguration.isManifold && CellConfiguration.isSpecialFreeProduct>
		<#assign isCustomizedManifold = true>
	</#if>

	<#if CellConfiguration.characteristicGroupList??>
	<#list CellConfiguration.characteristicGroupList as charGroup >
		<div id ="cell_characteristic_group">
		<div class="row">
			<div class="col-sm-12 ik_characteristic_group" >
			 </div>
		</div>

		<#if charGroup.characteristicList??>
		<#list charGroup.getCharacteristicList() as ch >
			<div id="cell_characteristic">
				<div class="row mt-2">
					<div class="col-lg-6 col-sm-12">${ ch.getChLabel() }</div>
					<div class="col-lg-5 col-sm-10">
						<#if ch.chOptionList??>
							<#if ch.getChType() == "drop" >
								<#assign isRadio = false>
								<select class="form-control event <#if ch.chStatus =="with_errors"> ik_option_red</#if> " size id=${ch.getChId()}<#if CellConfiguration.isClosedConfiguration || isCustomizedManifold> disabled="disabled"</#if>>
									<#list ch.getChOptionList() as op>

										<option
										<#if op.isOpSelected()> selected</#if>
										<#if !op.isOpCompatible()> class="ik_option_red" </#if>
										id="${op.getOpCharacteristicName()}" value="${op.getOpValue()}"
										data-status="${ch.getChStatus()}" data-compatible="${op.isOpCompatible()?c}" data-recalculategroup="${op.isOpRecalculategroup()?c}">
										${op.getOpLabel()}</option>

									</#list>

								</select>
							<#else>
							<div class ="ik_interval_selection_group">
								<div>
								<#list ch.getChOptionList() as op>
								<#assign isRadio = true>
								<#if op.opValue?has_content >
										<label class="radio-inline ">
											<input class="interval_selection" type="radio"
											<#if op.isOpSelected()> checked </#if>
											name="${op.getOpCharacteristicName()}" value="${op.getOpValue()}"
											data-status="${ch.getChStatus()}" data-compatible="${op.isOpCompatible()?c}" data-recalculategroup="${op.isOpRecalculategroup()?c}"<#if CellConfiguration.isClosedConfiguration || isCustomizedManifold> disabled="disabled"</#if>>
											${op.getOpLabel()}
										</label>
								</#if>
								</#list>
								</div>
							</div>
							</#if>
						</#if>
					</div>
					<div class="col-lg-1 col-sm-2">
						<#if ch.getChStatus() =="correct">
							<img class="ik_state_image ${ch.getChStatus()}" src="<@hst.webfile path="/images/vcconfigurator/imageStatus/correct.png"/>"/>
						<#else>
							<#if !isRadio>
								<img class="ik_state_image ${ch.getChStatus()}" src="<@hst.webfile path="/images/vcconfigurator/imageStatus/with_errors.png"/>"/>
							</#if>
						</#if>
					</div>
				</div>
			</div>
			</#list>
			</#if>
		</div>
	</#list>
	<#--
	<#else>
		No hay ningun cellCharacteristicGroup
	-->
	</#if>

	<#-- Product wrapper options -->
			<#include "configurator-editor-grid-products-wrapper.ftl">
	<#-- Product wrapper options -->

	<#if customisedElementPermission>
		<#if CellConfiguration.isManifold && !CellConfiguration.isClosedConfiguration>
			<div class="search-results customized-manifold-selector">
				<div class="row">
					<div class="col-12" id="customizeManifold">
						<span id="customizedManifold" style="display:${CellConfiguration.isSpecialFreeProduct?then('block','none')}">
						<@fmt.message key="customized.manifold.standard"/>
						</span>
						<span id="standardManifold" style="display:${CellConfiguration.isSpecialFreeProduct?then('none','block')}">
						<@fmt.message key="customized.manifold.customized"/>
						</span>
					</div>
				</div>
			</div>
			<div id="manifoldSpecialContainer">
				${customizedManifoldTable}
			</div>
		</#if>
		<#if CellConfiguration.customizedCellHtmlForm??>
		${CellConfiguration.customizedCellHtmlForm}
		</#if>
	</#if>

</div></div>

<#if customisedElementPermission>
<@hst.headContribution  category="scripts">
    <script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/customized/valve-customized.js"/>" type="text/javascript"></script>
</@hst.headContribution>

<@hst.headContribution  category="htmlBodyEnd">
<script type="text/javascript">
    let customizeManifoldUrl;
	let addCustomizedManifoldReferenceUrl;
	let modifyCustomizedManifoldReferenceUrl;
	let deleteCustomizedManifoldReferenceUrl;
	let addCustomizedManifoldPartUrl;
	let modifyCustomizedManifoldPartUrl;
	let deleteCustomizedManifoldPartUrl;
	let resetCustomizedManifoldUrl;
	let saveFreeHiddenMeassuresUrl;
	let setDimensionsUrl;
	let saveFreeElementReferenceUrl;
	let addFreeElementPartUrl;
	let modifyFreeElementPartUrl;
	let deleteFreeElementPartUrl;
    $(document).ready(function() {
        customizeManifoldUrl = '<@hst.resourceURL resourceId="customizeManifold"/>';
		addCustomizedManifoldReferenceUrl = '<@hst.resourceURL resourceId="addCustomizedManifoldReference"/>';
		modifyCustomizedManifoldReferenceUrl = '<@hst.resourceURL resourceId="modifyCustomizedManifoldReference"/>';
		deleteCustomizedManifoldReferenceUrl = '<@hst.resourceURL resourceId="deleteCustomizedManifoldReference"/>';
		addCustomizedManifoldPartUrl = '<@hst.resourceURL resourceId="addCustomizedManifoldPart"/>';
		modifyCustomizedManifoldPartUrl = '<@hst.resourceURL resourceId="modifyCustomizedManifoldPart"/>';
		deleteCustomizedManifoldPartUrl = '<@hst.resourceURL resourceId="deleteCustomizedManifoldPart"/>';
		resetCustomizedManifoldUrl = '<@hst.resourceURL resourceId="resetCustomizedManifold"/>';
		saveFreeHiddenMeassuresUrl = '<@hst.resourceURL resourceId="saveFreeHiddenMeassures"/>';
		setDimensionsUrl = '<@hst.resourceURL resourceId="setDimensions"/>';
		saveFreeElementReferenceUrl = '<@hst.resourceURL resourceId="saveFreeElementReference"/>';
		addFreeElementPartUrl = '<@hst.resourceURL resourceId="addFreeElementPart"/>';
		modifyFreeElementPartUrl = '<@hst.resourceURL resourceId="modifyFreeElementPart"/>';
		deleteFreeElementPartUrl = '<@hst.resourceURL resourceId="deleteFreeElementPart"/>';
    });
</script>
</@hst.headContribution>
</#if>