<#include "../include/imports.ftl">

<#-- @ftlvariable name="menu" type="org.hippoecm.hst.core.sitemenu.HstSiteMenu" -->
<#-- @ftlvariable name="editMode" type="java.lang.Boolean"-->
<#assign currentLocale=hstRequest.requestContext.resolvedMount.mount.locale>
<#assign currentCountry = currentLocale?lower_case?substring(3) >
<#assign images = [] />
<#assign productsArray = [] />
<#assign countProds = 0 />
<#assign image = ""/>
<#assign explore = ""/>
<#assign search = ""/>
<#assign menuObj = ""/>
<@hst.link var="link" path="/binaries/content/gallery/smc_global/global-products/"/>
<@hst.link var="allProdsImg" path="/binaries/content/gallery/smc_global/headicons/menu-web-all-products.svg"/>
<@hst.link var="solutionsImg" path="binaries/content/gallery/smc_global/headicons/menu-web-solutions.svg"/>
<@hst.link var="tools" path="products/engineering-tools/"/>
<@hst.setBundle basename="essentials.global"/>
<#if menu??>
<!-- /* RACA-0 */-->
    <ul class="main-navigation-list d-xxl-flex d-xl-flex d-lg-flex d-none" id="main-navigation-list__view" data-swiftype-index='false'>
        <#if menu.siteMenuItems??>
            <#list menu.siteMenuItems as item>
                <li <#if item?index gte 4 && item.childMenuItems?size == 0 && item.parameters["isHighlighted"] == "false" >class="main-navigation-secondary"<#elseif item.parameters["isHighlighted"] == "false">class="main-navigation-secondary-grey"</#if>>
                <a class="parent-item" href="<@osudio.linkHstMenu item/>" <#if item.externalLink??><@osudio.openInNewTab item.externalLink/></#if>>${item.name?html}</a>
                <#if item.childMenuItems?size gt 0>
                    <div class="main-navigation__mega">
                        <div class="container">
                            <div class="main-navigation__mega__left">
                               <!--  <div class="main-navigation__mega__left__intro">
                                    <#if item.parameters??>
                                        <#if item.parameters["title"]??>
                                            <h2 class="heading-03">${item.parameters["title"]}</h2>
                                        </#if>
                                        <#if item.parameters["description"]??>
                                            <p>${item.parameters["description"]}</p>
                                        </#if>
                                    </#if>
                                </div>
                                <ul class="main-navigation__mega__left__links">
                                    <#assign normalMenuItems = [] />
                                    <#list item.childMenuItems as item2>
                                        <#if item2.parameters?? && item2.parameters["isBottomLeft"]?? && item2.parameters["isBottomLeft"] == "true" >
                                            <li><a href="<@osudio.linkHstMenu item2/>" <#if item2.externalLink??><@osudio.openInNewTab item2.externalLink/></#if>>${item2.name?html}</a></li>
                                        <#else>
                                            <#assign normalMenuItems += [item2] />
                                        </#if>
                                    </#list>
                                </ul>-->
                            </div>
                            <#-- Start Products -->
                            <#if item.parameters["title"] == "Our products" || item.name == "Products" || item.parameters["description"]?lower_case == "products-menu">
                            <@hst.link var="newProductLink" path="${item.name?lower_case}/new?&select_2883959="/>
                            <div class="first-block">
                                <div class="head-titles">
                                		<img width="100px" src="${allProdsImg}">
                            			<span>${item.parameters["title"]}</span>
                            		</div>
                            <div class="first-list">
                            <ul class="main-navigation__mega__level2 scrollable">
                            <!-- Now we iterate over the normal items -->
                                <#list normalMenuItems as normalMenuItem>
                                        <#if normalMenuItem.parameters?? && normalMenuItem.parameters["isHighlighted"]?? && normalMenuItem.parameters["isHighlighted"] == "true">
                                            <li class="u-bold">
                                        <#elseif normalMenuItem.name?lower_case == "explore" >
                                        		<#assign explore =  normalMenuItem/>
                                        		<li class="" style="display: none;">
                                        		<#elseif normalMenuItem.name?lower_case == "search" >
                                        		<#assign search =  normalMenuItem/>
                                        		<li class="" style="display: none;">
                                        <#else>
                                            <li class="">
                                        </#if>
                                        <#if normalMenuItem.hstLink??>
                                            <#assign href><@hst.link link=normalMenuItem.hstLink/></#assign>
                                        <#elseif normalMenuItem.externalLink??>
                                            <#assign href>${normalMenuItem.externalLink?replace("\"", "")}</#assign>
                                        </#if>
                                        <a class="parent-item" id="parent" data-parent="${normalMenuItem.name}" href="<@osudio.linkHstMenu normalMenuItem/>" <#if normalMenuItem.externalLink??><@osudio.openInNewTab normalMenuItem.externalLink/></#if>>${normalMenuItem.name?html}</a>
                                        <#-- Our products -->
                                        <#if normalMenuItem.childMenuItems?size gt 0 >
                                            <ul class="main-navigation__mega__level3">
                                                <h5 class="products-headers">
                                                		<strong>
                                                			<a href="<@osudio.linkHstMenu normalMenuItem/>"
                                                				<#if normalMenuItem.externalLink??>
                                                					<@osudio.openInNewTab normalMenuItem.externalLink/>
                                                				</#if>
                                                				>${normalMenuItem.name?html}
                                                			</a>
                                                		</strong>
                                                	</h5>
                                                <!-- We need to filter which ones are top right items and which ones are normal items -->
                                                <#assign topRightItems = [] />
                                                    <#list normalMenuItem.childMenuItems as item3>
                                                        <#if item3.parameters?? && item3.parameters["isTopRight"]?? && item3.parameters["isTopRight"] == "true" >
                                                            <#assign topRightItems += [item3] />
                                                        <#else>
                                                            <#if item3.parameters["description"]??>
                                                            	<#assign image = item3.parameters["description"]/>
                                                            		<#assign images += [image]/>
                                                            		<#assign productsArray += [item3]>
                                                            </#if>
                                                            <#assign countProds = countProds + 1 />
                                                            <li><a class="links-level3" id="child" data-child="${normalMenuItem.name}" data-index="${countProds}" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                        </#if>
                                                    </#list>
                                            </ul>
                                            <#if topRightItems?size gt 0>
                                                  <!--RACA-2 Menu derecha Products se adapta al numero de items de la zona azul -->
                                                <ul class="main-navigation__mega__level31 rightPanelImage">
                                                	   <#if normalMenuItem.parameters["subtitle"]??>
                                                        <li class="d-none d-lg-block"><strong>${normalMenuItem.parameters["subtitle"]}</strong></li>
                                                    </#if>
                                                    <#list topRightItems as topRightItem>
                                                    		<#if topRightItem.name?lower_case == "image">
                                                        		<li><a id="child2" href="<@osudio.linkHstMenu topRightItem/>" <#if topRightItem.externalLink??><@osudio.openInNewTab topRightItem.externalLink/></#if>>${topRightItem.parameters["subtitle"]}</a></li>
                                                    			<img id="" width="100px" src="${link}/${topRightItem.parameters["description"]?lower_case}">
                                                    		</#if>
                                                    </#list>
                                                </ul>
                                            </#if>
                                        	</#if>
                                    		</li>
                                </#list>
                            </ul>
                            </div>
                            </div>
                            <#-- fin de UL´s -->
                            <div class="explore-container">
                            <ul class="image-set">
                            <#--  --list productsArray as prod-->
                            <#list productsArray as prod>
                            <li class="image-display-active">
	                       	<div class="img-level2">
	                       		<img id="product-image" width="200px" src="${link}/${prod.parameters["description"]?lower_case}">
           					</div>
           					</li>
           					</#list>
				             <#--  --/#list-->
				             </ul>
                       		</div>
                       		<div class="explore-more">
		                       		<p><b>${explore.parameters["title"]}</b></p>
		                            	<hr class="hr-horizontal"/>
		                            	<#-- RACA-0 -->
                               <div class="explore-more-content">
		                            	<ul>
		                            	<#list explore.childMenuItems as exp>
		                            	<#if exp.name != "button">
		                            		<#--<li><a id="newProds" <#if exp?index == 0>class="newProducts"</#if> href="<@osudio.linkHstMenu exp/>" <#if exp.externalLink??><@osudio.openInNewTab exp.externalLink/></#if>>&nbsp ${exp.name}</a></li>-->
                                            <li><a class="expmore${exp?index}" href="<@osudio.linkHstMenu exp/>" data-link="<@osudio.linkHstMenu exp/>" <#if exp.externalLink??><@osudio.openInNewTab exp.externalLink/></#if>>&nbsp ${exp.name}</a></li>
                             		<#else>
                             			<#assign button = exp>
                             		</#if>
                             		</#list>
                             		</ul>
		                            <a  class="btn shadow-border-none  btn-primary" href="${tools}">${button.parameters["title"]}</a>
		                       </div>
                             </div>
                            <#-- Fin Our products -->
                            <#-- Our solutions -->
                            <#elseif item.parameters["title"] == "Our solutions" || item.name == "Solutions" || item.parameters["description"]?lower_case == "solutions-menu">
                        	    <div class="first-block">
                            	<div class="head-titles">
                                	<img width="100px" src="${solutionsImg}">
                            		<span>${item.parameters["title"]}</span>
                            </div>
                            <div class="first-list">
                            <ul class="main-navigation__mega__level2 solutions-list">
                            <!-- Now we iterate over the normal items -->
                                <#list normalMenuItems as normalMenuItem>
                                        <#if normalMenuItem.parameters?? && normalMenuItem.parameters["isHighlighted"]?? && normalMenuItem.parameters["isHighlighted"] == "true">
                                            <li class="u-bold">
                                        <#elseif normalMenuItem.name?lower_case == "image">
                                        		<li style="display: none;">
                                        <#else>
                                            <li class="">
                                        </#if>
                                        <#if normalMenuItem.hstLink??>
                                            <#assign href><@hst.link link=normalMenuItem.hstLink/></#assign>
                                        <#elseif normalMenuItem.externalLink??>
                                            <#assign href>${normalMenuItem.externalLink?replace("\"", "")}</#assign>
                                        </#if>
                                        <#if normalMenuItem.name?lower_case == "image">
                                            <#assign solutionsText =  normalMenuItem.parameters["title"]/>
                                            <#assign solutionsSub =  normalMenuItem.parameters["subtitle"]/>
                                            <#assign solutionsImage =  normalMenuItem.parameters["description"]?lower_case/>
                                        </#if>
                                        <a class="parent-item" href="<@osudio.linkHstMenu normalMenuItem/>" <#if normalMenuItem.externalLink??><@osudio.openInNewTab normalMenuItem.externalLink/></#if>>${normalMenuItem.name?html}</a>
                                        <#if normalMenuItem.childMenuItems?size gt 0 >
                                        <div class="solutions-container">
                                        	<div class="solutions">
                                            <ul class="main-navigation__mega__level3-solutions">
                                                <!-- We need to filter which ones are top right items and which ones are normal items -->
                                                <div class="solutionsTopContainer">  <!--RACA-2 GR050-49  More Details  pantalla solutions anadir scroll en industry sectiors -->
                                                <div class="solutionsTopBlock">  <!--RACA-2 GR050-49  More Details  pantalla solutions anadir scroll en industry sectiors -->
                                                <#assign topRightItems = [] />
                                                <#assign bottomItems = [] />
                                                    <#list normalMenuItem.childMenuItems as item3>
                                                        <#if item3.parameters?? && item3.parameters["isTopRight"]?? && item3.parameters["isTopRight"] == "true" >
                                                            <#assign topRightItems += [item3] />
                                                            <#list item3.childMenuItems as item4>
                                                            		<#assign bottomItems += [item4] />
                                                            </#list>
                                                        <#else>
                                                            <#list item3.childMenuItems as item4>
                                                            		<#assign bottomItems += [item4] />
                                                            </#list>
                                                            <li><a class="links-level3" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                        </#if>
                                                    </#list>
                                                </div>
                                                </div>

                                          <div class="details">
                                          	<h6><strong>More Details</strong></h6>
                                          </div>
                                          <div class="details-separator">
				                            	<hr class="hr-horizontal"/>
                                          </div>
                                            </ul>
                                          </div>
                                      	</div>
                                            <#if bottomItems??>
                                            <div class="details-content">
                                                <ul class="main-navigation__mega__level31-solutions">
                                                <div class="solutionsBottomContainer">  <!--RACA-2 GR050-49  More Details  pantalla solutions anadir scroll en industry sectiors -->
                                                <div class="solutionsBottomBlock">  <!--RACA-2 GR050-49  More Details  pantalla solutions anadir scroll en industry sectiors -->
                                                    <#list bottomItems as topRightItem>
                                                        <li><a href="<@osudio.linkHstMenu topRightItem/>" <#if topRightItem.externalLink??><@osudio.openInNewTab topRightItem.externalLink/></#if>>${topRightItem.name?html}</a></li>
                                                    </#list>
                                                </div>
                                                </div>
                                                </ul>
                                            </div>
                                            </#if>
                                            </#if>
                                    		</li>
                                </#list>
                            </ul>
                    			<div class="solutions-configurable">
                    				<p><strong>${solutionsText}</strong></p>
                    				<h6>${solutionsSub}</h6>
                    				<img id="" width="100px" src="${link}/${solutionsImage}">
                    			</div>
                            </div>
                            </div>
                            <#-- Fin Our solutions -->
                            <#-- Support -->
                            <#elseif item.parameters["title"] == "Support" || item.name == "Support" || item.parameters["description"]?lower_case == "support-menu">
                            <ul class="main-navigation__mega__level2-support">
                            <!-- Now we iterate over the normal items -->
                                <#list normalMenuItems as normalMenuItem>
                                		<div class="support-container">
                                			<div class="support-item">
                                			  <#-- <a class="parent-item" href="<@osudio.linkHstMenu normalMenuItem/>" <#if normalMenuItem.externalLink??><@osudio.openInNewTab normalMenuItem.externalLink/></#if>>${normalMenuItem.name?html}</a>-->
                                               <p class="parent-item" href="<@osudio.linkHstMenu normalMenuItem/>" <#if normalMenuItem.externalLink??><@osudio.openInNewTab normalMenuItem.externalLink/></#if>>${normalMenuItem.name?html}</p>
                                			   	<#if normalMenuItem?index == 0>
                                			   		<#if normalMenuItem.childMenuItems?size gt 0>
                                			   		<div class="help">
                                			   		    <ul class="main-navigation__mega__level3-support">

                                            <#--  RACA GR050-80 Elementos en hippo sin enlace - en el menu salen clickables -->
                                			   			<#list normalMenuItem.childMenuItems as item3>
                                                            <#if item3.hstLink??>
                                                                <li><a class="item3-support" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                            <#elseif item3.externalLink??>
                                                                <li><a class="item3-support" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                            <#else>
                                                                <li><p class="item3-support">${item3.name?html}</p></li>
                                                            </#if>
                                                                <#if item3.childMenuItems?size gt 0>
                                                                    <#list item3.childMenuItems as item4>
                                                                        <li><a class="item4-support" href="<@osudio.linkHstMenu link=item4/>"<#if item4.externalLink??><@osudio.openInNewTab item4.externalLink/></#if>>${item4.name?html}</a></li>
                                                                    </#list>
                                                                <br>
                                                            </#if>
                                                        </#list>
                                			   			</ul>
                                			   			<hr class="hr-vertical-support">
                                			   		</div>
                                			   		</#if>
                                			   		<#--  --div class="right-content" >
	                            	    					<hr class="hr-vertical-solutions"/>
	                            					</div-->
	                            				<#elseif normalMenuItem?index == 1>
	                            					<#if normalMenuItem.childMenuItems?size gt 0>
	                            					<div class="manuals">
                                			   		    <ul class="main-navigation__mega__level3-support">
                                			   			<#list normalMenuItem.childMenuItems as item3>
                                			   				<li><i class="fa fa-download"></i> <a class="item3-support" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                			   			</#list>
                                			   			</ul>
                                			   			<hr class="hr-vertical-support">
                                			   		</div>
                                			   		</#if>
                                			   		<#--  --div class="right-content">
	                            	    					<hr class="hr-vertical-solutions"/>
	                            					</div-->
	                            			   	<#elseif normalMenuItem?index == 2>
                                                    <#if normalMenuItem.childMenuItems?size gt 0>
                                                        <ul class="main-navigation__mega__level3-support">
                                                        <#list normalMenuItem.childMenuItems as item3>
                                                            <#if item3.name != "button-support">
                                                            <li><a class="item3-support" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                            <#else>
                                                            <#assign buttonsupp = item3>
                                                            </#if>
                                                        </#list>
                                                        </ul>
                                                           <div class="engineering-tools__button">
                                                           <#if buttonsupp??>
                                                        <a  class="btn shadow-border-none  btn-primary" href="<@osudio.linkHstMenu link=buttonsupp/>">${buttonsupp.parameters["title"]}</a>
                                                        </#if>
                                                    </div>
                                                    </#if>
                                                </#if>
                                            </div>
                                        </div>
                                            </li>
                                </#list>
                            		</ul>
                            <#else>
                            <#-- Custom -->
                           <ul class="main-navigation__mega__level2 custom-list no-right">
                            	<div class="custom-head-title">
                            		<span>${item.parameters["title"]}</span>
                            </div>
                            <!-- Now we iterate over the normal items -->
                            <#assign highlights = []/>
                                <#list normalMenuItems as normalMenuItem>
                                        <#if normalMenuItem.parameters?? && normalMenuItem.parameters["isHighlighted"]?? && normalMenuItem.parameters["isHighlighted"] == "true">
                                            <li class="u-bold">
                                        <#else>
                                            <li class="">
                                        </#if>
                                        <#if normalMenuItem.hstLink??>
                                            <#assign href><@hst.link link=normalMenuItem.hstLink/></#assign>
                                        <#elseif normalMenuItem.externalLink??>
                                            <#assign href>${normalMenuItem.externalLink?replace("\"", "")}</#assign>
                                        </#if>
                                        <#if normalMenuItem.parameters?? && normalMenuItem.parameters["isHighlighted"]?? && normalMenuItem.parameters["isHighlighted"] == "true">
                            					<#assign highlights += [normalMenuItem]>
                                        </#if>
                                        <a class="parent-item" href="<@osudio.linkHstMenu normalMenuItem/>" <#if normalMenuItem.externalLink??><@osudio.openInNewTab normalMenuItem.externalLink/></#if>>${normalMenuItem.name?html}</a>
                                        <#if normalMenuItem.childMenuItems?size gt 0 >
                                        <div class="custom-container">
                                        	<div class="custom-block1">
                                            <ul class="main-navigation__mega__level3-custom" >
                                                <!-- We need to filter the highlighted customs -->
                                                <div class="custom-title-container">
                            						   <h5 class="custom-title1">${normalMenuItem.parameters["title"]}</h5>
                            					   </div>
                                                    <#list normalMenuItem.childMenuItems as item3>
                                                        <li><a class="links-level3" href="<@osudio.linkHstMenu link=item3/>"<#if item3.externalLink??><@osudio.openInNewTab item3.externalLink/></#if>>${item3.name?html}</a></li>
                                                    </#list>
                                            </ul>
                                          </div>
                                      	</div>
                                        	</#if>
                                    		</li>
                                </#list>
                            </ul>
                            <div class="custom-separator">
	                            	<hr class="hr-vertical-custom1"/>
	                        </div>
                            <#if highlights??>
                            <div class="custom-separator">
	                            	<hr class="hr-vertical-custom2"/>
	                        </div>
                            <div class="custom-right">
	                        		<div class="head-titles">
    		                    			<span>Highlight ${item.parameters["title"]}</span>
                            		</div>
                            		<div class="details-content">
                                		<ul class="main-navigation__mega__level31-custom">
                                    		<#list highlights as highlight>
                                        		<li><a href="<@osudio.linkHstMenu highlight/>" <#if highlight.externalLink??><@osudio.openInNewTab highlight.externalLink/></#if>>${highlight.name?html}</a></li>
                                    		</#list>
                                		</ul>
                            		</div>
                            </div>
                            </#if>
                            <#-- Fin Custom -->
                            </#if>





                            <#--  --if item.name == "Products">
                       		<div class="explore-container">
	                       		<div class="img-level2">
	                       		<@hst.link var="link" path="/binaries/content/gallery/smc_global/products/"/>
	                       			<img id="product-image" width="200px" src="${link}/${productsArray[0].parameters["description"]?lower_case}">
           						</div>

	                       		<div class="explore-more">
		                       		<p><b>Explore more</b></p>
		                            	<hr class="hr-horizontal"/>
		                            	<ul>
		                            		<li>News Products</li>
		                            		<li>Highlights Products</li>
		                            		<li>Standard Stocked Items</li>
		                            </ul>
		                            <button>Engineering tools</button>
	                            </div>

                       		</div>
                       		</#if-->

                       		<#if item.name == "Products" || item.parameters["description"]?lower_case == "products-menu">
                       		<@hst.link var="functionality" path="/functionality-nav?nodes=W3sibm9kZUlkIjoiNDI0OTIwIiwibmFtZSI6IkdlbmVyYWwgZnVuY3Rpb25hbGl0aWVzIiwic2VsZWN0ZWRJZCI6IjQyNTA2NCIsInNlbGVjdGVkTmFtZSI6Ik1vdmVtZW50LCBncmlwcGluZyAmIGNsYW1waW5nIn1d';"/>
                       		<#if search.childMenuItems?size gt 0>
                       		<div class="search-buttons pb-4">
                       			<p>${search.parameters["title"]}</p>
                       			<#list search.childMenuItems as item>
                       				<a class="btn shadow-border-none col-md-10  invert mb-4" href="<@osudio.linkHstMenu item/>" <#if item.externalLink??><@osudio.openInNewTab item.externalLink/></#if>>${item.name?html}</a>
                       			</#list>
                       		</div>

                       		</#if>
                       		<hr class="hr-vertical"/>
                       		<#elseif item.name == "Solutions" || item.parameters["description"]?lower_case == "solutions-menu">
	                        		<div class="right-content">
	                            	    	<hr class="hr-vertical-solutions"/>
	                            	</div>
                       		</#if>

                            <!-- <a href="javascript:void(0);" class="close-menu-btn close-menu-btn-js"></a> -->
                        </div>
                    </div>
                </#if>
            </#list>
        </#if>
    </li>
        <div class="cmseditlink">
            <@hst.cmseditmenu menu=menu/>
        </div>
    </ul>
