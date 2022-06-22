<#include "../../include/imports.ftl">
<@hst.setBundle basename="valveconfigurator"/>

<@hst.actionURL var="actionURL"/>
<@hst.actionURL var="initSyf" resourceId="fileUpload"/>

<@hst.headContribution category="htmlHead">
	<script>
		var actionUrl;
	</script>
</@hst.headContribution>

<@hst.headContribution category="scripts">
	<script type="text/javascript">
		$(document).ready(function(){
			actionUrl = "${actionURL}";
    });
    </script>
</@hst.headContribution>


<div class="container">
    <div>
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
	<main class="smc-main-container valve-configurator">
        <div>
            <div class="cmseditlink">
            </div>
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="valveConfigurator"/></h2>
            <h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesSY"/></h1>
        </div>
        <br>
        <div class="smc-tabs">
            <div class="smc-tabs__head">
                <div class="container">
                    <ul>
                        <li class="heading-0a smc-tabs__head--active"><a href="#"><@fmt.message key="CreateCustomConfigScratch"/></a></li>
                        <li class="heading-0a"><a href="#"><@fmt.message key="OpenExistingConfig"/></a></li>
                    </ul>
                </div>
            </div>
            <section class="search-results">
                <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly smc-tabs__body--active">
                    <div class="simple-collapse__head">
                        <h2 class="heading-06 heading-semi-light"><@fmt.message key="CreateCustomConfigScratch"/></h2>
                    </div>
                    <div class="simple-collapse__body">


                        <div class="simple-collapse__bodyInner p-0">
                            <div id="" class="container_12">

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">1. <@fmt.message key="ManyfoldType"/> <a href="${s3bucket}valve-configurator/${.locale}/Manifold_Types.pdf" target="_blank"><i id="manifoldInfo" class="fas fa-info-circle"></i></a></div>

                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">

                                                <span id="m_ip40" class="manyfold selSeriesElement sprite ip40 active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="PlugInMetalBase"/></p>
                                            </a>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">

                                                <span id="m_ip67" class="manyfold selSeriesElement sprite ip67 active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="PlugInResinBase"/></p>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">2. <@fmt.message key="PipingRedirection"/> <a href="${s3bucket}valve-configurator/${.locale}/Piping_redirection.pdf" target="_blank"><i id="pipingInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option active">
                                                <span id="p_side" class="piping selSeriesElement sprite side active"></span>
                                                <p class="m-0 p-2"><@fmt.message key="sidePorted"/></p>

                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">

                                                <span id="p_bottom" class="piping selSeriesElement sprite bottom noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="bottomPorted"/></p>

                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">

                                                <span id="p_top" class="piping selSeriesElement sprite top noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="top"/></p>

                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">3. <@fmt.message key="connectionType"/></div>
                                    <div class="col-12 h5 mt-4"><@fmt.message key="parallelConection"/> <a href="${s3bucket}valve-configurator/${.locale}/Connection_type_Parallel_wiring.pdf" target="_blank"><i id="parallelConnectionInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_dsub" class="connection selSeriesElement sprite dsub noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.DSub"/></p>

                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_flatribbon" class="connection selSeriesElement sprite flatribbon noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Flat"/></p>

                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2 d-none">
                                        <div class="select-option noactive">
                                                <span id="c_pcwiring" class="connection selSeriesElement sprite pcwiring noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Pc"/></p>

                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_terminalblock" class="connection selSeriesElement sprite terminalblock noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Terminal"/></p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_leadwire" class="connection selSeriesElement sprite leadwire noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Lead"/></p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_circular" class="connection selSeriesElement sprite circular noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Circular"/></p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h5 mt-4"><@fmt.message key="serialInterface"/> <a href="${s3bucket}valve-configurator/${.locale}/Connection_types_Serial_wiring.pdf" target="_blank"><i id="serialConnectionInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex120" class="connection selSeriesElement sprite ex120 noactive"></span>
                                                <p class="m-0 p-2">EX120</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex126" class="connection selSeriesElement sprite ex126 noactive"></span>
                                                <p class="m-0 p-2">EX126</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex250" class="connection selSeriesElement sprite ex250 noactive"></span>
                                                <p class="m-0 p-2">EX250</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex260" class="connection selSeriesElement sprite ex260 noactive"></span>
                                                <p class="m-0 p-2">EX260</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex500" class="connection selSeriesElement sprite ex500 noactive"></span>
                                                <p class="m-0 p-2">EX500</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex510" class="connection selSeriesElement sprite ex510 noactive"></span>
                                                <p class="m-0 p-2">EX510</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="c_ex600" class="connection selSeriesElement sprite ex600 noactive"></span>
                                                <p class="m-0 p-2">EX600</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-12 h4 mt-4">4. <@fmt.message key="solenoidValveSize"/> <a href="${s3bucket}valve-configurator/${.locale}/Valve_size.pdf" target="_blank"><i id="valveInfo" class="fas fa-info-circle"></i></a></div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy3000" class="valve selSeriesElement sprite sy3000 noactive"></span>
                                                <p class="m-0 p-2">3000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy5000" class="valve selSeriesElement sprite sy5000 noactive"></span>
                                                <p class="m-0 p-2">5000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_sy7000" class="valve selSeriesElement sprite sy7000 noactive"></span>
                                                <p class="m-0 p-2">7000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_mixed" class="valve selSeriesElement sprite mixed noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Mixed"/> 3000/5000</p>
                                        </div>
                                    </div>
                                    <!-- option -->
                                    <div class="col-6 col-md-4 col-lg-2">
                                        <div class="select-option noactive">
                                                <span id="v_mixed7000" class="valve selSeriesElement sprite mixed7000 noactive"></span>
                                                <p class="m-0 p-2"><@fmt.message key="option.Mixed"/> 5000/7000</p>
                                        </div>
                                    </div>
                                </div>
								<form id="form-selseries" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}" method="post">
                                    <input id="idGroup" name="idGroup" value="defaultValue" type="hidden">
                                    <input id="serie" name="serie" value="defaultValue" type="hidden">
                                    <span class="btn btn-primary noactive mt-4 mb-4" id="boton"><@fmt.message key="createCustomConfiguration"/></span>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="search-results">
                <div class="smc-tabs__body search-result-item simple-collapse simple-collapse--mobileOnly">
                    <div class="simple-collapse__head">
                        <h2 class="heading-06 heading-semi-light"><@fmt.message key="OpenExistingConfig"/></h2>
                    </div>
                    <div class="simple-collapse__body">
                        <div class="simple-collapse__bodyInner p-0 mb-5 mt-3">
                            <form id="ik_sy_open_form" method="post" enctype="multipart/form-data" action="${actionURL}&${_csrf.parameterName}=${_csrf.token}">
								<div class="container_12" style="margin-left:0px;">
									<div class="grid_5 fake_file" id="upload-file-container">
										<span class="d-inline-block"><@fmt.message key="LoadExistingConfig"/></span>
										<button id="browse_button" class="btn btn-primary ml-sm-3 mt-3 mt-sm-0" data-brackets-id="17079"><@fmt.message key="button.open"/></button>

										<!--<input class="fake_file" type="text" style="margin-top:-20px" value="">-->
									</div>
									<div id="sy_submit_div" class="grid_2">
										<input id="file_input" type="file" name="file_input" class="file" noscript="true">
										<input id="serie" name="serie" value="test" type="hidden">
									</div>
								</div>
							</form>


                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>


	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/underscore-min.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/functions/page-functions.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/class.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/selseries.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/configure-selseries-options-set.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
	 	<!-- ROLLBACK S3
	 		<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/sel_series.css"/>" type="text/css"></link>
	 	-->
	 	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/sel_series.css" type="text/css"></link>
	</@hst.headContribution>
</div>