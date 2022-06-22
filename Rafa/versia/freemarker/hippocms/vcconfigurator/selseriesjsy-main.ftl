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
            <h1 class="heading-02 heading-main"><@fmt.message key="refSelseriesJSY"/></h1>
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
                <#if vcJsyNextVersion?c == "true">
                    <#include "./selseriesjsy-next.ftl">
                <#else>
                    <#include "./selseriesjsy.ftl">
                </#if>

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
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/selseries-jsy.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
		<script src="<@hst.webfile path="/freemarker/versia/js-menu/vcconfigurator/configure-selseries-jsy-options-set.js"/>" type="text/javascript"></script>
	</@hst.headContribution>

	<@hst.headContribution  category="scripts">
    <!-- ROLLBACK S3
    	<link rel="stylesheet" href="<@hst.webfile  path="/freemarker/versia/css-menu/vcconfigurator/sel_series_jsy.css"/>" type="text/css"></link>
    -->
        <link rel="stylesheet" href="${s3bucket}valve-configurator/style/seriesJSY/sel_series_jsy.css" type="text/css"></link>
	</@hst.headContribution>
</div>