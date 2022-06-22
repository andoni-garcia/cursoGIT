<#include "../include/imports.ftl">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" type="text/css"/>
<@hst.setBundle basename="essentials.global"/>

<@hst.link var="link" path="/binaries/content/gallery/smc_global/global-products/"/>
<#assign topRightItems = [] />
<#assign bottomItems = [] />

<#if menu??>
<div id="wpHiddenUrl" class="d-none">
    ${workplaceTestUrl}
</div>
 <nav class="bg-white mt-3x d-xl-none" role="navigation">
  <div class="container">
    <div class="navbar-header">
        <span class="fade-icon main-header__nav-trigger navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
		<span class="fade-icon__icon icon-hamburger"></span>
		<span class="fade-icon__icon icon-close"></span>
	</span>
    </div>
    <div class="collapse navbar-collapse" id="navbar-collapse">
      <ul class="nav navbar-nav p-3">
        <#if menu.siteMenuItems??>
        <ul id="list">
     		<#list menu.siteMenuItems as item>
     		    <#if item.parameters?? && item.parameters["isHighlighted"]?? && item.parameters["isHighlighted"] == "true">
					<li style="font-weight: bolder;" data-level="0">${item.name}
				<#else>
					<li data-level="0">${item.name}
				</#if>
					<#if item.parameters["title"] == "Our products" || item.name == "Products" || item.parameters["description"]?lower_case == "products-menu">
	                		<#if item.childMenuItems??>
								<ul>
									<li class="levels"><a href="#" class="firstLevel" ><h3><i class="fa-solid fa-angle-left"></i> ${item.name} </h3></a></li>
									<#list item.childMenuItems as prodFam>
										<#if prodFam.parameters?? && prodFam.parameters["isHighlighted"]?? && prodFam.parameters["isHighlighted"] == "true">
											<li class="u-bold levels" data-level="1">${prodFam.name}
										<#elseif prodFam.name?lower_case == "explore" >
												<#assign explore =  prodFam/>
												<#elseif prodFam.name?lower_case == "search" >
												<#assign search =  prodFam/>
												<#elseif prodFam.name?lower_case == "image" > <#-- RACA-0 -->
												<#assign image =  prodFam/> <#-- RACA-0 -->
										<#else>

												<li class="levels" data-level="1">${prodFam.name} <i class="fa-solid fa-angle-right"></i>
										</#if>
										<#if item.childMenuItems??>
											<ul>
											<li class="levels"><a href="#" class="secondLevel" >  <h3><i class="fa-solid fa-angle-left"></i> ${prodFam.name} </h3></a></li>
												<#list prodFam.childMenuItems as prod>
														<#if prodFam.parameters?? && prod.parameters["isHighlighted"]?? && prod.parameters["isHighlighted"] == "true">
														<li class="u-bold levels" data-level="2"><a href="<@osudio.linkHstMenu link=prod/>"<#if prod.externalLink??><@osudio.openInNewTab prod.externalLink/></#if>>${prod.name?html}</a></li>
													<#elseif prod.name?lower_case == "image" >
															<#assign image =  prod/>
													<#else>
															<li class="levels" data-level="2"><a href="<@osudio.linkHstMenu link=prod/>"<#if prod.externalLink??><@osudio.openInNewTab prod.externalLink/></#if>>${prod.name?html}</a></li>
													</#if>
												</#list>
											</ul>
										</#if>
										</li>
									</#list>
								</ul>
								<div id="fixed-block">
									<div class="explore-more">
										<p><b>${explore.parameters["title"]}</b></p>
											<hr class="hr-horizontal__mobile"/>
											<ul>
											<#list explore.childMenuItems as exp>
											<#if exp.name != "button">
												<li> <i class="fa-solid fa-angle-right"></i><a id="newProds" href="<@osudio.linkHstMenu exp/>" <#if exp.externalLink??><@osudio.openInNewTab exp.externalLink/></#if>>&nbsp ${exp.name}</a></li>
										<#else>
											<#assign button = exp>
										</#if>
										</#list>
										</ul>
										<a  class="btn shadow-border-none  btn-primary" href="${tools}">${button.parameters["title"]}</a>
									</div>
									<@hst.link let="functionality" path="/functionality-nav?nodes=W3sibm9kZUlkIjoiNDI0OTIwIiwibmFtZSI6IkdlbmVyYWwgZnVuY3Rpb25hbGl0aWVzIiwic2VsZWN0ZWRJZCI6IjQyNTA2NCIsInNlbGVjdGVkTmFtZSI6Ik1vdmVtZW50LCBncmlwcGluZyAmIGNsYW1waW5nIn1d';"/>
									<#if search??>
									<div class="search-buttons pb-4">
										<p>${search.parameters["title"]}</p>
										<#list search.childMenuItems as item>
											<a class="btn shadow-border-none col-md-10  invert mb-2" href="<@osudio.linkHstMenu item/>" <#if item.externalLink??><@osudio.openInNewTab item.externalLink/></#if>>${item.name?html}</a>
										</#list>
									</div>

									</#if>
									<#assign productsText =  image.parameters["title"]/> <#-- RACA-0 -->
									<#assign productsSub =  image.parameters["subtitle"]/> <#-- RACA-0 -->
									<#assign productsImage =  image.parameters["description"]?lower_case/> <#-- RACA-0 -->
									<div class="products-configurable"> <#-- RACA-0 -->
                    					<p><strong>${productsText}</strong></p> <#-- RACA-0 -->
                    					<h6>${productsSub}</h6> <#-- RACA-0 -->
                    					<img id="" width="100px" src="${link}/${productsImage}"> <#-- RACA-0 -->
									</div> <#-- RACA-0 -->
									
									
								</div>
	                		</#if>
					<#elseif item.parameters["title"] == "Our solutions" || item.name == "Solutions" || item.parameters["description"]?lower_case == "solutions-menu">
						<#if item.childMenuItems??>
							<ul>
								<li class="levels"><a href="#" class="firstLevel"><h3><i class="fa-solid fa-angle-left"></i> ${item.name}</h3></a></li>
								<#list item.childMenuItems as solFam>
									<#if solFam.parameters?? && solFam.parameters["isHighlighted"]?? && solFam.parameters["isHighlighted"] == "true">
									<#elseif solFam.name?lower_case != "image">
											<li class="levels" data-level="1">${solFam.name} <i class="fa-solid fa-angle-right"></i>
									</#if>
									<#if solFam.name?lower_case == "image">
										<#assign solutionsText =  solFam.parameters["title"]/>
										<#assign solutionsSub =  solFam.parameters["subtitle"]/>
										<#assign solutionsImage =  solFam.parameters["description"]?lower_case/>
									</#if>
									<#if solFam.childMenuItems??>
										<ul>
										<li class="levels"><a href="#" class="secondLevel" ><h3><i class="fa-solid fa-angle-left"></i> ${solFam.name} </h3></a></li>
										<#list solFam.childMenuItems as sol>
											<#if sol.parameters?? && sol.parameters["isTopRight"]?? && sol.parameters["isTopRight"] == "true" >
												<li class="u-bold levels" data-level="2"><a href="<@osudio.linkHstMenu link=sol/>"<#if sol.externalLink??><@osudio.openInNewTab sol.externalLink/></#if>>${sol.name?html}</a></li>
											<#else>
												<li class="levels" data-level="2"><a href="<@osudio.linkHstMenu link=sol/>"<#if sol.externalLink??><@osudio.openInNewTab sol.externalLink/></#if>>${sol.name?html}</a></li>
											</#if>
											<#list sol.childMenuItems as item4>
												<#assign bottomItems += [item4] />
											</#list>
										</#list>
										</ul>
									</#if>
									</li>
								</#list>
							</ul>
							<div id="hamburguer_details">
								<h6><strong>More Details</strong></h6>
								<div class="hamburguer_details-separator">
									<hr class="hr-horizontal__mobile"/>
								</div>
								<#if bottomItems??>
									<div class="explore-more">
										<ul class="">
											<#list bottomItems as topRightItem>
												<li><a href="<@osudio.linkHstMenu topRightItem/>" <#if topRightItem.externalLink??><@osudio.openInNewTab topRightItem.externalLink/></#if>>${topRightItem.name?html}</a></li>
											</#list>
										</ul>
									</div>
								</#if>
								<div class="solutions-configurable">
                    				<p><strong>${solutionsText}</strong></p>
                    				<h6>${solutionsSub}</h6>
                    				<img id="" width="100px" src="${link}/${solutionsImage}">
                    			</div>
							</div>
						</#if>
					<#elseif item.parameters["title"] == "Support" || item.name == "Support" || item.parameters["description"]?lower_case == "support-menu">
						<#if item.childMenuItems??>
						<ul>
							<#list item.childMenuItems as supFam>
								<#if supFam?index == 0>
									<li class="levels"><a href="#" class="firstLevel"><h3 style="color: #4d4d4d"><i class="fa-solid fa-angle-left"></i> ${supFam.name}</h3></a>
									<#if supFam.childMenuItems??>
										<ul id="help-list">
										<#list supFam.childMenuItems as sup>
											<#if sup.parameters?? && sup.parameters["isHighlighted"]?? && sup.parameters["isHighlighted"] == "true">
												<li class="u-bold"><a class="" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>>${sup.name?html}</a>
											<#else>
												<li class=""><a class="" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>>${sup.name?html}</a>
											</#if>
											<#if sup.childMenuItems??>
												<ul>
												<#list sup.childMenuItems as sup2>
													<#if sup2.parameters?? && sup2.parameters["isHighlighted"]?? && sup2.parameters["isHighlighted"] == "true">
														<li class="u-bold"><a class="" data-level="1" href="<@osudio.linkHstMenu link=sup2/>"<#if sup2.externalLink??><@osudio.openInNewTab sup2.externalLink/></#if>>${sup2.name?html}</a></li>
													<#else>
														<li class=""><a class="text-blue" href="<@osudio.linkHstMenu link=sup2/>"<#if sup2.externalLink??><@osudio.openInNewTab sup2.externalLink/></#if>>${sup2.name?html}</a></li>
													</#if>
												</#list>
												</ul>
											</#if>
											</li>
										</#list>
										</ul>
									</#if>
									<br/>
									</li>
								<#elseif supFam?index == 1>
									<li class="levels" data-level="1"><h3 style="margin-left: 0em;">${supFam.name}</h3>
									<#if supFam.childMenuItems??>
										<ul id="manuals-list">
										<#list supFam.childMenuItems as sup>
											<#if sup.parameters?? && sup.parameters["isHighlighted"]?? && sup.parameters["isHighlighted"] == "true">
												<li class="u-bold">
