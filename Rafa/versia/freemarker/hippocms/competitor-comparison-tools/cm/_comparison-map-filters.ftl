<div class="modal fade" id="_comparisonMapFilters" aria-labelledby="_comparisonMapFilters" aria-hidden="true">
    <div class="modal-dialog cct-modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <div class="row w-100">
                    <div class="col-10">
                        <h4 class="modal-title"><@fmt.message key="comparisonmap.filters.title"/></h4>
                    </div>
                    <div class="col-2">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-body" style="position: static">
                <div class="row w-100 mb-5 mt-5">
                    <div class="col-lg-4 pr-0 border border-top-0 border-bottom-0 border-left-0 border-secondary">
                         <div class="row w-100 pr-0 mr-0">
                            <div class="col-lg-12 pr-0 mb-5">
                                <select id="selectPickerFamiliesDataCombo"
                                data-dropup-auto="false" 
                                data-bind="selectPicker:true,value:FamiliesDataComboSelected,options:FamiliesDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.family'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.family'/>" 
                                data-live-search="true" 
                                data-style="btn-default" 
                                show-tick>
                                </select>
                            </div>
                            <div class="col-lg-12 pr-0 mb-5">
                                <select id="selectPickerSubFamiliesDataCombo" 
                                data-dropup-auto="false"
                                data-bind="selectPicker:true,value:SubFamiliesDataComboSelected,options:SubFamiliesDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.subfamily'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.subfamily'/>" 
                                data-live-search="true"  
                                data-style="btn-default" 
                                show-tick 
                                disabled>
                                 </select>
                            </div>
                            <div class="col-lg-12 pr-0 mb-5">
                                <select id="selectPickerSmcSeriesDataCombo" 
                                data-dropup-auto="false"
                                data-bind="selectPicker:true,value:SmcSerieComboSelected,options:SmcSerieCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.smcSeries'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.smcSeries'/>" 
                                data-live-search="true" 
                                data-style="btn-default" 
                                show-tick>
                                 </select>
                            </div>
                         </div>
                    </div>
                    <div class="col-lg-4 pr-0 border border-top-0 border-bottom-0 border-left-0 border-secondary">
                        <div class="row w-100 pr-0 mr-0">
                            <div class="col-lg-12 mb-5 pr-0">
                                <select id="selectPickerCompetitorCombo"
                                data-dropup-auto="false" 
                                data-bind="selectPicker:true,value:CompetitorsDataComboSelected,options:CompetitorsDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.competitor'/>',valueAllowUnset:true,,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.competitor'/>" 
                                data-live-search="true"  
                                data-style="btn-default" 
                                show-tick>
                                 </select>
                            </div>
                            <div class="col-lg-12 mb-5 pr-0">
                                <select id="selectPickerCompetitorSeriesCombo"
                                data-dropup-auto="false" 
                                data-bind="selectPicker:true,value:SerieByCompetitorDataComboSelected,options:SerieByCompetitorDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.competitorSerie'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.competitorSerie'/>" 
                                data-live-search="true"  
                                data-style="btn-default" 
                                show-tick
                                disabled>
                                </select>
                            </div>
                         </div>
                    </div>
                    <div class="col-lg-4 pr-0">
                        <div class="row w-100 pr-0 mr-0">
                            <div class="col-lg-12 mb-5 pr-0">
                                <select id="selectPickerSmcBenefitCombo"
                                data-dropup-auto="false" 
                                data-bind="selectPicker:true,value:BenefitsDataComboSelected,options:BenefitsDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.smcBenefit'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.smcBenefit'/>" 
                                data-live-search="true" 
                                data-style="btn-default" 
                                show-tick>
                                 </select>
                            </div>
                            <div class="col-lg-12 mb-5 pr-0">
                                <select id="selectPickerAdvantages"
                                data-dropup-auto="false"
                                data-bind="selectPicker:true,value:AdvantagesDataComboSelected,options:AdvantagesDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.advantages'/>',valueAllowUnset:true,event:{change:getCombinedFilters}" 
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.advantages'/>"
                                data-live-search="true" 
                                data-style="btn-default" 
                                show-tick>
                                </select>
                            </div>
                            <div class="col-lg-12 pr-0">
                                <select id="selectPickerDisadvantages"
                                data-dropup-auto="false"
                                data-bind="selectPicker:true,value:DisadvantagesDataComboSelected,options:DisadvantagesDataCombo,optionsText:'value',optionsValue:'id',optionsCaption:'<@fmt.message key='comparisonmap.filters.disadvantages'/>',valueAllowUnset:true,event:{change:getCombinedFilters}"  
                                class="selectpicker w-100" 
                                title="<@fmt.message key='comparisonmap.filters.disadvantages'/>" 
                                data-live-search="true" 
                                data-style="btn-default" 
                                show-tick>
                                </select>
                            </div>
                         </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="row w-100">
                    <div class="col-lg-12 text-right">
                        <button id="btn_comparisonMapDownload" class="btn btn-outline-primary compare-product-button mt-10 mt-sm-0 ml-4" data-bind="click:clearAllFilters">
                            <@fmt.message key="comparisonmap.filters.btn.clear"/>
                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                            <i class="ml-2 fa fa-times"></i>
                        </button>
                        <button id="btn_comparisonMapFilter" class="btn btn-primary compare-product-button mt-10 mt-sm-0 ml-4"  data-toggle="modal" data-target="#_comparisonMapFilters" data-bind="click:searchComparisonDataAll">
                            <@fmt.message key="comparisonmap.filters.btn.search"/>
                            <i class="loading-container-ssi-btn loading-container-ssi-js"></i>
                            <i class="ml-2 fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