</#if>
<script>

/* Select the level 2 item to set the url*/
$( document ).ready(function() {
    var url;
    var parentUrl;
    var newProds;
    var count = $('.explore-more-content li').length;
    parentUrl = $('.main-navigation__mega__level2 li a#parent:first-child').data('parent');
    for (var i=0; i<count; i++) {
        url = $('.expmore'+i).attr('data-link');
        if(url.indexOf("&")!="-1"){
            newProds = url + parentUrl;
        }else{
            newProds = url;
        }
        $('.expmore'+i).attr('href', newProds);
    }

	/*var url = '${newProductLink}';
    var parentUrl;
	var newProds;
    parentUrl = $('.main-navigation__mega__level2 li a#parent:first-child').data('parent');
    newProds = url + parentUrl;
    $('.newProducts').attr('href', newProds);*/ //1406

	/*$('.main-navigation__mega__level2 li a#parent').hover(function() {
		console.log($(this));
		parentUrl = $(this).data('parent');
		console.log(parentUrl);
		console.log(url);
		newProds = url + parentUrl;
		console.log(newProds);
		$('.newProducts').attr('href', newProds);
	});*/ //RACA-2
    
    /*RACA-2 Menu derecha Products se adapta al numero de items de la zona azul*/    
     setPositionMainNavigationLevel31()
});

/*RACA-2 Menu derecha Products se adapta al numero de items de la zona azul*/
function setPositionMainNavigationLevel31(){
    let divSearchButtons = document.querySelector('.search-buttons').children
    let marginLeft
    let marginTop
    let arrChildsDivSearchButtons = Array.from(divSearchButtons)
        arrChildsDivSearchButtons.forEach(function(v, i, a) {
            if(divSearchButtons.length <= 4){
                 marginTop =  '10%'
            }
            else if(divSearchButtons.length > 6){
                marginLeft =  '26%'
                marginTop =  '-16%'
            }
            else{
                marginTop =  '1'+i+'%'
            }
        });
        $('.rightPanelImage').css('marginLeft' , marginLeft)
        $('.rightPanelImage').css('marginTop' , marginTop)
}
     


</script>