<a class="" data-level="1" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>>${sup.name?html}</a></li>
											<#else>
												<li class=""><a class="" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>><i class="fa fa-download" aria-hidden="true"></i> ${sup.name?html}</a></li>
											</#if>
										</#list>
										</ul>
									</#if>
									<br/>
									</li>
								<#elseif supFam?index == 2>
									<li class="levels" data-level="1"><h3 style="margin-left: 0em;">${supFam.name}</h3>
									<#if supFam.childMenuItems??>
										<ul id="resources-list">
										<#list supFam.childMenuItems as sup>
											<#if sup.parameters?? && sup.parameters["isHighlighted"]?? && sup.parameters["isHighlighted"] == "true">
												<li class="u-bold"><a class="" data-level="1" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>>${sup.name?html}</a></li>
											<#else>
												<li class=""><a class="" href="<@osudio.linkHstMenu link=sup/>"<#if sup.externalLink??><@osudio.openInNewTab sup.externalLink/></#if>>${sup.name?html}</a></li>
											</#if>
										</#list>
										<div class="engineering-tools__button">
											<button>Engineering tools</button>
										</div>
										</ul>
									</#if>
									</li>
								</#if>
							</#list>
							</ul>
						</#if>
					<#else>
						<#if item.childMenuItems??>
							<#assign secondColumn = []>
							<#assign highLights = []>
							<ul>
							<li class="levels" ><a href="#" class="firstLevel"><h3><i class="fa-solid fa-angle-left"></i> ${item.name}</h3></a>
							<#list item.childMenuItems as cusFam>
									<#if cusFam.parameters?? && cusFam.parameters["isHighlighted"]?? && cusFam.parameters["isHighlighted"] == "true">
										<#assign highLights += [cusFam]>
									</#if>
									<li class="levels" ><a href="#" class="firstLevel">${cusFam.name}</a>
									<#if cusFam.childMenuItems??>
										<ul>
											<h6>${cusFam.parameters["title"]}</h6>
											<#list cusFam.childMenuItems as cus>
													<#if cus.parameters?? && cus.parameters["isHighlighted"]?? && cus.parameters["isHighlighted"] == "true">
														<#assign secondColumn += [cus]>
														<li class="u-bold"><a class="" href="<@osudio.linkHstMenu link=cus/>"<#if cus.externalLink??><@osudio.openInNewTab cus.externalLink/></#if>>${cus.name?html}</a>
													<#else>
														<#assign secondColumn += [cus]>
														<li class=""><a class="" href="<@osudio.linkHstMenu link=cus/>"<#if cus.externalLink??><@osudio.openInNewTab cus.externalLink/></#if>>${cus.name?html}</a>
													</#if>
												</li>
											</#list>
										</ul>
									</#if>
									</li>
							</#list>
							</ul>
							<div id="custom_third-column">
								<ul>
									<#list highLights as cus>
										<li class=""><a class="" href="<@osudio.linkHstMenu link=cus/>"<#if cus.externalLink??><@osudio.openInNewTab cus.externalLink/></#if>>${cus.name?html}</a>
									</#list>
								</ul>
							</div>
						</#if>
					</#if>
					</li>
			</#list>
     		</ul>
     	</#if>
      </ul>
    </div>
  </div>
