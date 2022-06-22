<#include "../include/imports.ftl">

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#assign currentLocale=hstRequest.requestContext.resolvedMount.mount.locale>
<@hst.link var="logo" path="binaries/content/gallery/smc_global/logos/logo.svg"/>
<@hst.link var="mobile" path="binaries/content/gallery/smc_global/logos/footer-logo-mobile.png"/>

<#if menu??>
    <div class="secondary-footer main-footer__bottom text-02" data-swiftype-index='false'>
    			<div class="footer-top">
    			<div class="corporate-footer">
    				<div>
        				<img class="d-none d-sm-none d-md-none d-lg-block d-xl-block" src="${logo}" alt="SMC" /> 
						<img class="d-xs-block d-sm-block d-md-block d-lg-none d-xl-none" src="${mobile}" alt="SMC" />
    				</div>
            		<#if menu.siteMenuItems??>
                		<div class="row-menu">
                        		<ul class="secondary-footer__links">
                            		<#list menu.siteMenuItems as item>
                                		<li><@osudio.linkHstFooterMenu link=item/>
                                			<#list item.childMenuItems as item2>
                                			<ul class="contact_items">
                                				<li><@osudio.linkHstFooterMenu link=item2/></li>
                                			</ul>
                                			</#list>
                                		</li>
                            		</#list>
                            		<div class="cmseditlink">
                                		<@hst.cmseditmenu menu=menu/>
                            		</div>
                        		</ul>
                		</div>
              </div>
            		</#if>
        		</div>
        		<hr>
    </div>
</#if>