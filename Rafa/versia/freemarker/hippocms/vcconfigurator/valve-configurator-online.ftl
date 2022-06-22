<#include "../../include/imports.ftl">
<#-- Bundle para las traducciones necesarias -->
<@hst.setBundle basename="valveconfigurator"/>

<@hst.link var="refSelseriesSY" siteMapItemRefId="refSelseriesSY"/>	
<@hst.link var="refSelseriesSV" siteMapItemRefId="refSelseriesSV"/>		
<@hst.link var="refSelseriesNVQC" siteMapItemRefId="refSelseriesNVQC"/>
<@hst.link var="refSelseriesJSY" siteMapItemRefId="refSelseriesJSY"/>

<div class="container">	
	<div class="mb-30">
        <@osudio.dynamicBreadcrumb identifier="eshop" breadcrumb=breadcrumb />
    </div>
	<main class="smc-main-container valve-configurator">
        <div>
            <div class="cmseditlink">
            </div>
            <h2 class="heading-08 color-blue mt-20"><@fmt.message key="title.ValveConfiguratorOnline" /></h2>
        </div>
        <br>

		<div>
            <div class="row">
                <!-- Bloque SY -->
                <div class="col-md-4 col-sm-12">
                    <div class="category-tile-wrapper">
                        <div class="category-tile category-tile--noExpand">
                            <div class="category-tile__image p-3">
                                <a href="${refSelseriesSY}" class="js--LazyImageContainer image-shown">
                                    <img src="${s3bucket}valve-configurator/img/SY-general.jpg" alt="Series SY">
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <h2 class="heading-07 category-tile__title"><@fmt.message key="refSelseriesSY" /></h2>
                                <div class="category-tile__text__inner">
                                    <p><u><@fmt.message key="SYp1" /></u></p>
                                    <ul>
                                        <li style="text-align:left"><@fmt.message key="SYlist01" /></li>
                                        <li style="text-align:left"><@fmt.message key="SYlist02" /></li>
                                    </ul>
                                </div>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                        </div>
                        <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                    </div>
                </div>
                <!-- Bloque JSY -->
                <#if vcJsyEnabled>
                <div class="col-md-4 col-sm-12">
                    <div class="category-tile-wrapper">
                        <div class="category-tile category-tile--noExpand">
                            <div class="category-tile__image p-3">
                                <a href=${refSelseriesJSY} class="js--LazyImageContainer image-shown">
                                    <img src="${s3bucket}valve-configurator/img/JSY-general.jpg" alt="Series JSY">
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <h2 class="heading-07 category-tile__title"><@fmt.message key="refSelseriesJSY" /> </h2>
                                <div class="category-tile__text__inner">
                                    <p><u><@fmt.message key="JSYp1" /></u></p>
                                    <ul>
                                        <li style="text-align:left"><@fmt.message key="JSYlist01" /></li>
                                        <li style="text-align:left"><@fmt.message key="JSYlist02" /></li>
                                    </ul>
                                </div>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                        </div>
                        <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                    </div>
                </div>
                </#if>
                <!-- Bloque VQC -->
                <div class="col-md-4 col-sm-12">
                    <div class="category-tile-wrapper">
                        <div class="category-tile category-tile--noExpand">
                            <div class="category-tile__image p-3">
                                <a href="${refSelseriesNVQC}" class="js--LazyImageContainer image-shown">
                                    <img src="${s3bucket}valve-configurator/img/VQC-general.jpg" alt="Series SY">
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <h2 class="heading-07 category-tile__title"><@fmt.message key="refSelseriesNVQC"/></h2>
                                <div class="category-tile__text__inner">
                                    <ul>
                                        <li style="text-align:left"><@fmt.message key="NVQClist01" /></li>
                                        <li style="text-align:left"><@fmt.message key="NVQClist02" /></li>
                                    </ul>
                                </div>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                        </div>
                        <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                    </div>
                </div>
                <!-- Bloque SV -->
                <div class="col-md-4 col-sm-12">
                    <div class="category-tile-wrapper">
                        <div class="category-tile category-tile--noExpand">
                            <div class="category-tile__image p-3">
                                <a href=${refSelseriesSV} class="js--LazyImageContainer image-shown">
                                    <img src="${s3bucket}valve-configurator/img/SV-general.jpg" alt="Series SY">
                                    <span class="category-tile__image__mask"></span>
                                </a>
                            </div>
                            <div class="category-tile__text text-01">
                                <h2 class="heading-07 category-tile__title"><@fmt.message key="refSelseriesSV" /> </h2>
                                <div class="category-tile__text__inner">
                                    <ul>
                                        <li style="text-align:left"><@fmt.message key="SVlist01" /></li>
                                        <li style="text-align:left"><@fmt.message key="SVlist02" /></li>
                                    </ul>
                                </div>
                                <div class="category-tile__text__accordion-trigger"></div>
                            </div>
                        </div>
                        <span class="icon-close category-tile-mobile-close smc-close-button"></span>
                    </div>
                </div>
            </div>
        </div>
    
        
                
    </main>

</div>

	<@hst.headContribution  category="scripts">
	 	<link rel="stylesheet" href="${s3bucket}valve-configurator/style/sel_series.css"/>" type="text/css"></link>
	</@hst.headContribution>