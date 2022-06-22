<#-- @ftlvariable name="compToolsReducedVersion" type="java.lang.Boolean" -->
<div class="row pb-0">
    <div class="col-6 col-md-6 col-lg-2">
        <figure class="text-center">
            <!-- ko if: competitorPart.image!=null -->
            <img class="cct-img p-3" data-bind="attr:{src: competitorPart.image,alt:competitorPart.partNumber}">
            <!-- /ko -->
            <!-- ko if: competitorPart.image==null -->
            <img class="cct-img p-3" src="<@hst.webfile path='/images/nodisp3_big.png'/>">
            <!-- /ko -->
        </figure>  
    </div>
    <div class="col-6 col-md-6 col-lg-3  text-center">
        <p class="font-weight-bold text-uppercase"><span data-bind="text:competitorPart.partNumber==null ? 'N/A' : competitorPart.partNumber"></span><span class="ml-2 mr-2">|</span><span data-bind="text:competitorPart.name==null ? 'N/A' : competitorPart.name"></span></p>
    </div>
    <div class="col-6 col-md-4 col-lg-3  text-center">
        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.series"/>:</span><span data-bind="text:competitorPart.serie==null ? 'N/A' : competitorPart.serie"></span></p>
    </div>
    <#if !compToolsReducedVersion>
	    <div class="col-6 col-md-4 col-lg-2  text-center">
	        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.listPrice"/>:</span><span data-bind="text:competitorPart.price==null ? 'N/A' : competitorPart.price"></span><span data-bind="text:competitorPart.price==null ? '' : ' ' + competitorPart.currencyCode"></span></p>
	    </div>
	    <div class="col-12 col-md-4 col-lg-2  text-center">
	        <p><span class="mr-2 detail"><@fmt.message key="partnumberconvert.deliveryTime"/>:</span><span data-bind="text:competitorPart.deliveryTime==null ? 'N/A' : competitorPart.deliveryTime"></span></p>
	    </div>
    </#if>
</div>