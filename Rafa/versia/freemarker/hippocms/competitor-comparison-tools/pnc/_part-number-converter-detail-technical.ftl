<@hst.setBundle basename="partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems"/>
<#-- @ftlvariable name="compToolsReducedVersion" type="java.lang.Boolean" -->
<div class="row pt-0 mt-0  mb-0 pb-0">
    <div class="col-12 col-lg-12 text-right">
        <!-- ko if:smcPartTechnical.partNumber!=null || smcPartTechnical.partNumber!=""-->
        <button class="btn btn-secondary btn-secondary--blue-border btn-addfavorites add-to-favourites" data-toggle="tooltip" data-placement="bottom" title="" data-bind="attr: { 'data-partnumber':smcPartTechnical.partNumber},click:$root.refreshAddFavouriteButtons" data-original-title="Add to favourites">
            <i class="icon-star-full"></i>
        </button>
        <!-- /ko -->
    </div>
    <div class="col-6 col-lg-2">
        <figure class="text-center">
        <!-- ko if: smcPartTechnical.image!=null -->
            <img class="cct-img p-3" data-bind="attr:{src: smcPartTechnical.image,alt:smcPartTechnical!==null?smcPartTechnical.partNumber:''}">
        <!-- /ko -->
        <!-- ko if: smcPartTechnical.image==null -->
        <img class="cct-img p-3" src="<@hst.webfile path='/images/nodisp3_big.png'/>">
        <!-- /ko -->
        </figure>  
    </div>
    <div class="col-6 col-lg-3 text-center">
        <p class="font-weight-bold text-uppercase">
            <!-- ko if:smcPartTechnical.partNumber!=null -->
            <a data-bind="attr: { href: 'https://www.smc.eu/reference?quote=' + smcPartTechnical.partNumber },text:smcPartTechnical.partNumber==null ? 'N/A' : smcPartTechnical.partNumber" target="_blank"></a>
            <!-- /ko -->
            <!-- ko if:smcPartTechnical.partNumber==null -->
            <a>N/A</a>
            <!-- /ko -->
            <span class="ml-2 mr-2">|</span><span data-bind="text:smcPartTechnical.name==null ? 'N/A' : smcPartTechnical.name"></span>
        </p>
    </div>
    <div class="col-6 col-lg-3 text-center">
        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.series"/>:</span><span data-bind="text:smcPartTechnical.serie===null ? 'N/A' : smcPartTechnical.serie"></span></p>
    </div>
    <#if !compToolsReducedVersion>
	    <div class="col-6 col-lg-2 text-center">
	        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.listPrice"/>:</span><span data-bind="text:smcPartTechnical.price=== null ? 'N/A' : smcPartTechnical.price"></span><span data-bind="text:smcPartTechnical.price=== null ? '': ' ' + smcPartTechnical.currencyCode"></span></p>
	    </div>
	    <div class="col-12 col-lg-2 text-center">
	        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.deliveryTime"/>:</span><span data-bind="text:smcPartTechnical.deliveryTime=== null ? 'N/A' : smcPartTechnical.deliveryTime""></span></p>
	    </div>
    </#if>
</div>
<!-- Advantages -->
<div class="row pt-0 mt-0">
    <div class="col-12">
        <strong class="text-secondary"><@fmt.message key="partnumberconvert.advantages"/></strong>
        <div class="divider--primary mt-2 mb-2"></div>
    </div>
    <div class="col-12">
        <!-- Advantage -->
        <!-- ko if:smcPartTechnical.advantages!=null -->
        <!-- ko foreach:{data: smcPartTechnical.advantages} -->
        <div class="row pl-0 pr-0 ml-0 mr-0 mb-1">
            <div class="col-12">
                <strong data-bind="text:$data.title"></strong>
                <p class="mb-0" data-bind="text:$data.description"></p>
            </div>
            <div class="col-12">
                <p class="mb-1"><strong class="mr-1 text-success"><i class="fa fa-check-circle mr-1" aria-hidden="true"></i><@fmt.message key="partnumberconvert.benefit"/>:</strong><span data-bind="text:$data.benefit,attr: {class:$data.benefit=='' || $data.benefit==null? 'text-secondary':''}"></span></p>
            </div>
        </div>
        <!-- /ko -->
        <!-- /ko -->
        <!-- ko if:smcPartTechnical.advantages==null -->
         <div class="row pl-0 pr-0 ml-0 mr-0 mb-3">
            <div class="col-12">
                <p class="text-secondary">Not availables</p>
            </div>
        </div>
        <!-- /ko -->
        <!-- /Advantage -->
    </div>
</div>
<!-- /Advantages -->
<!-- Comments -->
<div class="row pb-0 mb-0">
    <div class="col-12">
        <strong class="text-secondary"><@fmt.message key="partnumberconvert.comments"/></strong>
        <div class="divider--primary mt-2 mb-2"></div>
    </div>
    <div class="col-12">
        <!-- Comment -->
        <div class="row pl-0 pr-0 ml-0 mr-0 mb-0 pb-0" data-bind="foreach: smcPartTechnical.comments" >
            <div class="col-12">
                <!-- ko if:$data!=null -->
                <p  data-bind="text:$data"></p>
                <!-- /ko -->
                <!-- ko if:$data==null -->
                <p class="text-secondary">Not availables</p>
                <!-- /ko -->
            </div>
        </div>
        <!-- /Comment -->
    </div>
</div>
<!-- /Comments -->