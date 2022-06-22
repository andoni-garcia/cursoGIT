<@hst.setBundle basename="competitorTools,partNumberConverter,SearchPage,ParametricSearch,SearchBar,StandardStockedItems,comparisonMap"/>
<#-- @ftlvariable name="compToolsReducedVersion" type="java.lang.Boolean" -->
<#assign compToolsReducedVer = compToolsReducedVersion>
<!-- item comparison Map-->
<div class="row tbody-row">
  <div class="col-12 col-md-1 pr-0">        
    <div class="custom-control custom-checkbox text-left">
      <input type="checkbox" class="form-check-input d-none" data-bind="attr: {id:$data.idSerie==null ? 'check_' : 'check_'+$data.idSerie,'data-serie':$data.idSerie},click:$parent.handleCheckboxItem">
    </div>
  </div>
  <div class="col-12 col-md-3 pl-lg-0">
    <div class="row m-0 p-0">
        <div class="col-4 col-md-12 col-lg-4 pl-lg-0">
            <figure class="mb-1">
                <!-- ko if: $data.smcImage!=null -->
                <img class="cm-row-img cct-img cm-table-img--display" data-bind="attr:{src:$data.smcImage ,alt:$data.smcSerie}">
                <!-- /ko -->
                <!-- ko if: $data.smcImage==null -->
                <img class="cm-row-img cm-table-img--display" src="<@hst.webfile path='/images/nodisp3_big.png'/>">
                <!-- /ko -->
            </figure>
        </div>
        <div class="col-8 col-md-12 col-lg-8">
            <p class="text-uppercase mb-0"><span data-bind="text:$data.smcSerie==null ? 'N/A' : $data.smcSerie"></span></p>
        </div>
    </div>
  </div>
  <div class="col-12 col-md-4">
    <div class="row m-0 p-0">
        <div class="col-4 col-md-12 col-lg-3 p-md-0 p-lg-0">
            <figure class="mb-1">
              <!-- ko if: $data.competitorImage!=null -->
              <img class="cm-row-img cct-img cm-table-img--display" data-bind="attr:{src:$data.competitorImage ,alt:$data.competitorSerie}">
              <!-- /ko -->
              <!-- ko if: $data.competitorImage==null -->
              <img class="cm-row-img cm-table-img--display" src="<@hst.webfile path='/images/nodisp3_big.png'/>">
              <!-- /ko -->
            </figure>
        </div>
        <div class="col-8 col-md-12 col-lg-9">
            <p class="text-uppercase mb-0">
              <span class="d-block" data-bind="text:$data.competitorSerie==null ? 'N/A' : $data.competitorSerie"></span>
              <span class="text-secondary" data-bind="text:$data.competitorName==null ? 'N/A' : $data.competitorName"></span>
            </p>
        </div>
    </div>
  </div>
  <div class="col-12 col-md-3 p-md-0 p-lg-0">
    <!-- ko if:$data.advantages==null || $data.advantages.length==0-->
    <div class="row m-0 p-0">
      <div class="col-12 col-md-3 pl-lg-0 text-uppercase">
          N/A
      </div>
    </div>
    <!-- /ko -->
    <!-- ko if:$data.advantages!=null && $data.advantages.length>0-->
    <ul class="list-group list-group-flush" >
      <!-- ko foreach:{data:$data.advantages} -->
      <!-- ko if:$index()< 2 -->
      <li class="list-group-item cct-list-group-item cct-list-group-item--overflowText pl-lg-0" data-bind="text:$data.title"></li>
      <!-- /ko -->
      <!-- /ko -->
    </ul>
    <!-- ko if:$data.advantages.length> 1 -->
    <div data-bind="attr: { id:'collapsedDetails_cm_list'+$index()+'collapsedList_cm_list'+$index()}" class="collapse">
      <ul class="list-group list-group-flush" >
        <!-- ko foreach:{data:$data.advantages} -->
        <!-- ko if:$index()>=2 -->
        <li class="list-group-item cct-list-group-item cct-list-group-item--overflowText" data-bind="text:$data.title"></li>
        <!-- /ko -->
        <!-- /ko -->
      </ul>
    </div>
    <!-- /ko -->
    <!-- ko if:$data.advantages.length> 2 -->
    <div class="text-right">
      <span 
      class="icon-plus-details" 
      style="display:none"
      data-toggle="collapse" 
      role="button" 
      aria-expanded="false" 
      data-bind="attr: { 'data-target': '#collapsedDetails_cm_list'+$index()+'collapsedList_cm_list'+$index(),
      'aria-controls':'collapsedDetails_cm_list'+$index()+'collapsedList_cm_list'+$index()}"
      >
        <i class="fa fa-plus text-dark"></i>
      </span>
    </div>
    <!-- /ko -->
    <!-- /ko -->
  </div>
  <div class="col-12 col-md-1 text-center" data-bind="style:{display:($data.advantages!=null && ${compToolsReducedVer?c}) || (!${compToolsReducedVer?c} && ($data.advantages!=null || $data.disadvantages!=null || $data.documents!=null || $data.successStories!=null))? '' : 'none'}">
    <span 
    class="icon-plus-details " 
    data-toggle="collapse" 
    role="button" 
    aria-expanded="false"
    data-bind="attr: { 'data-target': '#collapsedDetails_cm_list'+$index(),'aria-controls':'collapsedDetails_cm_list'+$index()}"
    >
      <i class="fa fa-plus"></i>
    </span>
  </div>
  <!-- item comparison Map product details -->
  <div 
  class="col-12 collapse cct-detail" 
  data-bind="attr: { id: 'collapsedDetails_cm_list'+$index()}"
  >
    <!-- Item comparison Map detail tabs-->
    <div class="row">
      <div class="col-12">
        <div class="smc-tabs desktop mt-3">
          <div class="smc-tabs__head mb-0">
            <ul class="nav w-100" id="cmTab" role="tablist">
              <!-- ko if:$data.advantages!=null &&  $data.advantages.length> 0 -->
              <li data-bind="attr:{ class:$data.advantages!=null?'nav-item heading-0a subHeading-0a smc-tabs__head--active':'nav-item heading-0a subHeading-0a smc-tabs__head--active'}">
                <a
                data-toggle="tab" 
                role="tab" 
                data-bind="attr: { 'href': '#cm_advantages'+$index(),'aria-controls':'cm_advantages'+$index(),class: $data.advantages!=null?'active':'active'}"
                aria-selected="true"><@fmt.message key="comparisonmap.advantages"/></a>
              </li>
              <!-- /ko -->
              <#if !compToolsReducedVersion>
              <!-- ko if:$data.disadvantages!=null &&  $data.disadvantages.length> 0 -->
              <li data-bind="attr:{ class:$data.advantages!=null?'nav-item heading-0a subHeading-0a':'nav-item heading-0a subHeading-0a smc-tabs__head--active'}">
                <a 
                data-toggle="tab" 
                role="tab"
                data-bind="attr: { 'href': '#cm_disadvantages'+$index(),'aria-controls':'cm_disadvantages'+$index(),class: $data.advantages!=null?'':'active'}"
                aria-selected="false"><@fmt.message key="comparisonmap.disadvantages"/></a>
              </li>
              <!-- /ko -->
              <!-- ko if:$data.successStories!=null -->
              <li data-bind="attr:{ class:$data.advantages!=null || $data.disadvantages!=null?'nav-item heading-0a subHeading-0a':'nav-item heading-0a subHeading-0a smc-tabs__head--active'}">
                <a 
                data-toggle="tab" 
                role="tab" 
                data-bind="attr: { 'href': '#cm_successStories'+$index(),'aria-controls':'cm_successStories'+$index(),class: $data.advantages!=null || $data.disadvantages!=null?'':'active'}"
                aria-selected="false"><@fmt.message key="partnumberconvert.successStories"/></a>
              </li>
              <!-- /ko -->
              <!-- ko if:$data.documents!=null && $data.documents.length>0 -->
              <li data-bind="attr:{ class:$data.advantages!=null|| $data.disadvantages!=null || $data.successStories!=null?'nav-item heading-0a subHeading-0a':'nav-item heading-0a subHeading-0a smc-tabs__head--active'}">
                <a 
                data-toggle="tab" 
                role="tab" 
                data-bind="attr: { 'href': '#cm_documents'+$index(),'aria-controls':'cm_documents'+$index(),class:$data.advantages!=null || $data.disadvantages!=null || $data.successStories!=null> 0?'':'active'}"
                aria-selected="false"><@fmt.message key="partnumberconvert.documents"/></a>
              </li>
              <!-- /ko -->
              </#if>
            </ul>
          </div>
          <div class="tab-content" id="cmTabContent">
            <!-- ko if:$data.advantages!=null &&  $data.advantages.length> 0 -->
            <!-- Advantages -->
            <div class="tab-pane fade show active smc-tabs__body--active" 
            data-bind="attr: { 'id': 'cm_advantages'+$index()}"
            role="tabpanel">
              <#include "./_comparison-map-detail-advantages.ftl">
            </div>
            <!-- /Advantages -->
            <!-- /ko -->
            <#if !compToolsReducedVersion>
	            <!-- ko if:$data.disadvantages!=null &&  $data.disadvantages.length> 0 -->
	            <!-- Disadvantages -->
	            <div
	            data-bind="attr: { 'id': 'cm_disadvantages'+$index(),class: $data.advantages!=null?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}" 
	            role="tabpanel">
	              <#include "./_comparison-map-detail-disadvantages.ftl">
	            </div>
	            <!-- /Disadvantages -->
	            <!-- /ko -->
	            <!-- ko if:$data.successStories!=null -->
	            <!-- Success stories -->
	            <div class="tab-pane fade" 
	            data-bind="attr: { 'id': 'cm_successStories'+$index(),class: $data.advantages!=null || $data.disadvantages!=null?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}" 
	            role="tabpanel">
	              <#include "./_comparison-map-detail-successstories.ftl">
	            </div>
	            <!-- /Success stories -->
	            <!-- /ko -->
	            <!-- ko if:$data.documents!=null && $data.documents.length>0 -->
	            <!-- Documents -->
	            <div class="tab-pane fade" 
	            data-bind="attr: { 'id': 'cm_documents'+$index(),class: $data.advantages!=null || $data.disadvantages!=null || $data.successStories!=null?'tab-pane fade':'tab-pane fade show active smc-tabs__body--active'}" 
	            role="tabpanel">
	              <#include "./_comparison-map-detail-documents.ftl">
	            </div>
	            <!-- /Documents -->
	            <!-- /ko -->
            </#if>
          </div>
        </div>
      </div>
    </div>
    <!-- /Item comparison Map detail tabs-->
  </div>
  <!-- /item comparison Map product detail -->
</div>
<!-- /item comparison Map-->