</nav>
</#if>


<script>

var initialList;
var sublist;
var element;
var fixedBlock = $("#fixed-block");
var hamburguerDetails = $("#hamburguer_details");
var customThirdColumn = $("#custom_third-column");

    $(".levels").hide();
    hideAll();
    $('[data-level="0"]').show();

    function reloadMenu(level, e) {
        let nodeName = $(e.target).closest('li').text().split('\n')[0];
        if($(e.target).children("ul").children('.levels').is(":hidden")) {
            element = $(e.target).children("ul").children('.levels');
            $(e.target).children("ul").children('.levels').show();
        }
        hideAll();
        if (nodeName.trim().includes('Products')) {
            $('#list').html(element).append($(fixedBlock).show());
        }
        else if (nodeName.trim().includes('Solutions')) {
            $('#list').html(element).append($(hamburguerDetails).show());
        }
        else if (nodeName.trim().includes('Custom')) {
            $('#list').html(element).append($(customThirdColumn).show());
        }
        else {
            $('#list').html(element);
			/*RACA-1*/
            if(sublist.text().split('\n')[0].split(' ')[1] === 'Products'){
                $('#list').append($(fixedBlock).show());
            }

            //$('#list').append($(fixedBlock).show());
            
        }
        if($('#list')=="") {
            $('#list').replaceWith(element);
        }
	}

    $(document).on('click', '[data-level="0"]', ((e) => {
		sublist = $(e.target).children("ul").children(".levels").clone().show();
		initialList = $(e.target).parent("ul").clone();
		reloadMenu(".firstLevel", e);
	}));

    $(document).on('click', '[data-level="1"]', ((e) => {
		reloadMenu(".secondLevel", e);
	}));

    $(document).on('click', '.firstLevel', ((e) => {
		reloadSubList('[data-level="0"]', initialList);
	}));

    $(document).on('click', '.secondLevel', ((e) => {
		let list;
		let nodeName = $(sublist).text().split('\n')[0];
		if (nodeName.trim().includes('Products')) {
            list = $('#list').html(sublist).append($(fixedBlock).show());
        }
        else if (nodeName.trim().includes('Solutions')) {
            list = $('#list').html(sublist).append($(hamburguerDetails).show());
        }
        else if (nodeName.trim().includes('Custom')) {
            list = $('#list').html(sublist).append($(customThirdColumn).show());
        }
		reloadSubList('[data-level="1"]', list);
	}));

    function hideAll() {
        $("#fixed-block").hide();
        $("#hamburguer_details").hide();
        $("#custom_third-column").hide();
	}

    function reloadSubList(level, list) {
        $('#list').replaceWith(list).clone();
        $(level).show();
	}

</script>
