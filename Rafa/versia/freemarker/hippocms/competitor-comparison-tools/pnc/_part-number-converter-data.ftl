<@hst.setBundle basename="partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems,eshop"/>
<!-- item partNumberConverter-->
<div class="row tbody-row">
  <div class="col-12 col-md-1 pr-0">        
    <div class="custom-control custom-checkbox text-left">
      <input type="checkbox" class="form-check-input" data-bind="attr: { id: 'check_'+$parent.removeSpecials(competitorPart.partNumber),'data-partnumber':competitorPart.partNumber},click:$parent.handleCheckboxItem">
    </div>
  </div>
  <div class="col-12 col-md-3 pl-lg-0 text-uppercase" data-bind="text:competitorPart.partNumber==null ? 'N/A' : competitorPart.partNumber"></div>
  <div class="col-12 col-md-3">
  <!-- ko if:smcPartTechnical!=null -->
    <a data-bind="attr: { href: 'https://www.smc.eu/reference?quote=' + smcPartTechnical.partNumber },text:smcPartTechnical.partNumber" target="_blank"></a>
  <!-- /ko -->
  <!-- ko if:smcPartTechnical==null || smcPartTechnical.partNumber == null || smcPartTechnical.partNumber ==""-->
  <a>N/A</a>
  <!-- /ko -->
  </div>
  <div class="col-12 col-md-3">
    <!-- ko if:smcPartSales!=null -->
    <a data-bind="attr: { href: 'https://www.smc.eu/reference?quote=' + smcPartSales.partNumber },text:smcPartSales.partNumber" target="_blank"></a>
    <!-- /ko -->
    <!-- ko if:smcPartSales==null || smcPartSales.partNumber == null || smcPartSales.partNumber == "" -->
    <a>N/A</a>
    <!-- /ko -->
  </div>
  <div class="col-12 col-md-2 text-right">
    <!-- ko if:smcPartSales!=null && smcPartSales.partNumber!= null || smcPartTechnical!=null && smcPartTechnical.partNumber!= null-->
      <span class="icon-plus-details" data-toggle="collapse" role="button" aria-expanded="false" data-bind="attr: { 'data-target': '#collapsedDetails_'+$parent.removeSpecials(competitorPart.partNumber),'aria-controls':'collapsedDetails_'+$parent.removeSpecials(competitorPart.partNumber)}">
        <i class="fa fa-plus"></i>
    </span>
    <!-- /ko -->
  </div>
  <!-- item partNumberConverter product details -->
  <div class="col-12 collapse cct-detail" data-bind="attr: { id: 'collapsedDetails_'+$parent.removeSpecials(competitorPart.partNumber)}">
    <!-- Item partNumberConverter detail -->
    <#include "./_part-number-converter-detail.ftl">
    <!-- /Item partNumberConverter detail -->
    <!-- Item partNumberConverter detail tabs-->
    <div class="row pt-0">
      <div class="col-12">
        <div class="smc-tabs desktop mt-3">
          <div class="smc-tabs__head">
            <ul class="nav w-100" id="pncTab" role="tablist">
              <!-- ko if:smcPartTechnical!=null -->
              <li data-bind="attr:{ class:smcPartTechnical!=null?'nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0 ':'nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0 '}">
                <a
                data-toggle="tab"
                data-bind="attr: { 'href': '#pnc_tech'+$index(),'aria-controls':'pnc_tech'+$index(),class:smcPartTechnical!=null?'active':'active'}" 
                role="tab"  
                aria-selected="true"><@fmt.message key="partnumberconvert.technical"/></a>
              </li>
              <!-- /ko -->
              <!-- ko if:smcPartSales!=null -->
              <li data-bind="attr:{ class:smcPartTechnical!=null?'nav-item heading-0a subHeading-0a mb-0':'nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0'}">
                <a
                data-toggle="tab"
                data-bind="attr: { 'href': '#pnc_sales'+$index(),'aria-controls':'pnc_sales'+$index(),class:smcPartTechnical!=null?'':'active'}"
                role="tab" 
                aria-selected="false"><@fmt.message key="partnumberconvert.sales"/></a>
              </li>
              <!-- /ko -->
              <!-- ko if:successStories!=null -->
              <li data-bind="attr:{ class:smcPartSales!=null || smcPartTechnical!=null?'nav-item heading-0a subHeading-0a mb-0':'nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0 '}">
                <a
                data-toggle="tab" 
                data-bind="attr: { 'href': '#pnc_successStories'+$index(),'aria-controls':'pnc_successStories'+$index(),class:smcPartTechnical!=null||smcPartSales!=null?'':'active'}"
                role="tab" 
                aria-selected="false"><@fmt.message key="partnumberconvert.successStories"/></a>
              </li>
              <!-- /ko -->
              <!-- ko if:documents!=null && documents.length>0  -->
              <li data-bind="attr:{ class:smcPartSales!=null || smcPartTechnical!=null || successStories!=null?'nav-item heading-0a subHeading-0a mb-0':'nav-item heading-0a subHeading-0a smc-tabs__head--active mb-0'}">
                <a
                data-toggle="tab" 
                data-bind="attr: {'href': '#pnc_documents'+$index(),'aria-controls':'pnc_documents'+$index(),class:smcPartTechnical!=null||smcPartSales!=null||successStories!=null?'':'active'}" 
                role="tab" 
                aria-selected="false"><@fmt.message key="partnumberconvert.documents"/></a>
              </li>
              <!-- /ko -->
            </ul>
          </div>
          <div class="tab-content" id="pncTabContent">
            <!-- Technical -->
            <!-- ko if:smcPartTechnical!=null -->
            <div class="tab-pane fade show active smc-tabs__body--active" 
            data-bind="attr: { 'id': 'pnc_tech'+$index()}"
            role="tabpanel" 
            aria-labelledby="pnc_tech-tab">
              <#include "./_part-number-converter-detail-technical.ftl">
            </div>
            <!-- /ko -->
            <!-- /Technical -->
            <!-- Sales -->
            <!-- ko if:smcPartSales!=null -->
            <div class="tab-pane fade" 
            data-bind="attr: { 'id': 'pnc_sales'+$index(),class: smcPartTechnical!=null ?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}"
            role="tabpanel" 
            aria-labelledby="pnc_sales-tab">
              <#include "./_partnumber-converter-detail-sales.ftl">
            </div>
            <!-- /ko -->
            <!-- /Sales -->
            <!-- Success stories -->
            <!-- ko if:successStories!=null -->
            <div class="tab-pane fade" 
            data-bind="attr: { 'id': 'pnc_successStories'+$index(),class: smcPartTechnical!=null|| smcPartSales!=null?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}" 
            role="tabpanel"
            aria-labelledby="pnc_successStories-tab">
              <#include "./_part-number-converter-detail-successstories.ftl">
            </div>
            <!-- /ko -->
            <!-- /Success stories -->
            <!-- Documents -->
            <!-- ko if: documents!=null && documents.length>0-->
            <div class="tab-pane fade" 
            data-bind="attr: { 'id': 'pnc_documents'+$index(),class: smcPartTechnical!=null|| smcPartSales!=null||successStories!=null?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}" 
            role="tabpanel" 
            aria-labelledby="pnc_documents-tab">
              <#include "./_part-number-converter-detail-documents.ftl">
            </div>
            <!-- /ko -->
            <!-- /Documents -->
          </div>
        </div>
      </div>
    </div>
    <!-- /Item partNumberConverter detail tabs-->
  </div>
  <!-- /item partNumberConverter product detail -->
</div>
<!-- /item partNumberConverter-->