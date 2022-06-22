function ComparisonMapViewModel() {
    var data = {
        registryPerPage: 10,
        registryIndex: 1,
        registryToIndex: 10,
        numbersTotalResults: [1],
        totalResults: 1,
        expanded: true,
        isSMCUnique:0
    };
    //Self as 'this' reference
    var self = this;
    //Results per page 10|20|50|100
    self.RegistryPerPage = ko.observable();
    //Number of current page
    self.RegistryIndex = ko.observable();
    //Number to current page
    self.RegistryIndexTo = ko.observable();
    //First number of current page showing
    self.RegistryIndexFrom = ko.observable();
    //Number of total results
    self.TotalResults = ko.observable();
    //Numbers list of total results
    self.NumbersTotalResults = ko.observableArray([]);
    // SMC Unique
    self.SMCunique=ko.observable();
    self.SMCSerieRefListExcell=ko.observableArray([]);
    // Combos filters
    self.FamiliesDataCombo = ko.observableArray([]);
    self.SubFamiliesDataCombo = ko.observableArray([]);
    self.CompetitorsDataCombo = ko.observableArray([]);
    self.SerieByCompetitorDataCombo = ko.observableArray([]);
    self.ComparisonDataAll = ko.observableArray([]);
    self.BenefitsDataCombo = ko.observableArray([]);
    self.AdvantagesDataCombo = ko.observableArray([]);
    self.DisadvantagesDataCombo = ko.observableArray([]);
    self.CompetitorsSeriesDataCombo = ko.observableArray([]);
    self.SmcSerieCombo = ko.observableArray();
    // Combo filters selected
    self.FamiliesDataComboSelected= ko.observable();
    self.SubFamiliesDataComboSelected= ko.observable();
    self.SmcSerieComboSelected= ko.observable();
    self.CompetitorsDataComboSelected= ko.observable();
    self.SerieByCompetitorDataComboSelected= ko.observable();
    self.BenefitsDataComboSelected= ko.observable();
    self.AdvantagesDataComboSelected= ko.observable();
    self.DisadvantagesDataComboSelected= ko.observable();
    // Export Comparison
    self.ExportComparisonInformation = ko.observable();
    self.SuggestedPartNumbers = ko.observableArray();
    self.initialize = function () {
        self.resetPagination();
        self.getFamiliesDataCombo();
        self.getCompetitorsDataCombo();
        self.getBenefitsDataCombo();
        self.getAdvantagesDataCombo();
        self.getDisadvantagesDataCombo();
        self.getSmcSerieCombo();
        self.SMCunique(data.isSMCUnique);
    }
//------------------ Combos --------------------//
    self.getFamiliesDataCombo = function () {
        $.ajax({
            url: window.getFamiliesDataCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                console.log("Families",result);
                self.FamiliesDataCombo(result);
                $('#selectPickerFamiliesDataCombo').selectpicker('refresh');
                console.log("families", self.FamiliesDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("families error", err);
            });
    };
    self.handleFamiliesDataComboSelected=function(){
        $('#selectPickerSubFamiliesDataCombo').prop('disabled', false);
        self.getSubFamiliesDataCombo();
    };
    self.getSubFamiliesDataCombo = function () {
        self.SubFamiliesDataComboSelected('');
        if(typeof self.FamiliesDataComboSelected()!='undefined'){
            $.ajax({
                url: window.getSubFamiliesDataCombo,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    familyParam:self.FamiliesDataComboSelected()
                },
                success: function (result) {
                    self.SubFamiliesDataCombo(result)
                    $('#selectPickerSubFamiliesDataCombo').selectpicker('refresh');
                    console.log("SubFamiliesDataCombo", self.SubFamiliesDataCombo());
                }
            }).fail(
                function (xhr, textStatus, err) {
                    console.log("SubFamiliesDataCombo error", err);
                });
        }
    };
    self.getSmcSerieCombo = function () {
        $.ajax({
            url: window.getSmcSerieCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (data) {
                self.SmcSerieCombo(data);
                $('#selectPickerSmcSeriesDataCombo').selectpicker('refresh');
                console.log("SmcSerieCombo", self.SmcSerieCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("SmcSerieCombo error", err);
            });
    };
    self.getCompetitorsDataCombo = function () {
        $.ajax({
            url: window.getCompetitorsDataCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                self.CompetitorsDataCombo(result)
                $('#selectPickerCompetitorCombo').selectpicker('refresh');
                console.log("CompetitorsDataCombo", self.CompetitorsDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("CompetitorsDataCombo error", err);
            });
    };
    self.handleCompetitorsDataComboSelected=function(){
        $('#selectPickerCompetitorSeriesCombo').prop('disabled', false);
        self.getSerieByCompetitorDataCombo();
    };
    self.getSerieByCompetitorDataCombo = function () {
        self.SerieByCompetitorDataComboSelected('');
        if(typeof self.CompetitorsDataComboSelected()!='undefined'){
            $.ajax({
                url: window.getSerieByCompetitorDataCombo,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    competitorParam: self.CompetitorsDataComboSelected()
                },
                success: function (result) {
                    self.SerieByCompetitorDataComboSelected('');
                    self.SerieByCompetitorDataCombo(result);
                    $('#selectPickerCompetitorSeriesCombo').selectpicker('refresh');
                    console.log("SerieByCompetitorDataCombo", self.SerieByCompetitorDataCombo());
                }
            }).fail(
                function (xhr, textStatus, err) {
                    console.log("SerieByCompetitorDataCombo error", err);
                });
        }
    };
    self.getBenefitsDataCombo = function () {
        $.ajax({
            url: window.getBenefitsDataCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                self.BenefitsDataCombo(result)
                $('#selectPickerSmcBenefitCombo').selectpicker('refresh');
                console.log("BenefitsDataCombo", self.BenefitsDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("BenefitsDataCombo error", err);
            });
    };
    self.getAdvantagesDataCombo = function () {
        $.ajax({
            url: window.getAdvantagesDataCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                self.AdvantagesDataCombo(result);
                $('#selectPickerAdvantages').selectpicker('refresh');
                console.log("AdvantagesDataCombo", self.AdvantagesDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("AdvantagesDataCombo error", err);
            });
    };
    self.getDisadvantagesDataCombo = function () {
        $.ajax({
            url: window.getDisadvantagesDataCombo,
            cache: false,
            type: 'GET',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                self.DisadvantagesDataCombo(result);
                $('#selectPickerDisadvantages').selectpicker('refresh');
                console.log("DisadvantagesDataCombo", self.DisadvantagesDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("DisadvantagesDataCombo error", err);
            });
    };
    self.getCompetitorsSeriesDataCombo = function () {
        $.ajax({
            url: window.getCompetitorsSeriesDataCombo,
            cache: false,
            type: 'GET',
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            success: function (result) {
                self.CompetitorsSeriesDataCombo(result)
                console.log("CompetitorsSeriesDataCombo", self.CompetitorsSeriesDataCombo());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("CompetitorsSeriesDataCombo error", err);
            });
    };
    self.getSuggestedPartNumbers=function(){
        $.ajax({
            url: window.getSuggestedPartNumbers,
            cache: false,
            type: 'POST',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            data: {
                partNumberParam: "2"
            },
            success: function (result) {
                self.SuggestedPartNumbers(result)
                console.log("SuggestedPartNumbers", self.SuggestedPartNumbers());
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("SuggestedPartNumbers error", err);
            });
    };
    self.getExportComparisonInformation = function () {
        $.ajax({
            url: window.exportComparisonInformation,
            cache: false,
            type: 'POST',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            data: {
                partNumbersToExport: "2"
            },
            success: function (result) {
                console.log("URL export", result);
            }
        }).fail(
            function (xhr, textStatus, err) {
                console.log("ExportComparisonInformation error", err);
            });
    };
//------------------ Filters Combined ----------------------------------------------//
self.getCombinedFilters=function(){
    //$('#cm-loading-container').show();
    if(typeof self.FamiliesDataComboSelected()=='undefined'){
        self.FamiliesDataComboSelected('');
        self.SubFamiliesDataComboSelected('');
    }
    if(typeof self.SubFamiliesDataComboSelected()=='undefined'){
        self.SubFamiliesDataComboSelected('');
    }
    if(typeof self.SmcSerieComboSelected()=='undefined'){
        self.SmcSerieComboSelected('');
    }
    if(typeof self.CompetitorsDataComboSelected()=='undefined'){
        self.CompetitorsDataComboSelected('');
        self.SerieByCompetitorDataComboSelected('');
    }
    if(typeof self.SerieByCompetitorDataComboSelected()=='undefined'){
        self.SerieByCompetitorDataComboSelected('');
    }
    if(typeof self.BenefitsDataComboSelected()=='undefined'){
        self.BenefitsDataComboSelected('');
    }
    if(typeof self.AdvantagesDataComboSelected()=='undefined'){
        self.AdvantagesDataComboSelected('');
    }
    if(typeof self.DisadvantagesDataComboSelected()=='undefined'){
        self.DisadvantagesDataComboSelected('');
    }
    $.ajax({
            url: window.getCombinedFilters,
            cache: false,
            type: 'POST',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            data: {
                familyParam:self.FamiliesDataComboSelected(),
                subfamilyParam:self.SubFamiliesDataComboSelected(),
                smcSerie:self.SmcSerieComboSelected(),
                competitorParam: self.CompetitorsDataComboSelected(),
                competitorSerieParam:self.SerieByCompetitorDataComboSelected(),
                benefitParam:self.BenefitsDataComboSelected(),
                advantageParam:self.AdvantagesDataComboSelected(),
                disadvantageParam:self.DisadvantagesDataComboSelected(),
                uniqueParam:self.SMCunique().toString(),
                registryIndex:self.RegistryIndex(),
                registryPerPage:self.RegistryPerPage()
            },
            success: function (result) {
                console.log("List filters combos", result);  
                //Family combo
                self.FamiliesDataCombo(result.family);
                if( self.FamiliesDataComboSelected()!=''){
                    $('#selectPickerSubFamiliesDataCombo').prop('disabled', false);
                }
                else{
                    self.SubFamiliesDataComboSelected('');
                    $('#selectPickerSubFamiliesDataCombo').prop('disabled', true);
                }
                $('#selectPickerFamiliesDataCombo').selectpicker('refresh');
                console.log("Family combo", self.FamiliesDataCombo());
                console.log("Family combo selected end", self.FamiliesDataComboSelected());
                //Subfamily combo
                self.SubFamiliesDataCombo(result.subFamily);
                $('#selectPickerSubFamiliesDataCombo').selectpicker('refresh');
                console.log("SubFamily combo", self.SubFamiliesDataCombo());
                // Smc combo
                self.SmcSerieCombo(result.smcSerie);
                $('#selectPickerSmcSeriesDataCombo').selectpicker('refresh');
                console.log("Smc combo", self.SmcSerieCombo());
                // Competitor data combo
                self.CompetitorsDataCombo(result.competitor);
                if( self.CompetitorsDataComboSelected()!=''){
                    $('#selectPickerCompetitorSeriesCombo').prop('disabled', false);
                }
                else{
                    self.SerieByCompetitorDataComboSelected('')
                    $('#selectPickerCompetitorSeriesCombo').prop('disabled', true);
                }
                if(self.SMCunique().toString()=='1'){
                    $('#selectPickerCompetitorSeriesCombo').prop('disabled', true);
                     self.SerieByCompetitorDataComboSelected('UNIQUE');
                     $('#selectPickerCompetitorSeriesCombo').selectpicker('refresh');
                }
                $('#selectPickerCompetitorCombo').selectpicker('refresh');
                console.log("Competitor data", self.CompetitorsDataCombo());
                // Serie competitor combo
                self.SerieByCompetitorDataCombo(result.competitorSerie);
                $('#selectPickerCompetitorSeriesCombo').selectpicker('refresh');
                console.log("Serie competitor combo", self.SerieByCompetitorDataCombo());
                // Benefict combo
                self.BenefitsDataCombo(result.benefits);
                $('#selectPickerSmcBenefitCombo').selectpicker('refresh');
                console.log("Benefict combo", self.BenefitsDataCombo());
                // Advantage combo
                self.AdvantagesDataCombo(result.advantages);
                $('#selectPickerAdvantages').selectpicker('refresh');
                console.log("Advantage combo", self.AdvantagesDataCombo());
                // Disadvantage combo
                self.DisadvantagesDataCombo(result.disadvantages);
                $('#selectPickerDisadvantages').selectpicker('refresh');
                //Handle isUnique
                console.log("Disadvantage combo", self.DisadvantagesDataCombo());      
            }
        }).done(function() {
               //$('#cm-loading-container').hide(); 
            }).fail(
            function (xhr, textStatus, err) {
                console.log("ComparisonDataAll error", err);
                $('#cm-loading-container').hide();
                $('#cm-notificationError').removeClass('d-none');
            });
}
//------------------ Search Filter ----------------------------------------------//
    self.searchComparisonDataAll=function(){
        self.resetPagination();
        self.getComparisonDataAll();
    }
//------------------ Results ----------------------------------------------//
    self.getComparisonDataAll = function (isInitialize) {
        $('#cm-notificationError').removeClass('d-none');
        $('#cm-notificationError').addClass('d-none');
        $('#cm-loading-container').show();
        $.ajax({
            url: window.getComparisonDataAll,
            cache: false,
            type: 'POST',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
            },
            data: {
                familyParam:self.FamiliesDataComboSelected(),
                subfamilyParam:self.SubFamiliesDataComboSelected(),
                smcSerie:self.SmcSerieComboSelected(),
                competitorParam: self.CompetitorsDataComboSelected(),
                competitorSerieParam:self.SerieByCompetitorDataComboSelected(),
                benefitParam:self.BenefitsDataComboSelected(),
                advantageParam:self.AdvantagesDataComboSelected(),
                disadvantageParam:self.DisadvantagesDataComboSelected(),
                uniqueParam:self.SMCunique(),
                registryIndex:self.RegistryIndex(),
                registryPerPage:self.RegistryPerPage(),
				familyParamText:$("#selectPickerFamiliesDataCombo").val()!=''?$("#selectPickerFamiliesDataCombo option:selected").text():'',
				subfamilyParamText:$("#selectPickerSubFamiliesDataCombo").val()!=''?$("#selectPickerSubFamiliesDataCombo option:selected").text():'',
				smcSerieText:$("#selectPickerSmcSeriesDataCombo").val()!=''?$("#selectPickerSmcSeriesDataCombo option:selected").text():'',
				competitorParamText:$("#selectPickerCompetitorCombo").val()!=''?$("#selectPickerCompetitorCombo option:selected").text():'',
				competitorSerieParamText:$("#selectPickerCompetitorSeriesCombo").val()!=''?$("#selectPickerCompetitorSeriesCombo option:selected").text():'',
				benefitParamText:$("#selectPickerSmcBenefitCombo").val()!=''?$("#selectPickerSmcBenefitCombo option:selected").text():'',
				advantageParamText:$("#selectPickerAdvantages").val()!=''?$("#selectPickerAdvantages option:selected").text():'',
				disadvantageParamText:$("#selectPickerDisadvantages").val()!=''?$("#selectPickerDisadvantages option:selected").text():''
            },
            success: function (result) {
                if (result != null) {
                    self.TotalResults(result.numTotalElements);
                    if (result.currentPage == 1) {
                                self.RegistryIndexFrom(result.currentPage);
                    }
                    else {
                        self.RegistryIndexFrom(((result.currentPage - 1) * self.RegistryPerPage()) + 1);
                    }
                    self.RegistryIndexTo(((result.currentPage - 1) * self.RegistryPerPage()) + result.numElements)
                    self.RegistryIndex(result.currentPage);
                    if (result.content != null) {
                        if (result.content.length > 0) {
                            $('#cm-notResults').hide();
                        } else {
                            $('#cm-notResults').show();
                        }
                        self.ComparisonDataAll(result.content);
                    } else {
                        $('#cm-notResults').show();
                        self.ComparisonDataAll([]);
                    }
                    self.handleTotalPages(result.totalPages);
                }else{
                    $('#cm-notResults').show();
                }
                self.handleSubTabs();
                self.handleCheckboxAll();
                $('#cm-loading-container').hide();
                console.log("list partnumberconverter", self.ComparisonDataAll());           
            }
        }).done(function() {
                if(isInitialize!=true){
                    $('html,body').animate({
                        scrollTop:$('#ssi-container').offset().top-135
                    }, 1000);
                }
            }).fail(
            function (xhr, textStatus, err) {
                console.log("ComparisonDataAll error", err);
                $('#cm-loading-container').hide();
                $('#cm-notificationError').removeClass('d-none');
            });
    };
//------------------ Clear ------------------------------------------------//
    self.clearAllFilters=function(){
        self.resetPagination();
        self.FamiliesDataComboSelected('');
        self.SubFamiliesDataComboSelected('');
        self.SmcSerieComboSelected('');
        self.SerieByCompetitorDataComboSelected('');
        self.BenefitsDataComboSelected('');
        self.CompetitorsDataComboSelected('');
        self.AdvantagesDataComboSelected('');
        self.DisadvantagesDataComboSelected('');
        self.SMCunique(data.isSMCUnique);
        $("#rodEndOptionsSwitchToggle").prop( "checked", false );
        $('#selectPickerCompetitorSeriesCombo').prop('disabled', true);
        $('#selectPickerSubFamiliesDataCombo').prop('disabled', true);
        $(".selectpicker").val('default');
        $(".selectpicker").selectpicker("refresh");
        self.resetCombos();
    }
    self.resetPagination=function(){
        self.RegistryIndex(data.registryIndex);
        self.RegistryPerPage(data.registryPerPage);
        self.TotalResults(data.totalResults);
        self.RegistryIndexTo(data.registryToIndex);
        self.NumbersTotalResults(data.numbersTotalResults);
    }
    self.resetCombos=function(){
        self.SubFamiliesDataCombo([]);
        self.SerieByCompetitorDataCombo([]);
        $('#selectPickerCompetitorSeriesCombo').selectpicker('refresh');
        self.getFamiliesDataCombo();
        $('#selectPickerFamiliesDataCombo').selectpicker('refresh');
        $('#selectPickerSubFamiliesDataCombo').selectpicker('refresh');
        self.getCompetitorsDataCombo();
        $('#selectPickerCompetitorCombo').selectpicker('refresh');
        self.getBenefitsDataCombo();
        $('#selectPickerSmcBenefitCombo').selectpicker('refresh');
        self.getAdvantagesDataCombo();
        $('#selectPickerAdvantages').selectpicker('refresh');
        self.getDisadvantagesDataCombo();
        $('#selectPickerDisadvantages').selectpicker('refresh');
        self.getSmcSerieCombo();
        $('#selectPickerSmcSeriesDataCombo').selectpicker('refresh');
        $('#selectPickerSubFamiliesDataCombo').prop('disabled', true);
        $('#selectPickerCompetitorSeriesCombo').prop('disabled', true);
        self.SMCunique(data.isSMCUnique);
    }
//------------------ ToggleSMCUnique ---------------------------------------//
    self.handleToggleSMCUnique=function(model,event){
        console.log("Toggle value item",event.currentTarget.checked);
        self.RegistryIndex(1);
        if(event.currentTarget.checked){
            self.SMCunique(1);
            self.getCombinedFilters();
        }else{
            self.SerieByCompetitorDataComboSelected('');
            self.SMCunique(0);
            self.getCombinedFilters();
        }
        self.searchComparisonDataAll();
        return true;
    };
//------------------ Excell -------------------------------------------------//
    self.getExportComparisonInformation=function(){
         var checkboxes = $('#cm-spares-accessories-result-container').find(':checkbox');
        $('#cm-notificationError').removeClass('d-none');
        $('#cm-notificationError').addClass('d-none');
        self.SMCSerieRefListExcell([]);
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].id !== "cm_select_all") {
                self.SMCSerieRefListExcell.push(checkboxes[i].getAttribute('data-serie'));
            }
        }
        console.log("list Excel", self.SMCSerieRefListExcell());
        var SMCSerieRefListExcell;
        if($('#cm_select_all').is(':checked')){
            SMCSerieRefListExcell="";
        }else{
            SMCSerieRefListExcell=self.SMCSerieRefListExcell();
        }
        if (this.SMCSerieRefListExcell().length > 0 && typeof this.SMCSerieRefListExcell() != 'undefined') {
           $('#cm-loading-container').show();
            $.ajax({
                url: window.exportComparisonInformation,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
                data: {
                    familyParam:self.FamiliesDataComboSelected(),
                    subfamilyParam:self.SubFamiliesDataComboSelected(),
                    smcSerie:self.SmcSerieComboSelected(),
                    competitorParam: self.CompetitorsDataComboSelected(),
                    competitorSerieParam:self.SerieByCompetitorDataComboSelected(),
                    benefitParam:self.BenefitsDataComboSelected(),
                    advantageParam:self.AdvantagesDataComboSelected(),
                    disadvantageParam:self.DisadvantagesDataComboSelected(),
                    uniqueParam:self.SMCunique().toString(),
                    registryIndex:self.RegistryIndex(),
                    registryPerPage:self.RegistryPerPage(),
                    idsSeriesToExport: SMCSerieRefListExcell
                },
                success: function (result) {
                    $('#cm-loading-container').hide();
                    console.log("Excell", result);
                    window.open(result, '_blank');
                }
            }).fail(
                function (xhr, textStatus, err) {
                    $('#cm-loading-container').hide();
                    $('#cm-notificationError').removeClass('d-none');
                }
            );
        }
        else {
            $('#cm-notificationError').removeClass('d-none');
        }
    }
//------------------ Pagination ---------------------------------------------//
    self.handleTotalPages = function (totalPages) {
        var arrayEmpty = [];
        self.NumbersTotalResults(arrayEmpty);
        for (var i = 1; i <= totalPages; i++) {
            self.NumbersTotalResults.push(i);
        }
    };
    self.showCurrentPage = function (paginationPerPage, event) {
        self.RegistryIndex(paginationPerPage);
        self.getComparisonDataAll();
    };
    self.showFirstPage = function () {
        var previousPage = 1;
        self.RegistryIndex(previousPage);
        self.getComparisonDataAll();
    };
    self.showLastPage = function () {
        var lastPage = self.NumbersTotalResults().length;
        self.RegistryIndex(lastPage);
        self.getComparisonDataAll();
    };
    self.showPreviousPage = function () {
        if (self.RegistryIndex() > 1) {
            var previousPage = self.RegistryIndex() - 1;
            self.RegistryIndex(previousPage);
            self.getComparisonDataAll();
        } else {
            console.log("Not more pages");
        }
    };
    self.showNextPage = function () {
        if (self.RegistryIndex() < self.TotalResults()) {
            var nextPage = self.RegistryIndex() + 1;
            self.RegistryIndex(nextPage);
            self.getComparisonDataAll();
        } else {
           console.log("Not more pages");
        }
    };
    self.updateRegistryPerPage = function (model, event) {
        self.RegistryPerPage(event.currentTarget.innerText);
        self.RegistryIndex(1);
        self.getComparisonDataAll();
    };
//------------------ checkbox list --------------------------------------------//
    self.handleCheckboxAll = function () {
        $('#cm_select_all').change(function () {
            var checkboxes = $(this).closest('#cm-spares-accessories-result-container').find(':checkbox');
            checkboxes.prop('checked', $(this).is(':checked'));
            for (var i = 0; i < checkboxes.length; i++) {
                $('#cm-btn-download').prop('disabled', true);
                if (checkboxes[i].checked) {
                    $('#cm-btn-download').prop('disabled', false);
                }
            }
        });
    };
    self.handleCheckboxItem = function (e) {
        var checkboxes = $('#cm-spares-accessories-result-container').find(':checkbox');
        for (var i = 0; i < checkboxes.length; i++) {
            $('#cm-btn-download').prop('disabled', true);
            if (checkboxes[i].checked) {
                $('#cm-btn-download').prop('disabled', false);
                break;
            }
        }
        return true;
    };
//------------------ Tabs --------------------------------------------------------//
    self.handleSubTabs = function () {
        var tabs = $(".subHeading-0a");
        tabs.click(function () {
            // delete active class all elements
            $(this.parentElement).children().removeClass("smc-tabs__head--active");
            // activation current element
            $(this).addClass("smc-tabs__head--active");
        });
    };
//------------------ LOGS --------------------------------------------------------//
    self.logActionCM = function (e) {
		var $element = $(e.target);	
		$.ajax({
                url: window.logActionUrl,
                cache: false,
                type: 'POST',
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', window.csrfToken)
                },
               	data: {
                    action:$element.attr('smc-cmLog-action'),
                    type:$element.attr('smc-cmLog-type'),
                    dataList:[
							$element.attr('smc-cmLog-data1'),
							$element.attr('smc-cmLog-data2'),
							$element.attr('smc-cmLog-data3')
					]
                },
                success: function (result) {
                }
            })
    };
}
(function (window) {
    var vmcm = new ComparisonMapViewModel();
    ko.applyBindings(vmcm, document.getElementById("CMcontenedor"));
    vmcm.initialize();
    $(window).click(function(e) {
        if(e.target.id=="cm"){
            vmcm.clearAllFilters();
            vmcm.getComparisonDataAll(true);
        }
		if(e.target.getAttribute("smc-cmLog-action")!=undefined){
            vmcm.logActionCM(e);
        }      
    });
}(window));