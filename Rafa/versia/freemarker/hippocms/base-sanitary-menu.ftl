<#include "../include/imports.ftl">

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#assign corp = "© 2022 SMC Corporation" />

<#if menu??>
	<#if menu.siteMenuItems??>
        <div class="base-sanitary-menu-baseline">
        			<div class="corp-container">
        				<div class="corp">${corp}</div>
        			</div>
        	<div class="policies-container">	
        		<ul class="base-footer__links">
        			<hr>
            		<#list menu.siteMenuItems as item>
                		<li>
                			<@osudio.linkHstFooterMenu link=item/>
                    	</li>
                    	<hr>
               	</#list>
                	<div class="cmseditlink">
                		<@hst.cmseditmenu menu=menu/>	
               	</div>
            	</ul>
      	</div>
      	</div>
	</#if>
</#if>